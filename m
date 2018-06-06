Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4qmyG6tMGFsIHAAAmS7hNA
	; Wed, 06 Jun 2018 21:07:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C666A607E4; Wed,  6 Jun 2018 21:07:07 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="kLCtg3cq"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2DDA7605BD;
	Wed,  6 Jun 2018 21:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DDA7605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeFFVHF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 17:07:05 -0400
Received: from mail-by2nam01on0135.outbound.protection.outlook.com ([104.47.34.135]:53001
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752112AbeFFVHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 17:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF/7jjxy3P/1Bhe0sOHvPWCFH4/iucWQ3uOZvej3Yuw=;
 b=kLCtg3cqwffcfu3dHtqq+QO/vrX49iU2VAYuQNeYAThoIB8MNsuUvyeVLzzgD68FAHuHc+bHvfd+WhfrbXefdUYdaGjcEpCYt0Sgmkk9JcX7lVrlzBcxH4FPCHvoL2sCI+o/n/jL5kJzd9Id5MN53pHHzA9uhYDQ2ZcLqL74WJw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=hoan.tran@amperecomputing.com;
Received: from T3400_localhost.amcc.com (4.28.13.142) by
 BY2PR0101MB1558.prod.exchangelabs.com (2a01:111:e400:52fc::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Wed, 6 Jun 2018 21:07:01 +0000
From: Hoan Tran <hoan.tran@amperecomputing.com>
To: Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Tai Nguyen <ttnguyen@amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Loc Ho <loc.ho@amperecomputing.com>,
        Hoan Tran <hoan.tran@amperecomputing.com>
Subject: [PATCH] perf: xgene: Fix IOB SLOW PMU parser error
Date: Wed,  6 Jun 2018 14:06:54 -0700
Message-Id: <1528319214-19726-1-git-send-email-hoan.tran@amperecomputing.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.28.13.142]
X-ClientProxiedBy: BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49)
 To BY2PR0101MB1558.prod.exchangelabs.com (2a01:111:e400:52fc::24)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR0101MB1558;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0101MB1558;3:wbP++N/OFchfw+zEMFKj8Ea3bARCzhY//H1NRh42ZdW0ZW8Q+R9+e+HvKB70qX5iYmFzuzSSBE3j+QQD0hoUaDK+ZKmrfR80uQ8zybw/lUBwZNLboRHGM5FOElVfbp35mI7TFuFW5o7l8479LLi5jU+YGIgTd0SIwGmxEsaDmgfqpVLYRL2jJFrfhlAmMZHYCApxar2PjPdxQtgMZ3p0LqRu3/hT+sNUt/2n21/d5aJWhiKfrsAMeFDQX5K7LZ9o;25:9uQfp+0JVl+Ofkg5WAiaRdPu0BWSGVDF/vU8c43yLCMJVdCJbJMYyAAnFGcgLh/u3gkBLdnaFFGASDyuOWxviYbnCRbb4OUygwjLRt2rMUmF4yNdZIk7HrLveW6ReDRUp1NYuBnvogyiti9yG17jqM57A1pGKI3+lGcbeDYWIUEk/y6cKSYaDoFLUIlKpDWG09KP7hD7pH+P5LbDBQImPJ0jBn/lf6limRLkFgSGaRXS3ervfxH75uxLQPo+2SWqXjvXZ6ZFKwkIC13nT13misDcqYqbD06IfSrV9K9Ghi5LoydoLtFEFeb8XQzAiejZRqso4774ka5Oxdu2pvGQCw==;31:dPDDBN5OZ4pzzNQRRliLr/ldcBPdPxBFn9X29ECX1Z/S4K+ERpQ0AkZDqLzbQKCr15RTk4y3EqX2bvQCKTbUQbNUmSiyYfJ0Ut4uy1neBtnYRhuaN0M7ewiC1Z5tlAZY/KRZcRQgyY5gplYJnDLoQMhSpXNuitFIA2Iq5/C0C1HUtX4T4cmOx4hdzhmdVz4267TpIP25Ipx2iPS+9kGaFELVQDto0sddxc4wAhYQ4yk=
X-MS-TrafficTypeDiagnostic: BY2PR0101MB1558:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0101MB1558;20:Y9dIv888yzDnnEUFRe07JkfBF+CyjgF2D/Kq4TRyv6dq+rXClG6wj8psVKGGth7CNXtPxT/fKIXfU8GjlFS10UL6PYx8TCBOm9sgD/62ZC96H66GQYmnvOXdPWh4tQzNQwhqJzTJgRbSo4MFvUzWqCI8o1DHKVYZ83TMerHQTPQ=;4:eshWTDZ2+mE+Lxoc7MT9TLLMj2V8QrIgTUMMwwIyIZ7VG3ukoK4mRCGQechDWfxyWvd3RDa5VNtlHgrmwzxQL1Idp5VlMZP4cTj9YfypXI7f9sque2lKgAykhv5CPE81lpAezg3z1wU//dGRbUMvKbr4Q219HRRcBNW7xEe+aTClNZp08LFYj6H/1hka8Xcj3ID/36yCga3HLsYiAj3jQpbVb8/0rTF6SuHu8hI7ZtgGEFTKj8hE5e/ZJ4MxycPSpRh3/luEg/HlbTEpZ2JeFzbu0to1jCTcgXfsUxizXBNMS46/fXA0bUFCCZyL3GuX
X-Microsoft-Antispam-PRVS: <BY2PR0101MB1558484573D0F2E0C8E682F0E4650@BY2PR0101MB1558.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR0101MB1558;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0101MB1558;
X-Forefront-PRVS: 06952FC175
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(396003)(366004)(346002)(39850400004)(39380400002)(199004)(189003)(107886003)(105586002)(106356001)(7736002)(305945005)(53936002)(25786009)(97736004)(6512007)(6506007)(386003)(486006)(59450400001)(26005)(16526019)(1857600001)(186003)(6486002)(478600001)(53416004)(47776003)(8676002)(51416003)(2906002)(52116002)(37156001)(4326008)(66066001)(50466002)(50226002)(8936002)(6116002)(3846002)(81156014)(81166006)(48376002)(68736007)(69596002)(36756003)(16586007)(316002)(44832011)(54906003)(110136005)(6636002)(86362001)(6666003)(956004)(476003)(2616005)(5660300001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR0101MB1558;H:T3400_localhost.amcc.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0101MB1558;23:o2pSK6XbmZeFvMErxzRC2v5K2cyIf/HFC/5lQC+?=
 =?us-ascii?Q?zAeyJvnNSJrlnMXS+RTG+FlgtyuN4Rn4NKY0M4/8J1mF3VQ1zykMZMFTgPFB?=
 =?us-ascii?Q?LCLNG60XMNd01osTmsCej4KeC2TlymcCAU876/cu2R6ltresrc01hZ/WiUMt?=
 =?us-ascii?Q?8Eq77uOlhgcWIurOfgD+a8ycDRraZIxCGwUC2MEwn8HSUdQ8xH8Y/7izR9uV?=
 =?us-ascii?Q?BkbqOOgkcPNOWQNDLwSqOzL+FgXXlCadHJnkrEnllTlHFbh/x5j3nBGiDlr0?=
 =?us-ascii?Q?pNjdQ/6Ez+jIHFDWVxQ9FpuvXwGP7iORk8rY0/yXmGdARkZ7zHTjKI5QScIE?=
 =?us-ascii?Q?EBihWYcgIPUGllvz0oJAlL5+ZIt4tNo5LbHpJ4divR+nzq7pP4f0jcKwHGXA?=
 =?us-ascii?Q?6pbMlTTfXoFs0J60qGfdJ8QDK7QNFEmTY3SZQTMkHha5vme87dhiNn9pTSaI?=
 =?us-ascii?Q?hTOD+jgzipqUaVR/RFJTzOvMzqb5dHMyO30n8RgB9gpOMyR5CrjUYzk95lin?=
 =?us-ascii?Q?R7xDzQPG6wxb8r6jB4V9AhI1b2yHIV2QGd/3ztRsHyBQAI8+sNrsfV7cWPAK?=
 =?us-ascii?Q?1Eo5aftd4Mv5OI0r9FWBBuIpf1/uSMEso2x80rZpaZOhRXntXxfD3sWKEt76?=
 =?us-ascii?Q?Y6jXG4WJ7ZBY/ZCBFbKW62UlrQM9GnyN42hy6O9gAHsM9OQn/LCvRYJnUzuP?=
 =?us-ascii?Q?v8zC1c16AG7Ycs4LV7Lfv2wygn51KFduZK3syI9rkfCiNtWD7/fUud2rzIOb?=
 =?us-ascii?Q?4DoP1crp5UCZCBvfhpzI0o3AZnqnV9WIaQ/sahepqdlJ+Y+KJcdRA4JDN1aq?=
 =?us-ascii?Q?GyUrUrwHj996boqITwNM/AzKbBQ6t4EtUcatjZ1Fy5bicY0far9nFW1s9/nf?=
 =?us-ascii?Q?GqQF013pjK+S/b0Pe8QfaYh1BsJmQI1vq6yR41zmEJBH+yeOZWdm9wF3FO3J?=
 =?us-ascii?Q?y24DAcKU6YAIpVs0KDN4NqkyWQ+Q8dT89x3xw6xLYTqAonnLVySWGEStKmdh?=
 =?us-ascii?Q?4rEJ9FgCR9EMoBg29y093W1qrx5/f5v8qHQy8bszWcitiAhbMVQy9Qs7ryEz?=
 =?us-ascii?Q?BMelWxSBfkk8g01jW8DYbYRe3a3C7QRb92wwUdXAVoVsacm6IT/UTyB/ic03?=
 =?us-ascii?Q?8OaFxfJ7EQ4THm/tFkORP6+rLyralZvH4TmJxUMJhastAXKWNNLjTWzNBMTS?=
 =?us-ascii?Q?FbzkSEG/dZh8Adbtc3FFmoNDRZyqq5752L42HpRa0+kCrTEDX9RFQj2vXvH0?=
 =?us-ascii?Q?8kiSjpOEZAozigHC7in4XDC31UfjIgDkQWc9+xKngEiQ1zTvjJJmv+M5/G3l?=
 =?us-ascii?Q?g2KfF5gy7MXhprSRe4ksAQmk0li3zuDbL9edMJg1GulZOFaD/rmo1kr65jkh?=
 =?us-ascii?Q?rRzF8gw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 8j9w1WI2R9re0J8EOR4mlgkVYiQWqU4pCg7MhC+ReJqQFbjcjPmV1mUgnnDYIGtoeOLZlcx1YfAsmTwApNwu0pN9WfIzRPADdkqHtx7NK5IZv65vl/koQlDRJLmWMnBnWQ/HQlXG+8cPFcuDPbhQ/RWhwHL+oH5uCNjSYgJ1B9eV8z43nzRf3kxq+A7FSQrh
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0101MB1558;6:Y/++G/cUa3TiJG5Fm9C1GhiS5bZ0B7PHw+5uB5Yyk7tE0WR5dnypbDYLWeaMMBbs5ZnerjxQSSc++/45HCL/qsXETe8sO92BsLBWsgZxPBMTPKK1EtxAUnHYVnunhpwZJZD2hBHzqipaCXxF1fcbdvrHe0I6DM8wrgzA+A7u3/QstB8t3ZoIF2zrcbpHl8+F1p9psFUEJ76PQqSO5Vbilig+vQHU3BiEp3jbJI9wseJaXovSvTaN/VfTv5XDDYvD5WpxWIaBu6sTY7e/NvA8V+2oj92vrRvaRQrKj+lWaG0Q8ODDoBACVvCf7kyYxW7MMsC1FTY+J8U4LMprY7UzmktmkFYm9I0JzjOylzBjkdqJz2VPICzorfmyVXsF3QGh5dlyNYDyi/wdSFRjtKoC3er8WzydvvmVwDxgxNdh9DQT37obLITHx2LVEE1n+aBGmChRlKFAgqdCpcmHEwfkuQ==;5:BPWQ+NBa+OTt2L8sfQWW9ZDVMzwUVdO5mPAg6l6Z5JKWZbyImzykojbcszY7fmdk/FiDrxRpWoATxaPo0zp6STtcXx9tIX+6jWNQA5VNKARcoRPU5ik+u//fuL7UT3xsdfGcNZF0UAnhCLfDwePcdwgJaGDMUKWejVYS7SUhkW4=;24:o5nJjFltBZE2zRTNxCwxD9q0FSTlbFDhoMOtlv8GqiUaRp8xM1btS8tqnr9lMU2B93JYhSoahkBSHcFRFPtxBx47lBLIGM6ZODeKj4devGk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0101MB1558;7:11Wdhj6HaHsCcbmTVoxWIiUk+8Kt+Gi6KGfGa+GXU2lzFxF2A52ZxU/7Jdl+IJBdcrTgitqOXLpfofURj5/Z2LxUwXqpF/zlPrmlvMJ5K7cq/IC4JthUpelAU11rmEI6qnEJ9ShhEHUNlLWlLoTu3OqJ9UHYVHU8grcsTMICc0jQu6bMRQ09oQiL1NdglvTXA4AsqiS4S2QmaasYNuLcVq29WVCn8dy3FfJcKB8J4+rgk5BaRzJ1FiYvVtUMb09t
X-MS-Office365-Filtering-Correlation-Id: 92cdd3a9-5ecd-429b-a8db-08d5cbf172f2
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 21:07:01.8555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cdd3a9-5ecd-429b-a8db-08d5cbf172f2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0101MB1558
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the below parser error of the IOB SLOW PMU.

	# perf stat -a -e iob-slow0/cycle-count/ sleep 1
	evenf syntax error: 'iob-slow0/cycle-count/'
        	                 \___ parser error

It replaces the "-" character by "_" character inside the PMU name.

Signed-off-by: Hoan Tran <hoan.tran@amperecomputing.com>
---
 drivers/perf/xgene_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 6bdb1da..0e31f13 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1463,7 +1463,7 @@ static char *xgene_pmu_dev_name(struct device *dev, u32 type, int id)
 	case PMU_TYPE_IOB:
 		return devm_kasprintf(dev, GFP_KERNEL, "iob%d", id);
 	case PMU_TYPE_IOB_SLOW:
-		return devm_kasprintf(dev, GFP_KERNEL, "iob-slow%d", id);
+		return devm_kasprintf(dev, GFP_KERNEL, "iob_slow%d", id);
 	case PMU_TYPE_MCB:
 		return devm_kasprintf(dev, GFP_KERNEL, "mcb%d", id);
 	case PMU_TYPE_MC:
-- 
2.7.4
