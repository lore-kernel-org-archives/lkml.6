Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C6CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B837620846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gfxKqRxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B837620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbeGWKqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:46:09 -0400
Received: from mail-eopbgr10046.outbound.protection.outlook.com ([40.107.1.46]:46529
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387957AbeGWKqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+KUX/LnsNOoYwClt0oD6H+70sZkZFYLzHfKPzszaMw=;
 b=gfxKqRxLbbfWZpQNBL77o1ixQiRabPnyWkwFWpnyEhhWzkXECzcyJ10ICdgupk/WxYS2F+CEdWl99jf7OQN9ioDOfcZOGfdU5Rk2qc90dSVRtmNbvwGsEIPKQ6oGSNgXIS4jdSl1WCqZhKqQj8CAYJmsBPYn5i7ogMDt/6Eqfn4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3232.eurprd04.prod.outlook.com (2603:10a6:802:6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Mon, 23 Jul 2018 09:45:40 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, s.hauer@pengutronix.de,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v3 2/3] dmaengine: imx-sdma: add memcpy interface
Date:   Tue, 24 Jul 2018 01:46:11 +0800
Message-Id: <1532367972-29707-3-git-send-email-yibin.gong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11c2b6e4-a819-4045-5921-08d5f0810f26
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3232;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;3:o+ML0ypgFdO8c3D0rLyutQSMSXMxyJPTqBRCTzOJaqoW6sLquOcH55pd4K/Usgsb0+sDuDpmidlRmxZdhBwXwPXG5keJxXgOJKq1EZ8atph3YmwlCEy7qRaVm4AKeHos7QiS3fL9+zv3RTfsTffKi8aRh0hbItgKnT1ht4lIv2g5BEa7AEY+5lK7+263NfZHT7bIrWsjwu1ocPeNtGBQsT+1NphxTTsab0EpaC/0cnVNakahgsPrQdUCLugavZT9;25:UYO+4Hr/+pON4d/7tHW/94H6r2YjnATVy4p9tqFrIM/owyTTpo3v5MCj3W+oO50Q8zoLbFzuu2vDwNpKovq+qt0W1IQYk1ZYKh//MC96ys9bZxJEHW6VAwCd6T4X140FaS7nCSxazb89jmSiukiGT6BrFuDvFL5L5jliKqjwTK6xPaGpOzfbRTeW+h2ZcxTnG996OM5a8DvJW8CbZJvBqGc/l3obsrjO6VGwQTMQiKELIJ7fNtjtx6l1j5uHvXFF1EhAtn13Mg2UWubigb3CrGazFkjrDHvaV757h5EHBHSZsG++vi4o7uofZ9gucY0G6Sr1CVwGmRkvpI0xwiyVlA==;31:5gmvr8Mq1PhxckLFjyinMW7fVMdCSZivIaEi9Ksprmt1WPCfed2Bo/61khI3LiIUTVLIQcGd98C2SzQBK9sd+uBMqoGAgL7748kyWgHWA3tnf6+r2Awq5EwXXSrO4FwNYQa1Dj6p9CW+OY+p3nASdmKmNkHhWvws4Gpx/aegfaflokJBX5sMZE+Icca1sjdct4friwIKMQd3VSdATq56QXg3W0f0BHU1q9bDHrppoUM=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3232:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;20:paChy6eUgYaMDvrzvWMd1hQfdp4hMSYy6mbioGImUiufvfMRsXXORFJgiHH0/H94vkaIzoJQr0Fj1gYgrdjNY7PG/ec3VQnQRhwIfbJuRHBn1NQYzVhPihmJSTinpPqrvFAMcjOQk8ZBeJIFe5gxDmR5OMOBi0aFi0nCuwkFAzyb+7TN5f4r16oD7w0F4nIZ8vktxTwU2o6CWc2yvFPcrZ7qeRucTiIYUO0imKBC5bQHQYj7AOjeXcWmNiiZNXIeIeF5Qe0bHtfTNL1hbOs4fCxIFixn8MRXnTl2TpLSJqPcg1s3f+G5oT2Y8jAawVtbIv4udBrK87NLGElNC2Lfh6VEx5ukE3lZJD8elbWE9ywb3XT9Sgm2PZA9jJzIqgs21iKtj+G6xAys0cI7bdld7yEnoWMfeiNIsS6UUIyERzlGdBd5WKSCALMCYpqjbADMQIQUy0OiGmybM45bTyIjea+tAUizHZEhXb996OMtI1wlbuzIDyD0ih/OrrjJd4B0;4:uPwedbte2uqVARRpAclzkE+SVSlCgzjI4rVqLXrhQIP+ApJl3Ea+WTKZxAIM23VGGbx2n+Y8/dJ9dw2PNuXlIrUjt3jlpJCQMPJWlmVN9KS+5Hrl9zVHDBRVYbdhoraldHp5svxELRqpqCpkJr+nMj9R3dGnY4H42/qloAeIoBM0QJlQRG0hPMT7aZugUmuS4e9WtgVDeL5eBbQGjXUgmWQH9L5MCZ+aJRqEyvG/ekTgbHg/C9Pj1J8U3RWFOKUIUBWHmzj7/BTkbEDBe71m3LRCjmIA1gN+hIWeqgJz8wkX1mOyYxG/xYoddZVxMbDc
X-Microsoft-Antispam-PRVS: <VI1PR04MB3232333B4F86D4CA09252C9489560@VI1PR04MB3232.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3232;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3232;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(39860400002)(376002)(199004)(189003)(16526019)(6116002)(3846002)(956004)(8936002)(66066001)(47776003)(53936002)(478600001)(305945005)(26005)(50466002)(48376002)(476003)(2616005)(6512007)(25786009)(7736002)(4326008)(11346002)(6506007)(386003)(14444005)(36756003)(50226002)(106356001)(97736004)(446003)(5660300001)(68736007)(6666003)(105586002)(2906002)(486006)(81166006)(8676002)(52116002)(81156014)(186003)(86362001)(51416003)(16586007)(6486002)(316002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3232;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3232;23:/zGjJn+o5OFuOOt50bod4GTyt17TRfxBAvhgrkoBF?=
 =?us-ascii?Q?LoYYYv4z0f0M4hl7RTSqY+T3JklRI+NaQmjsA7cIB1jn2ZcdH9FTMRuRzDII?=
 =?us-ascii?Q?pzkLXusGpzg7c9OgenUzQ/uCgE/m95FzI9zERyW4vHPGyznbZp2K692eVies?=
 =?us-ascii?Q?nBVbdrIuK7Xl6xIbBmvgYWZpIOcE7Z6ZgtC4AaIWmPLqJ47uYFxSQj+Qpil7?=
 =?us-ascii?Q?Is4D5vMkbDBnbnXm/fLdGn81tnC+TeXOu+JLWtT+Ua2D2m7H/7FVlzxlHxEV?=
 =?us-ascii?Q?eTUP2jwMta+LATF+SouG+yN4P/qmTn3Qmw6mzO7TYFP38GJZfONZqXIuA6/U?=
 =?us-ascii?Q?9GnaIpOqXOVY7OrGiPWLxmz0Zn42KTfsdJ5cZxvBogm0oCa69dfD9XEvles0?=
 =?us-ascii?Q?88yt943yk515HyU5/cRXwdiZS7/GOtY2KCcSyqOt1dhRVR8zuQHEx75CL9DY?=
 =?us-ascii?Q?eV59EhqyxuQwR6nowoVNGBdTcLpeECpoXy3BcWBe290OpLLKUfRD1HFEXfSv?=
 =?us-ascii?Q?x85zdAHx5ERYW6oGDQZWgJXYlt/KVDUTB02CfC6xngOVYUPGBMZ+i1Ila+KY?=
 =?us-ascii?Q?aptd6qMYTKYL74gZDBxWRgreuoFTWuBnCl+IL7A/1Eyxuo170iVAg8FeO9cd?=
 =?us-ascii?Q?S+hD9fKgYtU8QJlcPUWLo+sldtBNy6K2DfY+Fp1u+EUOzdLM/JKX5GiXswMW?=
 =?us-ascii?Q?qNJWNsn86GUltzvLkBtv90bFnHxY2gEyRFhskb9A1OvjzAhn7tD50fIKcldO?=
 =?us-ascii?Q?kPOQfT081M6kY5Ktzcn7C/CYKiEepPyv3qHGu4scIs5i0ZR9yeOKceYgvPIX?=
 =?us-ascii?Q?oKQ8sxuxd7FVVjKBADtWjdzaxJ5IUinQoVljXNViUPHssAId7tHfYAQVUYWx?=
 =?us-ascii?Q?6Dw26JGA5SrX8ioe5w10sClDUFvrXsmOo0wSEJpXZe7Bf/m22VYH0b/mKDdK?=
 =?us-ascii?Q?n6Fl4i2wQA2DHS/vTxX4g61F5/bd/Yv02DHjRszoit0bsfmu+Opv+5WJCCcl?=
 =?us-ascii?Q?bk58KG46LXCZjk/heThh/Jlp/bHiA4NzDVr7RFix5t0u3RhyHstEXFIUxNtE?=
 =?us-ascii?Q?JF5wPmScO0h5ajPtemUy1LVUJhbPX2IPngqhcLsV0w9Q4XEU/JzSAoZqh4yY?=
 =?us-ascii?Q?kIe5dTBUG4Zw3qNGE/Ns3nI0ZeeXkdhWWiWzUaKhhoC2fU7/gdA8w=3D=3D?=
X-Microsoft-Antispam-Message-Info: g2IKnuL9PurU2Mp3R6uHw+1UvhliRrvl9fm8gLgXVx1R+mz0LyL5sfHjNRF2Ia/QVB5mOu0Yw+scdbMAZX0WyshO02ebJ3K/8goKH3w58eesm+N7LZgKZaYhwjIRObqkoDddjD4iTcf0Z0ErNaJOM2OC+U8fc4oCwtCLGS5u3drk77hgzwc81vRMEcVCMEwG0DW2pl64ekUjVl/Q4zhBqtdCbnvk0bwitgB9h29n/+RQ4UE7lEiZ0nGiuATCNdhnXFDvs6+mntuJDA26UXPU8zrhpjhMXHsulZU9ZDpY8OWHfpzlSlqPfyuTOgePA1LmMob1YOZYWoVGzm7ow4R8Vm4R9fy+biymRFjWLExUt84=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;6:Zic3s8iwAtb4NCjvE8GrlyDULjzhHy4qibbp5e+FxMDBHDiP3jZeWXVR8Abyn8+yYZL+qtImggsspBiiECFw4AJznE3GusQ+U01RzVGurcJch6rfATqVV7ZvSeisII/QgxAoYFfIcDtdmTGn1XBkk6ZqDj/WfY15echd7nxaW9xS0sNpX/Mqytg5YrJAl70pBBS+kndZbz45yWuwg0wsy1oqWjaTkyE7C/6m0MnZLKBlp7NHC81NYRyzjAOxPwjjaErW0pSERTVwvgUlRV/iaYcbHFamQuTe8UB8G1qR+6qxxU0B9Csuf0rrJebYZQ3AdciTjfhZwprfCKLg7dkaJkl/54W7l0n6EBBlVRqV+1Zkwh8t3ZsY6QCQ9h6YosU7M3jr7opgO85mLeDDJSICqIkoXw9AC8jQTu0SNjhZZnJm3vP3Ro5FNc4xQvyc8ndW6l6OzFGE6mRKs3hxxyfoMQ==;5:+PK7FG07ZozJ7CjOSoE7xBms8Ebz5IgU4gtmvzkTyxPgN7ZfRUk/NUO2+4SMVqr5rIRERoAmiCFgDOYSF7OIhlchy4jv+h/lePYgEm5orEiLdD8Bmzpg79YzjzUEOVARPDxIvzAGsDAgTblF70eVDXtVKLi4+cU5XkDKxaQ66OE=;7:bhItgMfPhnT0eOnuLyLtd+6BccEp+pSti76pOMEUbWnzh+1W9i2GhCrCkr9+WLJbxPJRhAMC/v+DvE1AGBJqO6OB4ZvrPKaamWEeJdtlg0nYb4Pt/x1KOm5XlB3uOnw55S5e5LmjG+AFiIejLyY7UeA8/UPpdDheAJNGn6nRjcC03lUiophxVPLECcFyE3xlm7RVKlE0hGQSrEmND+RrRVfxB3lAITA8dCHFn8ob2jRFCLoXYMtTQS8TkFq4iuSD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 09:45:40.9192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c2b6e4-a819-4045-5921-08d5f0810f26
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MEMCPY capability for imx-sdma driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index e3d5e73..b4ec2d2 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -342,6 +342,7 @@ struct sdma_desc {
  * @pc_from_device:	script address for those device_2_memory
  * @pc_to_device:	script address for those memory_2_device
  * @device_to_device:	script address for those device_2_device
+ * @pc_to_pc:		script address for those memory_2_memory
  * @flags:		loop mode or not
  * @per_address:	peripheral source or destination address in common case
  *                      destination address in p_2_p case
@@ -367,6 +368,7 @@ struct sdma_channel {
 	enum dma_slave_buswidth		word_size;
 	unsigned int			pc_from_device, pc_to_device;
 	unsigned int			device_to_device;
+	unsigned int                    pc_to_pc;
 	unsigned long			flags;
 	dma_addr_t			per_address, per_address2;
 	unsigned long			event_mask[2];
@@ -869,14 +871,16 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	 * These are needed once we start to support transfers between
 	 * two peripherals or memory-to-memory transfers
 	 */
-	int per_2_per = 0;
+	int per_2_per = 0, emi_2_emi = 0;
 
 	sdmac->pc_from_device = 0;
 	sdmac->pc_to_device = 0;
 	sdmac->device_to_device = 0;
+	sdmac->pc_to_pc = 0;
 
 	switch (peripheral_type) {
 	case IMX_DMATYPE_MEMORY:
+		emi_2_emi = sdma->script_addrs->ap_2_ap_addr;
 		break;
 	case IMX_DMATYPE_DSP:
 		emi_2_per = sdma->script_addrs->bp_2_ap_addr;
@@ -949,6 +953,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	sdmac->pc_from_device = per_2_emi;
 	sdmac->pc_to_device = emi_2_per;
 	sdmac->device_to_device = per_2_per;
+	sdmac->pc_to_pc = emi_2_emi;
 }
 
 static int sdma_load_context(struct sdma_channel *sdmac)
@@ -965,6 +970,8 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 		load_address = sdmac->pc_from_device;
 	else if (sdmac->direction == DMA_DEV_TO_DEV)
 		load_address = sdmac->device_to_device;
+	else if (sdmac->direction == DMA_MEM_TO_MEM)
+		load_address = sdmac->pc_to_pc;
 	else
 		load_address = sdmac->pc_to_device;
 
@@ -1214,10 +1221,28 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct imx_dma_data *data = chan->private;
+	struct imx_dma_data mem_data;
 	int prio, ret;
 
-	if (!data)
-		return -EINVAL;
+	/*
+	 * MEMCPY may never setup chan->private by filter function such as
+	 * dmatest, thus create 'struct imx_dma_data mem_data' for this case.
+	 * Please note in any other slave case, you have to setup chan->private
+	 * with 'struct imx_dma_data' in your own filter function if you want to
+	 * request dma channel by dma_request_channel() rather than
+	 * dma_request_slave_channel(). Othwise, 'MEMCPY in case?' will appear
+	 * to warn you to correct your filter function.
+	 */
+	if (!data) {
+		dev_dbg(sdmac->sdma->dev, "MEMCPY in case?\n");
+		mem_data.priority = 2;
+		mem_data.peripheral_type = IMX_DMATYPE_MEMORY;
+		mem_data.dma_request = 0;
+		mem_data.dma_request2 = 0;
+		data = &mem_data;
+
+		sdma_get_pc(sdmac, IMX_DMATYPE_MEMORY);
+	}
 
 	switch (data->priority) {
 	case DMA_PRIO_HIGH:
@@ -1307,6 +1332,10 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 	if (sdma_alloc_bd(desc))
 		goto err_desc_out;
 
+	/* No slave_config called in MEMCPY case, so do here */
+	if (direction == DMA_MEM_TO_MEM)
+		sdma_config_ownership(sdmac, false, true, false);
+
 	if (sdma_load_context(sdmac))
 		goto err_desc_out;
 
@@ -1318,6 +1347,62 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 	return NULL;
 }
 
+static struct dma_async_tx_descriptor *sdma_prep_memcpy(
+		struct dma_chan *chan, dma_addr_t dma_dst,
+		dma_addr_t dma_src, size_t len, unsigned long flags)
+{
+	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct sdma_engine *sdma = sdmac->sdma;
+	int channel = sdmac->channel;
+	size_t count;
+	int i = 0, param;
+	struct sdma_buffer_descriptor *bd;
+	struct sdma_desc *desc;
+
+	if (!chan || !len)
+		return NULL;
+
+	dev_dbg(sdma->dev, "memcpy: %pad->%pad, len=%zu, channel=%d.\n",
+		&dma_src, &dma_dst, len, channel);
+
+	desc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM,
+					len / SDMA_BD_MAX_CNT + 1);
+	if (!desc)
+		return NULL;
+
+	do {
+		count = min_t(size_t, len, SDMA_BD_MAX_CNT);
+		bd = &desc->bd[i];
+		bd->buffer_addr = dma_src;
+		bd->ext_buffer_addr = dma_dst;
+		bd->mode.count = count;
+		desc->chn_count += count;
+		bd->mode.command = 0;
+
+		dma_src += count;
+		dma_dst += count;
+		len -= count;
+		i++;
+
+		param = BD_DONE | BD_EXTD | BD_CONT;
+		/* last bd */
+		if (!len) {
+			param |= BD_INTR;
+			param |= BD_LAST;
+			param &= ~BD_CONT;
+		}
+
+		dev_dbg(sdma->dev, "entry %d: count: %zd dma: 0x%x %s%s\n",
+				i, count, bd->buffer_addr,
+				param & BD_WRAP ? "wrap" : "",
+				param & BD_INTR ? " intr" : "");
+
+		bd->mode.status = param;
+	} while (len);
+
+	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+}
+
 static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
@@ -1903,6 +1988,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
+	dma_cap_set(DMA_MEMCPY, sdma->dma_device.cap_mask);
 
 	INIT_LIST_HEAD(&sdma->dma_device.channels);
 	/* Initialize channel parameters */
@@ -1969,6 +2055,7 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.dst_addr_widths = SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.directions = SDMA_DMA_DIRECTIONS;
 	sdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	sdma->dma_device.device_prep_dma_memcpy = sdma_prep_memcpy;
 	sdma->dma_device.device_issue_pending = sdma_issue_pending;
 	sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
 	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);
-- 
2.7.4

