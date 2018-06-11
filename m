Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pNmNDQ0eHls2NgAAmS7hNA
	; Mon, 11 Jun 2018 07:00:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1BA1F607BB; Mon, 11 Jun 2018 07:00:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yPXTKy59"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0B93D607A4;
	Mon, 11 Jun 2018 07:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B93D607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932402AbeFKHAZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:00:25 -0400
Received: from mail-he1eur01on0043.outbound.protection.outlook.com ([104.47.0.43]:11125
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932092AbeFKHAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fj3pqXsIpLV3HJ7xuR1wYzL7KI7pXU+auA9ZqS9e6IY=;
 b=yPXTKy59COuz9iDsY7aS9QKpVdOEQlfx+qmxAnnkS3e51ax8Xn3fzIcX9BxVXkYmIUaQ47sMV/21wENT5hSY9C918lJOKmoESPZcfoWINjzV1iggpDcw7J2i/dlwqAWUD6LIVATr6goBCz5gueRo+vJt/BlDqL6w4UcNyeuAdDI=
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3217.eurprd04.prod.outlook.com (2603:10a6:206:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Mon, 11 Jun 2018 07:00:16 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: vkoul@kernel.org, s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v3 1/6] dmaengine: imx-sdma: factor out a struct sdma_desc from struct sdma_channel
Date: Mon, 11 Jun 2018 22:59:28 +0800
Message-Id: <1528729173-28684-2-git-send-email-yibin.gong@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;3:MgqeBfVvwuQYgs5hOxY8bd5Fjb7YlhkRzBDC0eRFpE2e325xQE0cUenzRP9QxChVyM4mWAbdaPnHecorBUC5vkNkDJkxmJCzY4ItuHcD4Il9FRfL+LNUIWfkxGPmBd8W99YFXHfGLs7Nk35z9tJ1bn2cEf1nm+dC3455OPqa3/IZSVAEqxnLekX4stlluf4ss8wvOSv+OZot7G2D/Uu+WirmxYYQj98UZQ+JIzx+D8WjHFbmqL8MUvkA3GpHZRtI;25:2txp4Y/oKe7vU3SR8QMhaqhQRIKLcte6AumGwPOmkc2yivwErxoqMRrPKH2WxaXSd4yrEymJKnwnoh9JnUrZ8faWGosRg/D98yCx6jQuBOPPhQPDnzv6GEJDKMG+U3HSFd0eBdPpufIdpFq2d8qT20iAoar4gE6Vrz5jPTJCK4YuBSGEw29Ryh0xolvIchQRKjos7SUwamTU++ixvx4govkCCMB1KTt7x7Sya2MDuJLqp63z7PeXmj0xqES4f7LemTzIwzkonLhIhf9FqHkT0erHY1jhPdo6VDLFqA9ux8imxBE03TldbWEotJILhA+pFat/p86q5xH0QGoKPUYWhg==;31:8X2PgL8NoINF9E7NcLox+wofGHy/53CBxEXnle6qc6iMNTm+PzWj1jBzziu05iQQGfdFAzSRnaaaHKtuy+3EMVpjzkWg69WP8G+88JWa7XqrAN0xFPyEozWIKj8pNlg4F8zXXfFdMWiRzpdSTzwEokES6zyUTs8e0KTx3RqwqchORX+02l2TzzUJ9RKSV0GimryYFaAK6mZHQbZIVBi0ifnWDuRUtSoRRa4klYflO3c=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3217:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;20:IN7BooMeWvxdfuQduwo4kAhj2pycsaeqYylwFdtNJqtJY760W1sShpevjv/wJSr09bWVfBXcalNG6FeqpRK+nq+g73Lgcmw4Fnk9gXhjs7qIwohNook4m3ACudDxcMY1+Y1g4eQ/8sfcCtR+MH4Ur3KRZYYbOcZEdgQs7aUixB+3k8PaQ+dUBJse18p91jOzLacQPGuWwft4TlKhXh/UpybUIhhUQ+bHbdyPLU/4cMNzdHRN1C7zHqERNVTt2TnYArRn5+Zkm8Z17/ksbK8mu1uRx9z3Rk1kv4Kz7+bENQMXebORoETsJSLpqfTm4BagCSzj3FtjL0aIqH3GYhcieCnmPQBRvqjjWUbBZ5B469skzZv+WhU9B6yIkJj4j1woIMwaBGEP3HjZu9HDmZKC0lQHveXnsik84fLjFc4vz+x6Ru+kTN1hmNezixzbG/edcdALQTs/Fs4IsAh9TjCoNqjDhgbbG8QT0xwKKdftbZlF+uzyotZvaP+Bj/n5jK2O;4:xN3ZXCf8iDqn7ye9tQBLgw+9vqQjxTAPU+Fmsa7W6INRGpCzCooqdGT4b+kQnb1kIxEcqk+Ly2VB6zd/uu9rJmg2nmslNu63oAH3++v78ko2POtgGViYsGEYaaqAB2G8uC0rQv5Dyhg4dYdnUi689rGhsomXxGC+844mWscDheswmbB/raHmsqm8KcwrbrUIkJ7UT/8XNnU7kk8bJ2aca61G4Q6GLZ2ormgW4b1WJXUkzAZ9fkXE1UuW10g+By2fK/kLdaIRqa2uIKqyFpZCYQ==
X-Microsoft-Antispam-PRVS: <AM5PR04MB3217FC9BAAE5D26D7C1103BA89780@AM5PR04MB3217.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3217;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3217;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(396003)(366004)(39860400002)(189003)(199004)(5660300001)(7736002)(51416003)(76176011)(52116002)(97736004)(478600001)(16586007)(68736007)(48376002)(59450400001)(36756003)(50466002)(316002)(2906002)(386003)(6506007)(81156014)(4326008)(86362001)(476003)(106356001)(66066001)(8676002)(16526019)(6486002)(105586002)(486006)(2616005)(956004)(6666003)(3846002)(47776003)(53936002)(50226002)(186003)(446003)(26005)(6512007)(6116002)(81166006)(25786009)(305945005)(11346002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3217;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3217;23:AHg/9841TekPbfMLZvNOS55yHEtewHIhfjwcMGeE8?=
 =?us-ascii?Q?+LuTbAEngmrzWtVaakgytpnbWveqbu7uk90zTXXz8eX+7Un9DR1vI61RxOer?=
 =?us-ascii?Q?6SSdfkUapwuYccOxntVm+SBUiKTHD3fArEqTIHNaGEfINqUw5MEngIt7Hntb?=
 =?us-ascii?Q?rTRICHZSXVuby1hCCEf4c/sh9cGZisV5Z+efZVAazgf9kP8Wrt8yFJJdOuFe?=
 =?us-ascii?Q?PH+cxAZXy5mVVuMZe1LQxDnppVZ22vJs6eC5b3RTqmBne+LunSp5tlfLiiMr?=
 =?us-ascii?Q?17grsUw/OoVmWkSLBi2zOdhhoHmI2zBIeV751gVSQO4+i3bGpjH+8RNtPN9U?=
 =?us-ascii?Q?xNgRd1JRQscRi0HfbS56Goj8qafO9QstiN//YOBkNNl9jtvvqtMdvYJxvCG2?=
 =?us-ascii?Q?YYNQXflwyId9TQQiEPoo7kFD69tWanaFdodVLlWBdB0+iDNjSaQk/OSIOWVH?=
 =?us-ascii?Q?TNjB9U74Kf0uaP9tsG7lY77SzC2+21nmeVEhstHnC/jmhnHr8Sy2M/70FD2Y?=
 =?us-ascii?Q?N8jCpsLwkU//x/JFMwkJHpl1pxC/7LuIvjGsjVpJcCj8S6HlWyWtdqsqX5Lo?=
 =?us-ascii?Q?hXO2P6EH2unAxd96bjf/Yo/vjk8MwXiqiKMbCBxCnO2GlH5CvbQBEeKC9n0N?=
 =?us-ascii?Q?KkYO2te20QQOp4Hucf1IrFXZhINDU4jTLDFwwyLXdsQYVn/6rbO2wBEmtg+T?=
 =?us-ascii?Q?V134SmdyJ19qXn8t8l1CuDfk28dZpv1JTamauSzMzPP8sVrhB8uANHauO4ZW?=
 =?us-ascii?Q?7Jx/dRsgdMe6ZNbrgnqHgFFGMDo5K91eFkV0hOLDh0SYQyGoUsLFC8ergSPq?=
 =?us-ascii?Q?ssE7go+8WqlHQjqKV+3W4/zGcT5O68OMWm2WLjfgEIsB2foC1zwreOBEqJ06?=
 =?us-ascii?Q?KKvQ05ZipkaGvINXpIqIYs0gzVILwZoyl3vpY7g9I+ZcIsvHPQOaZv60Cfhe?=
 =?us-ascii?Q?5TmnyTWYCCyvvHagfmN3fN2i8XDKOqtz5mCWMExMFiV7he1x3UwFRPEcDu5L?=
 =?us-ascii?Q?2LfzNx11VQdfjv+a/cG7Wo3JTJ/bw1nVm8nqCWfdc+4bDZ0tVSi9ZWP7yTf9?=
 =?us-ascii?Q?isIro33mSajl8fjssjW7+LTDw/cZIJt9zlI1GiZ0gslsbnRbeFj1MO25UcAZ?=
 =?us-ascii?Q?g0oLXdYh8hndg2ILlEHgymvWid/AQr3tRIHVx0DQZl55X/Vm/ATN9J3JI/ck?=
 =?us-ascii?Q?/svLhWxFjV6wvM=3D?=
X-Microsoft-Antispam-Message-Info: 7oRFST2cQq4RLT2rd2wrKNOn2r0tmI2gVWQSxl+G8JLlURJzYCR1Qtz1pfiErLL6wdozh5OwooyeQvpSeArEJgMsvkhPfrEhrecxrOiWrWz5pn0dYtJiok9Hi/QxSkLrUp683puM4Lh5ALPy9fjs9S6sT8gTbMn3DLAc3RNvwh5wKvluJCPWOMelOXSdFC0f
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;6:IFfDedpyUn3YqSKHYy5n9cXL0GcoTIHG/YW+tqwPY2x/sv44j/nnsKL9LwBqvYD2iBlPi0QHx5Qr1mPu4O0fzcKdyrq6dXRYg0EDtRU8dvks3gMPEBOW8i+PCwAAoH9IbpizUS5bA9YyvGHb1OcP0qgxpsRbkWBbOFytcfxt/9NLjAOeePZYOqlG0482FWCrUz62DV3hGLBAV/PpMYunrQMaThM2FbC8V2m1rXDGt9BwIXNDJ4KbcMVPlAYeaJuirz1qgvgei4uHaa7VLIO2r8tT1u0DBGZe6r/5cm8HJvgXfvj04yxeutFyoeFYum3SYfAaOOPm7lSTv5z8cBgLqHU5aroMrECVH5479iazHL1A2V7m+QhARYwbo2X7bpyTTmJ050fyfAGj9s9n5BR4IRzhoSwSdj0SlIA9N6vt9BxvjCRYvhj8FyK0XZh6Q4C/c0FIuv+1y3+Z3+UkXkTIXA==;5:Ce0uKs+oLU32yAA5J4On6zS9nst6VXbVDJmklqT/amRXc1oYZDE+4wabx/IWqXv1DKHOj88yQp4kDvR7u/Q4ptp0bf6dpTg6Qt5zzxmfo+a7+cluKnN+Lqb/u+TBTlYuNEVIQxHs+5q7ALWH5YpAku/JO23KYJUUtGSHh8nYgNY=;24:rBaqDI8owZrGmnYJpF52f4wpCVXCB8XtO+kIkpgUqlGYF79MumnLZr0B6NxlmmKD/TkfizGwnBRyh1NtCEkTJZLTJ6+0iIV1DzPcwllvja4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;7:fFywyL9ZvKWyUezDBdBociPxvPUBhvOPs3AWAI1j3LZOYZ+sTTV5QZkNSsyX6DRmKC4Iyzn0LdlnimIMWxVn4UOIH9umr5N21wgLnAErPeVRdqJVMKFUE1vhzu4LHQQW+GzID2W1ns/1YcTgTbWR3eKUgk36q55EwtZVCozyEXMuygup1L2Ci3HRQDm2AX0FFdbrlDtxG/bFcxli2cTUnRE7+ehwa6erddgjXh7CPcYsJTVpUUG1wR6L7yFKs77t
X-MS-Office365-Filtering-Correlation-Id: f6157479-fcea-4e72-c698-08d5cf68fded
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 07:00:16.2497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6157479-fcea-4e72-c698-08d5cf68fded
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3217
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
