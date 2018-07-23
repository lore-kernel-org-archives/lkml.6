Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757D4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B54420875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BlqzJF8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B54420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388351AbeGWKqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:46:16 -0400
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:29424
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387957AbeGWKqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYR6WX+u6+d3vL7+0QkiTo0t2BvjvxQpYEVGrjfuRMs=;
 b=BlqzJF8vzOCso+EA6B2odlpel+HQslk8AkpeGqVIPNuRH9xnqWjFHdmWX00Olc3gMqTygj0Lf1v/aQgmUJF6q8rRVTzsucn1bN46o8KpbArp2oFCnpvwIv6zL0jJTnKu0GgFt1FjGm0VoW947DTKu040MBHxSm2MPqJ2KSyv0yw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3232.eurprd04.prod.outlook.com (2603:10a6:802:6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Mon, 23 Jul 2018 09:45:46 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, s.hauer@pengutronix.de,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v3 3/3] dmaengine: imx-sdma: allocate max 20 bds for one transfer
Date:   Tue, 24 Jul 2018 01:46:12 +0800
Message-Id: <1532367972-29707-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
References: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:203:72::26) To VI1PR04MB3232.eurprd04.prod.outlook.com
 (2603:10a6:802:6::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02b5ecce-293b-437b-c0e2-08d5f0811274
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3232;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;3:fhZdM9gJOXXep4ktaAyzpxY8SghKgwWhfeoOitYPNeYuUisjSoQhcf3kYD2zeFMTmTrEWIR0N9lMsG0TpUWCIzHZP0X5IwPO0mbmtsfbbB8i03xwXmlzad21LiTBkR2cCg8qnnm0nO8lRvYjzfyfl9uEGNIVgqu/Ut6WTQqreUC6dzsPy9vEggpsIgpdEMWvtvku/Ur9MG5HRoo2lyHLODoXeKFtGUu95DFSGkei+oqhcYjfJakIBsc3RVJs8CAp;25:DY+DG6fqCFTHhnuXRz4iT5Fc+DEEOKhehdqSJZcWIj2oXw8RymfOn+SIrYkP3sMdZSMUwKqxitwi4LHrTZmk4zjdhZvg+zfWE+DsO02yFP7SrmLRA1ZWbdCmPNOGffsPKe9x9voYRmiVjjB/Y/rr/rfBI9QC3NTEAQ+AcyjelDrB37RErA0WRVTk451qZub2mGjqjd1IYeK8dFg+Fhm8cEYtkysIILOZmXdn40apMufPwqcIEmUbLMWeuVqjKyTQmrcE3tNA++L2/Ilevg7TEksUboIu1zRR4q83ZY8hSjZMc+W3pLFqtfIzOHW95u8QitPKWn2XktSgv4acc2mh2g==;31:bPp6DembvxEByuiQDig2nFICjh6A4M3FngR9qD+UsUwncecfbDZe45uW7oh14xDOg5WSzbwH03ilnARrsDaDJyazSDFjOzedR2jZac2Aq5NTqd09P/RV6t5TU0qJGy37ju+45J17lz4uZ6zMfojDStYLi1kyJtjKamvfZJaIHnIQvrHkAKDzApaoL7FIxiW3yXVynz0D+qAXh/Th3deav1didXZL4c1uJYob07hfNvA=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3232:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;20:ulhu/s5j/Q3EYveHYGeM2+NYZxLXFxF9yjL6bSIrXzs5qX93sye83Mp++KKlO8JE5ls7D1ojNiQwURYPTNrdc8PuXwp2cDCI6uOw0V4GBuzIdmDDlBHgoawTTEC6gUABMzei4s4zIPiq5Oko6yPXzn+1Bxi9rZguwkqf8N/Uw5Qxsb81XQwFoOqnJm1bjfmz279P8qgpzeAMjxd7oEkMiBi4MfCI7HXrPg4n4WJLD1raZBwqPzxjOoY6F/BlTfM8Zgm5MemkfilSFJe6yvVD8yo96eLIzD7xGAuvV+jFDrdFaQDno+vYQyKxqPSpJqmK0I+MTdNFLUtLDsCpjpd7vqWJHhBxXaboFbJhZjAAJfhZoi8qtfk3IzTU8K+j74jxe4miPpQudLzyxusZD3Q3wgYs10p4apXzEXj22CMDThz1mvku+BkbIeQe2DIAbT3M+gGHup4uUU++ovg4P3ss+/jwngJdCG40rhfueqwUTLpvmwWjS42U3fJkizbIrln/;4:HCROHq7sRPUMjltbI7O27ffrFFrCOOn4aLNs1WT/2ndnn95DCUMDY5yXHIioYQLjSxvMwgIveC6J1yDKmCyz0pn5F6Qn1c8ujokfe5JW80uCbHO4dp5sUraDfGXZx/JU1xgoJvIVzq/EnbqWAKX/2Df9fsTr+/ym0rDDWyZjg4hEp4HnvRGMXF9yRo2ats5BuIX2NsMT3eXat574vcXhCgJtb6I4d15/qYKK67LwbOvt8qRmJK0b2XoTeTQ1rzg/u/EC5yX/gAGaqNCbzwpB4bD5FkZWtVgKlTmtmIrxWgcWmp1DqwOWSVU2cbei24w8
X-Microsoft-Antispam-PRVS: <VI1PR04MB32324B8C6FEDDAB3E692B83F89560@VI1PR04MB3232.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3232;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3232;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(39860400002)(376002)(199004)(189003)(16526019)(6116002)(3846002)(956004)(8936002)(66066001)(47776003)(53936002)(478600001)(305945005)(26005)(50466002)(48376002)(476003)(2616005)(6512007)(25786009)(7736002)(4326008)(11346002)(6506007)(386003)(14444005)(36756003)(50226002)(106356001)(97736004)(446003)(5660300001)(68736007)(6666003)(105586002)(2906002)(486006)(81166006)(8676002)(52116002)(81156014)(186003)(86362001)(51416003)(16586007)(6486002)(316002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3232;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3232;23:f9mYoH6F34CQFEt0o0BF3pKiBOtZLfutgZBlO7eaG?=
 =?us-ascii?Q?In3e9Qif2JiHct9KVMvLtiK2LGrEshVrA/cu1GZrBAQJZpE+LfVZIHQz2xD3?=
 =?us-ascii?Q?FeVAYjUUeVzeZsvnt7dpy1XlNs3gvndm/iYPp2kkAXRYU0BGBFr7BoBxIB6v?=
 =?us-ascii?Q?AtmclTHj5rc5tq/3+OGGmtAksjw7WVC6TdHsaVA6KkfHCmXaQw1FzColjDWb?=
 =?us-ascii?Q?RZfGC46hfUw3jeF0owsKcMqM5GwHeUmQG6UeV2yVnaih8YDTV5c+vd+/gdUb?=
 =?us-ascii?Q?+bnBzEeWpsCdUzjL/FPauowr37CBvJOvDxTKFchK2XBMWLsAn4fRU3r11PuP?=
 =?us-ascii?Q?Vicf0f7earQhkunmAabf0BOOQE2qTj8S5G6yT89A/UeCSgYglctFrLdM6BWg?=
 =?us-ascii?Q?3JVXH/KvsQJ4YeERSRKLOllKZCj2mO3LljSx4AN6vAZoutIoHOgmk5HPcUFr?=
 =?us-ascii?Q?yQYGrICNrF3lbHp/RbDacMb+9StGpldxNUWG6Wrjc05hiPsOVFamQBcKM4Ii?=
 =?us-ascii?Q?LUedJbca29uDXKDrk5UAs9+z+PBWMneOCel261mMBSFEfsYkL/rWjveMeDtc?=
 =?us-ascii?Q?7GK5mgYfSva6E0k1EnLgQuPH/Or4jEKN63R8zez4GussPuqY4xoYTDqN3zHm?=
 =?us-ascii?Q?jF/4iF/Q0YWytAQ1b2NeLLNhxad8cOp1GzX5X4iAbHAXLgLVNlc/LkI6WouZ?=
 =?us-ascii?Q?Y7RGwQuCtgIjRbbBoQSMQkl1OKo8fLdXxOOz3cE+SDq8v+pzcnTZAZoqFBqp?=
 =?us-ascii?Q?dtlyJIN2ATLbx+eoKx++yVIrCJPQ62VNVLo1odo4PhAxuuHCuBfdH/NnVrJE?=
 =?us-ascii?Q?AAJ4Sw9ven2HArevWx/SeGHWPJG4rIzdD0qilOGNg39Mh+mw4EtCACXkaPps?=
 =?us-ascii?Q?JeU7Cmk6rCWKtxOvKd/YlMMcSVWuQv9EkXLOUzlTyzX9YUd2EsK3O52NYPa1?=
 =?us-ascii?Q?BuRyqt92zJEVImh5iUjC7JbdUQx+Bpbh4D+XrYZ6lExLDztkc7QCBxYZFSaL?=
 =?us-ascii?Q?qEFsE+qfPUbfxc5wvrCMBGdEOpSDEmO+hLvt8p0yxQ9mYlxfW3aC8Hw1qbgg?=
 =?us-ascii?Q?6y7KwhsL0e6tmZ1BoamAOqrM+XCDivHSuVLL2dC97mo++mpYrhA5w/8e4aLd?=
 =?us-ascii?Q?7RnIvFTlpxoiCHGVtSzFYVV+5WTNPmcUZYfYF6Bdzx4uTZj0dKh9Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: akzLU7kbeeGyjEkfKYCh+XyajDZEsZLiI0/O4EULd8PCRTVPBB7qaeA8P0divMzU0n6fU/YP/FuEoLdqXsL9RVeiCA1Kjppm+LrZXVSVgCZ1q10D3MLsrEfldrcpMcN2vtyyBcDwYbPRQotSCD4Vz39JDG9IXt6qZtiku4io4+Sno5kq3XKLEVTEdbyXRa06XodgNhJDTrWx30pRTQZj9KhVxbBufSL+ChyqmIScxJUoQt6wUWNUFTkyJGtT85IiOhnBd0pG84B9TdvxFGn8SfxTaKMoIi7MtoII3gWAC5YiZUQEd1gsdH3ULz40PoOXmXAity5Na6j4w4q1PFSH0SzSVRk0Es6BClClv2fARF4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;6:axX8SHOwQhJ9UbgBdn07XFFeCBQaFkiNMg5kA5pwS/2+gRr4JZkNrPvxpuDg9L9AK9BOSgBfyoLsR+seO2VLfPl4z8eaikCCzyBO2MvzP+vGmG6J1wsps62d0QxYHZdpovqMwPMNLlPNW6yQ1CVVuy7CvyhUBrrNGSL0gHcrRqHBm6gcn/eUPcv3Va4jGOBtxR1xBiGmcly0xlETT7UFL3OLtezBa0S1EMBeSHkO/viStJfHnGdhXJsol3L2dFHhzFCJ9NyfA0LqGJFJXt3x8sEvhcetAlCAAntPH+J8/xr1JyMFbzn1w2S8Vwvchwuu1HfwqXite0F3ZtEdZ8E9fgdrHzBCoOu8hUwvj8hmGNt0F+rP3W0E09x7eHotuGbbsJyudMtobwzcxyfRae79pDNtIywQBSV04+71PflxPorEdYQFD5/ROANlfcLT2m3JV73wdN1QlQz4+81ioWggyw==;5:Auo8fmFTVQHaVOl5anYZKQ5gIiEMgYWCmG6NGUlTzgNGvOMniVuyq4CWF3DwqM4/lkJ5n1Nr/HLVTYAmXmJcvMVg6O2JcSDCdDo1A+poI7Z7k/g4LxvFg+JgM/2Q6a2ALkmqU3ri6apKqNkSLnDVXX+0v/i5nkm4ItwnBnhP2Ks=;7:DkGpiZljAioVXCmklDDLA8fVITozE6K2K6RmY94NF3lR7HAu0hxR1U+saLOWDx3/3wwwjFJbVBdiC9Mx5yvQtCmw2hz8ZyaCO/wk59zWKYn2OskRVRdEcRpuhun+vLt3ym0x7jiOBsnRkxb3OEzOm7RA/TtB6mOAKbteTdo669kwg7t2eGaSXL5ZdOfMZTsvzLEpZHeGNaP+gtaHR2SXJqWBlNH0nyMujhfyBRG1uIcJYW+L2kvawl0rHh2RT/9o
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 09:45:46.4662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b5ecce-293b-437b-c0e2-08d5f0811274
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If multi-bds used in one transfer, all bds should be consisten
memory.To easily follow it, enlarge the dma pool size into 20 bds,
and it will report error if the number of bds is over than 20. For
dmatest, the max count for single transfer is NUM_BD *
SDMA_BD_MAX_CNT = 20 * 65535 = ~1.28MB.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index b4ec2d2..5973489 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -298,6 +298,15 @@ struct sdma_context_data {
 	u32  scratch7;
 } __attribute__ ((packed));
 
+/*
+ * All bds in one transfer should be consitent on SDMA. To easily follow it,just
+ * set the dma pool size as the enough bds. For example, in dmatest case, the
+ * max 20 bds means the max for single transfer is NUM_BD * SDMA_BD_MAX_CNT = 20
+ * * 65535 = ~1.28MB. 20 bds supposed to be enough basically.If it's still not
+ * enough in some specific cases, enlarge it here.Warning message would also
+ * appear if the bd numbers is over than 20.
+ */
+#define NUM_BD 20
 
 struct sdma_engine;
 
@@ -1273,7 +1282,7 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 		goto disable_clk_ahb;
 
 	sdmac->bd_pool = dma_pool_create("bd_pool", chan->device->dev,
-				sizeof(struct sdma_buffer_descriptor),
+				NUM_BD * sizeof(struct sdma_buffer_descriptor),
 				32, 0);
 
 	return 0;
@@ -1314,6 +1323,12 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 {
 	struct sdma_desc *desc;
 
+	if (bds > NUM_BD) {
+		dev_err(sdmac->sdma->dev, "%d bds exceed the max %d\n",
+			bds, NUM_BD);
+		goto err_out;
+	}
+
 	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
 	if (!desc)
 		goto err_out;
-- 
2.7.4

