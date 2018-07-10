Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25888C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBA520871
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ul2/G8Ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBA520871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933343AbeGJIY3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:24:29 -0400
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:27868
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752652AbeGJIYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn5ZS/0Z7r3YZNeiNiyl5ypfNYHZGrwUVwMaLd00DTs=;
 b=ul2/G8NsfrE5pqRdln81tBsDGlKzkDPXagwwExgHtR8Do35ROnIBg7VMMdez8klnjRnFQ1WvaYGzhHIu28/AIppltxoL9B+YSLBRb6HrQNVDd42Ny/0MTjolLZZnqXuy4T8S5JTwySLizjpNhgewombQUc54bswBIxZvMJUpOYA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3221.eurprd04.prod.outlook.com (2603:10a6:6:6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 10 Jul 2018 08:24:16 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
Date:   Wed, 11 Jul 2018 00:23:10 +0800
Message-Id: <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::20) To DB6PR04MB3221.eurprd04.prod.outlook.com
 (2603:10a6:6:6::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f6301a7-6c1a-4aff-d375-08d5e63e896a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3221;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;3:QjZBZzqsK5XdP/wZZvsa9xGgVyPBQj+v1NPDf/BZw8/pgVtUHp07OJ4xl0XKbSaYDfbOA0FEw6T5v84hNtm6u9qktz2k9NQXBW6q9U/Va59n02gqVZ3S1y+fmJY0uSB10DzspIc86fxxiBCl0zjmELGnL/42YxtQ4JmF2D2c88qzfPsrW2MTnIodPN7ufw/dSVLMT2/xWnXE9o4n8fkOmebdDezBaSblpdRYBnSePY7b4DgMLIG6pvOSXu34nPMg;25:DbaUqzRxJ/dOora7l84Dcx3O4tEjuTszOt6zJyUvrVDMgQlimPzzwfFabnmpkj8RVmZfiI54eFJ5F1rxUTFPpMIXnPIgpPEZMIzQXzmEKPqmmq9292/f3fLb9zDUP4yJSXgqZMwJVwuq6G/W9oOmLaM6cPeEYCxECNwrnJDM5ygx3gLBuw+8JvdhdTgpGN2ZFpzEeKSUsj8MRa0fPM0AZj0En1RKHna4NtJmUHihz/kpCdCWVOreFE4JSXoAt1I3Zahwhiv/AhD8ET0sH8Vq+yWx7W7afPGsvNUiCZ1JZ5aXIWN9usyrEZZxL/oZIAAxeMeJXgo5/4AgU9vkmsUXLw==;31:Lp3jFtoPn/cVDVzzI4B+P4brw/HkIPrwx39T2RhqZfydaAQXHtj0wm3/pQo83AKevNgHE53BQcMGOezffbykevIu4z+BVQtxO+8E+mWgiIdAf2kJKfWD9m3nGs4G2/Yd3cq6cy2PIMbhpqbJdR3uZxO/rOBPq0HxpVQzMmSYLyXHtLSTKjtbNkf71Vqe2H3LdK2tkkO9onBTB38xJlado+I7gcA7nxGl5KEUMzg53dc=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3221:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;20:WKmkuzcppEb8nctzQ3UiLtLYTT0gwCggORTCb5Yr1Z7XaNFof3tT6UY92dNY8+LQ2Wd8nWPHsGf/LgUfSMS4qgAPMN0cslQ+htQ+QDaeCpaZOCoNsZUsjUclmZxZZFElKpc4E1BRWfWyoGz5AQpMdxXgYySaiKyCrPNXOhGvzYGE2xBClbIE7KXXngYtOR3YHCxFz2ZZBNjtagZD3nkHGIfHeYMun/76i7D/74J+9objKlRZ8XbaMmlI84pD3S87+w7DdtGfG2oOOhooqlU96vNHioE90Nq91ZMLlQGFN5rdL/2Vgk37Us0CCU7DpQiwh4bb7yFde3twq4glbDlLkX0Oetg8lIRbUvNBU2WDuHpBVhT4WgnGqF1Vdcv5JCQtsXx5UefU5b/rR6lE7pSbvxAGY2lItK5bj2U/9K6eeMOWTfshvrt9ZH9BoSMPVp7FgShGZjsvSHJ5ly9KCkR7b/4xzf1cFfWCzOY7mJqsqNxMIcYfNk6hCN/jxmQJZxdL;4:szRFMsG+lMdvRC7elvfoiodnLLDf0D/S7KNkzr3AT295ap+xs26oDfqWcEImiVTw6QUYqQFSxitT5GvdgEmqEmds1qEsnW1SnPFCSa+MoPu5lrlyMLsOQox3nhgiw7CTZldfzzpnfMcW9iBcfuSldiCNJo09A1lH8EpzZ5cqZtcWZxQvnAIqQHIVWRY1NBDLhFthT3mAIxAYq/JRZ2V8yJlVlv4NJmTKq+EkL72VVjRQHvw0tjnhXVIcPS3gJjnqjZAZbUNQV19FuNbcddNgJAc7W5Ojz5tnlftR7G6Kd4nUcvew9Xw+MQZWRb6pi83h
X-Microsoft-Antispam-PRVS: <DB6PR04MB32213E16AE2FE7BA11201D52895B0@DB6PR04MB3221.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3221;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3221;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(53936002)(36756003)(5660300001)(50466002)(50226002)(6116002)(6666003)(106356001)(97736004)(8936002)(52116002)(76176011)(51416003)(3846002)(6486002)(14444005)(47776003)(68736007)(478600001)(86362001)(66066001)(25786009)(48376002)(4326008)(105586002)(2906002)(6512007)(476003)(2616005)(486006)(446003)(956004)(11346002)(305945005)(8676002)(7736002)(26005)(81156014)(16526019)(186003)(316002)(81166006)(6506007)(386003)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3221;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3221;23:vxNryO+dvTKysgbujsLep5NysRJOL6IAfBRd8GgdI?=
 =?us-ascii?Q?3ZxYCoN/0qOyAHV7+1I2z8GetNIn5lmBmnJ8XoXAE+pyl4Wg6tOErURtGKV3?=
 =?us-ascii?Q?WvVaYR4PWWsiFL23IW4UBsWrRcJfWyc0Ac8ohwQwL12K1nK93BVQELbSJWku?=
 =?us-ascii?Q?aOAjgj4QfgJ3FTlDLHeZ9D8zL1Wd9/CVO/VDkdQX3AXeR5OrgBcC2QrL/TbF?=
 =?us-ascii?Q?wUVR3vJ8jRtGagchmMS9qEq3Wav+LdNgHdAAFxCUB7TYloqBiYzNQ8P1sGnT?=
 =?us-ascii?Q?EjM5/8s4bJE6eh/ox1tawHw0sraP8Oh25FODYEQ/W2tvipgwiFVW6j7yUKV4?=
 =?us-ascii?Q?AE3gXoZzq78+kkvH1e44jMYpjOK90oLn7cLxliUeYEgvaia2b2y9HEgEEHn3?=
 =?us-ascii?Q?TAHda/zIkAnhv6B0QNtXpNmJFvHiD0cnF8buNQMv9ZMkasM0cLmd6/kDvOFE?=
 =?us-ascii?Q?uYnXkzvq7B23rNIeReO04htEx+QgNgVU4TMpQ6vHAOuBLkl2FMAfGuXLEbys?=
 =?us-ascii?Q?vndNRDonbVjHES9TgiX+VnPcYzsjSev0v//B2NCMeGLweiTdCwVjb1tB6N9e?=
 =?us-ascii?Q?dcHHRXgLbaZNRrMnLJ0svJ9qqSZbXYi1hHyWeYxGYsTDamWCcMBGSRsqRfu/?=
 =?us-ascii?Q?TwwD3Z9rqgBynLykzGQCF9iF7uPIj78etOJb4JUVpulBoJrcSK+aU5ZqWxrB?=
 =?us-ascii?Q?nwQnfRyVPnQ236Q1TuXavnwB3dQWfGhBqUOMQ+bqmkpbMRxUUMhsKSZrtpBe?=
 =?us-ascii?Q?AMBkJzD7uL03YTo0VdzTwenPl7D9q3AFDtB4vVTyATxXmBfY0XYLFXBOjNNY?=
 =?us-ascii?Q?4gJBrTaN5Bh9voAaHB0eBz88kiDfPutBZ6JO4vVvwL12d/jzrpVGNkgAxOEc?=
 =?us-ascii?Q?hy17/24yCri59xhcvMXcIdu3itQFhvvXLdHRG4vdvcGiBusY+PMJLM5ypAyS?=
 =?us-ascii?Q?MH1Z+qMDxfY4+OrfM/F+OB76BhVqmc0BIO4Puuc6Ut2/bUcLaBHyjFhhcvrB?=
 =?us-ascii?Q?WChoEdartMPF5OAbEIuWyyBxNCJqKKOFrzPOt20h+amkL40jT12eVwd7aV3G?=
 =?us-ascii?Q?6cx1XuJy0L2jxEyAMt3E2pDqumKHdCRfJ0OEo3ZWkdkbK/vxwALR17iIwZJc?=
 =?us-ascii?Q?d1DE27RM26R3xRG9cr/lPGZzDDdWbKw7hfqVdSykZvNoPc9KnnrgA=3D=3D?=
X-Microsoft-Antispam-Message-Info: yG73EHhxa7pJ69l7FLJAqTk4xtV5alqOrZMS2Qw4+wmBY+rlWrJ9p9i871AQPu4+qSjzCZWYat2XW4vQf/1DQCNqWQRijRfwfyajst1wgv0h9HoURsGSjuOUIMFOatwR4FK3p7zVZwk/6/TbrpVVMzOxAt+VUA7FRrQlKSO01PPHOHJwKTf+DAmPsHrPBotMoNgcljPWB5zXBHorbZFRdprUZG9rTg+o9Y71CMCNwYyc9qau9px/Yl28H86KI0LqPe0nIWQtGGu+dgCi+FWDf+3PjGgOWjeN4a4htpehjxpyHMJq740A16hEuwGbn/19Kpifg4BMq5tFMb3r3UpVIjb7NjRyKU9aASL2b8AYa/4=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;6:ObYdeEuqP9E3GuR8LdjmuuxjBklsAP2FNrCErJT50sVh11FeBS9FfX6tr+lB7CsLgRSRsZUTmUpgWFlRh9XBiuWfNPFcxUKfrWjacOovi95DcIM92lj/4mfGLY4tDHej/PH6ywED3PgEZplCQvNYwSTT7Dv/s+gSOEQcUrhrlwFGXD6I8/Ia/9TKr+ycDLTLYwdFuu9zqAFuD8DdyYaqMhM/6BXO0Ol+5QyFb7YF6/vkKB9GMDYAtzAw0GR7K4OoxEjkIvXwU1R75rIIEH7Xijj3lqZZT2RX7ExRZw5gLwLn0O8Jfwt6prQ42tZIud7ZIlrIz0+t/PJnorcMUk/jHqOGl3iQdzPhO+PzQWz221VVWuuFbhQqsXZINQorK/6qw90qDibyxBUYbhgsb5bt1vhCle2Eyf/d/Qi6NbIDGOuCz5Mq7ewY3xnzVzNwgZ/qgB+2tVPjoJWxnKoWzrGo2A==;5:bMV6MT95fJrXC6o/Yp7oLGsma2nfokwqCzULKK8ItqYvWe3LsGomt8ShOvBSxy9NkHj+9fEbqF+wYLqJhMVN9nOSD4a5AIgdN0tvqHEESlUoy42wnlFWlX6Eh+FawtwnY//q4Ou3rBYvOluBcCoSNjUtq8VzI6e7cmSAWwvIof0=;24:vhCMBtrF+byvGgyTZ4hr9PPK5y+MXBSJ49pHSJR0xtnXQC+G6fqtycFP+lnkrhbzorEZXcXDfhTCxYaEMBwqurTiIuAUPDnfDg6yvsnp1Aw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;7:WOZnKYhH65Zavcy2mplbM9gZDfeZzDYnc68qRPhvYwBFpqQmSO2COo45ZL31ZawPZKGmBhfot5NizDmBdSfxZMs0TIjEIeSBpbTruy1G3t5bY5VA1Re1UgmarpvK3qbA39K/WKsq2AI+wyfV0Y/61l9XRdy/kUb7x32KncJ4u7TLcjJU4MEAP4+4Z9lUmwj5JG3eVTAhwKVOIyYScABtl+2nK43Tvayt5jk3OK2iCaVFWqzHeEOA6O56lOo6/1U8
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 08:24:16.9624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6301a7-6c1a-4aff-d375-08d5e63e896a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MEMCPY support, meanwhile, add SDMA_BD_MAX_CNT instead
of '0xffff'.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3b622d6..27ccabf 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -341,6 +341,7 @@ struct sdma_desc {
  * @pc_from_device:	script address for those device_2_memory
  * @pc_to_device:	script address for those memory_2_device
  * @device_to_device:	script address for those device_2_device
+ * @pc_to_pc:		script address for those memory_2_memory
  * @flags:		loop mode or not
  * @per_address:	peripheral source or destination address in common case
  *                      destination address in p_2_p case
@@ -366,6 +367,7 @@ struct sdma_channel {
 	enum dma_slave_buswidth		word_size;
 	unsigned int			pc_from_device, pc_to_device;
 	unsigned int			device_to_device;
+	unsigned int                    pc_to_pc;
 	unsigned long			flags;
 	dma_addr_t			per_address, per_address2;
 	unsigned long			event_mask[2];
@@ -385,6 +387,8 @@ struct sdma_channel {
 
 #define SDMA_FIRMWARE_MAGIC 0x414d4453
 
+#define SDMA_BD_MAX_CNT	0xffff
+
 /**
  * struct sdma_firmware_header - Layout of the firmware image
  *
@@ -868,14 +872,16 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
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
@@ -948,6 +954,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	sdmac->pc_from_device = per_2_emi;
 	sdmac->pc_to_device = emi_2_per;
 	sdmac->device_to_device = per_2_per;
+	sdmac->pc_to_pc = emi_2_emi;
 }
 
 static int sdma_load_context(struct sdma_channel *sdmac)
@@ -964,6 +971,8 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 		load_address = sdmac->pc_from_device;
 	else if (sdmac->direction == DMA_DEV_TO_DEV)
 		load_address = sdmac->device_to_device;
+	else if (sdmac->direction == DMA_MEM_TO_MEM)
+		load_address = sdmac->pc_to_pc;
 	else
 		load_address = sdmac->pc_to_device;
 
@@ -1317,6 +1326,84 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
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
+	desc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM, len / SDMA_BD_MAX_CNT
+					+ 1);
+	if (!desc)
+		goto err_out;
+
+	do {
+		count = min_t(size_t, len, SDMA_BD_MAX_CNT);
+		bd = &desc->bd[i];
+		bd->buffer_addr = dma_src;
+		bd->ext_buffer_addr = dma_dst;
+		bd->mode.count = count;
+		desc->chn_count += count;
+
+		switch (sdmac->word_size) {
+		case DMA_SLAVE_BUSWIDTH_4_BYTES:
+			bd->mode.command = 0;
+			if ((count | dma_src | dma_dst) & 3)
+				goto err_bd_out;
+			break;
+		case DMA_SLAVE_BUSWIDTH_2_BYTES:
+			bd->mode.command = 2;
+			if ((count | dma_src | dma_dst) & 1)
+				goto err_bd_out;
+			break;
+		case DMA_SLAVE_BUSWIDTH_1_BYTE:
+			bd->mode.command = 1;
+			break;
+		default:
+			goto err_bd_out;
+		}
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
+err_bd_out:
+	sdma_free_bd(desc);
+	kfree(desc);
+err_out:
+	return NULL;
+}
+
 static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
@@ -1344,9 +1431,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 		count = sg_dma_len(sg);
 
-		if (count > 0xffff) {
+		if (count > SDMA_BD_MAX_CNT) {
 			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
-					channel, count, 0xffff);
+					channel, count, SDMA_BD_MAX_CNT);
 			goto err_bd_out;
 		}
 
@@ -1421,9 +1508,9 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 
-	if (period_len > 0xffff) {
+	if (period_len > SDMA_BD_MAX_CNT) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
-				channel, period_len, 0xffff);
+				channel, period_len, SDMA_BD_MAX_CNT);
 		goto err_bd_out;
 	}
 
@@ -1486,6 +1573,8 @@ static int sdma_config(struct dma_chan *chan,
 		sdmac->watermark_level |= (dmaengine_cfg->dst_maxburst << 16) &
 			SDMA_WATERMARK_LEVEL_HWML;
 		sdmac->word_size = dmaengine_cfg->dst_addr_width;
+	} else if (dmaengine_cfg->direction == DMA_MEM_TO_MEM) {
+		sdmac->word_size = dmaengine_cfg->dst_addr_width;
 	} else {
 		sdmac->per_address = dmaengine_cfg->dst_addr;
 		sdmac->watermark_level = dmaengine_cfg->dst_maxburst *
@@ -1902,6 +1991,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
+	dma_cap_set(DMA_MEMCPY, sdma->dma_device.cap_mask);
 
 	INIT_LIST_HEAD(&sdma->dma_device.channels);
 	/* Initialize channel parameters */
@@ -1968,9 +2058,11 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.dst_addr_widths = SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.directions = SDMA_DMA_DIRECTIONS;
 	sdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	sdma->dma_device.device_prep_dma_memcpy = sdma_prep_memcpy;
 	sdma->dma_device.device_issue_pending = sdma_issue_pending;
 	sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
-	dma_set_max_seg_size(sdma->dma_device.dev, 65535);
+	sdma->dma_device.copy_align = DMAENGINE_ALIGN_4_BYTES;
+	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);
 
 	platform_set_drvdata(pdev, sdma);
 
-- 
2.7.4

