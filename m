Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE68BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFF820989
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="CMMnbPUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFF820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390025AbeIURn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:43:56 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:20694 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389879AbeIURnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:43:55 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 21 Sep 2018 20:55:21 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id C25137318C;
        Fri, 21 Sep 2018 20:55:21 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,284,1534777200"; 
   d="scan'208";a="291574204"
Received: from mail-ty1jpn01lp0177.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.177])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2018 20:55:21 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtpVBrfDAxJ902LH1KDk8fPYNWagCzpqZnK/iNK9au8=;
 b=CMMnbPUJKgMGCVUHb1Vq+hJkT2WJnx/GKbOv9JAWef3I7RHNWILSPW9jnxJxAjvEQHviSe6WR3AARDaWJpqt4Ez93V7s7mmHoWNsTwP/eb/4IwfbNlryr9VDmi3gNyG4W1nQflEecI9kfJeVF7AsBZndEPmabWmDVbUV0tQ3b3Q=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
Received: from localhost.localdomain (211.11.155.144) by
 OSBPR01MB2296.jpnprd01.prod.outlook.com (2603:1096:603:26::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 11:55:20 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/8] phy: renesas: rcar-gen3-usb2: fix vbus_ctrl for role sysfs
Date:   Fri, 21 Sep 2018 20:53:18 +0900
Message-Id: <1537530804-19399-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.144]
X-ClientProxiedBy: TYXPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:403:a::35) To OSBPR01MB2296.jpnprd01.prod.outlook.com
 (2603:1096:603:26::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f286972a-c9a1-4977-027e-08d61fb91b1e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(8559020)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2296;
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;3:k7MfNr467H2hRx5EaL4Odpb6VNEELX9dOqdwEkvBCrPh7od6dqPA7JqW10MnmBDZ2ZiUCfF5HG3ydDyfKdQgxnaSMMn9uVID+k99WEQQiLIOAfo3KhuD9sH+VnwWrAMG0SVpb2s2aRjSAtzPshddgBZanKZWLODc8AxE0R48vsjW+7OiA2cEv+Hi75UMZmBYToFg08TV189f3+Crf8OHPO57tZqfxXAX+iT3ePew+RFSlu20+jeBPyLZkQ9IugiX;25:ePguMW65AUYBZggao/ONkw9+PXEUcZM4ai3jIOEXC5EMqwMngrXzbITmE/d6oxnAaf2lWzVC4ATzLNWdfLdwx4tZks07e5iyy1GT324rUS03PuM6H1LH7BEyzx3j+0PdbMZ+6egfilqu8GWOTCvXtIu/7Iz55KCxqMKA4pnjexEjA/q6tIh6NrnolIHtsLCYOouk+CNbgBenjC1VLiF/+C3iFQ9F7UcXyXuZEgHBl07e9ZwBxlUVUO0qTmHQN0clDY+Ib7L1WGHA6qufsiTP2/5o58sOqIgJ7K5+oM04ZIMME6NpVyLpzlz0glinKPmbgU5YL7v/m/hNUA5xGE443g==;31:1xzMNAqYFHia4kg9sjoaKN2YqFYX7LiKWhfTANvDoRPyjMB701olMTaSiSqVgmeGY+XUYLOlm6ZATGIp6tEwpYbC8CQgveepQ/4M1hc8Chyap+Sm61kMw4vGigVQ0KljU6E4V3EhM9LqbgrIFha0tfCub7SVMWREgxmXUynOOkT7NG36SfwgjviHpjmTOCcNIf4IGEYewHC5SuLo5Vp6ajPDn3krVuNiXGbbU5Ff0ZU=
X-MS-TrafficTypeDiagnostic: OSBPR01MB2296:
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:n1pMakV0fo7i/uklxcDW13uHF7+djroixKopGcYIx07TELo+Iv1S14IlZmZoU1dD8ef3djznXfMcb0HE1pqFFsg5DRAgbVU5IpayW7ua5ntnXzYtuJeG93DkAeWuiSouV+AUMEhpowbml7sacBuPiPB+rJt55NGHFh3GemZ6DNj0pJEhbDmZFhmpEesJmnETPwXzI6rbXnJ/QCB/s017lzq5kAkCVTdMoVvOBqswIDf+bfpsTYFErz8fm6+wy+QqJaNeboIycT/fsG3GyUu+ByHVIePmpgwwirlrEZiZvm7yLP3wrZ+0Mufi5YzgKOvIJz55fzCaeFCkyIkd+8UN4c3S1mRU5NdS6rqR9zP4ZSblBYrr1P1VCExABDHnftEEN40K1t6aedXHgOThAq0QKsOgTeaMePQ02WxnYQ5uMLapt0c4q5K3Nowqm2UBbg/R7UVPIOUBTmxDPrmRVojUZfMpIRx3PLoFODDrH1lBswwsby4FXkJeBXoyay12h+Ky;4:joohRSouD/r5++/IQoMStbWlUyiSNl08iWsjR46x+Bxtvt3AuSQFwJwvdP/+GA6zqZ3XxI3OWjKJBr9LrMPyEBt5yXdDOCkw2IN529cfdK0AGFTjDL1KYZe6h3BXAqpe81BWJP0vrQ/N7ZgxS+HDJ7N58wHP1mH/22Nq15PtmmCuVkj3K+Mkj47DWQQs9n8Q2qPSHyMZOlCYseSgcmHeD+8mgYi8Ak6ZIH1cx1iSUBGspj6tAJSbxNU2oL3zbJRYU0MILL49S0CkOfW3FkT0bQ==
X-Microsoft-Antispam-PRVS: <OSBPR01MB22965AFACD1A5F2667C74ECEB8120@OSBPR01MB2296.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:OSBPR01MB2296;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2296;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(66066001)(4326008)(52116002)(107886003)(6512007)(486006)(6506007)(42882007)(51416003)(386003)(47776003)(78352004)(476003)(26005)(6486002)(105586002)(11346002)(956004)(2616005)(53936002)(446003)(36756003)(76176011)(69590400006)(16526019)(25786009)(97736004)(50466002)(81166006)(5660300001)(50226002)(16586007)(8676002)(6116002)(3846002)(81156014)(68736007)(316002)(48376002)(14444005)(106356001)(498600001)(8936002)(305945005)(2906002)(7736002)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2296;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:0;
Received-SPF: None (protection.outlook.com: localhost.localdomain does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;OSBPR01MB2296;23:37vZRJXc/H/ZSSmfNxtrv0dSAiiAKaBmW9dpdaPAK?=
 =?us-ascii?Q?4G5DwGorng2jrHOZ7CRWbIbI/udwn05/uobXu+6tRT2kHKaPeAFAAQde35wA?=
 =?us-ascii?Q?YGHOs5/1OAWZjLa7ETPU/HTd2HNQHXfYchQJKURl2EtXo28KzU9XYbUmxLcj?=
 =?us-ascii?Q?ZnGfDlu1y/bFHiGtzbRy0C+NKk4apgz/gaLm0tQm7wR9xAjyHb3wt90XQNN5?=
 =?us-ascii?Q?IGBqoxrVlvObXm+3dFGr21SuYhqObLFCbac8ApMwp0vEanJ8GAfTDBoSxdXJ?=
 =?us-ascii?Q?qrjMFOQWm/01/jihkcHdqFdejuq3jKmlf9xHNOZdPEEP/IyoSomoF4pofUSJ?=
 =?us-ascii?Q?SPqcLVZRiMCZu8z0/3Otg8nNuWJ7Gy2DaEJYT4271whA+tfgtBHwUJGX4W54?=
 =?us-ascii?Q?p/eAXCDcMwbbNw3Vk7Nic1rbXpzUaw+NGJqUSlSItRFGt0K1c4ddkDpQ5xOF?=
 =?us-ascii?Q?ufJVpz/Z1SZjVsXGHuPOGSWhV4UBJ3IJKboxvb4b21AYnkzOV/GZKH94ZbmH?=
 =?us-ascii?Q?CE4Tc53pOITm04dza8PU3pwintkWBMKAq4BbauQd47tU8EctLcVYcsjHF03k?=
 =?us-ascii?Q?XplACR/MbH2kaCbySYqmGpbgKagLbxBSqzlyhKoWg6vFmkQaiYND9lfR5NeQ?=
 =?us-ascii?Q?9InCYC/kqBpQ/4vuyuI2MdChbr7t1sICMp04NtjMfW2PzMe1DfVJNQ+XyWbd?=
 =?us-ascii?Q?TiI4P+EDPpR17oLxRz2uT2ux4t+Io2AfMniFXioMVlhAKxi87aTl34Muv6sF?=
 =?us-ascii?Q?rmHPQuikNZ+RS09EVHhacAPnP9AYQV5QF8VUdkhbUXvtdvM+QH4dX1d9dYMZ?=
 =?us-ascii?Q?9tsBwSDyBzNkfQBLvC0w6dxm1jSr3k/H0inubPST2UfJuMIzNMAPBhACQgas?=
 =?us-ascii?Q?gOFT+rumDg7cnp+OryvI11i3P8h94FnlKC38esc8jZ7cQVNHbDBRO20r4aS3?=
 =?us-ascii?Q?rNcHZgPDMGHwlfmAam2x+P8S1ZToBlS36hRIakQROLZ6Dd/COFyL/8VeKxwF?=
 =?us-ascii?Q?TGejQcTfK6AkVAT+atR3eg6Qo2Oi/deghNAb8P1hRRjD3UiIni7i6WQ9dZsU?=
 =?us-ascii?Q?VXDvhzk5IZwokWyLfAFy/9kvcFubvho6LzG1wYnov07IfazX1uokKIUp57fT?=
 =?us-ascii?Q?NYaaPYaZzOVeGSynt1zHKBUVs4FPzwmvWBS48S4i7l0XRTQn3ZaO23QC4fAR?=
 =?us-ascii?Q?MkPz4A+aclfCiQjzoFRM8ghvQ9mAkPUAv6aIG/aWQ9fgQ459UQJjuDN8kNr/?=
 =?us-ascii?Q?V1eyi6+GE1YXaobaYo=3D?=
X-Microsoft-Antispam-Message-Info: quxTL/hJYfO30JESTAR5a+5i84xskc5UPU1m2BR717sUDXkB6Gqi0RaqGBmZmSXQR9mk1vLw79ennKwWg+Fl920M+k/IqEUVTR/irTXLAUbQ05c8WFLkf6InloniBLunPeQo+qZr/v8QGGNIoAJKYlRWGsQNwK0FM3ooys0sFcV/29hfqaZ/mEQYFsalQNquFyVdR1fVXRGAbeAwwRParOn3J8ygXlXlX9CLhHmrQn1dmRD/cGA+6ETsdSYtWA1cz4LtKMVfPvHdR3IRpDtgvmqHf0kGGMbmneymIPrLdhj2MpJ62p4xQh4Luag+7yJmUnk0uxMrNFrURfBsDlnYTCEo4DwB+W19D+U/8uZqUec=
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;6:fU2A1j/l5cfPHSPrrAoS6c6PaVtj7uU7fY1p2/robdiis1cRu95vtMcRXjWM37ZpdU2HBfSKk/aW+G++98rdSpCjQogs8AtXqK5cmibYgW1jYPJv6WpYDSJ2Kd0TvjRXkKxI8dYwjPU7p8/HhQyB/vHUZk4GpWTictVcJb1I8mMCUdCnJtU08oJvuyGsw4PoJvO5wIzGMFZzl/EwvzI3MfzfFRaLLWrMKKu8wKhk7CZBp7njHRQFM2pWnIZwQw6xNKT2hHAlWWUCIou4k4ZrIfBChToX1/ZwyLmKnGWS3go0j4Gz/hAq3cc4xo/D1adf2BZGGO5XAxvLtVygnRkD02F+DJ12TuMEv5rMUvVnu2PxSAmF/xIdF2ysZAVIppbOY36LhEpVc8vHYnTWQ8ySR2++ow6MvtXBcI1bJaVFD+emoRNB/qSPVwgLFojE0UVBhJx9zd5w+EwwH7RjwNjUNQ==;5:DCLYW7nwbIMnQsrGyyWrv9R5/p0wVp/4OOoVjrFIF/GdSwkw4RNZfByQ9QHoOH4ZIkkFxtl+cbjL63juPMQ1QBkS/wA7z65S+GOmVbZwOL2LJMRET9X1RQRvr8EHEDhaCGjNZTY3P0xIT++bs7re8Oe912P3CBcOK6NkC2NDz0Q=;7:BdFHJQ8BNbPvccK9WHfxrTOLgItBPid9IR6ib6sCuZbgj+cBsyo/TcJ06+vAF28wzeW/wemLQuz8nHcVpXOnIKesKE3s8oZE1VcR6+ot2aWjwebX+VnpjjX9HdMg5Tlq+5ayIP8+MDxRU2aJaLwqryYWa9LWG4hQgZE27QKN3tPLV1+J8G+rrCP+cA/Cznd0sjmR7NSUnteH42pTsaroWH7zpZcO1KSgm2k82IeVkFVKKXOId6VvrtiBC1UI15FN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:zalyU4ku+UyuRdtsoE3QWH2IoWXQk26veypMNu5Aqvp/SqltaFby6MinQYqmqk+17V5sQA913MS7d3iwUb5L/CLsGTMltqkwdO7ewXvdHWpRZ2r/sTG5YHEHueRKFFOj46RKGNqMKhjmHgj5ojyM4CQ6Dq2jfy+e2cp0rbxcRuc=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 11:55:20.2485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f286972a-c9a1-4977-027e-08d61fb91b1e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes and issue that the vbus_ctrl is disabled by
rcar_gen3_init_from_a_peri_to_a_host(), so a usb host cannot
supply the vbus.

Note that this condition will exit when the otg irq happens
even if we don't apply this patch.

Fixes: 9bb86777fb71 ("phy: rcar-gen3-usb2: add sysfs for usb role swap")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 3d57ea1..a6db25c 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -195,7 +195,7 @@ static void rcar_gen3_init_from_a_peri_to_a_host(struct rcar_gen3_chan *ch)
 	val = readl(usb2_base + USB2_OBINTEN);
 	writel(val & ~USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
 
-	rcar_gen3_enable_vbus_ctrl(ch, 0);
+	rcar_gen3_enable_vbus_ctrl(ch, 1);
 	rcar_gen3_init_for_host(ch);
 
 	writel(val | USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
-- 
1.9.1

