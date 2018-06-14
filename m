Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B3A87C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AF5208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Un1zNGec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AF5208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbeFNFgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:36:49 -0400
Received: from mail-he1eur01on0076.outbound.protection.outlook.com ([104.47.0.76]:37120
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752664AbeFNFgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJEStYlyUo+3VImJbclMrVeIOJislYagF5VTHz4qP3U=;
 b=Un1zNGecEbnPiCbsce2DfuoqawaDLKb9Oq56o+CsGssimGm15FqhcAPVsVDAwhhMkwnsnkdItLnWqokz9XPP9y8zyuwNJkgHZ3f7srCbejYWYnCapN61vs1ZZrCN/lLXVCG/BnEfKjv9aG5S37wHqMLcOcvf/cdliDCBEsAuw7c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3222.eurprd04.prod.outlook.com (2603:10a6:6:6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 14 Jun 2018 05:36:36 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v4 2/7] dmaengine: imx-sdma: factor out a struct sdma_desc from struct sdma_channel
Date:   Thu, 14 Jun 2018 21:35:32 +0800
Message-Id: <1528983337-2726-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528983337-2726-1-git-send-email-yibin.gong@nxp.com>
References: <1528983337-2726-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::36) To DB6PR04MB3222.eurprd04.prod.outlook.com
 (2603:10a6:6:6::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9c9a6f4-15cc-486f-7974-08d5d1b8cdb4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3222;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;3:d64mWohz0kDcYDsvbwg+jmCNMczGwyaYnSDFzVgtpMUDzQgXoB86nhAVmAGDVpb1ZMx6R8hXLhYROT0OBSlT8kzArmSVHFDkntFbx5uxAk+Mf5XcRJiQz86S4ILDs2Z0ODiKQPOsjNPEU2MwaMPrYLPHOwo2s40aYo5LuxY9GfWfxry6eQtLagrWNPnQ7INdgyw5JOp+imlqY7Pf0i6MqI7oZXhiH5Fw9DfzgDzWU0PT6YQVTdsat85RtfyMm8Oj;25:EMNpocezaha0YJZ4ytNRw56brkNhaSBSq9mNO5Sl4rbavvxjGzu05vS+n8fU4wvr60OssX1M8TR2wYjrtkBCwzydNn+oAe9JZ2G/xa0NDMFU+sMriPUMGJW7XFywAjusAIu0ww/2EfyaAdWA8ptswElZMS4CQiaNOYAcgLLYAlpyZNlhxUgHBhnZWn/ux6lfwJU9GRF3EABD4eQiemjeIyVExWgB3QLHffHbO8Z4ByOANbQ3iDikO7GyPxealTKPxCi7s2ZBcExMHgjkF10SttIpOkk+w+UeyrPP7E0t7Q1wNA6etAypGbWAXJNt3CR99eKDNzkDBrsF5dYu2KDscg==;31:IlOyDPpglUe60mjpPZPSpVvWnBKMppf0/+RGCvy2KgbpW7iDxJJCxJ4V4H9uMYwpW3C+6FG6+EHDU2a81SIWa+fNnHJO1Q51HB06anI+VueGvKvhIJ2QaKAXAdsAcqWV8OWkZcmfb6PAX1PDmNSPkGjmtXxLmg6FcGPMugj+sPYSOGWKGzi8+K0lw8CBzuH4hynjqCrsaJOIKY3CGnL/wDjyQPrslxEEKP1Qur+3vCQ=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3222:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;20:hOj+GbhubFwWruRZvu7oiuds40SS/9Ku6gfqHr53ilQc1mpqIEeQa9ZpkKY8l80jT7+pbPsodhph1bKchmTfupsIMj4mzhvdCxFvBKLv06OHJ7nwMq7Fnw7n1DmXD3G9oZ2Rmtoaj4POB9P/9NGdHnHIy59SDmi0YjM22NQBmM8Eoro7D9acMJ2yqKQdnB2RtmRGR/IIV/dGy83b/0WkXHNIYXrjNB1MaEEeNrMEJWDrPkgAHObRpqhKypcrbCjsq0TGrFZRQKxrhuf8CgbRuwnbiwt3oCMM2R7qWyRbJxbYzh0StLl+AVl1LJMIEjZoo53vy8w8L0OMP/lc0Aka6IOqykvztGxJoCbzpoq9U+D1AwuttGG6KZ7ghvQOiQPInBuFMS1nicdqDFkkG30cpKDd0pi6lGhsFK4j4nOB5VWqNeBMO+jiY0ZyuoCoTbtiZ640g5XfOt3m3x1SEtPNoeLyGLOnQ4xmjfU0BY3Nsp3G7SR4wxE9DCveIPyhkaDy;4:3vOc5FQrQfVbG9x0Ac55g6NdYcXzXiTxEQU27Fd+nJxNvbCYcD2GGc5H218avyKCyys8cIgUfdfxi/owBqJPjHuT52Z1FpSXQEt6iltcgrq1r3w/TJpgzilKgAERbmsMIHy2ZU8QQTHYLIa00E0niSWfe2ead8/dZRNGDd7LSsx/IIPbIIEnMJE/3L3DAm3WR5MjCWtb7821q2Tb0AKbiaXgz0JSIzlVZFl8CDkCUy745fRVBH09/1ufiPF0XjZuvlxdCt4yHy7B8O82pIeAH6fiw0gRvW6XzaJ4a01bU2KKah+dq1ej7qiFVHBHquBf
X-Microsoft-Antispam-PRVS: <DB6PR04MB32224856DFA60C7E64976D1A897D0@DB6PR04MB3222.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3222;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3222;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(376002)(366004)(346002)(199004)(189003)(476003)(6486002)(11346002)(86362001)(16586007)(6666003)(50466002)(48376002)(446003)(25786009)(66066001)(305945005)(956004)(47776003)(97736004)(2616005)(59450400001)(52116002)(51416003)(76176011)(6506007)(386003)(16526019)(486006)(186003)(105586002)(106356001)(36756003)(81156014)(68736007)(3846002)(6116002)(478600001)(53936002)(26005)(6512007)(81166006)(8936002)(2906002)(316002)(8676002)(5660300001)(4326008)(7736002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3222;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3222;23:nrDSbTIkjFH/PERtzs0Ms/Y55DJl9db9/GOitMcjC?=
 =?us-ascii?Q?V6Q8PDx0IMsOUYoZRfgK+CuV0dyHb4PEMD5B+loKDFciJkwcZ5v1ptwf4f8B?=
 =?us-ascii?Q?7UbmccAns+93Mpv5FoxjWhmY/yZbLyvilVujp/VdankX+2E4TC2/O0NzSlDJ?=
 =?us-ascii?Q?oujAbIWyySytUDzZQU+oDmQ2Eo0jQ6an+amUgD3gVTQRwiqnMEjxsdKkHz6d?=
 =?us-ascii?Q?7V/jss8p5Q9oFnp0RYT3RcFYIRTfEZo5QQhB+3wxiSfGctoTamjJfZJgU0OA?=
 =?us-ascii?Q?1sSc1Hsl8TNLvocJCiF98E7uzZnyj4t7Xpt9Nj0oT0U/MkpnInWDaLef1rjy?=
 =?us-ascii?Q?l7vS5+7fakfO5f9/WBQhfWCxy9/+KrJHfNuEtdjMnFkGULpaOnLMc3VL2h6K?=
 =?us-ascii?Q?Bq7c2Fzp8EAGKJbE1C8SiH2Xt5hnJOcKGDAt1TcTM8pjlLpejcUJwKO71PiW?=
 =?us-ascii?Q?hjrvc6UqSsH0fyc8/kAeFp4uCZlQciD6uOkcXl/1e/C03Ghn4QJ5UrPTDHng?=
 =?us-ascii?Q?70HS+RBiXUeLh5EI32DcSLn3PQrr0WL1xqKg3TNZkzKy3RXs14O8UkIjPgfK?=
 =?us-ascii?Q?GUSHDzZcbTfr/EfwK09ERPmIF2U2khYOZUMwto6nwZGqSt7Knu3oesmkJc/1?=
 =?us-ascii?Q?SCIwdjjwRIUtyWVwJj+rCNWH9qiEnPR4J3KigK+r2hGZP58RCgL5iQc6NowT?=
 =?us-ascii?Q?CKrqi1jQ/1lvL8grfr7k24J6HaMCKpVYFeozg5WNOSDv9CZKMdAVMP8eTjJN?=
 =?us-ascii?Q?OOcGeM0XXsP6csMzp39VBd8Xq1DQOeIpvg5nMZwd/Nt3U86f4o2M3HX6uy3R?=
 =?us-ascii?Q?0xmfU8p1UeWQpiNoE1Nli0rMqgJMtmXAUkVEp3fOGmIhD1hq+O+8c3sjPjHQ?=
 =?us-ascii?Q?wDyAg+A4xOB/Qz01lAF27VHDErGqosnekDacOrASV+LAb89DQl66uZeCZnBX?=
 =?us-ascii?Q?QXRtlbwMmTJS8Xyc1rywbT79QMomQnFDPMakhsUv2rRv7b4X7G5flIGbAg4w?=
 =?us-ascii?Q?jFm2MViwXB9quGPmgemgo8ceBe/lMR8zXvCEOzDZ05UYiew99AvuDgiSNxie?=
 =?us-ascii?Q?UjmfbWjuEd8lvaHdzW3aU0xMjIqoPkXaA4RodVePYySR/7D6NqlbAFWe90mR?=
 =?us-ascii?Q?IkFY6qqYbnEyJLOiEhsIP76J2FP+g6GiPgJauWGoUdQbWLQNzZbwMhv0Pd21?=
 =?us-ascii?Q?lGAjNjQXrrINLM=3D?=
X-Microsoft-Antispam-Message-Info: btkh+LWhgqOBuS+6js98eWVkcyiQ63KExpYQGJ95JWnnZlDIYZ/vJdF7N61zaOycuXBU/+DC7C6XcwKXPrM2VZjotmsbktW1XMZVqtxPrXnFVDNiCRxYEMOaqfWp2/4NUT5GdikBjEuaui7tBnb7Um8FXkjh2/rfxCBe9G3vP9uqpvK1aiLiI6VzpXXL8b/k
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;6:VHwu8dcrJgwtduaLLwIKWlEy3USoYSoCtJwCgN54Pebbqzc9B87UdeJXZIoQNJGLOZVp4icwSVH4WYd1GqlrWQPXO0l8aZL30OsLqFE+Yx/Z+7RgbJkgBigS7qdR1JNb45lVVwnpxW9Vx8TbLGaQRkOAChMPGyE4v/aOEEabE5uaA3ClztFuRxh7n3tDKZWl6fv+5fr4UBjwHwlljne6K4BcZvyBzM4Pf5Xlex5Uu+39GPEEKGphXeerpaeJKN67FfnIqOZfHavLxlA2rTBugQJ8OJ7bARmtE0ufnJknJ2tjAB2pbQy3YJwvz2wQS1Fsriy/URUZQWfLlHUS2HRMRsfyLwn6V7ufSuxchEb5lRedUhyUzaCBtYsuhC6Y6DED38oxyt3xXkHaQzk1PGSubIzbdG5aBZpgrEH93/yUR5eGWQdrLknkeA4N5Qt8i0Vxy0UTjGSKcpKaHmsgIWOXvA==;5:p8jAa5TE0p4oX/udtdm5rfdIMm8dFu5TNqzG57WCe0PzuiiHPFekk3lf+ipu1++mLfKGLD9cBKjfmbIqusN978MtrizAXRH6Di5KtPH3CiVpVpttVZKLi4Cw6vdKtC8AhawHg0odZUC3RYS8WcjDd8vATNJBXvQEUA2GbkrJFS8=;24:c0QXvxCfSXrDBRP0sNKYIIOQBKnnunUcabsQ/Qe/eB7Rt0cP4jO7NLi19F3KluM23ApmZEVlXJHJTd6aMlbLXxICe0HKbmP4oXUlej4C8dk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;7:Ei+JKv8Gb5W/XUHPlzCjrtKJbOcZ3dBElctLGw0QNk7xr4xtHj7ZpxSG+sfbKlaF4vD8xUWMPIytVBQF/up6E8jTLyEr48x5dvYK6KjpBkTXVOiqtqYyMSLo4h6QShBWa0MBoRQdYFLvydEKTtrqRmm35LWMlzUxS68LNJ9lDslFBGDSNqPIoGQG/X6NTIDoByRHZXZWABkEITwbUjV4FyjdOCmIVVKonfsMeu3hEpe9LYmAe2XMpAIz64W0CSd4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 05:36:36.7199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c9a6f4-15cc-486f-7974-08d5d1b8cdb4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3222
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

