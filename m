Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zgbnKGQVGlu5bwAAmS7hNA
	; Fri, 08 Jun 2018 05:46:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 16C5D607E4; Fri,  8 Jun 2018 05:46:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FYYDfH6S"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 726E060275;
	Fri,  8 Jun 2018 05:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 726E060275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbeFHFp5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:45:57 -0400
Received: from mail-db5eur01on0067.outbound.protection.outlook.com ([104.47.2.67]:28736
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751116AbeFHFpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUbjUmXz/Do8HhTTs/JDxWEXXkbyr24ZUCQqCntohlE=;
 b=FYYDfH6S2YXdSO3XjScQ2LdxDPa+AxR90Btb3Ka0EoPamYDTRuKdqPNErmepNe2gVT3f9/GvhY39lj25BgbNcy1ltxRfo0oUWg01T1Rj8tiamcKRzEogNhyt4Mj18NpCUOeQF0+CzyF8aWlkClP31WcOiZK0SvK+olLEBabbitc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3232.eurprd04.prod.outlook.com (2603:10a6:802:6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Fri, 8 Jun 2018 05:45:43 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: vkoul@kernel.org, s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v2 1/5] dmaengine: imx-sdma: add virt-dma support
Date: Fri,  8 Jun 2018 21:44:46 +0800
Message-Id: <1528465490-19684-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
References: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:202:2::24) To VI1PR04MB3232.eurprd04.prod.outlook.com
 (2603:10a6:802:6::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3232;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;3:ingMeTGU/qA+lNEeyiqGTmBu4FPB6E4/AQyXpVwETQscY1feyAxdqeGpRjgMKisRuvx8l5sPZaIPtiCXGNCESlBXumiizpNGzcyRYw+QU8lpRPQ2HPgLbW4udxC0hna/6ir2vLc6+xdQfBjoNepk2mL6oIUXQSrnUDJPs6KD6sKjndQt2npskzdXHSAwn01g/pRwAhQGmczo9ZH4gqsE3YJnQivxYAgfRo79we5wAm5pwcej0cPNhDofuK9PLXnR;25:GyLKp5UNbOiR1UmdgU0DWs5x6fv5oHLeh1Q+ICN/FBvp8TnTX0ZOF/6G0oRr70Gp86bbo/igwY9ucGNmGRqVB3OBdZVnbJTwu36PO8qjREp4JzFrzdA6HUCmH4BuU1Mpg+M5xlA21d+ThQF7VMcYFKfZtkxF/2WCJF9CSmN7whtAOILQDux0M4oh4yxNeNz175tC12Rt8JppTmVTWh4fTEvWuS+IALnDezhxc93gpcbMs6EO+h9mzCAhbKOHl20Hx5piFoGNW1dsXkSz8cNIwK/rQW8hxU90ArTKCBNkJmT9vaGbynlHG1aHUMRvFZ8IgmiZDcwjhmNTaM23fMhmsA==;31:zd4MFUrUC/H1lvLwKdNb91NcIDS8urf1jGPNRf0RMt6g9PAH3B5Q5leFwYCWZEVEx7ymdGsZjHMnc4VekkZsInogeAEXLTiQ52Z+Nl8C7r6H3PxMMx6PJtIR9sCwwa1hqJIn5/IKclkuGRespws3TpeyT/lmA+QFq5QdJXbKVu+yxvf08GgWjWB1Fw82kkmBXhW7frH/FgOnJDrz9W6pfNhWBnfGYLC1z5JPjJKY0vM=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3232:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;20:TPhJcDPMXSQD9x35d5RR+mJC4NGKd5wMNc68IOL9/6REQpHbCx2f/dkAxiQuyNf4bXjqJfVLqi50vZvO+UTXr0n5AAjT5ue/cQF+oWwKhAsD2hsntp67Pr/4Dp1pk44LzQRPTwVyJD+4nyya0/HGI4qIJ4htvRrfGy32ymNxdRIj/jrpcMLADqOuUwaoYdq0u41/r+9bFGeNWpaPKdbIavCxr28us8fyb8ifEQlb1jyxAiXziNmofnYde7jpzYGHFsfbgEB0sGA+G25nrsPMh77YR0GjR8yfvEAtM/6jS5C/jczimp4JXKWt6M8mAJyOtN/bVKiAwb+EtW+V7Hvm2KFk+o7T8pFx3SGZojCxRHHwulxiakEpyZq7qpqRyPhl8E3hobAN2WQcc5sfvXY1xCGL4Td1PFj0lubgN4gAGzuGshBNFvu/sAsp6drOcDmmF0HY2jH0kLCyEyMIVlO5l2Hmnxe21z4pl6q34CbyqOGaESRGGvgvEjhDdds/FxbG;4:HCYWk/PXKaPtHrw/Px0C5RpwR9G858BnY4e23wb5ICls44rBavtbF1zJd78B7Ann7b1RkUkOgQi4999G5v6H5mU1vS22CS6JSzAkMs1oDBWqu859vN6CKnBnDiFsU3uXX+nPFpzc6lIaSsC2CX01gEW3t/cBBCtE4VJP3tjC1P5xxJNC09iLY6wNDxT8V1C8dr2iPuBokUmR9XSQM1UYvDtARd4mGILx8wSww3Bmvoh0ZznmiO72BFfQuMoSQSFCF6T2pdJZMEBAA80orYKifit6x/LPcPTbmmvzfgAI+6On7Di1RpiUcEUCbucAAxl7
X-Microsoft-Antispam-PRVS: <VI1PR04MB32327D560054E38498727DFD897B0@VI1PR04MB3232.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3232;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3232;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39380400002)(39860400002)(346002)(199004)(189003)(11346002)(6512007)(386003)(186003)(66066001)(48376002)(2906002)(3846002)(6116002)(68736007)(16586007)(52116002)(36756003)(97736004)(53936002)(76176011)(86362001)(25786009)(51416003)(26005)(59450400001)(316002)(4326008)(81156014)(2616005)(956004)(446003)(476003)(50226002)(486006)(575784001)(81166006)(6506007)(106356001)(7736002)(8936002)(8676002)(5660300001)(478600001)(16526019)(6486002)(47776003)(105586002)(50466002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3232;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3232;23:VV0Wg8xKiKNSUZNkUy95Q1+Uti052qy6/nZebAQW2?=
 =?us-ascii?Q?1i6ux8bhsHoOMWoU1WlTYoXM9uBST2n76NgJ1bKO/Gp4ar28KX8/wVdK//YU?=
 =?us-ascii?Q?ZSx68ipqv0dYWmbY4tJBQ4mtAfo0GB2B1qa3eSot1HZauPeYriEMSodYtAzC?=
 =?us-ascii?Q?/8briFuh/vRf9pxbFTUM8h+UzZIZjmtaN0/VosulKu3gdPzb74WsK9XyMmVg?=
 =?us-ascii?Q?UtsJdTUqxCfhV+rPZtN0zF+bDmZ4uDQQ8pUKlHYQg/qe57Y/Xrw6u5oxQbqZ?=
 =?us-ascii?Q?mcKkhTYh67sn4XQ0FNGhB3qV0s8Vj4q1ARCjRWRLAmPy406zF+rvTbsqpp1j?=
 =?us-ascii?Q?NUDXxcf6qk5SubTWBAO4FSPBGnnVt+Hpx5vzszeKodQCFFRKfUwbsQq3XlNK?=
 =?us-ascii?Q?NeWhhs1Vc00wxfIA+1MKExzVj1QsTlcbnT57ebES9F5r8sW6KYUdRuZX3HxA?=
 =?us-ascii?Q?rI9n6l3mscCV1O19J6kt6BjPYRF04Gf2iaYCjnWysvCkyQkqP9qR4qizPAot?=
 =?us-ascii?Q?mkE6uN15CW26lXGZGYO/3ZI6rD/BvIfOMDcRZvtR/AzxHHnIX1ptFCOqdqGQ?=
 =?us-ascii?Q?MgSNvxIpdqMnCxEB+is9eHaE3b/gMKb9T7UpxU8ZuiSwqwle1q4f483ZbxcN?=
 =?us-ascii?Q?FPGgwVf+iX96+wpycOCsRlwxaZh2TxnB3XDB9BCyXYu5aqbQSMQQR3pkd+T0?=
 =?us-ascii?Q?ewmjAMsAGS8xAZWy/1ubF3w5haZUaCljp1NgUqTE+ZW9fvM3XkSE2pRW3S6m?=
 =?us-ascii?Q?VksEmBfTOejidDUcQCWqCONlLJpTGvGfizCELGYL1UlLlgIn9bz8a7hTnv+G?=
 =?us-ascii?Q?EXaIA39MFMMZisfTl/gfSLsD+Qd4X9c14h4sQ1b7SYyFb//DG1XOIkV9hB+p?=
 =?us-ascii?Q?OzxxNa21vdjVKXb8kDXFGbRJiIwniYC6SGTU0mU7DIrqnEo9UNihD78gBmy8?=
 =?us-ascii?Q?k9j4t+jklvZuGlKycasJxVmPJt8P8KO3PLLQxjFmnkq4E8bxVOoI2O2RtACE?=
 =?us-ascii?Q?FqQOkjvL/Ds4a2Hf7EXakqSRp4Yk+kgyUV+TVhna9SObAi5sTV92TFx/41I9?=
 =?us-ascii?Q?FCNM2ofvRlxpJMoFUYUKhbk6yi/IPPanZVQvRgzzjkpbE8/y+Nti6oopblNm?=
 =?us-ascii?Q?Cqeufin3NfzyM6FxLHk1lFTeg+CtxVVvdhxbnOJqH1a2kEkgXY0hmT/exeHi?=
 =?us-ascii?Q?C1E+gXHVhzmoV8=3D?=
X-Microsoft-Antispam-Message-Info: peWJOssuQu6ExR4ANI7IUgTphpyp69vAMiLKlBER1WNin9WFBQ0yaLMvXBCiJVrOP0fxgm6tNIQHebZ3pwxEbZW0mKdcpPnrIgrhlWgVQ2ktf8gTewbW6HowFJtN+7AfnEUWCW6zqs93skv1q43poThcXQYaM0ak0l4NkUTsGgDaiuo0KFsJzcCthERm5nE4
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;6:MOechM63uPChhJ9EIC44r8R85gTK18STnN7FUMnV36jxTp7Bzxyxb5jQmxyZbrOlBJJtLsmSwFbZsBsmuEEBqKrdAFy/wungkrRQo1RTje9STzclsMhZaYJu5KA6cjkcijjWD7KUySwYaWi5t3xV6qJFiypSt/s9Gp5JrUaZDizXbdSK6OvBgB3LX97Zm5sgzAzkPQi37jJPm2yEBH/4+WFr1vXFa1QfASn7bFY1rDwJgCT7k3FiLuGBBpbwZZr4yftFVBm+/47SLiIuLRks7k87YLqp8fw6nKiH+Eay2OQry84uvuhDTHVFfQanwaS48x6SLtMcNjfesl1q7Voxgu+Nt5OSq6AFSj8WxVq5IU1D/6xf8fwDcGBS8Y3ywRa8n8OmjijIXtdqV5CdQzUJcq1GKi0psGb74o1d9J1kzSZQK1rK+oyp2YghYw1Uh3I2GUFjqQM2589515hu1VWrzA==;5:pEqVUuAcdduPGNSt/uedPkkZTkPQR9PBx311uITxbTrvc2tEj+r80duwiZ+8pHO423YHy7IV/R/GLjq/LJh68GofpZKMKcNtrdW+ecj1UBX83QUN8yijhz3c0l0kt1lnLQwlj04q+lCnk5devmdSjFActqgvxjgIWcvcgw5Vuz0=;24:PRyBEDA4neGl9jR5BBy6yW/k5i32yEcurboRIpxvq0vVFag7NLxSSljaKNmWLUCFDZ8Jt5MLjUEjTYIM7uiIEkygtrbp52N31HSZmD0wmww=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;7:gS243xfYLBrkUCgUl8r45/kq5HGiwaaXf2YGF7aOlC3MHa437+pJDto/wV+i7CEvSCIRWDi6GT6hStoIbLh+X70JNQerTK5hMK2C+J7vVxAAsOfqghQUcl9Nge+IrgsESXA9qVBuguQjXATU/toebwqfIQ03hHjYZxDS1AUClqxwjvGSOBQW3ESk415x3bgSCtXnkU94iH8ff8ONkGpeoAj72yQZYGXopz5vgs9R1TZkGpMqa0JY1TUvhybCjx6u
X-MS-Office365-Filtering-Correlation-Id: 4d9ede44-2725-49c9-8a90-08d5cd0314c5
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 05:45:43.6129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9ede44-2725-49c9-8a90-08d5cd0314c5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy sdma driver has below limitations or drawbacks:
  1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
     one page size for one channel regardless of only few BDs needed
     most time. But in few cases, the max PAGE_SIZE maybe not enough.
  2. One SDMA channel can't stop immediatley once channel disabled which
     means SDMA interrupt may come in after this channel terminated.There
     are some patches for this corner case such as commit "2746e2c389f9",
     but not cover non-cyclic.

The common virt-dma overcomes the above limitations. It can alloc bd
dynamically and free bd once this tx transfer done. No memory wasted or
maximum limititation here, only depends on how many memory can be requested
from kernel. For No.2, such issue can be workaround by checking if there
is available descript("sdmac->desc") now once the unwanted interrupt
coming. At last the common virt-dma is easier for sdma driver maintain.

The main changes as below:
  --new "sdma_desc" structure containing virt_dma_desc and some members
    which moved from "sdma_channel" such as "num_bd","bd_phys","bd",etc,
    since multi descriptors may exist on virtual dma framework
    rather than only one as before.
  --remove some members of "sdma_channel" structure since it's handled
    by virtual dma common framework, such as "tasklet", "dma_chan",etc.
  --add specific BD0 for channel0 since such bd descriptor is must and
    basic for other dma channel, no need alloc/free as other channel,so
    request it during probe.
  --remove sdma_request_channel(),sdma_tx_submit(),etc.
  --alloc/free bd descriptor added and code changes for virtual dma.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/Kconfig    |   1 +
 drivers/dma/imx-sdma.c | 332 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 220 insertions(+), 113 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ca1680a..d4a4230 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -250,6 +250,7 @@ config IMX_SDMA
 	tristate "i.MX SDMA support"
 	depends on ARCH_MXC
 	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Support the i.MX SDMA engine. This engine is integrated into
 	  Freescale i.MX25/31/35/51/53/6 chips.
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ccd03c3..8d0c1fd 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -48,6 +48,7 @@
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 
 #include "dmaengine.h"
+#include "virt-dma.h"
 
 /* SDMA registers */
 #define SDMA_H_C0PTR		0x000
@@ -296,6 +297,31 @@ struct sdma_context_data {
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
+	struct virt_dma_desc	vd;
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
@@ -305,11 +331,10 @@ struct sdma_engine;
  * @event_id0		aka dma request line
  * @event_id1		for channels that use 2 events
  * @word_size		peripheral access size
- * @buf_tail		ID of the buffer that was processed
- * @buf_ptail		ID of the previous buffer that was processed
- * @num_bd		max NUM_BD. number of descriptors currently handling
  */
 struct sdma_channel {
+	struct virt_dma_chan		vc;
+	struct sdma_desc		*desc;
 	struct sdma_engine		*sdma;
 	unsigned int			channel;
 	enum dma_transfer_direction		direction;
@@ -317,12 +342,6 @@ struct sdma_channel {
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
@@ -330,13 +349,10 @@ struct sdma_channel {
 	unsigned long			event_mask[2];
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
-	struct dma_chan			chan;
 	spinlock_t			lock;
-	struct dma_async_tx_descriptor	desc;
 	enum dma_status			status;
 	unsigned int			chn_count;
 	unsigned int			chn_real_count;
-	struct tasklet_struct		tasklet;
 	struct imx_dma_data		data;
 	bool				enabled;
 };
@@ -398,6 +414,8 @@ struct sdma_engine {
 	u32				spba_start_addr;
 	u32				spba_end_addr;
 	unsigned int			irq;
+	dma_addr_t			bd0_phys;
+	struct sdma_buffer_descriptor	*bd0;
 };
 
 static struct sdma_driver_data sdma_imx31 = {
@@ -632,7 +650,7 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
 static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 		u32 address)
 {
-	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
+	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
 	void *buf_virt;
 	dma_addr_t buf_phys;
 	int ret;
@@ -688,6 +706,35 @@ static void sdma_event_disable(struct sdma_channel *sdmac, unsigned int event)
 	writel_relaxed(val, sdma->regs + chnenbl);
 }
 
+static struct sdma_desc *to_sdma_desc(struct dma_async_tx_descriptor *t)
+{
+	return container_of(t, struct sdma_desc, vd.tx);
+}
+
+static void sdma_start_desc(struct sdma_channel *sdmac)
+{
+	struct virt_dma_desc *vd = vchan_next_desc(&sdmac->vc);
+	struct sdma_desc *desc;
+	struct sdma_engine *sdma = sdmac->sdma;
+	int channel = sdmac->channel;
+
+	if (!vd) {
+		sdmac->desc = NULL;
+		return;
+	}
+	sdmac->desc = desc = to_sdma_desc(&vd->tx);
+	/*
+	 * Do not delete the node in desc_issued list in cyclic mode, otherwise
+	 * the desc alloced will never be freed in vchan_dma_desc_free_list
+	 */
+	if (!(sdmac->flags & IMX_DMA_SG_LOOP))
+		list_del(&vd->node);
+
+	sdma->channel_control[channel].base_bd_ptr = desc->bd_phys;
+	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
+	sdma_enable_channel(sdma, sdmac->channel);
+}
+
 static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 {
 	struct sdma_buffer_descriptor *bd;
@@ -706,8 +753,10 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 	 * loop mode. Iterate over descriptors, re-setup them and
 	 * call callback function.
 	 */
-	while (1) {
-		bd = &sdmac->bd[sdmac->buf_tail];
+	while (sdmac->desc) {
+		struct sdma_desc *desc = sdmac->desc;
+
+		bd = &desc->bd[desc->buf_tail];
 
 		if (bd->mode.status & BD_DONE)
 			break;
@@ -723,11 +772,11 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
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
@@ -736,40 +785,36 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		 * executed.
 		 */
 
-		dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
+		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
 
 		if (error)
 			sdmac->status = old_status;
 	}
 }
 
-static void mxc_sdma_handle_channel_normal(unsigned long data)
+static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
 {
 	struct sdma_channel *sdmac = (struct sdma_channel *) data;
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
 		sdmac->status = DMA_ERROR;
 	else
 		sdmac->status = DMA_COMPLETE;
-
-	dma_cookie_complete(&sdmac->desc);
-
-	dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
 }
 
 static irqreturn_t sdma_int_handler(int irq, void *dev_id)
@@ -785,13 +830,22 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
 	while (stat) {
 		int channel = fls(stat) - 1;
 		struct sdma_channel *sdmac = &sdma->channel[channel];
-
-		if (sdmac->flags & IMX_DMA_SG_LOOP)
-			sdma_update_channel_loop(sdmac);
-		else
-			tasklet_schedule(&sdmac->tasklet);
+		struct sdma_desc *desc;
+
+		spin_lock(&sdmac->vc.lock);
+		desc = sdmac->desc;
+		if (desc) {
+			if (sdmac->flags & IMX_DMA_SG_LOOP) {
+				sdma_update_channel_loop(sdmac);
+			} else {
+				mxc_sdma_handle_channel_normal(sdmac);
+				vchan_cookie_complete(&desc->vd);
+				sdma_start_desc(sdmac);
+			}
+		}
 
 		__clear_bit(channel, &stat);
+		spin_unlock(&sdmac->vc.lock);
 	}
 
 	return IRQ_HANDLED;
@@ -897,7 +951,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int channel = sdmac->channel;
 	int load_address;
 	struct sdma_context_data *context = sdma->context;
-	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
+	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
 	int ret;
 	unsigned long flags;
 
@@ -946,7 +1000,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 static struct sdma_channel *to_sdma_chan(struct dma_chan *chan)
 {
-	return container_of(chan, struct sdma_channel, chan);
+	return container_of(chan, struct sdma_channel, vc.chan);
 }
 
 static int sdma_disable_channel(struct dma_chan *chan)
@@ -968,7 +1022,16 @@ static int sdma_disable_channel(struct dma_chan *chan)
 
 static int sdma_disable_channel_with_delay(struct dma_chan *chan)
 {
+	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
 	sdma_disable_channel(chan);
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	vchan_get_all_descriptors(&sdmac->vc, &head);
+	sdmac->desc = NULL;
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
+	vchan_dma_desc_free_list(&sdmac->vc, &head);
 
 	/*
 	 * According to NXP R&D team a delay of one BD SDMA cost time
@@ -1097,42 +1160,55 @@ static int sdma_set_channel_priority(struct sdma_channel *sdmac,
 	return 0;
 }
 
-static int sdma_request_channel(struct sdma_channel *sdmac)
+static int sdma_request_channel0(struct sdma_engine *sdma)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
-	int channel = sdmac->channel;
-	int ret = -EBUSY;
+	int ret = 0;
 
-	sdmac->bd = dma_zalloc_coherent(NULL, PAGE_SIZE, &sdmac->bd_phys,
+	sdma->bd0 = dma_zalloc_coherent(NULL, PAGE_SIZE, &sdma->bd0_phys,
 					GFP_KERNEL);
-	if (!sdmac->bd) {
+	if (!sdma->bd0) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	sdma->channel_control[channel].base_bd_ptr = sdmac->bd_phys;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
+	sdma->channel_control[0].base_bd_ptr = sdma->bd0_phys;
+	sdma->channel_control[0].current_bd_ptr = sdma->bd0_phys;
 
-	sdma_set_channel_priority(sdmac, MXC_SDMA_DEFAULT_PRIORITY);
+	sdma_set_channel_priority(&sdma->channel[0], MXC_SDMA_DEFAULT_PRIORITY);
 	return 0;
 out:
-
 	return ret;
 }
 
-static dma_cookie_t sdma_tx_submit(struct dma_async_tx_descriptor *tx)
+static int sdma_alloc_bd(struct sdma_desc *desc)
 {
-	unsigned long flags;
-	struct sdma_channel *sdmac = to_sdma_chan(tx->chan);
-	dma_cookie_t cookie;
+	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
+	int ret = 0;
 
-	spin_lock_irqsave(&sdmac->lock, flags);
+	desc->bd = dma_zalloc_coherent(NULL, bd_size, &desc->bd_phys,
+					GFP_KERNEL);
+	if (!desc->bd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+out:
+
+	return ret;
+}
 
-	cookie = dma_cookie_assign(tx);
+static void sdma_free_bd(struct sdma_desc *desc)
+{
+	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
 
-	spin_unlock_irqrestore(&sdmac->lock, flags);
+	dma_free_coherent(NULL, bd_size, desc->bd, desc->bd_phys);
+}
+
+static void sdma_desc_free(struct virt_dma_desc *vd)
+{
+	struct sdma_desc *desc = container_of(vd, struct sdma_desc, vd);
 
-	return cookie;
+	sdma_free_bd(desc);
+	kfree(desc);
 }
 
 static int sdma_alloc_chan_resources(struct dma_chan *chan)
@@ -1168,19 +1244,10 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret)
 		goto disable_clk_ipg;
 
-	ret = sdma_request_channel(sdmac);
-	if (ret)
-		goto disable_clk_ahb;
-
 	ret = sdma_set_channel_priority(sdmac, prio);
 	if (ret)
 		goto disable_clk_ahb;
 
-	dma_async_tx_descriptor_init(&sdmac->desc, chan);
-	sdmac->desc.tx_submit = sdma_tx_submit;
-	/* txd.flags will be overwritten in prep funcs */
-	sdmac->desc.flags = DMA_CTRL_ACK;
-
 	return 0;
 
 disable_clk_ahb:
@@ -1195,7 +1262,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
 
-	sdma_disable_channel(chan);
+	sdma_disable_channel_with_delay(chan);
 
 	if (sdmac->event_id0)
 		sdma_event_disable(sdmac, sdmac->event_id0);
@@ -1207,8 +1274,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_set_channel_priority(sdmac, 0);
 
-	dma_free_coherent(NULL, PAGE_SIZE, sdmac->bd, sdmac->bd_phys);
-
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
 }
@@ -1223,6 +1288,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	int ret, i, count;
 	int channel = sdmac->channel;
 	struct scatterlist *sg;
+	struct sdma_desc *desc;
 
 	if (sdmac->status == DMA_IN_PROGRESS)
 		return NULL;
@@ -1230,9 +1296,20 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 	sdmac->flags = 0;
 
-	sdmac->buf_tail = 0;
-	sdmac->buf_ptail = 0;
-	sdmac->chn_real_count = 0;
+	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
+	if (!desc)
+		goto err_out;
+
+	desc->buf_tail = 0;
+	desc->buf_ptail = 0;
+	desc->sdmac = sdmac;
+	desc->num_bd = sg_len;
+	desc->chn_real_count = 0;
+
+	if (sdma_alloc_bd(desc)) {
+		kfree(desc);
+		goto err_out;
+	}
 
 	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
 			sg_len, channel);
@@ -1240,18 +1317,18 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	sdmac->direction = direction;
 	ret = sdma_load_context(sdmac);
 	if (ret)
-		goto err_out;
+		goto err_bd_out;
 
 	if (sg_len > NUM_BD) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
 				channel, sg_len, NUM_BD);
 		ret = -EINVAL;
-		goto err_out;
+		goto err_bd_out;
 	}
 
-	sdmac->chn_count = 0;
+	desc->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
+		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
 		bd->buffer_addr = sg->dma_address;
@@ -1262,33 +1339,33 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
 					channel, count, 0xffff);
 			ret = -EINVAL;
-			goto err_out;
+			goto err_bd_out;
 		}
 
 		bd->mode.count = count;
-		sdmac->chn_count += count;
+		desc->chn_count += count;
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES) {
 			ret =  -EINVAL;
-			goto err_out;
+			goto err_bd_out;
 		}
 
 		switch (sdmac->word_size) {
 		case DMA_SLAVE_BUSWIDTH_4_BYTES:
 			bd->mode.command = 0;
 			if (count & 3 || sg->dma_address & 3)
-				return NULL;
+				goto err_bd_out;
 			break;
 		case DMA_SLAVE_BUSWIDTH_2_BYTES:
 			bd->mode.command = 2;
 			if (count & 1 || sg->dma_address & 1)
-				return NULL;
+				goto err_bd_out;
 			break;
 		case DMA_SLAVE_BUSWIDTH_1_BYTE:
 			bd->mode.command = 1;
 			break;
 		default:
-			return NULL;
+			goto err_bd_out;
 		}
 
 		param = BD_DONE | BD_EXTD | BD_CONT;
@@ -1307,10 +1384,10 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		bd->mode.status = param;
 	}
 
-	sdmac->num_bd = sg_len;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
-
-	return &sdmac->desc;
+	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+err_bd_out:
+	sdma_free_bd(desc);
+	kfree(desc);
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1326,6 +1403,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
 	int ret, i = 0, buf = 0;
+	struct sdma_desc *desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
@@ -1334,31 +1412,43 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->status = DMA_IN_PROGRESS;
 
-	sdmac->buf_tail = 0;
-	sdmac->buf_ptail = 0;
-	sdmac->chn_real_count = 0;
-	sdmac->period_len = period_len;
+	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
+	if (!desc)
+		goto err_out;
+
+	desc->buf_tail = 0;
+	desc->buf_ptail = 0;
+	desc->sdmac = sdmac;
+	desc->num_bd = num_periods;
+	desc->chn_real_count = 0;
+	desc->period_len = period_len;
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 	sdmac->direction = direction;
+
+	if (sdma_alloc_bd(desc)) {
+		kfree(desc);
+		goto err_out;
+	}
+
 	ret = sdma_load_context(sdmac);
 	if (ret)
-		goto err_out;
+		goto err_bd_out;
 
 	if (num_periods > NUM_BD) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
 				channel, num_periods, NUM_BD);
-		goto err_out;
+		goto err_bd_out;
 	}
 
 	if (period_len > 0xffff) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
 				channel, period_len, 0xffff);
-		goto err_out;
+		goto err_bd_out;
 	}
 
 	while (buf < buf_len) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
+		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
 		bd->buffer_addr = dma_addr;
@@ -1366,7 +1456,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		bd->mode.count = period_len;
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES)
-			goto err_out;
+			goto err_bd_out;
 		if (sdmac->word_size == DMA_SLAVE_BUSWIDTH_4_BYTES)
 			bd->mode.command = 0;
 		else
@@ -1389,10 +1479,10 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		i++;
 	}
 
-	sdmac->num_bd = num_periods;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
-
-	return &sdmac->desc;
+	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+err_bd_out:
+	sdma_free_bd(desc);
+	kfree(desc);
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1432,12 +1522,30 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	u32 residue;
+	struct virt_dma_desc *vd;
+	struct sdma_desc *desc;
+	enum dma_status ret;
+	unsigned long flags;
 
-	if (sdmac->flags & IMX_DMA_SG_LOOP)
-		residue = (sdmac->num_bd - sdmac->buf_ptail) *
-			   sdmac->period_len - sdmac->chn_real_count;
-	else
-		residue = sdmac->chn_count - sdmac->chn_real_count;
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE || !txstate)
+		return ret;
+
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	vd = vchan_find_desc(&sdmac->vc, cookie);
+	if (vd) {
+		desc = to_sdma_desc(&vd->tx);
+		if (sdmac->flags & IMX_DMA_SG_LOOP)
+			residue = (desc->num_bd - desc->buf_ptail) *
+				desc->period_len - desc->chn_real_count;
+		else
+			residue = desc->chn_count - desc->chn_real_count;
+	} else if (sdmac->desc && sdmac->desc->vd.tx.cookie == cookie) {
+		residue = sdmac->desc->chn_count - sdmac->desc->chn_real_count;
+	} else {
+		residue = 0;
+	}
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 
 	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
 			 residue);
@@ -1448,10 +1556,12 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 static void sdma_issue_pending(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_engine *sdma = sdmac->sdma;
+	unsigned long flags;
 
-	if (sdmac->status == DMA_IN_PROGRESS)
-		sdma_enable_channel(sdma, sdmac->channel);
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	if (vchan_issue_pending(&sdmac->vc) && !sdmac->desc)
+		sdma_start_desc(sdmac);
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 }
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
@@ -1657,7 +1767,7 @@ static int sdma_init(struct sdma_engine *sdma)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++)
 		writel_relaxed(0, sdma->regs + SDMA_CHNPRI_0 + i * 4);
 
-	ret = sdma_request_channel(&sdma->channel[0]);
+	ret = sdma_request_channel0(sdma);
 	if (ret)
 		goto err_dma_alloc;
 
@@ -1821,20 +1931,15 @@ static int sdma_probe(struct platform_device *pdev)
 		sdmac->sdma = sdma;
 		spin_lock_init(&sdmac->lock);
 
-		sdmac->chan.device = &sdma->dma_device;
-		dma_cookie_init(&sdmac->chan);
 		sdmac->channel = i;
-
-		tasklet_init(&sdmac->tasklet, mxc_sdma_handle_channel_normal,
-			     (unsigned long) sdmac);
+		sdmac->vc.desc_free = sdma_desc_free;
 		/*
 		 * Add the channel to the DMAC list. Do not add channel 0 though
 		 * because we need it internally in the SDMA driver. This also means
 		 * that channel 0 in dmaengine counting matches sdma channel 1.
 		 */
 		if (i)
-			list_add_tail(&sdmac->chan.device_node,
-					&sdma->dma_device.channels);
+			vchan_init(&sdmac->vc, &sdma->dma_device);
 	}
 
 	ret = sdma_init(sdma);
@@ -1939,7 +2044,8 @@ static int sdma_remove(struct platform_device *pdev)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
-		tasklet_kill(&sdmac->tasklet);
+		tasklet_kill(&sdmac->vc.task);
+		sdma_free_chan_resources(&sdmac->vc.chan);
 	}
 
 	platform_set_drvdata(pdev, NULL);
-- 
2.7.4
