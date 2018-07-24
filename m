Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BAEC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C99220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tSfS6PNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C99220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbeGXTZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:25:41 -0400
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:56266
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388427AbeGXTZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYG1lxLsTYHU3rAqt3pbkR0xfE216Y33h+4p/aHyXdM=;
 b=tSfS6PNMPNrJqWY7Gpo8um9++MXu18ziSiQ3Ev85pHuWrZVnnVtYI30ZQT/TMXgyQWyH/2JKh2nVGEgH5idqZ4/CxPKFgia7hvZYWFn8ym4yIKYoEFE65xAVUPFsgJ9/JNFV+8Z5N3mHk9E/W6f56rgSg3NiN4vAQpvfZveKiUQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (2603:10a6:803:3f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.22; Tue, 24 Jul 2018 18:17:51 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de
Subject: [RFC] PCI: imx: Add multi-pd support
Date:   Tue, 24 Jul 2018 21:17:38 +0300
Message-Id: <8018069bc772376caef29e76280e4d0facffdb68.1532455922.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR0502CA0016.eurprd05.prod.outlook.com
 (2603:10a6:203:91::26) To VI1PR04MB4301.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae2c77a1-46cf-4e63-00d6-08d5f191c58e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;3:x8D1F3UuR19idhx8JGL1U8ml0KS1S2ZZ4XQmSYIamg2wsZ4GOBPD8nitbTZaylnQ1V1LsUVEWSZtDbYRB4nhG+RmbgtB7a7dgHrk1gHeAtRMHnE3RhmwSi26h2LOzLKwcTJBf0Dnzn4CFNyjrT8byxr8zBH++AS+29rCiuCjGlCFAo6Xpr6qlvL1VIQRwCBv4hf0ZHHC2nI9CJ5+/iy+RMgDeUfkSPzh9J1wrjELegsnqTvyNQyVPh8nLJ7YCDtd;25:V6mHEYemVmmMaOTR6QHzoswJQKMEDgn6JUGVzNbS9Xc4gkTzWzvLxXRvItN6+6jlyWYUEGx4ZVg/RLjOyE9+CsAKyQGXea6oIBlTFJaf8f6KALSXKmqS3I3htrrzgTQ07u0Q44jSLtT7WtHZsKevUZcpfTfEkWG54M3trMyG7iFBunRv4wr9YuD5sz7TqiZ2NGNFlkHPleL+ApdlrRJq9jUPcHR5J5bbUb27v8pij92PRGrKi+NCWin49t2GvPVvl3N7a972Jj4pEyMCwvQFiLyH6i8zVEofcupteILwjOTHl7EXRsf4QjPq5VkruTJdyQR7/UjW3NomkNbEFwPO2g==;31:g5lQGcFWarA1YnIANebykFuUwEP1etVHTyUVnjeUviGnFwJ2edXdIUAmqThaf3we4aa6u1YWhlWqtoPBZdcHAolOuDss1IfFfO8/hBbgHEqMArErMW20VB/B4Wv1IKgA3qE23E2AN1mR7AxjimEjAUNJc8OkEhtjDmko0urUvX0xqs+VeuvRyRdnJYE9poQtDyKrfpzSSYdozAQfe6kgHH/Frr00t/kbFwU75hn84G0=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4301:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;20:BJgJqfnpIkJJ6p03QOSroOofrxm6FzSy2R8w+5yVBbK0gVTKrX+MJ0Uu2X9YGgeaXo2WUfo2CzBAVdybtW+liZcRB9LC96oGRh+ZnQld/x0f/k7Qpap0bQnbTfDnaW01iVctcyobQDwq0g4RJjNEY7hhahPJO91w6Zuf73oc7VUCMbEru5AVPD7DzQ6ZtuwAv4NHoWRfA5GGzxMg0QJxUmdddF0ROVXaAr4vOgUCh9cU8+9PSWbM2l2tqSFWGEbSIRse0AiWJCQAwTEZv+sYoheAHl9GsmnKuAXagmhEKMu5Eai4UwZnhNG8gbRUbTC247if5vziQYpEMSXDLud1x62rmIIix4OXJneMJb/Lft1gIZ1KtTuCBJ6mI0esoabt4FsVGErzRdg/zx7bMCOYExGjNEwkV8NC4pqFj7BzO6dZz/7AuQ+VXno51qupAONB7ObbbUUtAPZoJTFRPIe9qkpH1PshP2CgJLdAIgXxaBzpl9ZbkT6Yk32se0loJxZ3;4:L55RhnV9uXGq9s7spsrvaY3h+yyRJdfKvpxTbl39ErV8cmJjKYNoU07fRwKkjRkOoAVezrROLtOCiLolkN/GgFevJQ52k+GIeZByB0zs0ZloGQy3d1ebuCOvO2fXOktbGzp9JQsEcdkoISd/71FOez+DLeyKslplFr35vgQ+9n52nIk6qh2IZfGT/ZW37mleCggxo7jBKXj8SgGKMytsq1k/pHVpAXqHV2PhX1/zyZOwviA3PNbQYti1kGwQ26nh8JxtLvAFO9RWgh02LpR0LJN7ftDF0wAOFZEC/MJPlo5RpGa3h23aHsCb1jnYCFR3LVdp6vEMkWtwD3BbtB58xkRzHHaji9HlYfHoJPosCEE=
X-Microsoft-Antispam-PRVS: <VI1PR04MB43010B6284624A8200586DD1EE550@VI1PR04MB4301.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4301;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4301;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39860400002)(366004)(346002)(136003)(376002)(189003)(199004)(386003)(81166006)(8676002)(25786009)(81156014)(7416002)(50466002)(48376002)(4326008)(47776003)(7736002)(5024004)(14444005)(66066001)(39060400002)(97736004)(2906002)(86362001)(118296001)(6306002)(53936002)(6486002)(50226002)(8936002)(5660300001)(966005)(51416003)(956004)(2616005)(476003)(305945005)(16586007)(54906003)(6666003)(3846002)(316002)(110136005)(6512007)(68736007)(6116002)(44832011)(105586002)(36756003)(6506007)(486006)(186003)(106356001)(26005)(52116002)(478600001)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4301;23:v8NBdtGMoIm8/jpORioCny3k6wNNIm/dQO4YUAh/O?=
 =?us-ascii?Q?vB8CXfFwXKjrNnD74zvi5WPVPSwYNtpWtMEnnLHQGKVFWiVEcKmYcjRBJUKX?=
 =?us-ascii?Q?EYqAkTILEtIqzH+MWq3WbrgO425cTv4Qf7MBdMDgz7gCJVFcVjRfGnEcolA0?=
 =?us-ascii?Q?ND4R816dEwRV/GtnBDcsktvdY3Xgm22I0zLM2FFtkYzKib0qMLgDLE0Ntuhi?=
 =?us-ascii?Q?e4HZQXPBxp6afHy2lY5hlvp9nfG/Wo4VfoQgLaZmxJ2K/voKgj4JsvSLQwgu?=
 =?us-ascii?Q?dzHq6zppzU2l3AdSXtfhvVeX/UNFCGHBJPfGzDhLolnr2TcUdRP1WH2o+EIR?=
 =?us-ascii?Q?qQ9AKRBrlgmmJt/VLZTWQ/BanY0pi15liHYt021KaWa8npIVxnxWcwg+A9og?=
 =?us-ascii?Q?OBQoTpLlngOAUil9y6vjynQoa3VZs0B2pJfIRuxDz7odb1ijEPhocW4azMQE?=
 =?us-ascii?Q?CHGjODNP1U6XEuP4wwuaFxgEy0PcFV7veosajAmNbwdXeDWVltwTwtsoggw3?=
 =?us-ascii?Q?GjroPfwRq7/DiosPQxkryorFGNX+xB/0EtPfTqcGMojG34PGuAG2SnhP8ZWD?=
 =?us-ascii?Q?JOcqBcVFZ2XMzUhGd+ZD8YXC+DFzHc5WhzUsu5oYhC8KIRUQuoJSV1IsuH0u?=
 =?us-ascii?Q?oRC0plou3bvM72RXdVenSo1IAY6Z8kSl38BL63KXv5sOpNFZFyn5jkCJm0L6?=
 =?us-ascii?Q?c/4MRzhbw8/X+TxqpvuOAC5GO9bGR6CKnapNOV9Z2zM5ElWoyu0uQgOjtZzq?=
 =?us-ascii?Q?GM5AAhMrj5+iC8mNPN2osQ6AHK67+if8vtI5Kibisb3fzPIGg80Z8x0km9uE?=
 =?us-ascii?Q?yz45QZ7fTUxygQbUH0+lUcsC+LyXfMD/OCBA74FkrLYl15Er3E8WB2UvYqj0?=
 =?us-ascii?Q?rMoo2go2XbvrKSWo70c/G0DN2+UbL42Jc7FlL2lrQ5PfGi28eBO6DW1mckBp?=
 =?us-ascii?Q?b7qic5YquohwN1BmjKEiVzwhwF678Jl9mUqB7N9wEwJHhuWdc7qysukz878/?=
 =?us-ascii?Q?Mhq1lcmSdtA+c04Wv2iOoIFwCCNVC4msIh/6HM6UXToa0z/3lZKqrXzOGEWS?=
 =?us-ascii?Q?7QrADJhAchrZKLVCFe8MAlJINVMFHRdaHyRm+Jhp6uLZZ2CKKsC8dAa/zSby?=
 =?us-ascii?Q?+3tw3APz2+H5keruoUOz0ykgmv8RUOK/A6sJSga3mWvKYQXBSt5Ro4mFIe2x?=
 =?us-ascii?Q?Mibe1TluYlbk0+lRAN3yRTLnGsedsH5eSAbjtZE9+rejGG/G280XveBzpCFT?=
 =?us-ascii?Q?hFIJLqhxcCZvuovrZOGntz3NywWITv67Rhh1OsF4toyT0UXQfh8H5DNhIdjm?=
 =?us-ascii?Q?wArYtIbtF2ADYIB3zEAgX8=3D?=
X-Microsoft-Antispam-Message-Info: O0Yq9jteMJuhIQXGQDnOjqcjPEVePlRqSYkcMp7POJcsBcdpXhQSBi3LkhdIp1UFA3Tt5ZKxNzJhLZMZH8YFtCvFzQwMVdADsayTe3imhEAh5trbIFrfF1klvpH/v24+VDaVi4BUeFoJRhaHiQdQR85w4Et3Uh+jr9EoBHm1hzbF0SFl7nmgOXx2QF3jTSPfd1JWMkC6Rzk5jEf3v5Lh3+Bb+P45DJoVjk9cQuZ5aYZJd6d9TSYMTnBFnQqi1fL8EB3MRNfxKALbqT9/AFy0sl7UODCUQGwqnwcmdZyFr3kBUGS8pwjolI8G5sMjrIwbjkDe6p00/zN4ae4Okkgjiq188m0TYaQAKrFWtRgsoSA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;6:T068YSupgYIOlW00xlSpkgUIs+55WH26ZEcVtdq3Uc4ZTnCedptaUyfwRX8OiOcpNhqswCIMLZJm3Hbh7IHHpHXqa0h85O89jI8LA8rY8eRmScySmE6ZHvpqWZK///XtEufrfOtp1zhX3sBp0qpusVCn+4ryu0KGMDrbTVK/oKm/Swea7PNMW4L4rqeuzng5ILJHBQ1a/vSyI5JNM8hxXAaPbC5p5kIBC1uOP7vm4JsfATk5TCfGxf5VfReFY281OiOSjAw6xokmq40+d8cZ3mal7ssEk/qx2XP3SGAsY2NvjztuCXaPI3eZE+VWV1JDmEPOfwRaBwY1dfMcin3pYyoG2tuqD71Rr86Q7TMEe0EHfuUku4wsR2mdd0hzLE5xOv9wYT8Mdcq75xb+yvh/4zqUMSOfrMqn1hR+hI+UIgZQsnqqPbqJpWKYt0O5ZNmiUe3cCd+AvC8KPpVFlqm1Gg==;5:hqD9jjq0iKLsx5uho5bOAA9Eb2E3SZMYwKL5B0NNzCmYpYKQUQnMHu7cPKomyN2sVo9PaJNNiOYzrPNDmuWBZDmgLqBp7sOgy3RLmHxxmh4Z71OKoBMmXyvkPaYWP10H2SkaZSsy7WUh6ae3d/tNm9kayaIyUzv2mXJN/7dPcXE=;7:FII5M9IfhIOa6XqCMi4duBXe0EpiMnprblPfcbyjUzudM+PMSC03RrXdWNt3SotvVvVq0aP20t9Ph3m+Miw183ZT8FhHYcaLmWiRn29Zz7tE8rhneBLy8aVeeRZAQ4OOdMb2qd/KGYVYD/F2QnIJj+n+2OkUiZkHoAsoDicD/npDeauvolMcpnHwbThWjOuFgZCwOc88iZNkQHfWVo696c36lykziW6wEJuegA+4aK710IlvFR2rbl5WpAgxCb+E
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 18:17:51.9606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2c77a1-46cf-4e63-00d6-08d5f191c58e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some chips the PCIE and PCIE_PHY blocks are in separate power domains
which can be power-gated independently. The driver needs to handle this
by keeping both domain active.

This is intended for imx6sx where PCIE is in DISPMIX and PCIE_PHY in
it's own domain. Defining the DISPMIX domain requires a way for pcie to
keep it active or it will break when displays are off.

The power-domains on imx6sx are meant to look like this:
	power-domains = <&pd_disp>, <&pd_pci>;
	power-domain-names = "pcie", "pcie_phy";

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---

Right now if a device has a single power domain it will be activated
before probe but if it has multiple domains they need to be explicitly
"attached" to and controlled. Supporting both is a bit awkward, this
patch makes the distinction based on (dev->pm_domain != NULL).

Maybe the PM core should make this distinction based on a flag in struct
device_driver instead of number of power-domains? So by default when a
device has multiple power domains they would would be activated
together and this patch would be unnecessary.

This is marked as "RFC" mostly because I believe it should be handled
inside PM core, without driver code. Does this make sense to anyone else?

This is independent of recent patches adding suspend/resume support to
imx pci, but supporting suspend with multi-pd requires adding device
links, not just activating pds at probe time.

The device_link is marked as "STATELESS" because otherwise a warning is
triggered in device_links_driver_bound. This seems to happen because the
pd devices are always marked as "DL_DEV_NO_DRIVER". Maybe they should be
instead always be marked as DL_DEV_DRIVER_BOUND?

The imx pci driver doesn't support unbind or removal anyway so this is
not handled for multi-pd either.

Previously: https://lkml.org/lkml/2018/7/10/230
---
 drivers/pci/controller/dwc/pci-imx6.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index fc9529619469..7403918010e9 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -25,10 +25,12 @@
 #include <linux/resource.h>
 #include <linux/signal.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 
 #include "pcie-designware.h"
 
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
@@ -57,10 +59,15 @@ struct imx6_pcie {
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
 	u32			tx_swing_low;
 	int			link_gen;
 	struct regulator	*vpcie;
+
+	/* power domain for pcie itself (dispmix) */
+	struct device		*pd_pcie;
+	/* power domain for pcie phy */
+	struct device		*pd_pcie_phy;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
 #define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
 #define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
@@ -805,10 +812,47 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 static const struct dev_pm_ops imx6_pcie_pm_ops = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
 				      imx6_pcie_resume_noirq)
 };
 
+static int imx6_pcie_attach_pd(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	struct device_link *link;
+
+	/* Do nothing when in a single power domain */
+	if (dev->pm_domain)
+		return 0;
+
+	imx6_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
+	if (IS_ERR(imx6_pcie->pd_pcie))
+		return PTR_ERR(imx6_pcie->pd_pcie);
+	link = device_link_add(dev, imx6_pcie->pd_pcie,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+	if (IS_ERR(link)) {
+		dev_err(dev, "Failed to add device_link to pcie pd: %ld\n", PTR_ERR(link));
+		return PTR_ERR(link);
+	}
+
+	imx6_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
+	if (IS_ERR(imx6_pcie->pd_pcie_phy))
+		return PTR_ERR(imx6_pcie->pd_pcie_phy);
+
+	device_link_add(dev, imx6_pcie->pd_pcie_phy,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+	if (IS_ERR(link)) {
+		dev_err(dev, "Failed to add device_link to pcie_phy pd: %ld\n", PTR_ERR(link));
+		return PTR_ERR(link);
+	}
+
+	return 0;
+}
+
 static int imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
 	struct imx6_pcie *imx6_pcie;
@@ -945,10 +989,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->vpcie = NULL;
 	}
 
 	platform_set_drvdata(pdev, imx6_pcie);
 
+	ret = imx6_pcie_attach_pd(dev);
+	if (ret)
+		return ret;
+
 	ret = imx6_add_pcie_port(imx6_pcie, pdev);
 	if (ret < 0)
 		return ret;
 
 	return 0;
-- 
2.17.1

