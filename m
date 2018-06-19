Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14977C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB3B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LJNP7ykh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB3B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937512AbeFSI6S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:58:18 -0400
Received: from mail-he1eur01on0087.outbound.protection.outlook.com ([104.47.0.87]:3242
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937412AbeFSI6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjkJ49IzxsXA0AUvwGQBwmN5XSKbHG8elx0+6kxllGM=;
 b=LJNP7ykhVX6BxjB2WsFuREV8V+FE8kIbVQEPT7JZFi7QKXkvhdiCE3GmFC1fHP3PCmWB+ogIY3yJqUdMoimo1qabxIsq5ficxz7Hh5XS9JGO2nF+L4UACVnAWrH3vR6HR0gDnoJZ5pxRtP58wpCmvuUEoBPNDqsWQhmi4xSVop8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3231.eurprd04.prod.outlook.com (2603:10a6:802:6::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Tue, 19 Jun 2018 08:57:57 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v5 2/7] dmaengine: imx-sdma: factor out a struct sdma_desc from struct sdma_channel
Date:   Wed, 20 Jun 2018 00:56:59 +0800
Message-Id: <1529427424-12321-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0073.apcprd03.prod.outlook.com
 (2603:1096:203:72::13) To VI1PR04MB3231.eurprd04.prod.outlook.com
 (2603:10a6:802:6::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 808f3a1d-e6c9-41bf-e40a-08d5d5c2c256
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3231;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;3:mBbkyRx/DnRfU/5+0lZe7B/fdzMUHckBP4e6/I4G55PkxUxkoV29M7fwY6Kw7IieeBlB+3KMMwzn5qPUz46moAKLGwJGdbf/P/lY8/BAJ0evycl1KDApt6PR/BSL2Wbs89WLeqVIBk/oERdWt2Ez6522IUCR7MzSaT7EwUez8J5jcJTliC9/VQSDJji6HysFcXWaLthNtbDlsn0yS4RydKLdw1WG7UqMSkp+cKDYGC2ODeRvWcAcO+vWHhIW2O+s;25:L+MXr0+tYbxUx3LPnW9y3sQNDIxT+LcvV4nhjUoyslwdEOSnxvr3IyeLzYkC0LdIf1cpS0bqqs8Hy4SeNJitbQi9MxUUJNG4RDejYrb3IgMVfsd8BOeQHefOrP2cDXy/Ibf42q5v19zypTL1vwt0YtssmwwPVwq22PcAjYa7SU0gu9WlA9/1q1yTjqLAv09YBhF8kmIbVHaAXdqrGvkQ1SS3+r/8cWepW88wVg9qPrHNdDLE1doGQsN2wMTqCzSTazWlywpWgmGE8jxdLX+JTXFgMN5Wm/UxSUv0kicE7Y9qLFhrzFfWOnqoBKznhubFoa9juv24XQuHT2gPlVHrGw==;31:Lz2MHxYar9/MqqKwnQwjhfP9yvqX9UI3tyNEhksDLHMIfGlcIpF4QViDRhzap2msv31AJOkReIdPJz1nZv5HKzNic4geHz6Z+ImksLxmFYZP5Y0kTC9Gdo2iO/TW1gzHCP99oCE5PgQB7MIvQJuSXXZK/jgIqxEfvKeYY8RY4fOQkMFrGXs+kVxirlDzj5xBsKaaQztXQjb4y0Zhkjjv+JJfwqyJLvLyktsN/XYSDoQ=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3231:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;20:iqbVwFv0u1Kt4O7eWHWn7sRhNg3Wukb8o0nofM5e9sUK5Q/SeBvvM+CjjlIeWsAY/V0/R5wbtyWwqSALsKbGToYrViM8tBtJyYHzHOTgz/EJv8/FhPIlmt4GHo3jrywaZoJvWMYMG8PpXthNkknMccSxR1DYP8Fcs0kRNfVL/x1RBD6wLpvNcmYLt3KuKMSDPlMUYXdx3j28cCHQVdteVFDKfuBvgtLtPdK6+ccbO67kVW+jZ6dWYGn6EH00h1uM1NHJTbEz+Zsp83b9gIyrPI1QBG519jRVAANSpS//9EkgnfgH5aZVn6+2aAg5hKtguK4eHRqwUbAf5mZKkaCURu92RVrGBpo3AmFg3tdH1S27OH4666thxj19EtzrNnhj84RRzqlgb53fnDBksGOPZa8eAuS4l4Ye71LZi8kPJWuYkC/8EmcwAeK6uOe0PYKE+dj3zs4ER5GoHaY+TFSpZAksUYD6mVVyhWqm/hJMk/oUnybZvbQM+gE8JIzYv+qN;4:dWy/o8WQNaWMHwTAWeBpXN/RBzEpanFkqF1AfDuMNNvtJFbrPlFJjJkvNJMh26Q3XSqhkJH/Ciawq84IYWhBnKMliwwBqDidsjm5JEU8r+ne2BKVLGYXEujCLpFEMWWkkriRCsjsL9AtPaFoPPQYcMhUAZCZ0QcN2w8HD2l39RK2kciGYIOirKTCf6DFj4X8fhqEWJ4asrjBfVJUkKuo58Mo2Ymw8u+j6rCbKgOChtMrHlyKtpLJS0BO2y1lUqxZOk5/GobEiHInLY5O4uWlUiM2gs7XMjcCEbR+0OX0APE3kbUSkP/wZQQ3CRDgi65B
X-Microsoft-Antispam-PRVS: <VI1PR04MB323195A15B253804B55BA48589700@VI1PR04MB3231.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3231;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3231;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(199004)(189003)(53936002)(6512007)(5660300001)(478600001)(386003)(6506007)(59450400001)(26005)(52116002)(4326008)(25786009)(97736004)(51416003)(76176011)(68736007)(47776003)(86362001)(66066001)(7416002)(105586002)(36756003)(50466002)(6486002)(48376002)(106356001)(316002)(11346002)(446003)(476003)(186003)(16526019)(2616005)(956004)(486006)(81156014)(8936002)(2906002)(3846002)(305945005)(6116002)(50226002)(7736002)(8676002)(16586007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3231;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3231;23:LKpEkfGviIiWtY5lUcUU9RyySF2awvBq2MNh/empQ?=
 =?us-ascii?Q?9bMwnefX4j/07AcU7WyNIR5eUqpiBHvDSiunHnSL0CkfX2h6gqklUs0w9dKP?=
 =?us-ascii?Q?k8g+HGViwr6e5WqT+cILMgFVHPM+/6aFJOAIc8x3VDv3y6SfJe2zUhi/HZO2?=
 =?us-ascii?Q?QOllKoBM9bUWeo6OKsIZaoQaocTlBvuI62BYJCSfbB4ztZ2n01C9pc/livrg?=
 =?us-ascii?Q?LOq06jYCxR7xYVoysLkomn390KJEXVdtgcHO93Vuo481TFNMCLUE/TLhTtOo?=
 =?us-ascii?Q?gIe8bd6jVkIEvtweuciPNmk20uOuX//Up82LSjkZ3v5kiQMUS9FlMB/Mf5OV?=
 =?us-ascii?Q?2um8e+E3uWAvnu385jNRn6gzLHIc5hhSIaUaZAEabKZSxVKg8JfbMa9Ge5j7?=
 =?us-ascii?Q?lkF+1AZLk90xf3/z5EAZQcZCVH3BnaElHi9gXp+yTuAIkxkfD+Uz1i1SJI7v?=
 =?us-ascii?Q?ihWfnBNQB1Hh0EktILK4NMC4utnV2glARhsakGoEPBteVWqXO4YNDZ1NPVBO?=
 =?us-ascii?Q?vElF2KeG50pWwEC+ON5Czf2Yd4xzB7viy91bhsJyuDjueLYYNLQUnLdok3pX?=
 =?us-ascii?Q?fqB1c3upX3OvCAPZrS7Ve8LfpopB85pWUyJk0LZyUGB7Jp9VgsIGbLOGRR0f?=
 =?us-ascii?Q?F6Ak/p6Y9v2fo/RW8FTs6qw9us+huAld07rV2578nwQeIJgmQZ7qQGWXyM2h?=
 =?us-ascii?Q?BVuq8VoZfvrp4V4GwmZj5Cl+hzcbTkMIFOifoctQR1dOLfQfKTmc3u2/NdYh?=
 =?us-ascii?Q?GC6OMwak1TGIVPsq8ypMbcZkqeng6U8Ry+eVl66cpWCYqk14EWWkXDtAT6jw?=
 =?us-ascii?Q?/p+Cg9TG0q1WyoRlVUl+HDiY1iGmxEPqUjj773tic9pdLeoyu24cj9gc/+0B?=
 =?us-ascii?Q?LmRucgRwJdQ5azli5D29B9mTxc3MOtQ1vRxYJ0z2mGjIytT4sNiFYUsvIEdP?=
 =?us-ascii?Q?kJKOMCtlLbBVudmw+V4OvER9EgZ/u8DK9ikkJDotxf1SbLPEnFErbxvIVR3/?=
 =?us-ascii?Q?j4HmjtyS7iM12t0AdJ+WS1rC+AHSOG1Ts2ak0lfWVCOAvYOkLKetFmtZFFWJ?=
 =?us-ascii?Q?XT+GDtTlSbUDb3MCQCokbWCiNIAL0W811h2/iWYJ8yFSYTj8l67Gy3jhC92r?=
 =?us-ascii?Q?Jd5xEo4SA0CR98TRLFBZiDJs6qbYa+TRf/kO46HKZgP8sldMrkfkb+A4D5vf?=
 =?us-ascii?Q?vXarTpv/IAicf0=3D?=
X-Microsoft-Antispam-Message-Info: MMPLdly9qwN5LZfUCwMtNlvKhkzT+tx/shF5143msEeHYla5Jzg8E2FB7I1AvZm6TiDOEUYy5q7jAeHBitZV/7Wi8H9qv0iqTUacCq7C3nbelDOyAq66YlH+CFWbxqQAo1wvFxmNhdSXtkPmWNdoLdyV713SFDFeJiMwWG2fCizmPzMLypF6XOhPyvPXZWuHCAS/XMnywPtw7RVuKx6Uj7XDGm3RfuWJcbjxTqcWEQQia8VSLmeKldM41JloFEsImtGA9Zg9N4rKJCQ0ccFYKU3k+pS8LJQM4ESSeiCAGtKNgLCoFimrOpMz7rwNztvY
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;6:jlXW/B1yTdSqxtJZHgOZpJ9YB5uFIWnOlIKREh6WLWZ2xYB68+StijZzjhQmjGEPhBZ6RkXkQ2UEZo4lJHsCxWk/70a7NyWlGwPbOJ1M0tWeD7JGheRylb81WUEmQb5I6shbYkc3PV0gxYfoeX9R0DcKrWMGIBNHLmmjFD0zUpitV92ga3lG4vadysOvkQqfAyl26HRjj3L7RhJLoe1y32VnVv00IVV+ouz2CM8oaisVfnTgdgtLJ+dVnmJErU6jeS6q5B5N+OPAhxwcgg0ivRoBW6XGdvLoiiv+4izBK5jE7nnFHbAZyIrb6iH1PgPN4KwL9g/TrqdobtKvgO2W+yeYLPRbZXQq/tEaprLjbpZ+9I7/30iGlDpRfnDwLrmaCH2vY78Zo285Snvsg+cFQ2X3OINPk7NiIhmYF1Q+HSxVmKDNDpJJMbTPqZNkO+yi9QvQBiuXkQiFhD3J+hoGgg==;5:c+4MVJteiD/CiuIa7SO8qvyIo/mrMxtUgyCWpiRlHhECpYyIzlloRXgkQ6UXQXDT6QqWm4JRfcCd1sva1G7y+hxUd7jDQwj7K2J0bTi1ZvWhEeHjTGgXWQI7WaHjQIov1ZD+LiaTeVS7IDCLmZonGCTzPX8uj9yE9CnPLOoP7O8=;24:yT1s3+KN+dUIayUoo2A4Fpjt6+XRnuxJ8KgP+FIMFCnfurlOLVB+kYqa6GtqnSWeRdm+ATPHcKIg6O1t3/r4zOCyB8MFX+ClyVUNkpHQj5g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;7:NOIbhoSzyNJlLsWDbRtm+n/+EEWMLIUYoNyjJec1oUNPsukTLN0IBNzVizh3EypR8Jqqk8fkOszp0vfljvDpWp6XK5mv/r+sfDPtETj4F/TC3x403fSmYHStJQLz8TW/uzv3s33HIaMqIZcpfDuMEmSoO+kyaY872hrY/tOMI65pM4acn2T6imv7Mu7lI00KSb0Uikca5HMxr9tArjSbaNpNeqwLLzD2+QB3LEoMkzfu/sF6/kVPlxFC9mPMZIoF
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 08:57:57.0085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 808f3a1d-e6c9-41bf-e40a-08d5d5c2c256
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3231
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
index f0779926..19c351f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -289,6 +289,30 @@ struct sdma_context_data {
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
@@ -298,11 +322,10 @@ struct sdma_engine;
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
@@ -310,12 +333,6 @@ struct sdma_channel {
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
@@ -325,10 +342,8 @@ struct sdma_channel {
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
@@ -391,6 +406,8 @@ struct sdma_engine {
 	u32				spba_start_addr;
 	u32				spba_end_addr;
 	unsigned int			irq;
+	dma_addr_t			bd0_phys;
+	struct sdma_buffer_descriptor	*bd0;
 };
 
 static struct sdma_driver_data sdma_imx31 = {
@@ -625,7 +642,7 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
 static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 		u32 address)
 {
-	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
+	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
 	void *buf_virt;
 	dma_addr_t buf_phys;
 	int ret;
@@ -700,7 +717,9 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 	 * call callback function.
 	 */
 	while (1) {
-		bd = &sdmac->bd[sdmac->buf_tail];
+		struct sdma_desc *desc = sdmac->desc;
+
+		bd = &desc->bd[desc->buf_tail];
 
 		if (bd->mode.status & BD_DONE)
 			break;
@@ -716,11 +735,11 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
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
@@ -729,7 +748,7 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		 * executed.
 		 */
 
-		dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
+		dmaengine_desc_get_callback_invoke(&sdmac->txdesc, NULL);
 
 		if (error)
 			sdmac->status = old_status;
@@ -742,17 +761,17 @@ static void mxc_sdma_handle_channel_normal(unsigned long data)
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
@@ -760,9 +779,9 @@ static void mxc_sdma_handle_channel_normal(unsigned long data)
 	else
 		sdmac->status = DMA_COMPLETE;
 
-	dma_cookie_complete(&sdmac->desc);
+	dma_cookie_complete(&sdmac->txdesc);
 
-	dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
+	dmaengine_desc_get_callback_invoke(&sdmac->txdesc, NULL);
 }
 
 static irqreturn_t sdma_int_handler(int irq, void *dev_id)
@@ -890,7 +909,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int channel = sdmac->channel;
 	int load_address;
 	struct sdma_context_data *context = sdma->context;
-	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
+	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
 	int ret;
 	unsigned long flags;
 
@@ -1093,18 +1112,22 @@ static int sdma_set_channel_priority(struct sdma_channel *sdmac,
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
@@ -1169,10 +1192,10 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
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
 
@@ -1187,6 +1210,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_desc *desc = sdmac->desc;
 
 	sdma_disable_channel(chan);
 
@@ -1200,7 +1224,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_set_channel_priority(sdmac, 0);
 
-	dma_free_coherent(NULL, PAGE_SIZE, sdmac->bd, sdmac->bd_phys);
+	dma_free_coherent(NULL, PAGE_SIZE, desc->bd, desc->bd_phys);
 
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
@@ -1216,6 +1240,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	int ret, i, count;
 	int channel = sdmac->channel;
 	struct scatterlist *sg;
+	struct sdma_desc *desc = sdmac->desc;
 
 	if (sdmac->status == DMA_IN_PROGRESS)
 		return NULL;
@@ -1223,9 +1248,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 	sdmac->flags = 0;
 
-	sdmac->buf_tail = 0;
-	sdmac->buf_ptail = 0;
-	sdmac->chn_real_count = 0;
+	desc->buf_tail = 0;
+	desc->buf_ptail = 0;
+	desc->chn_real_count = 0;
 
 	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
 			sg_len, channel);
@@ -1242,9 +1267,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		goto err_out;
 	}
 
-	sdmac->chn_count = 0;
+	desc->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
+		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
 		bd->buffer_addr = sg->dma_address;
@@ -1259,7 +1284,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		}
 
 		bd->mode.count = count;
-		sdmac->chn_count += count;
+		desc->chn_count += count;
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES) {
 			ret =  -EINVAL;
@@ -1300,10 +1325,10 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
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
@@ -1319,6 +1344,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
 	int ret, i = 0, buf = 0;
+	struct sdma_desc *desc = sdmac->desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
@@ -1327,10 +1353,10 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
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
@@ -1351,7 +1377,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	}
 
 	while (buf < buf_len) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
+		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
 		bd->buffer_addr = dma_addr;
@@ -1382,10 +1408,10 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
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
@@ -1424,13 +1450,14 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
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
@@ -1654,6 +1681,8 @@ static int sdma_init(struct sdma_engine *sdma)
 	if (ret)
 		goto err_dma_alloc;
 
+	sdma->bd0 = sdma->channel[0].desc->bd;
+
 	sdma_config_ownership(&sdma->channel[0], false, true, false);
 
 	/* Set Command Channel (Channel Zero) */
-- 
2.7.4

