Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B66C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD8120685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="OhZfZ27q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD8120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeGYK7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:59:36 -0400
Received: from mail-dm3nam03on0072.outbound.protection.outlook.com ([104.47.41.72]:23728
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728629AbeGYK7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4u5uB4pyMz2QMMCboV1G5cEG2ARP2isXycosXVGyGw=;
 b=OhZfZ27qlc4FLzHpyhujBdRxmBGk5LyJxqkO/wng55WubtmMxjtt/Jrn1EHwrDJdTg2oqQkxyaF73KSFNGEKHK2bE+XmdzKbiGYXNB+K06gNRN4hu/PEgT5HjKHckhEyXD3N5QrdSeX1WDXcC4emBXmrW2sXvjh7wGKqp071OdA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1580.namprd03.prod.outlook.com (2a01:111:e400:529c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.22; Wed, 25 Jul
 2018 09:48:33 +0000
Date:   Wed, 25 Jul 2018 17:46:18 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH mmc-next 2/3] mmc: sdhci: introduce adma_write_desc() hook
 to struct sdhci_ops
Message-ID: <20180725174618.1dc9bdd4@xhacker.debian>
In-Reply-To: <20180725174235.1ca764cf@xhacker.debian>
References: <20180725174235.1ca764cf@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0142.jpnprd01.prod.outlook.com
 (2603:1096:402:1::18) To CY1PR0301MB1580.namprd03.prod.outlook.com
 (2a01:111:e400:529c::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aad1736a-dfa7-4e70-90ad-08d5f213ca04
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1580;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1580;3:2aHqziea3vj9+tx/Rv89Et6ZPC9hchjvPladp/OzLh1O2wtwWK/UE9Jtn+nRimvmys+RYvfgvQSZ32aHOf0OFwjNC7H+tuseyEsJvF9c9k6HA1xhY4rO9g8XkDoDhX7cBNLPBAmBY46xrZZ4bB+U3RKbWVdR1H+fCCI2vjlLjSHaD9svbkKsiUt5yvWrsyn5KNLkju1aSPzrSSc1PypFD4c5fpZWqgRstynykM9zJUbAWe+QBfIQN5iz9NgjQ5Yc;25:Bv6ydgWCncNsExtm0u+eOD34XPAZF/B1ZKDVwaSJKzdbGTxODKM9bgNCLvSSkQfm/FlKd3w9gnG/vpn3EdWwlGwfDMiDJP6JYRI+wTSi0kMrKVtzV/XHLHilOuEFRVaRNCWdsjFzLAdmJUKSbzGntx0AFdjugPPbr0lvgNVnItK50DZOnB2OMQi8NpH+l2EfUTSt1WYLJV0osDauejJaTFJL0yn4Tf3lmbJww3Amb/QA4dBwfxJ5AWty8eHQzlj76kL++DerDSGO637s6lqq5DVo/nhbvi31gqX0D15FPyIn9g3JCugLWYdFgGPlThbCdEUnIZryRXFW7dvcvAc72Q==;31:CB6jQUU20hMk5pby2k3PmLDUijK/NllCqfAxRN+4xElfpEEbygL+QBTUPek46Pd99QnwInz91OgfoAa2LDQawuFzLNgo6/HJaDWBB/G0umnqx35SzYOlzjJww1dVDbXbawH6MTpOd6UQ4dPQ5bbMKHNJRGr9/jXFjvmp1BOjaCF0XBVEZC6rnMTwRaMZQSVcyjln143YZUGeKJ4Tivqsifck5/QTM10INdWHRfCr8XI=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1580:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1580;20:mXuQfZel/mN+d1BRlrXMc2m45iAlzzt3N1o1lqDmAT+FiVXLK8XQXmDaW/snQJXX+U/J0gWnAsom9pwK5ddEHj30s2TBMvXaT3bnF+Zywq3WvafTF9VRMznMgNgj5Hg16ZqiYPVEiqzW/w9jb17ya5k+FFrPtSb/jIyk+JYCsICoLehI3oyKAqlFuKJgocPZu/fxJpYmqzlqo1+zDJYr/5yF/lDEEAVFy298lj0qCaqMR945xbzYZwJ0WOgqfWMhymRVGc2mqP6afQOyYswEk2SK+Kj8jtCCchmEIWuIVhyJLPQbyVS+NrJ2MapcVxG2xkAXeipTwZ85fE9wiqyQ7NwTilxg96QD36Zrz6xUnklszS/hRoyl+I17lc6qoGXVMITC+SVObuu5khgdbq9zOSfhITpESxpv89SOO2oygbf+z0f4dsqWoIDs9CDasEzwIuoyxRLM+Wsa4aUxHGVawn/MnYKBZSlyBlLg5PIxV9u94FvEAWKokUljnur44P3S;4:MI3rC+eTMJ/b6gh3vk7SA+NrZiXx2RQfEvGdShaH3AzUDgS9SctpiQzKlxB4zs9juvsgFiij8m5XYcWeOvN7fnSmQ++Vrw1s2Pm/BBcLIf1p0z8vk9ir6OwIACOfn7B0u6+N5B5lDQdBfmufdfJmXcUoR3Z46Q/KdHLq++z4bj8SXnvSsN/CcNcstL8dsrKoJPK/69WduwiAyD5TTkzN36yRETI1Sg2q0jxgOJfBedk8R7XeyenYHFAZoOtolpE773fdzRIsz4mLSNeLsGXvrA==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB1580F25E4F288A280F12216DED540@CY1PR0301MB1580.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR0301MB1580;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1580;
X-Forefront-PRVS: 0744CFB5E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(396003)(346002)(136003)(199004)(189003)(105586002)(14444005)(7696005)(486006)(9686003)(476003)(956004)(55016002)(47776003)(66066001)(1076002)(106356001)(3846002)(50226002)(86362001)(68736007)(25786009)(6116002)(5660300001)(575784001)(23726003)(2906002)(50466002)(305945005)(7736002)(97736004)(53936002)(8936002)(81166006)(8676002)(230700001)(386003)(6666003)(6506007)(76176011)(81156014)(33896004)(16526019)(186003)(4326008)(446003)(26005)(11346002)(110136005)(52116002)(316002)(478600001)(72206003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1580;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1580;23:XStgcuXH7bN+QRpm+64FU6gPIRsRwYJeRw3NT0e?=
 =?us-ascii?Q?T7plBWujOIt4PkpSG5VqBzVKnhG+DoxFIQfcvMod0G+rhf/iuAlTq0X+Mjxo?=
 =?us-ascii?Q?y6YvRXnqCN1uHA2TMuSUPNnDnmBnZzAD4SdUcXhSJ5veU2Qc5h3740H/WskZ?=
 =?us-ascii?Q?Fkb/78fkgFTdCd4TbvbdHvpSh7x8KqHme+yacnwy+cjFNB9e+Dbrw8Zcz2lM?=
 =?us-ascii?Q?w4dGTQkw8UtU7f2e67oGyB6eL21qz9Ca7+xOvDm+U/ziKeO34EoXHMsIqjWy?=
 =?us-ascii?Q?kR2tNZ/HCbgzAX1ogTETNuvcpovQogVegSscKGzHCXl6aRFiSg3WFR2OW9nH?=
 =?us-ascii?Q?d4itcNljX9X2+R1rFRBMEW7//6R6rssY7FpIfS4qN4v/acuV6BHi/nOfuMH4?=
 =?us-ascii?Q?aC1oXpWX9jnEsUwlJDOTbiIOXARj35uOGMlJGjYtZhvA7FFVvaumzgsVtU5Z?=
 =?us-ascii?Q?QJSbEMdA5wgXgrXOb1vi/AJHO8PVC951idhMewTBLydCi5t4aM9+q+cN6e0F?=
 =?us-ascii?Q?IvaHVOxfnDbeBnfQLavsUqeV0awvCN7g6mxknqnIM2ch/DiJ0A79PZ75etBa?=
 =?us-ascii?Q?Av4sUNlITpW6caNInXmKDnvsp9vrG2r5kLYpxUSYC9DCOFwp1zm3gGc/MkSq?=
 =?us-ascii?Q?Dev/MDnUA00wCJGr3Q9eu4YBD5hByii53RZQArppY6bOjVAilk/t/tpmg7qi?=
 =?us-ascii?Q?+StGtnarxu55UFJiKm3DpE8T0l+ASGrovvOJ3Bb1YQ/2EKrLB87ORg/Nj3Rg?=
 =?us-ascii?Q?dqIIbj467hHXbzOIE+WGPcsLNzYf3NM1wvak20KBolxyu3bE71iQCUUd7kh2?=
 =?us-ascii?Q?gbQYxGhOh2UeCmzScwQGXxforouD27HKZr2r0W8SrOE/PY5rjEQtLWll/A5A?=
 =?us-ascii?Q?6lOqB+VWZiMOrGiehm4RprJ8JHjw7Fov8iofI9MxKCp4XWhOqUS2sdj4KULd?=
 =?us-ascii?Q?KqeulBcyxTVaxJtbTAfsUMxuu7QC9P1jISbFPry1yWY6edrB1PMzBx1+61La?=
 =?us-ascii?Q?3xBq1VbtEk/QDEbKgoDRJyeMECfkCjkqDYEmb6/mQ9zRkmHQjs2osz7zVcZa?=
 =?us-ascii?Q?giP/kgQX07iEtHJPP2P6l2jEEcqL/nthFEDO3wVgltC+fH49ekTCICfhL+BQ?=
 =?us-ascii?Q?OYyb16i9xQsoakWf5U7vfvneHpAMKpOzkSIsjiIvmIRpeAxpIZaFR3aoJ0VG?=
 =?us-ascii?Q?jWEHkNZ1P0bsfzsOT8nBW9iEhSSygUp3eSCPY4YYS0+NszfLMpj3dtcmCeCi?=
 =?us-ascii?Q?LFiCgzP13px7+ZHbXc76KPbFSh0kbJVwaINztaKuV?=
X-Microsoft-Antispam-Message-Info: SOR+n6iJJU4r7kIz93XoykQKVI6tQJKw+vO6uMMA2c2oOE9RmGa0BTD7IUTB76PkLjjJcVY9uP1Uog4rQb45sQg4op6h3l+wUcgx5EFarwg616OzhH03B0+zx5B8QxFQ3OzqsYE3C5O1d+PJdqe/qOfUs724WIeOtIN8+LoWh7Uy/FKSlPbkXC+EX4wk5X2mj0HC8KIRpTBnTRAfJtxZIsvy0h9x1z0UlgFLC1w8fG7g1x5PHQR0Y7WfhwDhbm8w55oEyof/CvDIO0nCQdUBJZKbzBJPMMQf57QVTqJkHPEx1q3dUA+KdjvKKaobMV0tOujscBxxkeGhn+sqxG0U+mET9Pr67YjFQHtEzuhFD4I=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1580;6:lxoclWHkbKyGlyDhD5WA/iRO5Tkw64u2GYoRuf4cVIO+qPMg23XDlvB2szf42+vqBC5XfBvaAkKQS7h6Wsm8SYpvKMgCOM46/GrNQvjh36mzeloRxRzuapz+FQ69I4gZtoOb9j7uGfmJeAQvIsmUXOVDrwAcxsXWrihf0x4Qywy0jg3/cBF9dbKDLilCte0mzLcGNi9f1TjNh5EwSz/OUaPVJH694uJz4eweEfmh40ZtShKhHAPH12L8AYbadsOQj2Zz3ZQPSsHaTek7Z5lFO/PUI7EpcUCCPg3J7QUoJsweCjUxBwuG3vNcAOtZB2OxW9geQ6odmTsr1BwYx4KnA21mG7AWBs4l2vfXPVg9Ybk/X6cbF/3o1t8BNxU6UIM1iNO8qwojcKpBsOJNQb1DyIHX3sjjyDxE1/Uk5PhNlKFkoa7lnbH1EJ+a3iLi6ioLt+FYBvBf++HmDPZTZMAhXA==;5:gs4DFSSPDu1308hYxlgV8xGBaCZ2ubRMRvolf5zRGXYawJV/r3jbWv9ShEm6GNGHGT+6uv5Fb7XaiXtzUyEggO0hS87XzMXqb/P1xz5yrxmM1YFdPuGwhIth9aoHSHr55d3BkerDm+uWR2tn+4dS3iNZcog5xj4WCClczvY3XHA=;7:LAbuh/LaEvBf+a/N8pmMMPkEE0hAQ2KVPToh3A+pKdx1DMYhyOtEhqZYELKDx/NcH2P1g7nCxFeyRwiuYw+HD7x3dVCLqLn24F2MiZ0RigVdTQ4vrciY6QNF/i+Qox/3o+ZBsKNks9FlrUjY0himPPmJ2gXarl9WkTVOBsJg5XK0xngclR8inZOLLvq/FHosvPxUo2bQfInAXN2LWe7mDmaBjYTJoCcetCqx0mJrgh8m+kAc2YSF86RX0AlGX6Kg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 09:48:33.6171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad1736a-dfa7-4e70-90ad-08d5f213ca04
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this hook so that it can be overridden with driver specific
implementations. We also rename the original sdhci_adma_write_desc()
to _sdhci_adma_write_desc() and export it, so that it could be reused
by driver's specific implementations.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci.c | 31 +++++++++++++++++++++++--------
 drivers/mmc/host/sdhci.h |  6 ++++++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 14dd4a49e03b..50c846d99182 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -554,8 +554,8 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
 	local_irq_restore(*flags);
 }
 
-static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
-				  dma_addr_t addr, int len, unsigned cmd)
+unsigned int _sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
+				    dma_addr_t addr, int len, unsigned int cmd)
 {
 	struct sdhci_adma2_64_desc *dma_desc = desc;
 
@@ -566,6 +566,19 @@ static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
 
 	if (host->flags & SDHCI_USE_64_BIT_DMA)
 		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
+
+	return host->desc_sz;
+}
+EXPORT_SYMBOL_GPL(_sdhci_adma_write_desc);
+
+static unsigned int sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
+					  dma_addr_t addr, int len,
+					  unsigned int cmd)
+{
+	if (host->ops->adma_write_desc)
+		return host->ops->adma_write_desc(host, desc, addr, len, cmd);
+
+	return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
 
 static void sdhci_adma_mark_end(void *desc)
@@ -585,6 +598,7 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 	void *desc, *align;
 	char *buffer;
 	int len, offset, i;
+	unsigned int desc_sz;
 
 	/*
 	 * The spec does not specify endianness of descriptor table.
@@ -618,15 +632,16 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 			}
 
 			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, align_addr, offset,
-					      ADMA2_TRAN_VALID);
+			desc_sz = sdhci_adma_write_desc(host, desc,
+							align_addr, offset,
+							ADMA2_TRAN_VALID);
 
 			BUG_ON(offset > 65536);
 
 			align += SDHCI_ADMA2_ALIGN;
 			align_addr += SDHCI_ADMA2_ALIGN;
 
-			desc += host->desc_sz;
+			desc += desc_sz;
 
 			addr += offset;
 			len -= offset;
@@ -636,9 +651,9 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 
 		if (len) {
 			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, addr, len,
-					      ADMA2_TRAN_VALID);
-			desc += host->desc_sz;
+			desc_sz = sdhci_adma_write_desc(host, desc, addr, len,
+							ADMA2_TRAN_VALID);
+			desc += desc_sz;
 		}
 
 		/*
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d55fd7033e93..0aad0ee8f63b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -605,6 +605,9 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
+	unsigned int	(*adma_write_desc)(struct sdhci_host *host, void *desc,
+					   dma_addr_t addr, int len,
+					   unsigned int cmd);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -735,6 +738,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
+unsigned int _sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
+				    dma_addr_t addr, int len,
+				    unsigned int cmd);
 
 #ifdef CONFIG_PM
 int sdhci_suspend_host(struct sdhci_host *host);
-- 
2.18.0

