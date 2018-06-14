Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D197AC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A7B208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M0pcHezh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A7B208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbeFNGFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:05:48 -0400
Received: from mail-ve1eur01on0052.outbound.protection.outlook.com ([104.47.1.52]:25664
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752707AbeFNGET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJEStYlyUo+3VImJbclMrVeIOJislYagF5VTHz4qP3U=;
 b=M0pcHezh5V/sI1NfMyESo8h0FpUzhEDQ8/XXqOSnTOZMUrT+WyX4dwEpKnZNvySRVLFRVtxo+1dPkMo9SJMWqFDd3sPYsFdxEg9idZ8z13//AQajYOP+KcFrjMaWBk6YHjNwapMI8pcVyaqwTIxnyp5wrwRVnE4OOoSyG+4fZmw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3219.eurprd04.prod.outlook.com (2603:10a6:206:7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Thu, 14 Jun 2018 06:04:13 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v4 2/7] dmaengine: imx-sdma: factor out a struct sdma_desc from struct sdma_channel
Date:   Thu, 14 Jun 2018 22:02:57 +0800
Message-Id: <1528984982-5074-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
References: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:203:2e::26) To AM5PR04MB3219.eurprd04.prod.outlook.com
 (2603:10a6:206:7::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 676171de-e352-4afe-47ff-08d5d1bca924
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3219;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;3:iVYIeYp7E24mZKqOkHIK0Y2M89W6cuNf3DH5ZcAvsG19dY1+VL6MK9wPI2cykbbJN+9yfR87afjPy99bdidv1VWNAqowcwesYdq604lLyc50CjKILjIzX69QXOfrSAiy4hdB1x2lw4QiHvq/fpu3qzRwq4Gx2RJ3cSAshC0lRseeW+aiZwGWdlK6n2WodTWXgk7uCxZPUPgAHKfs/Hi2Z5kTnVo4bQdAdnHG60Xqej1BVNXAYUDCJwpab7/mMRRA;25:EzvjoSpa+88NvV8CUWgw6uDcCdwjq4jUHm8Kn58jwszDSSfNW1UFWoUL2nEPTFj0U7vEjBGisQA0Gslfw36pszDiPY+RhMrGv6mFJq7+kucbnB4zkaWoIX4acq0CIb52800mVqDr08dDgLDMplf09ikSVSMSvydHd5gUBpZ1b+Exv/7u1UbKQ9voLrbulKDaLwvP8HePFTUkFQptP3SoLYxZeqGtaTjiFru5tpfMYrg3ph+gGQ/8V1zQVVuSrfInYEbKU5Gu1Yjo/pZTIzmSkjUyNZbu7wegZnF9XN2qsDDP+I1Rbx+aQlYqXLXZp49wAlXcuE8sviFtOugT/1kl5Q==;31:OJ6QTTzYjmVE7vBzd56MyyO5pCFExGmkTnyvexyBF1HMKEP1ILbSKdCt41wrbsRC3xfz/b0l8AGOUGzWJ29WcMbUKJacels6ljE3tyecAb1ZipFAeFDwWy4GCRpjdIYl9cZAwcJuetRW7kuPVxRvbc98SmEPrFEGiYdQ/v2AynwGotFFQ/2CVRK+aT0w1HCqUfMx9H71ya+ew7zoCqTGdCf8kN0RSv9liFVEE3wwvWE=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3219:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;20:6gcUilH6ncTlNAUKQKKayb26J25fVHw1Kg5dQybRt8OH7DkEuoKeZpuocBKgrvLQzjrH9qcbmkYAyo3jLX89M1eBZ3utAORLbA/lQLqov9nyviqv1MQ1nwj3MLKilAqBigCeTg3mETyLUEMq3gOfl++kBpNowybqM/WQ/TWvDsLV4QEQKmkksZIsg5cRlxDjwB5XC1QSvY3paIKFb4CfUs4pcZwBS5HDhmuGf0UsmvZXqGSaCSMW4+yLXWpyXZrwIbWKm3rlhundpzIsU9sKb3mY6ppNOvRZDL7e5P6M83X6nFG1uoCcSvbwUByyK62dWmtRlS3G0O8Nio0xy97Zg6D3gyGKGa/pZcmDRPv0yEWMKdqP6e1nqHwMbdtPIVIC4ibhlZuyT0LrK6JzYdznEvuCdgLKGWJ2JAgtoGTepsgoYcUv/fmkd6ZGqNGoI8LLxVxxzL06aSYueS91Nx484IfTJNeV9kAKbjfNw05yyzKN3paWN0TJD3oP0oZDPrtk;4:21gYzU2/iGDuPYZTbC9xabYaz4kHSaxZNmKprEw0HcDFroOPqEhrsqhaOGkieEfsX0D2mE4m6mfBpxhHmCRIDfUqp0615cD5Mx2Ta9NFmSLu8X4CF2Fw09IQHPLHAKanJZc1z7JiA8uZaP5URqS/O6HFmyOKMxcek6ZhKHBSzTpQNYukmTj34zEN7+HunXYhdOv/QfwKjZUr5EUlIPZNkF7s27xyryjpn/iEVhp4D3IF6BBwP4VZGhq4+hTXDh2mS5e/SN1f5edhe7BKrw4mjH2FySRMxWOVRP8wSajEWWi0rqnKT8UkV/NkQ6BoC1y6
X-Microsoft-Antispam-PRVS: <AM5PR04MB32197570EDCB189191F1B025897D0@AM5PR04MB3219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3219;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3219;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39380400002)(39860400002)(199004)(189003)(68736007)(59450400001)(478600001)(7736002)(8936002)(305945005)(66066001)(50226002)(7416002)(86362001)(6512007)(3846002)(6116002)(47776003)(316002)(16586007)(8676002)(81166006)(16526019)(26005)(186003)(81156014)(386003)(6506007)(2906002)(52116002)(76176011)(51416003)(36756003)(6486002)(5660300001)(4326008)(50466002)(106356001)(25786009)(48376002)(105586002)(97736004)(6666003)(446003)(486006)(476003)(53936002)(2616005)(11346002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3219;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3219;23:3Gl8LthG4oKhJFk2OL7X04VVJChQgyGK3om2VXZZd?=
 =?us-ascii?Q?lW1xfbw6+OhvXIdmgHVFFNsbahGGNnz8Qj5E9bx+8G8tF6DfBK+stTvb7Ou+?=
 =?us-ascii?Q?fytdKUv+4r1Os44W7r/f0hXsSoj90cCiPi4JJeboNzr+vDo0daAvwN5+7rTJ?=
 =?us-ascii?Q?FgJBil70ky9/JnIRkF36ZExrkvhkXqW797gI9cRLFhO+v5qKs62tkTHDhEM6?=
 =?us-ascii?Q?RclH86lEdeExXaOSwWVk1CKJdsImmGjqJnYHLwITEltlQbVziFb7Wi4yLCDD?=
 =?us-ascii?Q?7NYd5FtgFGivlLf6ehaU0dvBhjnPxWM9WZeEW5kqGGz1T/c7vGEKYyDrTO+k?=
 =?us-ascii?Q?HToleUKm0d1vrjup5hlW7H1i7DC52dZoJkPnE3RVbvVxFfX/CBaZ/NKoVku+?=
 =?us-ascii?Q?pZC6fEkY3gK7lvNHPO5Ln+Ts4Qhn5o75BX5DYt+ksgbewWIac+eYbyZD/rGW?=
 =?us-ascii?Q?vs8+aM2lsFhl9c5Fsof7hiBxJOJmKS4AWboBalj4n4QsnXH/8/lQDX7/MXiG?=
 =?us-ascii?Q?+RfGlVfrYwFk9b2mOmRsuT13FOz8e7sze6n8vCA1W1KzpDoEMJFny7RAbHmS?=
 =?us-ascii?Q?mrVu/7bYZyB6wRidTUtkD2jATogHHjJjkSEDnEAy33WdV4nD8IwVu3zc4BbC?=
 =?us-ascii?Q?rg9Z/04oeBVfv+y5BJR4WXf6qwNX4eTxiFAukX2ZJ/wwJkIhh4QvKcrUEQle?=
 =?us-ascii?Q?fdFYpzrr0xHHKBIWh+juj0uIc5tnPEC4JpAxCE8SUAAnSbEALtir1tM6VufV?=
 =?us-ascii?Q?LJ6XN1S6NbeCG3ccgpLUwgVqrRGT47HZncYFzQgbBClrguLmEcJMq+Xo49ge?=
 =?us-ascii?Q?F2lez0bwbXBUhkZmvL/SiPqgIjFmbWJKPyCXIf0kcMcqFUEebytW0NKWECdb?=
 =?us-ascii?Q?5FvW4BwaPHmWZ/9IEMPeMMbN5pr7XXLAfUMe2hpr+++krQa84QTDNyeuGNNw?=
 =?us-ascii?Q?VoYTqsi2wh5EzDIR7WudEvPdp5pxZWKuJMKA7xv2n9EduCjccz7yqjdJIX5m?=
 =?us-ascii?Q?y/abnTTyYoolVnubsYUgikuxf0PH8bzdKYHas+6sX8UoG6vBVvg4Gaj6hTAP?=
 =?us-ascii?Q?Pqbm0ksIldmjxIG8N/JBVL5Skme0J9UPT3NGpe1xDIlC1IP4OocDNLVuZrwK?=
 =?us-ascii?Q?LBo6ZOYg6q33J6hK6v5CgnjIwuiKdjOnJsUvfxsqqwH7N3/PmkpWSdwK+2c7?=
 =?us-ascii?Q?F2NYdnpEcB4ePThQ849mdtRdfglqxUxmTDf?=
X-Microsoft-Antispam-Message-Info: udyNTWDKMO1WOqSqK61rHwh+yy0Bht/hrcXKwyKFP2iMg6VWoZBzBNxKUPrL89jUhc6krKlthajthMnFcz1KQDNeJWh0uSyYXfPtjNnxoSmbcQnKeIYUqcqIYQJuWockIj7SGqsNWEFPswlP0JbNB06tz7mK+2OIGl7mGQjA/JJdxJGnVwNZgOoLstuRrQJo
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;6:1LDAUAf+zkSo8A9/ORiBD18MVqmEqwSVgKqFS+rJLmJ5cKTmRoovafDpzsF6mWWZfOtQFJw0eCuksD6RI5INdjkJ0qP2Wy4lxD5aJwt9RUk2/BfPXCk28ahxZSkTipEkqefz4Xt+T4pCeMALjaU0dqb/GYhUooN/JcvpF774PXi724V/LeNT70b/k7hoJvfqFTwFbgRDpLhhsUJ2C7oGFjiArfs5Ay+FbLwREx8cBzjGgYEgfnAlrKt6x+GBzFDvwTQa5ShXS4dN0AvRrkvssrq+5vowvxM9kNSYqw2wHce4b1P/gN5Fxv2ngtr50ciKS2EX5UeI1DHxLJcdwbLAUhZoR8vjw/aU5i1WKYDC0q2U0e43mqCdu9hRp9VjJG3Jnj8uxLSC2ERvTzWmCxFsnV+QHA4ylr4NE1ms2MJ2HW94hI255kYL8B7WCSC2/80NzBsdZr0dfPwQfaycIxddkg==;5:/naT4pHF2hwhY1rqe61mJRYXjfa5rYtBSFJfw5AFu5DeqlvZnm1kdCbwGQlSOIfiXJbKHWCx52JUN23ImIwbMMFTiiB+e70C0WrOV7Elc34Q1jyKDkPMnegX6p7F6WMZkfq6HafXd82zyjXx0VepxPNXmW2bw5jUYOFy+FpiuXE=;24:wqSh5Ce/7bl6noqbbqWw5dLWuPPk/4XB21M/bQMk9cPLJZinLJO+ur3gt9uIatcbFJgsKNEUqICnpvyT7U6T8mG1LbagSiDFMC70SJ1cD2U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;7:CrRc0q2QQDuacgz9F78A3g0lKoGI+ZLzWqUpm/HqrSvMuS19o9sQtwi5Cppjfm5+clBWXm9hsY/s27lC0MtOToQG1E3a3cwTWWSV9+iIY546cXXywYyiuCA8B54bnjELDRFtWtNfTYFELi2pHZ42/SoUixFqiJUuY/gKE//T9Hbu3l194QtsJ4vvH6VJK8+x4xQVTz4Gf2oJTuG289z5L/7WL1A0e1IZcJ0dFGyS05Xv6ehq5NFcDSTx9Yr6J9GK
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 06:04:13.1863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 676171de-e352-4afe-47ff-08d5d1bca924
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

This is a preparation step to make the adding of virt-dma easier.
We create a struct sdma_desc, move some fields from struct sdma_channel
there and add a pointer from the former to the latter. For now we
allocate the data statically in struct sdma_channel, but with
virt-dma support it will be dynamically allocated.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 137 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 83 insertions(+), 54 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ccd03c3..556d087 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -296,6 +296,30 @@ struct sdma_context_data {
 struct sdma_engine;
 
 /**
+ * struct sdma_desc - descriptor structor for one transfer
+ * @vd			descriptor for virt dma
+ * @num_bd		max NUM_BD. number of descriptors currently handling
+ * @buf_tail		ID of the buffer that was processed
+ * @buf_ptail		ID of the previous buffer that was processed
+ * @period_len		period length, used in cyclic.
+ * @chn_real_count	the real count updated from bd->mode.count
+ * @chn_count		the transfer count setuped
+ * @sdmac		sdma_channel pointer
+ * @bd			pointer of alloced bd
+ */
+struct sdma_desc {
+	unsigned int		num_bd;
+	dma_addr_t		bd_phys;
+	unsigned int		buf_tail;
+	unsigned int		buf_ptail;
+	unsigned int		period_len;
+	unsigned int		chn_real_count;
+	unsigned int		chn_count;
+	struct sdma_channel	*sdmac;
+	struct sdma_buffer_descriptor *bd;
+};
+
+/**
  * struct sdma_channel - housekeeping for a SDMA channel
  *
  * @sdma		pointer to the SDMA engine for this channel
@@ -305,11 +329,10 @@ struct sdma_engine;
  * @event_id0		aka dma request line
  * @event_id1		for channels that use 2 events
  * @word_size		peripheral access size
- * @buf_tail		ID of the buffer that was processed
- * @buf_ptail		ID of the previous buffer that was processed
- * @num_bd		max NUM_BD. number of descriptors currently handling
  */
 struct sdma_channel {
+	struct sdma_desc		*desc;
+	struct sdma_desc		_desc;
 	struct sdma_engine		*sdma;
 	unsigned int			channel;
 	enum dma_transfer_direction		direction;
@@ -317,12 +340,6 @@ struct sdma_channel {
 	unsigned int			event_id0;
 	unsigned int			event_id1;
 	enum dma_slave_buswidth		word_size;
-	unsigned int			buf_tail;
-	unsigned int			buf_ptail;
-	unsigned int			num_bd;
-	unsigned int			period_len;
-	struct sdma_buffer_descriptor	*bd;
-	dma_addr_t			bd_phys;
 	unsigned int			pc_from_device, pc_to_device;
 	unsigned int			device_to_device;
 	unsigned long			flags;
@@ -332,10 +349,8 @@ struct sdma_channel {
 	u32				shp_addr, per_addr;
 	struct dma_chan			chan;
 	spinlock_t			lock;
-	struct dma_async_tx_descriptor	desc;
+	struct dma_async_tx_descriptor	txdesc;
 	enum dma_status			status;
-	unsigned int			chn_count;
-	unsigned int			chn_real_count;
 	struct tasklet_struct		tasklet;
 	struct imx_dma_data		data;
 	bool				enabled;
@@ -398,6 +413,8 @@ struct sdma_engine {
 	u32				spba_start_addr;
 	u32				spba_end_addr;
 	unsigned int			irq;
+	dma_addr_t			bd0_phys;
+	struct sdma_buffer_descriptor	*bd0;
 };
 
 static struct sdma_driver_data sdma_imx31 = {
@@ -632,7 +649,7 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
 static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 		u32 address)
 {
-	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
+	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
 	void *buf_virt;
 	dma_addr_t buf_phys;
 	int ret;
@@ -707,7 +724,9 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 	 * call callback function.
 	 */
 	while (1) {
-		bd = &sdmac->bd[sdmac->buf_tail];
+		struct sdma_desc *desc = sdmac->desc;
+
+		bd = &desc->bd[desc->buf_tail];
 
 		if (bd->mode.status & BD_DONE)
 			break;
@@ -723,11 +742,11 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		* the number of bytes present in the current buffer descriptor.
 		*/
 
-		sdmac->chn_real_count = bd->mode.count;
+		desc->chn_real_count = bd->mode.count;
 		bd->mode.status |= BD_DONE;
-		bd->mode.count = sdmac->period_len;
-		sdmac->buf_ptail = sdmac->buf_tail;
-		sdmac->buf_tail = (sdmac->buf_tail + 1) % sdmac->num_bd;
+		bd->mode.count = desc->period_len;
+		desc->buf_ptail = desc->buf_tail;
+		desc->buf_tail = (desc->buf_tail + 1) % desc->num_bd;
 
 		/*
 		 * The callback is called from the interrupt context in order
@@ -736,7 +755,7 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		 * executed.
 		 */
 
-		dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
+		dmaengine_desc_get_callback_invoke(&sdmac->txdesc, NULL);
 
 		if (error)
 			sdmac->status = old_status;
@@ -749,17 +768,17 @@ static void mxc_sdma_handle_channel_normal(unsigned long data)
 	struct sdma_buffer_descriptor *bd;
 	int i, error = 0;
 
-	sdmac->chn_real_count = 0;
+	sdmac->desc->chn_real_count = 0;
 	/*
 	 * non loop mode. Iterate over all descriptors, collect
 	 * errors and call callback function
 	 */
-	for (i = 0; i < sdmac->num_bd; i++) {
-		bd = &sdmac->bd[i];
+	for (i = 0; i < sdmac->desc->num_bd; i++) {
+		bd = &sdmac->desc->bd[i];
 
 		 if (bd->mode.status & (BD_DONE | BD_RROR))
 			error = -EIO;
-		 sdmac->chn_real_count += bd->mode.count;
+		 sdmac->desc->chn_real_count += bd->mode.count;
 	}
 
 	if (error)
@@ -767,9 +786,9 @@ static void mxc_sdma_handle_channel_normal(unsigned long data)
 	else
 		sdmac->status = DMA_COMPLETE;
 
-	dma_cookie_complete(&sdmac->desc);
+	dma_cookie_complete(&sdmac->txdesc);
 
-	dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
+	dmaengine_desc_get_callback_invoke(&sdmac->txdesc, NULL);
 }
 
 static irqreturn_t sdma_int_handler(int irq, void *dev_id)
@@ -897,7 +916,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int channel = sdmac->channel;
 	int load_address;
 	struct sdma_context_data *context = sdma->context;
-	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
+	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
 	int ret;
 	unsigned long flags;
 
@@ -1100,18 +1119,22 @@ static int sdma_set_channel_priority(struct sdma_channel *sdmac,
 static int sdma_request_channel(struct sdma_channel *sdmac)
 {
 	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_desc *desc;
 	int channel = sdmac->channel;
 	int ret = -EBUSY;
 
-	sdmac->bd = dma_zalloc_coherent(NULL, PAGE_SIZE, &sdmac->bd_phys,
+	sdmac->desc = &sdmac->_desc;
+	desc = sdmac->desc;
+
+	desc->bd = dma_zalloc_coherent(NULL, PAGE_SIZE, &desc->bd_phys,
 					GFP_KERNEL);
-	if (!sdmac->bd) {
+	if (!desc->bd) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	sdma->channel_control[channel].base_bd_ptr = sdmac->bd_phys;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
+	sdma->channel_control[channel].base_bd_ptr = desc->bd_phys;
+	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
 
 	sdma_set_channel_priority(sdmac, MXC_SDMA_DEFAULT_PRIORITY);
 	return 0;
@@ -1176,10 +1199,10 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret)
 		goto disable_clk_ahb;
 
-	dma_async_tx_descriptor_init(&sdmac->desc, chan);
-	sdmac->desc.tx_submit = sdma_tx_submit;
+	dma_async_tx_descriptor_init(&sdmac->txdesc, chan);
+	sdmac->txdesc.tx_submit = sdma_tx_submit;
 	/* txd.flags will be overwritten in prep funcs */
-	sdmac->desc.flags = DMA_CTRL_ACK;
+	sdmac->txdesc.flags = DMA_CTRL_ACK;
 
 	return 0;
 
@@ -1194,6 +1217,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_desc *desc = sdmac->desc;
 
 	sdma_disable_channel(chan);
 
@@ -1207,7 +1231,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_set_channel_priority(sdmac, 0);
 
-	dma_free_coherent(NULL, PAGE_SIZE, sdmac->bd, sdmac->bd_phys);
+	dma_free_coherent(NULL, PAGE_SIZE, desc->bd, desc->bd_phys);
 
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
@@ -1223,6 +1247,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	int ret, i, count;
 	int channel = sdmac->channel;
 	struct scatterlist *sg;
+	struct sdma_desc *desc = sdmac->desc;
 
 	if (sdmac->status == DMA_IN_PROGRESS)
 		return NULL;
@@ -1230,9 +1255,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 	sdmac->flags = 0;
 
-	sdmac->buf_tail = 0;
-	sdmac->buf_ptail = 0;
-	sdmac->chn_real_count = 0;
+	desc->buf_tail = 0;
+	desc->buf_ptail = 0;
+	desc->chn_real_count = 0;
 
 	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
 			sg_len, channel);
@@ -1249,9 +1274,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		goto err_out;
 	}
 
-	sdmac->chn_count = 0;
+	desc->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
+		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
 		bd->buffer_addr = sg->dma_address;
@@ -1266,7 +1291,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		}
 
 		bd->mode.count = count;
-		sdmac->chn_count += count;
+		desc->chn_count += count;
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES) {
 			ret =  -EINVAL;
@@ -1307,10 +1332,10 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		bd->mode.status = param;
 	}
 
-	sdmac->num_bd = sg_len;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
+	desc->num_bd = sg_len;
+	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
 
-	return &sdmac->desc;
+	return &sdmac->txdesc;
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1326,6 +1351,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
 	int ret, i = 0, buf = 0;
+	struct sdma_desc *desc = sdmac->desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
@@ -1334,10 +1360,10 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->status = DMA_IN_PROGRESS;
 
-	sdmac->buf_tail = 0;
-	sdmac->buf_ptail = 0;
-	sdmac->chn_real_count = 0;
-	sdmac->period_len = period_len;
+	desc->buf_tail = 0;
+	desc->buf_ptail = 0;
+	desc->chn_real_count = 0;
+	desc->period_len = period_len;
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 	sdmac->direction = direction;
@@ -1358,7 +1384,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	}
 
 	while (buf < buf_len) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
+		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
 		bd->buffer_addr = dma_addr;
@@ -1389,10 +1415,10 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		i++;
 	}
 
-	sdmac->num_bd = num_periods;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
+	desc->num_bd = num_periods;
+	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
 
-	return &sdmac->desc;
+	return &sdmac->txdesc;
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1431,13 +1457,14 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 				      struct dma_tx_state *txstate)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct sdma_desc *desc = sdmac->desc;
 	u32 residue;
 
 	if (sdmac->flags & IMX_DMA_SG_LOOP)
-		residue = (sdmac->num_bd - sdmac->buf_ptail) *
-			   sdmac->period_len - sdmac->chn_real_count;
+		residue = (desc->num_bd - desc->buf_ptail) *
+			   desc->period_len - desc->chn_real_count;
 	else
-		residue = sdmac->chn_count - sdmac->chn_real_count;
+		residue = desc->chn_count - desc->chn_real_count;
 
 	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
 			 residue);
@@ -1661,6 +1688,8 @@ static int sdma_init(struct sdma_engine *sdma)
 	if (ret)
 		goto err_dma_alloc;
 
+	sdma->bd0 = sdma->channel[0].desc->bd;
+
 	sdma_config_ownership(&sdma->channel[0], false, true, false);
 
 	/* Set Command Channel (Channel Zero) */
-- 
2.7.4

