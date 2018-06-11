Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9LHdFk8eHlsdOQAAmS7hNA
	; Mon, 11 Jun 2018 07:01:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 448CF60792; Mon, 11 Jun 2018 07:01:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sk/jxa6F"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B8BF4606FA;
	Mon, 11 Jun 2018 07:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8BF4606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932528AbeFKHBj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:01:39 -0400
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:55025
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932405AbeFKHAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7ck9/sGq1A2ycE/CQKfguATuxdSZuYNwjBFzvn5VcM=;
 b=sk/jxa6FzFsrAMXdKfBI0FJ2BgkRiHpHPgy7jSPkM8Gln/a/dzLYVHskEGS2ldD3zmQRkQJjojkb0Wl7/LXfi6C17T3xUM4Vle0xGGEl7XNwlDbmoNbNStKLt0898mM8htK0NwJlg5GspENTdH6X+Rh6RCPWSWPU4HrhnFI3wsE=
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3217.eurprd04.prod.outlook.com (2603:10a6:206:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Mon, 11 Jun 2018 07:00:25 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: vkoul@kernel.org, s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v3 4/6] dmaengine: imx-sdma: remove usless lock
Date: Mon, 11 Jun 2018 22:59:31 +0800
Message-Id: <1528729173-28684-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
References: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0159.apcprd02.prod.outlook.com
 (2603:1096:201:1f::19) To AM5PR04MB3217.eurprd04.prod.outlook.com
 (2603:10a6:206:7::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3217;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;3:pCzA1pCVFc/hpiN38GKlc3AOUS8RLH+NIL+qOPQVnOj4aeMeQkanmulNPpgiEcnKoLfX6RwHUIQZfDNSsagc05CXrVHYpwsa8jOh9S+YZbA6ZCdnY0Cyff0KgMyf3VcMkf6F+0xb7/DyGTGX8RnZaXTC/v0ouzXXe6oPgsUFNRTqWESYeLY/x3fN1bKSte6h+OW3MWbKY6qP0jtuaY0zIb2r5fdTnuUeyELsq/eId1IL562QUXA2RWqr/+BvG9go;25:iwC3019H1eF84qcKyA41j25pHaK4REmMKq/m5glsPXvNhIr91ppMfAEOCbLQCPt9Chvpli1lI0s8E5xdxWiz8s6ivnwJ1rAq6FIT5lm8s32NX/F1FGvV2ZZZy8MltXzkk94qcfQvfQKZFmubqnAkgxdxoG9iRaPAuy5rBQtfLRtPxebd5aIqx9sFFFko1ywvknmDHDxgWzTS9MzDkK7pRvRqQgKNDXf1tImjCwondbFsnnx9N20TEkaWdwoJPZDAX6OuYCAOQRYq5Zq6UD+ABadfdGPynZy6NhLsKQ+TTj+/nSd1ue2WXsuqOGa/4K20YPmNNtfGtgNH7jyRVwNV1A==;31:+wDLXUVwz//D8qz8yKo+mtEwkODeuihVoz/0FjxWrYh9+XSTIRg/LAKJrKbw6nBbRfITSmZ2ADDgSIpr8jkQnENkihwvZ8q+BqDwGtUMnVinUnAKxdN+5J6vFrBOgVX4U2XKii+u5Skc5wOCxX6MEJReGhQCZ5Za+x8K+X4xPQrWejf9iL7/CdNKZwn4imXfKU/7KZhBHslOVlkNz71kGKIjZQ0n8iFGnlcmcNErFtE=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3217:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;20:eVxCdSF/7z7cMLQvf/begV1MLzoL/EXgmDrN9NtJTwsHBuWIr0BwE3gY128pKG4qu1Xmx726rSmvp64Xl2d7uuTYEyDvk9yVwMrA7veIYKUadziuPvIQgaGbjwLChdxQogrwnPPWeJB1ph5k2hECt/jy02uMzfye291DPHW2y03bGhQADUSoxDzcub58yeoow5UmGqzOGnkSKIFSN6Uw8+WRW3KjAYzBPzPEpSWyssHUTVdwpLqMnICRUSPexZOINDfAFhJKEPhYUuaUt40c5OukN0aA0siBmBzN37JldV03xhnbXj+jHDgeinVIjW2/IEUJpulZ6KIcMTeytaQWXMkgLlnN5SWhlsoj9qJB5dYV17G8S73oUAHoQAwwGz7ZQmwcFKLqvthuOuIfKNBTL2BdDX2N5k95c/Z1Kna7mCqiU7cXwiIdkmfZQXW+zeNdvFu/VQGXElSPkW8nW/KJmStGPyt9chkvtyXsrxMuwAWO0mPQj5NTfBal5Yc8bhLa;4:eurIhIVQIK7HElm1m2VfJPf7AjqMvHEU8hF1vWSTJNLDTZ8+97JmM7sj7CRbX/J86fi5LJqC47VBFst9yH/QrbpknWPUbr+Xw3jScfcYKPf3SssBQCeyv6rSlfCgr/G7y03ZxLY6Zyifc7ZFyhDqv3MYeVD/G6eK7iQXVjtFfQfVz5NuSLgKAc8NDWDQycydWFByEjcTY0EAfGivACYtPD1sL6WjVE1DsNQQiizfPKL5kMWqvvPPsyUI7syTfxZeAdDKv26RPKqtKor6HtxKAtyl5kDNilBSiztGN6DhALLA+hHvXp0hdW9lxqt4NvNl
X-Microsoft-Antispam-PRVS: <AM5PR04MB32170EC3B00B763EFC1A4D4189780@AM5PR04MB3217.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3217;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3217;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39380400002)(376002)(346002)(396003)(366004)(39860400002)(189003)(199004)(5660300001)(7736002)(51416003)(76176011)(52116002)(97736004)(478600001)(16586007)(68736007)(48376002)(59450400001)(36756003)(50466002)(316002)(2906002)(386003)(6506007)(81156014)(4326008)(86362001)(575784001)(476003)(106356001)(66066001)(8676002)(16526019)(6486002)(105586002)(486006)(2616005)(956004)(6666003)(3846002)(47776003)(53936002)(50226002)(186003)(446003)(26005)(6512007)(6116002)(81166006)(25786009)(305945005)(11346002)(8936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3217;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3217;23:dUqtX94lRJipYMbVcQVCQWGe8FlDhaLSgHb0m7e5P?=
 =?us-ascii?Q?Xosv7c0QDlIbY0iWneXv61pj45eA+mCqiuGB2muNGzuKwwNKoF9xaPKFSdO8?=
 =?us-ascii?Q?eCeJarBc/pNrp1aMrND2+9qyTzMMdtjES4I6XmTBxkUCYoaUMIjQMITWjHtu?=
 =?us-ascii?Q?erskln7GIO7ljMXRnA7BUMQuyXsL+NL7VO0Qnr6rifACwbDMx2zuse8+T0Rq?=
 =?us-ascii?Q?gcVfepWj7TRKP3BOZq5SveTPOg2c7Y/UZZ9i/ijyPCLT6zTGEZAK7MHCzKBs?=
 =?us-ascii?Q?PBlrHcD0AcB8KXqHyFgi8Y3F/yXUdmRre9Ruze5ltsMCpaCnngDepQ5RVnP3?=
 =?us-ascii?Q?qeMAP/98G+ZPd0RVpcY7JZBRNV9R3FiL2ttfARWTTtGr7Jkyq7XihTAFYISK?=
 =?us-ascii?Q?aQO8jHlQIrgVjcM0Rv6ibdDufUloFPwqfnHv5Y8ef+r+52ntsNt1aA5FXaQG?=
 =?us-ascii?Q?zVLVPiE/RneAFytFLtCoFb5+y5D1Ris/x2ZDxAUWFskHcfs2SOIyIJnpz7ix?=
 =?us-ascii?Q?0pTZuzlKPF2GSmttYso/lRvzhYK9O9ZCjvYNls+zvDgqSR+DxXJq1tt+ykK4?=
 =?us-ascii?Q?pw6eGFAwtvJaoLzbUOKDqYcw5eh+XJjM/Crg4P4Ms6pqzTRdodm+RP2VsS/u?=
 =?us-ascii?Q?CAxhqyfTJ2gv+C81vplmcsp3W1aGGA7GtEeu/yT4Lpqgsio7CVJzvLz6gJwO?=
 =?us-ascii?Q?L5/TlWuj9yNd4ATWqiPx1wC0FoYAOAErtVDwbkR/JPZB0inIC9PfpfVrIRaO?=
 =?us-ascii?Q?qjvnxdSk14y/Mob27mBSHGCsiUCu1kHDjuEEy5vrssEaeXeVjC3S6ZTO0vsv?=
 =?us-ascii?Q?TjwmEc5a/cIxII2f5s50nDQv/StVHNO0FtU9ZaYzMA4M33GK45pxh+6fSAqu?=
 =?us-ascii?Q?t8yCmKjfwHZ+IDmwoUNQNAG4be3Zn6x84OZBBGyGpdcOZBHvZ0i6OOD9uZ3H?=
 =?us-ascii?Q?i3CVkVWLY7Ngq6QId4Fo5Ccp+ZkrdVZUppDdWepYdznINOE6X8lKMymmKH/x?=
 =?us-ascii?Q?qrf7h29W2ieqLsC9M/7xdhgPFObxGrOgDxJJRbKsBarhCBeYEkdrkwKUE/EP?=
 =?us-ascii?Q?GEFWI2kq/8ZaX16wG9faLoT1R5C5SHS+U/AkxkCWkS+LRzOgw+Dm6OZ3+Sxz?=
 =?us-ascii?Q?JL1RRKeAZ+NqLL/XoVbEAZnrXVh+UglMt5c7QQy5IhP4tookKjzdbTwjxLp0?=
 =?us-ascii?Q?UHAja0nlag8CLUQh7RhDbft4H6J6au1taYySrjPnRhohvwIWFWpSxASp/Z3Z?=
 =?us-ascii?Q?SvaG05d8YBpLGld1T57zSAl3Gck/48Chcl1lK+yCPz1rSkf0XnnQz/70U5Cf?=
 =?us-ascii?Q?ekI4d6/RC5tOWVpswaYfJQ=3D?=
X-Microsoft-Antispam-Message-Info: 6y+ZH4avPcGzTp+wGD0+cTP2AJLhbj00E2xEtRZuhmFSvK0aJNuZKCufHkVJpggbXz4KRoRqro6r5CpQrj0sP1Jafy95mB0ORyGGnyrR1lbkSzZbC4pYKy/DLo9fp/HoJ4d7fUIBnSapWz+lIQCO5qdx2hZM4sQRvxlIqfXwXboPA5t6JOkAAcPBciXWO/T8
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;6:LUsWtMPhV1AkzUavoTEqLqLxOsuqHEwAvX0WwY5rzhB+7AHI+ie8cel7PDkZD5JQbTAXzIiq7PMdVdpIAKkHaq6cfz3nTX3p6rWQ6uVqpCvtk91TJipMLF/wOG1nufZ5oDUm+EGxpYxqX+dxYtVMbleL9x+Wt5Oyh0ecTs9M2RRRcXhK4Df7JwhNyGT5qOYICKx12s8R/oT7AwM4+i6vHl5QZIKy0dbRZjCqOfSBw4TG4XCVXdYdlshBGKfblnU0G93DOX/UvIUM2OIH8xwvJZ5oT86Fkd7SqrlnLYrVmuL578E3CZb5FEVPQfvIX78AFnMUA+44VPJ9XLD+U74rr8StPsYmFjUbwfwZWNc+LdQfHuK27AwcW9FKGj8q1YdbPKTEJUDYLtDjNFiNlr3Bk9TEnTC2OOF9ltKsOposNK+onfoTGPk79i6bmtCxI6IadYsY/oFA/CtJE7tiKVc/uQ==;5:yYB3kNea/k527IZeR7Y4rOcLptHaEMKc5J7VGoncDTcbqY7jAJVR2TSa0KcQMqwKHyyswWJliEIl40Sh1RQkKc0KmoOGaw6luGVvgs43oAiJ4SnjlKAju2wpdC94Zqz1BxKSP4NvFs6hT//M6xd/ah5l97oXshq2QjRjsZiKXv0=;24:aVMojVQsppv4pTsVE4aPr6i8SvHTVzOZSvexSc+/bXZ9q/nIfSTZeDpbdXOwmkkEZoJk0b6sA9TUkLQMWUk9w4yfBTGQEXNvJdQ4RaYVQfw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;7:hVcDk++RhGmL1d4DvHEIP7BPpaQglJ28AL2qPzDtRFehWfF2Meq54ja6/TEpyNOCjpUy7q7ulgT0O1vSiwlv7t2TWa9CNq4RWp66zgYZ9ns1yEDoX8PW4ByO4Dn1jUqVCVpXcS3F5JcYp0mZlQW0QK5FcjdMvQHsm5Qc+6M7iVpsF4TCYU5gPee4Z+y9Hk+GHcY3Hszi0LJcLBbKqwVD2Ht/Dd/wyq4pk1YRwTmC1xO5cDWs9Qr/iqd3vTVrnOzU
X-MS-Office365-Filtering-Correlation-Id: 02b8d883-5c99-47d9-13cb-08d5cf69032c
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 07:00:25.0310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b8d883-5c99-47d9-13cb-08d5cf69032c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need anymore for 'lock' now since virtual dma will provide
the common lock instead.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index e0af8ee..f150b38 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -349,7 +349,6 @@ struct sdma_channel {
 	unsigned long			event_mask[2];
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
-	spinlock_t			lock;
 	enum dma_status			status;
 	struct imx_dma_data		data;
 };
@@ -1907,7 +1906,6 @@ static int sdma_probe(struct platform_device *pdev)
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
 		sdmac->sdma = sdma;
-		spin_lock_init(&sdmac->lock);
 
 		sdmac->channel = i;
 		sdmac->vc.desc_free = sdma_desc_free;
-- 
2.7.4
