Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4678DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04AA24650
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qHbNefzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04AA24650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbeFVRDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:03:20 -0400
Received: from mail-bl2nam02on0061.outbound.protection.outlook.com ([104.47.38.61]:58464
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754595AbeFVRC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df0cUYgXRkl6/nzcXbaxbIZKaYYw5fHq24tP0QaJvrQ=;
 b=qHbNefzAxfvNDUqVnUgDRzcdWxYMIGTGlF+ew90NLuqgLvVUpOxY78q7L+W0yE+nukBl8LMFp8kEWnTEnjEGUcTTcAliTFNAx3jqeW/zWRxIsd81bVV5Lmy2tBcF+RvushiYyXrDyGZt0MCkj3V4mis//RfQkVx7hY837TJ2PYo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from ssuthiku-ubuntu-b2.amd.com (165.204.78.1) by
 CY1PR12MB0133.namprd12.prod.outlook.com (2a01:111:e400:50f7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Fri, 22 Jun
 2018 17:02:23 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, jroedel@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 1/3] x86: irq_remapping: Move irq remapping mode enum
Date:   Fri, 22 Jun 2018 12:02:05 -0500
Message-Id: <1529686927-7665-2-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN6PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:805::19) To CY1PR12MB0133.namprd12.prod.outlook.com
 (2a01:111:e400:50f7::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98419757-19bb-4b71-f2ab-08d5d861eccd
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989114)(4534165)(4627221)(201703031133081)(201702281549075)(8990104)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0133;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;3:FHyqeCa+N4uspnRoTZFV49CL9vZNklcooZSy4IXxfVzrRxspwWcaOQUiGXMyGoaY53GK2sDI/Xhvs6dJAE9a2BD6JMJB3RvjkRrIyYC3+Cl+PKVBRXvA4dku5Uhqf0JnqEcp/zoRpJP1gBQEzvQYIq0ucKLcEa6CzTJyvjoNdUjKcrdCsjiM1DMwM90PhuTU2j/xx19ZRn3QM+u1yJFhu5l2Oy/blM3SsLYu2VY501zJqTldXEEOb0FqBV3xzHyW;25:WA0RfQ/p01NZoVtXbfv1UVJFXvQIKlFuZzpl/SI/VzG4Up6g82rPcNAv/dWt4A52/xRKdvKI0ha34Gq4XDsQSGQvyQBk6pW0EBoKu8/yXOXo7P4ujQB3hP1x9zxnyHM6zqsev6XIxLupOqkz+fN5yDwm96qnqcLdGlysm5G39ssxlBQVgnqzA2KJfX1RQoVkWy/zucb3lSnycoIr3NWi83E+k94ejXEWD4wgCHIj0/63Z9zw0QYviXcMZbRIz1f3lPJlRFH3YqpR2XKXwsQPLKCE48sql9Ovj0OeIjXNubFaXGMZgnH2zw5Ne72Rl5enV4VZ11xazRveA7YulNQDIg==;31:xMf6pTNXE3/hEI4ScG3yM9gaXHmNMQVmV8MpoEU32QxbcJcu/LdweYLzsc4bfkQI9cdgfjX3IFylp0wcxvDPEhsfN/wwrT/WotWG2v6xK1ydvICQCqVqZkTJBRPku1DoAVG11+0P+enKbagP/N38vCRWEQ/zmKv4dgFWe7/yJwMP/NGFHhxa8Cy/q9OKr4MTzDo3ZyoQCFmnPluz9bz11OSSbQs33WXOLVVth/RjPKI=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0133:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;20:Iw/zVcr3WIEcZN5JpZ4QKFJ28L/oDdtcobZNoGgqsUuW/U8Mv29QeawXRRTODRgVa95Q+2AhhEWFN4qiKMqmnhHp/UIRBu1XzR2jfzng67b9ot3TZoT+dPeN+j+V1hOR4nk6DFhBzA1dWkb0frqDu7pEP71/M/tErvgdv8hdEMoCgoScPjAHCXUGSZlsqC80Ob7oYroglebndsqAtUJ0EPXEb4jdx3l52wfVP2UOQParXOdBM/4mombYLpli+sh1JShuZQyKRgoxPDhus159r36TMVWSCdSu8ij94WGHmangRPIZc9aaaMhF1K8RlEP3umi6RoDHZMHkrNCK+e2kiWJV1w122sVqvBuKln8ipgmM0OvqDFTw35YWMRAgklAlNfoFxQNsfgGDRAIupQheux92NzWCf8634K245k5MlAh8gZWmSdF1uHUVn3cwCd2jsiUKu1YXKcK5Bu4lfGVz38heAkTbIoTVSWY+/G70vI2UVnHqr4D1m6d4lDmv5AV4;4:ey3YeYC7vvhjyN1V8CoS35K8jDvsTmSBFw7ZRK7fszV6oCRX/V2mzsfgZQsIC0ll5YPI2MjzhoKtN4JH75eKOmfh9tanZxc75D8XoxNw1Gvg1p31gl2tk7YkhkAeRXcw2KyVlk3Lgka4nNASRkUgcXtAMKp0Wgtjq3NlR3yazxsenBk3cUyVYEhEHQte17EKTM8kTVtRjomBx61n2CxhVLFarOmVD49yrcytdfdEFwFJEWojSPdhbFQd5dDJo/wRv68jetFpkBSKCGbyCRWK/N1SBwQvKhyBXC6iZz/1o09AGqQH0G33elskbO/xa/F8
X-Microsoft-Antispam-PRVS: <CY1PR12MB0133F786304900AA533B3157F3750@CY1PR12MB0133.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR12MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0133;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(50466002)(7696005)(4326008)(186003)(52116002)(26005)(16526019)(47776003)(53936002)(6666003)(25786009)(386003)(5660300001)(6116002)(66066001)(76176011)(478600001)(48376002)(3846002)(72206003)(51416003)(956004)(11346002)(476003)(44832011)(2616005)(486006)(106356001)(81156014)(81166006)(16586007)(6486002)(446003)(50226002)(8936002)(86362001)(316002)(68736007)(36756003)(97736004)(53416004)(7736002)(54906003)(305945005)(105586002)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0133;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0133;23:BPhr2rgpPTPSxVCEUyEo6GgjHhAnYtAytaTjeHGsF?=
 =?us-ascii?Q?LvpFd1+nBja0f+3evEumB3P7UmV63G3PlmgYKZU7cUiKt7jeaBiPZvhEJDmV?=
 =?us-ascii?Q?HYj/cJoMKyEXJOTxXMxCobS5knk3yprQx+7kapkQkWDmuFZyoaOPMh5B6WRB?=
 =?us-ascii?Q?CckLb1nfjhDLQWpFNbPKm9nY4QlUm7Jb4hYuMibAVj9NUG71Gf/zGCVTfpxn?=
 =?us-ascii?Q?17x21KzcSloOY5GrUQv8sET2DE/DP3M+YdqCLfvkXIeAPJQRO7N2WrMufjpC?=
 =?us-ascii?Q?Ce2JN+H271Hd9C3n8Do3qncl7HzxOPh/rX1+/A5ffQ9t3KENEmyGPyg0VmD3?=
 =?us-ascii?Q?nlP8+ClvtPXXTuEnEU365Z0ysZBvgylD8o7dIOOYyZ1BJAH0xbVm8vxformW?=
 =?us-ascii?Q?LOb505MrCaaQjyEtwQ0Fhpi9QGI0nfuTbOCMs40FNgA/POmbSR1sOk+464nf?=
 =?us-ascii?Q?yqxVkve8K9clbKWK3aRMrfqF2h3FF6JIXiQJr2IGsOsHaUgmAyUiLGV20IRz?=
 =?us-ascii?Q?Ocpm4OqsYxryP4jfsILRIQakBkQt/ihMZ+sBcg9f4qXwaDj/2mXxG7C+BDMG?=
 =?us-ascii?Q?BPb+UKUnWea/sz8//R669CCqa8VqZGrz6UjB8qrz2sG5gM0TRg00L6TEVaYi?=
 =?us-ascii?Q?LhSN37PGnwDNN6A5tpokzqExUHNF4vmwGpTGtfO1w/NGx0Ox+dxzJ3nMSmgC?=
 =?us-ascii?Q?80ZAOHX28BUFy6xbW1ERjqRII7A7YzstpNtg3fJPWqwUeRwFMe5W1FtrMa8a?=
 =?us-ascii?Q?p7aVg/flxav2RUdON+CrhrTAwwPZlNCuH9mQHBXxT9Xot1AHGPl9R13Vpz1w?=
 =?us-ascii?Q?fRwbT3Qqfs1Wok0S6eWYjDppI2InZ3ZDRbzUVRXOBO4W1lt0sOhO2dSWNFbF?=
 =?us-ascii?Q?15pPPUWwW5MBCXqlOtghsh+eSoE4ilf7ZRRl9snbtU5ZvotBfNv0fYUnAd/y?=
 =?us-ascii?Q?PJ8E3MKOJuu9CaUOUZr3c23P4iTJ9k+n0EKxS0GrbaExCZSyECVrZ8D/yNYd?=
 =?us-ascii?Q?wSq7HTCxIBsZVzv6yH+uH72yjYgsyKvorLEtbr3FQxcJjiQyj3OOmnOC09Ho?=
 =?us-ascii?Q?zctY8GUWPiV/Wm2W2F5jFQIlCEMVpt5Dkkr4nz2bxe44JTQcFsO33/XMIt1V?=
 =?us-ascii?Q?MlGXyTW4GM+y6EecAuCF0RoEORyrFR5kofE3f9UGAxlmbiZTwZOfFURioB6C?=
 =?us-ascii?Q?8wxP+wqV87CPdDvtm4XdHvmOAPeVeCrKOwFfaVnPYW1rusF2ncEetNhEQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: WaAY7ElLj0uTguMkiTJRyQexibpMEx9qyWgtEp30dc2mubMpVWL4BbSD1l7xTUwXBGFSkuZ62SClRKD2/pC7eXB2aBnfoo8PsTX6VyW2K1Z8OQ9ZV4pmgjq0eswNVqoG0q1hevCohdmmN2DzFLFTerbCGWQ0cgoEWzP6KcB2WJefBz0xS7UFpCkH6EnMJc4j5swnJfMYmBPYpFQGWQQV7nflUbXmcPPrSqsyWY0RzMIpN/ZwbRrh/oXDCsiQRClMS9N7c/5VsEfrxOZKQZEfFrcN7Ig/5dfthldfPROxIV7B0BW26q6KgLfHKGoZWKyomLu+EPCJ7EAlxWxE5JKkEIn2eWEaBczBxLRaoFIzpCc=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;6:ST5rcuRxP2CkyF4i5FMKRIaWt5QCTqS6LMbCmt+DXiBEaUKJJLIdl61Cy0QIk4DG5keUdSi96Et3mQ0DOkwF62RUl5Pnd17Bg75++TxAg1TJjm9vRjx1Sz9ZtSCXLTF0hlPf7FPTCM4Jzvj7+6LSsMAayFK0E4EbT0+ibJ6Tj0PT4DL8DNDEDw1dhyymvKnQ8pzBIrTmD2y22FVXXeFeumieL7LDiEYHA/0ju4YEEYTQ1bXLkBVLu4O+DteycnHfoG1jwlYglFjC/VMvkjqhZmvP1WgbaTpnhoj8j3V8Zi/+zkeZkuuM7pAmabkTec8BzoN/vg8gZ6PN/N2kL4f6EXJ61uCjZReXJj6h0+Rn5slJzpaqv047kJaJoWSydQQIoYLxtXWUnebn+M4dqoqwGc7ziBCs22lzlw2MrtVIJAlYZJJoNmho/ptvZLvZXXNqedyVhEOF+DE4LUDr8Ox16Q==;5:0sCCo/42zufz59wvZYM3rZ9aw3jAuGmBN+ZLMcSPiPGEZp9Jdt65oif2pTczcwNZh2SM/FiGqV6Cwn4B18GYAFlPyMey/61H8qOKuHHxPyiPZmdaIDZC8EYJXNyRjUeZnN5uVuUk0QjhK/wWXKSINa7rcJ3k+gYYE3SiorveBeQ=;24:SReThSPdJv+/w+SvLM/wz75TsNm3gJl3zbb/IhHzToWPHfFJs4RChwHWPI0kSaqzm6Ux8QhgfYY2+NU3RqYnDrJ/5aCxcb8Q8asahLVvYo8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;7:eNSXYfZWvlcWi36kyC2kmmeb1NtaB0DIkN3rYvQp8fgZYv8QDUQMfj+gT1jZwDl/4PuPs7a+8UD3bgsYKMBhpoUgya1eqgB/zBm8ntllPceVNg+G5pRq0tIW35VN3J3vJ64Fxdh5CDHop3UGKhul6y0T5GYmhrkBN0ZzXzW8I7fG4WtFgAOQs+Q3+bPIXioz6Hf5t+y0ecHCBSzEzxOtX3ELusbFO6imhL15sGbYavipj3Ji5f0FdpgB7cAaHlX8;20:CrmV5PDTT0Ojyk1y+gEgdY1EUXBl8bemL1WaWCORiC2HzrvH79zsGscJlI4X0Qr85Xzd6ZDZ6VOlXUTSAgCtMJoErUiIu5yuXFUmHFRuhCzSPcFKDBZPh/fTcgFtvVXFQCz2Kg862h7T45QiXVk4yKIhDJNC8IZAd5+1878WRLVl1akYkdhh18ti5yMbwRKgoG3UwzmS4Uew5CoEhP4vPHbZhKCCkxWWipkn2zHV7MS92kLJ7Q6CowwptJCuUHHV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 17:02:23.3886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98419757-19bb-4b71-f2ab-08d5d861eccd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum is currently defined in Intel-specific DMAR header file,
but it is also used by APIC common code. Therefore, move it to
a more appropriate interrupt-remapping common header file.
This will also be used by subsequent patches.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/include/asm/irq_remapping.h | 5 +++++
 include/linux/dmar.h                 | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 023b4a9..5f26962 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -33,6 +33,11 @@ enum irq_remap_cap {
 	IRQ_POSTING_CAP = 0,
 };
 
+enum {
+	IRQ_REMAP_XAPIC_MODE,
+	IRQ_REMAP_X2APIC_MODE,
+};
+
 struct vcpu_data {
 	u64 pi_desc_addr;	/* Physical address of PI Descriptor */
 	u32 vector;		/* Guest vector of the interrupt */
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e2433bc..843a41b 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -265,11 +265,6 @@ static inline void dmar_copy_shared_irte(struct irte *dst, struct irte *src)
 #define PDA_LOW_BIT    26
 #define PDA_HIGH_BIT   32
 
-enum {
-	IRQ_REMAP_XAPIC_MODE,
-	IRQ_REMAP_X2APIC_MODE,
-};
-
 /* Can't use the common MSI interrupt functions
  * since DMAR is not a pci device
  */
-- 
2.7.4

