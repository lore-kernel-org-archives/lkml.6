Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25270C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B768B20847
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Gfe3AkmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B768B20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbeGDJrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:47:21 -0400
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:7168
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753158AbeGDJrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/HmdVYrlBEkm82yTzHsRry1PgB9cw1gICpuQS7YrAI=;
 b=Gfe3AkmXm+0dT1VPMUmUXPeOuOr0/C4VDnebtqbdEtGSrLb7AXi8w6GUreZwCoJb1uDssboPq8dXkzCjQhVWw5KTfYzVhOOaEqcYAKCfhD8hYPckLLvwNjTvgnwPgFZUkLp1Vse8H81eWjWyb2C3UBpsgPu6snlsmbehrGPIrmQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2632.namprd03.prod.outlook.com (2603:10b6:903:75::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Wed, 4 Jul 2018 09:47:12 +0000
Date:   Wed, 4 Jul 2018 17:45:24 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Manjunath M B <Manjunath.MB@synopsys.com>
Subject: [PATCH] mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC
 dirver
Message-ID: <20180704174524.5f6d50fb@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0205.jpnprd01.prod.outlook.com (2603:1096:403::35)
 To CY4PR03MB2632.namprd03.prod.outlook.com (2603:10b6:903:75::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28389591-22cb-464b-4b13-08d5e1931f90
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2632;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;3:TarcWUIM7TCBoNfBLVhMbCw7y6nOsh8tmC9/4mnWixEDK2l+bEM/ALCUJygeH5/PzzDdtEmRl6xcLnHSL70XWzNnb8I45lpv6fL+xSobkKOZ8+fA9Ui6wr+iwN/Fog4+ViZFvtixZc6MOZu+cMzXShTqgMQ89e6aiQnnp44C4+8TrjLfxkk+6N2eam5BggR9AlYXXQp0iaeKTfqFZ81KpXdlwhSUbDlthxyx8CyHthtjGELKC7CldkJZ3TlD8Y6F;25:U2dt3ck269hKZMu6PoXr7Q4nFfU4MOnDc3TcsgM0cpIvPUTbSaoMCAtU/9lbuX1kQ7w8GkHHilB23PD16kZPS0vvFWqG1w1hUfzpsZEDyhaeHawFhcaIr2ymUeSXi2G2qJt8/u+RL3kXuy0uAy/89b0nuPlAqsAWzGENVZ1VcOJLOQFETeqSGhfOzo0zpJUCQlt7ymiWbxzJvJsIO4cpZfp4TGH1PwcqrsHlfmVJ4pFlSAaIoSJw+33MJgqWe9MA0AtVm2e6SwLRHY0adqBjLsfeY+RN5Ps0Xp+p8h3JFB5BC6/fv2qdwkYen8sLWDjhuzWGYDhYVhowAenHXZAjQw==;31:PS2/lSOh+OOWnZ8i1Etq2qx193CMJhykoSsJsr9CiQDIKSPGr+S1To7TI2HwtPTv8ITVfGe4wAWgFxnWcHCswy9t9BL8L6e+/km+2noiH/L3flJJ2GCyqrcROVA+0mgVx1lIkc2/FFm/lUUyYZzU47unvTuJC5Z2U6tixMLSwyqsUVfgNSde4AbSy3ijJ+AO5r1qNGYsnBdDCkCydzfwoqJ9esHzXyE5vrhW0cTzxUk=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2632:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;20:m3pZAmjoUl7VrTUSuDT1I57idB4dXm1bKPKyAqLrj+uGlHeZ1tlmzjAymO7x/nf7njPI6r/UT/NwG5906uKGpX05QB7ny4Sv5++/4k1RnburdVIIOOg4JSLkmxy4KWEtwFLXTaGEu7yzKY/witsCTZR2OXz09ULTIKovJsP5RM8Jwu8sXBrCTZb5RGeRNooNLmmFjyxHc61zQNSrSG9JNUmwB4MGc/9ARd3y1k5rBxP+bMAfEit8VqyvuqTW2SqoI4Zh/rG/ps5kxOoTUcGLtiEmQ66Yhj6N2cKjhE3ERllUMTp9J8AyEQ0wEtP/tZizXFRDwNt3oZ48ibC/nopt0PHXmx8KLbNzo56TKsDtYi9wNRCZdNcuFiXLyklc74DFmi73SPFBny9T0poIxli0HR6aDQLXRCr+ztQkjlH7fvCUCvuB9opkEfTDgnwjiFMNl0JUut6PKUOugiAFf5vT8NPBxfXrdTUSNrdX6p2CcWjUucUvPDeEoYNalNv3PZae;4:hGZsE8SVcJ9+k2GkOFfp19sO73W+L78eL7z2RkHDamzaL/IKnZyY7F+k7qXBitizDLDOceif5/PJ7mzUUbcdoFqeSMbSxr/RtQUXydxzyCXq6FuTqG1vdSohaGs0OeqfJZfNCKp9xq0aqqTRj3bMcYCKDoSqDA8V1ueoKJDF8oQoCJp5/nTOGYcNJtXNlhGqcbN6FbreGkInBGPPVPIQLIpe50rqOr6u5rHYuIrrgteuo5IXQGye8pmo5mXVTdBwjVgVPQVm3prylu2HHgr6Og==
X-Microsoft-Antispam-PRVS: <CY4PR03MB26328220DE47C13F6C7ACEDFED410@CY4PR03MB2632.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2632;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2632;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(4326008)(23726003)(53936002)(316002)(1076002)(52116002)(7696005)(186003)(110136005)(54906003)(33896004)(3846002)(230700001)(6116002)(50466002)(26005)(16526019)(1857600001)(97736004)(6506007)(386003)(7416002)(7736002)(305945005)(47776003)(476003)(55016002)(956004)(486006)(66066001)(9686003)(25786009)(2906002)(105586002)(50226002)(81166006)(72206003)(8676002)(8936002)(86362001)(81156014)(5660300001)(478600001)(6666003)(14444005)(106356001)(68736007)(133343001)(217873001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2632;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2632;23:EsVTWOY0gBJ/b6pyDvkbSzyNQvxcg4EnQYFA9xsva?=
 =?us-ascii?Q?cbtMKS5CsQFDgIxoAFIw8WWZWOcvwxE+bV5bL/CzCeFd5ow4LKUTiW1ZYNbM?=
 =?us-ascii?Q?XIyzVyMiGqGTFRmKDJYq4Ez5IScyvFi9hWYKHen8hqPMSIKyUdRGSODGOXi4?=
 =?us-ascii?Q?P7dIpMdkVbhso1PgAjj+b7ckUDIIzUGeSiwWjlyY9ZMWBHgp3/5D8IuAP5vA?=
 =?us-ascii?Q?lqpXK39IyVtgcR5ilT2SwHCo9zJAi3lf64HBPBoGG83FAnU0/6tQLnTcXa4p?=
 =?us-ascii?Q?zK3tOfom0dAOXLUSgOXr7wbMYlq4cXTHMqzbhd2T3If0tcRf12OJOGQM5Xkf?=
 =?us-ascii?Q?MQyM8QHyuWfK1zIG8cldcDdN6faeCRVQHfl8Zdpamt9B0gQFmtotR1EaH9RE?=
 =?us-ascii?Q?rHwpij3xvp0cc/z83jr05wewJBcNHBRWppXXlJc3jc0nJtkRl2RzTtsAkFJQ?=
 =?us-ascii?Q?QzPHe8gkEAq1+a3VbRBMu5Fhd0ZZ6J5bhXWCMgPrsTnMCW+vA8sakVABGj+S?=
 =?us-ascii?Q?YW5iIRR5RFqeam6lrXk7lDdlIIfa27qqa11AOIXlmJMGT9yoB7YasesG+Y+v?=
 =?us-ascii?Q?wf9XH5lkYIU2GT7j10LAMyw3kb2+Lo1mYmoSNobfqm9qhhVxxzTpIAwHOyr0?=
 =?us-ascii?Q?34/lzVK4NFWyKRvW6OeM0uChnc9W7nkDDMER+ySXhSFF4syHklAX5frbIWwY?=
 =?us-ascii?Q?qSlVMPa8y7E72M0kWRfwPVEGpUX6fM+71G/6peYTrtdUBRksXj0k8+Vxne0Y?=
 =?us-ascii?Q?0DEjlXZNZZMLw5DhyMzmbU+skKh7iKVajAoftRJaWunBlLFUSUVUSD57kp0R?=
 =?us-ascii?Q?rYHzAdC89kTRa7HTtVkKKLEyjwdfPalRylQ25ddUtfR2wywW/2Tqf6FRbBiH?=
 =?us-ascii?Q?pt90aXlf8InV7tBAu/wLalPeGsltcfKQwutvu1LRYK29R2PwGZpS/c8jcVer?=
 =?us-ascii?Q?8mZ+Gl2OKB8B/H+WiB93cowwErUlcTPWHPpUXrgnYTZxoYRvdV94Gw0QnOjt?=
 =?us-ascii?Q?3fGefl+/LmgrOeBJN+hJCxTA4p6pSiJMCdHwzjfVJQ0TnprYBpdhS/Nt5OY1?=
 =?us-ascii?Q?I1N346skxcP46SlMcW7P7JJXVv6saW32aoXOjULkz1Upp8oNy+6MKPkpxag8?=
 =?us-ascii?Q?X+1Ss6v35767h+IhbCZUMz8OQhTcwRa9RCMjHDz47GFPNLZCd74MYicfOLlr?=
 =?us-ascii?Q?L+Dk0Hs8eMPAGg2KRRqiWFxEYb8RliraOYbLByEk6yCnK4Kggz8/jkPu8rwJ?=
 =?us-ascii?Q?eC3j9GiwYLEMrF+CWjtPUNMibdoDPQYPb+ety8UPnqiYu7rz3AnLr4OB60Td?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: ZrpH3f2VoQOnhkhhBvlcsF6xfpg6hInfaTRJEKV8qqhyxV/FnZKGVGKDo0DGvdGitlxLt4dmoMFWNiu2vMMIOtDbn++zOY6zzHhixgXw68IRTcM4YEHLBGSLZQxm5Q9M72dnCxfeIAlB/RA0lIj6TU9gfl9Gp6cukTlgIMfjM+Q7q5Kspw3koG5/Um9cT3ZN2mNBr7E1JG7ykOJQYECmf6J2EXTxIbDcgYjFk4XdSRxhZnWQOosACzGv4XpNMC0LsHMYUxZBq7sWqtrn2BaZuR5GUe9dOs+uypKErbOZdPPHxK2wd9PT9RLWopOfnUhLZUgB3EObMs/dti+bL0r3F4C8Cmranda65mUh1Cemmgc=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;6:PJJV+WWCgV5wSYm2tu/Rz590LRnq8TB/RZkf7F/hblIbJDngJTFlXBBaXh7qXS5F27k4rsFhDPhuMT80SxfhIWZWHGuu2+zOXxccl2anac/b7JkPc6HpkUZ7MKlfut2LiwK9shIEqF4DFXXIEIfkMUZwZ1VthkLP7SlQFgwY9fpT4TmDPlDdfZZJIa9tuH4hUb8kJu1TH62vkqxO+rbvtr+ZmxbQoBPhYcHzhEHXOluKA6Pnx/kGOd5Tsi+KkKPmisg9K/x+VuZFIban9YqMzjqMv2i81GWBaYT+DpaXDw31PRxHELIBZZF6EojvmuuGSuiXSDNIdBCoAaUjpujKQo+jzadOxfIKyhDorydoO3HNmyYtvkTvlY8EtOTeTv89jFIQj4Y3DhfdP5UrnfMLiD3SYDj7PueBYDwBoBKScdiIO2Unaxah/tV1ZF9XpHfWVD5iCz+e9E8U61x/18RAMA==;5:xil5QzrfWq0bwejOl1b0ftWYaMcyQqL2rNWF7R+ZD5zVE2JmGtLu41I6qA6bD6uxem4PhKKFYhJkhlJlpzuephL2irgWlYpbkkDk7poHCLGxxst/UJE6l9Hwd7FPYCN2uC/W210wSz91B3PazgeRyo8PGh83pc54CtEnqiuMS0g=;24:jLTlXaZ5U869TpqExqu1nWnFq75ZpBh+aiJW9e6DYUW6U4Nrzi9xqMsbenWS6C2WSNYNNiDthipFsMfX2GPdNgMiKxwE64TGX0rNrzgFhfs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;7:8NNlj/ixFke8kieTH7LeDpntEc+1ZGE4nru092/bUHHt8Fhhb6aRXsIWQELGpMuuPv3Sbc23lS/13HY25YJW9KCTZcVBJD8gmEvtk2SX/GaEnyCexUtxceXiZkOcnRx1SjCUlCqFf2mjf/akMCw7pn3v80TJlFwQeUOtxiMokFtHSpJs/0c9MFyYfimFZSLfOqtI4vLbGxFlnhPwdaZv8vcLK/IKQblrJbtk+G5K/++2F2asxlpDGBeOgX8X/+PQ
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 09:47:12.4154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28389591-22cb-464b-4b13-08d5e1931f90
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for SDHCI OF Synopsys DesignWare Cores Mobile Storage
Host Controller.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../bindings/mmc/sdhci-of-dwcmshc.txt         |  20 +++
 drivers/mmc/host/Kconfig                      |  10 ++
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 117 ++++++++++++++++++
 4 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
 create mode 100644 drivers/mmc/host/sdhci-of-dwcmshc.c

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
new file mode 100644
index 000000000000..ee4253b33be2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
@@ -0,0 +1,20 @@
+* Synopsys DesignWare Cores Mobile Storage Host Controller
+
+Required properties:
+- compatible: should be one of the following:
+    "snps,dwcmshc-sdhci"
+- reg: offset and length of the register set for the device.
+- interrupts: a single interrupt specifier.
+- clocks: Array of clocks required for SDHCI; requires at least one for
+    core clock.
+- clock-names: Array of names corresponding to clocks property; shall be
+    "core" for core clock and "bus" for optional bus clock.
+
+Example:
+	sdhci2: sdhci@aa0000 {
+		compatible = "snps,dwcmshc-sdhci";
+		reg = <0xaa0000 0x1000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&emmcclk>;
+		bus-width = <8>;
+	}
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0581c199c996..23beb9ec6dbf 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -176,6 +176,16 @@ config MMC_SDHCI_OF_HLWD
 
 	  If unsure, say N.
 
+config MMC_SDHCI_OF_DWCMSHC
+	tristate "SDHCI OF support for the Synopsys DWC MSHC"
+	depends on MMC_SDHCI_PLTFM
+	depends on OF
+	depends on COMMON_CLK
+	help
+	  This selects Synopsys DesignWare Cores Mobile Storage Controller.
+	  If you have a controller with this interface, say Y or M here.
+	  If unsure, say N.
+
 config MMC_SDHCI_CADENCE
 	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
 	depends on MMC_SDHCI_PLTFM
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 85dc1322c3de..a18fbba1b97e 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
 obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
 obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
+obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
 obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
 obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
new file mode 100644
index 000000000000..93b613cd7c33
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Synopsys DesignWare Cores Mobile Storage Host Controller
+ *
+ * Copyright (C) 2018 Synaptics Incorporated
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include "sdhci-pltfm.h"
+
+struct dwcmshc_priv {
+	/* bus clock */
+	struct clk	*bus_clk;
+};
+
+static const struct sdhci_ops sdhci_dwcmshc_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
+	.reset			= sdhci_reset,
+};
+
+static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
+	.ops = &sdhci_dwcmshc_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+};
+
+static int dwcmshc_probe(struct platform_device *pdev)
+{
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_host *host;
+	struct dwcmshc_priv *priv;
+	int err;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
+				sizeof(struct dwcmshc_priv));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
+
+	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
+	if (IS_ERR(pltfm_host->clk)) {
+		err = PTR_ERR(pltfm_host->clk);
+		dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
+		goto free_pltfm;
+	}
+	err = clk_prepare_enable(pltfm_host->clk);
+	if (err)
+		goto free_pltfm;
+
+	priv->bus_clk = devm_clk_get(&pdev->dev, "bus");
+	if (!IS_ERR(priv->bus_clk))
+		clk_prepare_enable(priv->bus_clk);
+
+	err = mmc_of_parse(host->mmc);
+	if (err)
+		goto err_clk;
+
+	sdhci_get_of_property(pdev);
+
+	err = sdhci_add_host(host);
+	if (err)
+		goto err_clk;
+
+	return 0;
+
+err_clk:
+	clk_disable_unprepare(pltfm_host->clk);
+	clk_disable_unprepare(priv->bus_clk);
+free_pltfm:
+	sdhci_pltfm_free(pdev);
+	return err;
+}
+
+static int dwcmshc_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	sdhci_remove_host(host, 0);
+
+	clk_disable_unprepare(pltfm_host->clk);
+	clk_disable_unprepare(priv->bus_clk);
+
+	sdhci_pltfm_free(pdev);
+
+	return 0;
+}
+
+static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
+	{ .compatible = "snps,dwcmshc-sdhci" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
+
+static struct platform_driver sdhci_dwcmshc_driver = {
+	.driver	= {
+		.name	= "sdhci-dwcmshc",
+		.of_match_table = sdhci_dwcmshc_dt_ids,
+	},
+	.probe	= dwcmshc_probe,
+	.remove	= dwcmshc_remove,
+};
+module_platform_driver(sdhci_dwcmshc_driver);
+
+MODULE_DESCRIPTION("SDHCI platform driver for Synopsys DWC MSHC");
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

