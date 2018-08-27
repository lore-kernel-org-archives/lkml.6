Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1748C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E62D208E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="VfNm+M5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E62D208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeH0MLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:11:23 -0400
Received: from mail-eopbgr720059.outbound.protection.outlook.com ([40.107.72.59]:34272
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbeH0MLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t34Jq3WRCfdlEWi8ntOQHsyGNkAU8Rm7d/6CzQM9b18=;
 b=VfNm+M5sf+2QB1l8kBWsoVbkmqnTFhdHKCJoOGUYSmazpXBoL8H9alPLhHTjObQJ3aiZABg2kJt90qY1rJVrfvkt/UNxp9BYoEzmcQXT4hcMIkIGORRiDpVsx9hFiWKAzKMQHZllxQ9CBE/zR8sD3gN92HzweA3p6A/FAt+yEtA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1578.namprd03.prod.outlook.com (2a01:111:e400:529c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Mon, 27 Aug
 2018 08:25:41 +0000
Date:   Mon, 27 Aug 2018 16:22:42 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 2/3] mmc: sdhci: introduce adma_write_desc() hook to
 struct sdhci_ops
Message-ID: <20180827162242.0fc59e00@xhacker.debian>
In-Reply-To: <20180827162026.3901de27@xhacker.debian>
References: <20180827162026.3901de27@xhacker.debian>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0193.jpnprd01.prod.outlook.com (2603:1096:403::23)
 To CY1PR0301MB1578.namprd03.prod.outlook.com (2a01:111:e400:529c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fddc7e4-caf1-4060-19c4-08d60bf6adc6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1578;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;3:7tbD/BihYe0ssK7GQWsdDD4abLoy+/6jmkk6MiiWQK9U3qKys6xtTeCFnGVo2HHRHKNydK0BtuvujNKTWYBfuVBLQiiJZRaqShVY6v/O5ltQYS/WtMbYIjQcc4deeQIuyn82q6/zu/zIyH3YHl04xin1bW0gmy3mUTgLds6DrUTHoBqkid/ixf7TwWs8M3rY5Mu4RJlqMXXO694e7qUQS/HvwkWO+CkPec/BH16XZVxLDnSyJbzgEn+149fEqWqs;25:8bqzlSa+BE4X12J4w080RBjGpOGTuuSlB/R6BYDunCDB6ow1dQsG0BEKeARl7HybWBrNhz/PNzSldFVDcCJFMekYKGcpq8zTjdxgis9989j6O3ggBagJgImo46OF3WhoefK6c1HR9/uxX+VGvnEa57PcKUPikRIPEhsxpOuopBRyZo0z5oBoHiYK/h9aPCHZM1YPkdUc9H5rawtJFW/bj9fxn5bMdck7km+rjq8756mcHr99R5x9iKRE2yH9GvYt8OA8PoOjOeFd9682E2svdUafu8iEbB2xRJs+OlgT7BI4YwaKfq/xFLzo16TsDHYwYBbLlVUAfk7fbbq/SjEt/A==;31:X9Bcg7HK/T6phUz/6LC/DoDLEBeYnhZoKRa5Ri3ga/qLuDs+jHeIiZDXsil4E7KcsfDo24IgmFiXhlUxgTZ4mCaLEUJcUMDlaoXhMLacHHP6Hk3035NW1f8+n6AavsBQi2FMbm1UCdAp1f48d2OjCdSDq7liZ66ilP3dlyXAdakqv1I8fzVavvFL5IhYRexpEjmyTOrBYVj8Fe9vvjqpmju1aiu1km6z+eALwtix5vA=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1578:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;20:JwkvusBj384BkY9KexcacW/igD6eWLb532uQHzpJje/yh9klznlFO56N/H9X2LOlloZCvvsdQvAZADR1XYtW5MUHq+FTOmfyeJN9rxZBz6Xf+jAh1XYsanO2oXo/b5AP73DLUA0d0q03cVzHwxa3XknmPb3mlsD1ogg32tOrBSMbMrvsOi5Av26kTgHi29Va3YV2b8FialSS5PxofcXDadGstRcjyJ5QtLus4RfS6DCm8HmfuW74r13TqSNfuSI7hQoKsO6YX9G0QuxfFuhUs+5+kAZCzNkb4MAvBQxEmk9jjQOXoIUh8jeyt1kiQUkJ6lDwDwx7cGmQiiigb0hBHODoijpkiwBkyADkuqXSSvuGuORMSWXm0jhjYekiUAcZkU3Urx+QFg0BElhIWVR1197f1GMGghUaBlTlwvB38HKuEp+T/nfp+r+jmj/uQONDfXpcjplfKbrzMN0yfBgmHJBXmHgutXecepxNU6rR/WvBQwOpEipHB1L8RYc9ZuIw;4:ZkxR94yds9GLfVdG/OuW4vSgwqu5/Vpv4FA5JROp4w5i5AVe6QGo80CBW/pSg8J/f1wYWFAmjwCMHitGQF79uAoXXO0jbRwXghXx0/1sWjnJtlmXUC6Jy31BX3TGLs+Onu9aur99rana/Sl6OuCxM5v8WQ3/DgRxHnEfioRKApXHv3Mq7PYVj4EQcJM3cpXNkhpbkY/K6BTDLWqyFTFJxyRvP89Gk5rJ/8v/0cVlsnC15PE2klcf2Vzg81hlCmVHfTxoyTtoFKVoG0GhXmbP8KjrIgR7m2IRCYXxs0uYH+NBCh48r4E8qYGMbeScgt1X
X-Microsoft-Antispam-PRVS: <CY1PR0301MB15786B06714ABCEF072ABCA8ED0B0@CY1PR0301MB1578.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR0301MB1578;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1578;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(366004)(136003)(396003)(376002)(199004)(189003)(23726003)(6116002)(3846002)(478600001)(230700001)(4326008)(47776003)(72206003)(956004)(476003)(11346002)(54906003)(316002)(53936002)(446003)(110136005)(50226002)(9686003)(8676002)(5660300001)(66066001)(81156014)(81166006)(105586002)(76176011)(186003)(16526019)(25786009)(2906002)(97736004)(7736002)(106356001)(8936002)(33896004)(55016002)(50466002)(26005)(68736007)(6506007)(305945005)(86362001)(1076002)(7696005)(52116002)(486006)(386003)(14444005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1578;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1578;23:bzsBDuueZTYAcEEtmfWKQ/seUugu9hI3SVZbGsT?=
 =?us-ascii?Q?zxXHTvij3SVp5THF6YX01BPWLk6+hyq/KXtyRE2hIzS92N+Gk3OaT0uG4RDM?=
 =?us-ascii?Q?wfWrDl3Ad9y6ZP7DCIUbgxza7t28i01ulNzJbd4t4wPzl1n2m7dnp/xf8oQk?=
 =?us-ascii?Q?39yqLGuwIRD03CAe0DaVh2CG1COOSXKc1uJCm1djgwVteFRLFcCv8WNdtQ4m?=
 =?us-ascii?Q?HFPmDszXySc0VgmnVrgcgulFNY6phTuO57DVXLa+knokzqm5zMPzYixJdfI8?=
 =?us-ascii?Q?A9m9m+RIODfF4FvVrnY5w7C5OJ3pF58nToJ2D9iSHTdd9U2d6uX97HcVlPjM?=
 =?us-ascii?Q?EtZGKSPJNG0yfl2TUgStc8pQamL9jPtCo8ExctXaK0a8gla7AmjcnsuqkraA?=
 =?us-ascii?Q?9ILeIfetdwAWFQvfOtBqi1mfNZUtLzMibXAZS0XUXzfVWSFNOJZSLSgujLyG?=
 =?us-ascii?Q?LB+4a7igvcb5P/etDJa4lGsJO+znJrWS0UXed3ihpjBqCL8RiRBnoHQM2xzR?=
 =?us-ascii?Q?f4fIuwxc1R0ZWt/jwkyAm8a92BpF/x88feMk1oGDLUJVWAgSYRpyMbWdv+Va?=
 =?us-ascii?Q?tTrpUwpCoTIKPgAfbEqW5lm18ldQtBb1kfXYddC7a1Rg01VIEKFRnzxPuUhY?=
 =?us-ascii?Q?9Vb9OJBABZei+sX8ZKwh/XvO3jLn6i/kfB4xQAk9fjTdxKmi+nlXnoRMQ5Jv?=
 =?us-ascii?Q?hj16MRdy3jrgqakMp1BfdPlaEN0ELCT/smg3pmqORfr0Kaqxm+OqngtSFvp3?=
 =?us-ascii?Q?wXa3qYXX+EICrokL7Al4Wkb+v1Xt1nquBkVyCuv6Iw1+EKHg0GsOLyVardZa?=
 =?us-ascii?Q?XiNKa5d7/zgZVj4OCt3gwwq50cYhtcHZ6+SofGs54UwZM/0WF2N81E4Pa6HG?=
 =?us-ascii?Q?OkoWUV34nu8Gi8jBoll4Wj1zKCBM5KP1ojAz4GbB9oQFJdSkJhRbrCyh0Md5?=
 =?us-ascii?Q?hei7mhOWvM+NUVcXN1esTuNSN/Cv244haPchqK4fuJznv7Rd3HdKKynW+5lU?=
 =?us-ascii?Q?FApvVVwenrQt6MV3+C60qCk/fp9sNKMCj13gFdzwDgewcka9s1ubAHKDZkkF?=
 =?us-ascii?Q?nLXkDGyQoXKmNR1Wa0QtDyiOXyJ/YgEo8kSeFJE2QydCvoxfpuzMqAtiOETt?=
 =?us-ascii?Q?3RnVP8nPI5pynYbWmWWSnnmm8gLIVKhD7fQE2KmwKK0nXOASQMN8JsJOZJir?=
 =?us-ascii?Q?FmVKgamsfNDafjBDJtX4mQHecJk5MsSgqA8Bq27oijDzpzeRSQFcIMQ3lzRo?=
 =?us-ascii?Q?0fZ0rw4I/aLNLdZq1Rb0=3D?=
X-Microsoft-Antispam-Message-Info: T2WzvWnyVcVvp7M3D/r1hYQsu2r0mQXepxXm5iAaMwSSEpIfJuzpEQj0Vr4Iy5hYdDRN2Qi4lx6uXYwBQXLVhnUACsG4TvTMCBM1Xr+h6bzXUCHUBxcSH4lVKwVVmzj0I3GAygsWcnTJ/ojwh3dAC01IehU13Di1oh+Q5Ji5rLKQmpAX/ndkyxSzrwZh2XDz4Sdh/SnqZhfj/IyqtSboNsC1XT6xRtgVhBxHKoxTjLT6o2hVAZ7AtR6mVn1v/fWtyZmMKBtjeXStAM34M1Z3ZlOXbxVa5Io6WHGrY9ui5VNbuaMeR8SfY3mg57vVR1t/ql3bn8+RQUgS0CCXmMaoQO2GcIsbIq+4vUSrEFQ93Ag=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;6:h+WXq2lEjBNOjncwzMZXlqa8zs+hLpG7zuvs17+Qukoge9llEdafe2XjNqKg+CwYlWPFbZovr8K3wBHKpba0RjoNjSS7XzxnqvpmX7LfAegA958yjNOkuFWRh/+0eudKqXA5+2PwLIDcblPDjLdixAucLYKrsZvgKHNFB8ORbfHstiWlbvCdSqQtwWfnqC0ejPoBJ37lyF1DTxYUB7lo48gEzsWjdWrkm5+0y2bMrd5U0HTJH8oUfqj2cUajSVgChx2kQjDmOY8ILVNIcC522f9DqyV1OSeQdnrJsw3uTvNJ6T6/HWn76tzrsw4yFAubUpYFhbIu16zWziuBN9kDm4Rkaardjvj/pdc8fxWG6f6IhDhNjPS0QOUdDL4eeikpY+kBN8gOSE/tnGiEMCMGMGAyE/NlzSGdqLBDVSytkzMqfamvHxvGE1C9jVRu2oiaePSYS7Ixr6GyyLzSe9Xx+g==;5:SN47ULbc2d880ukblMv3IhNjYplQZo3jKil4qFivHcN0Qg2AzgfdVe4xhmJdXwXyCUNQ+Rb6KNWNnbzHTx1XqpBZC+geifnZk8+hlgM1zq6dpfHoIVE530xO3j0HbzdmmohuYaLUvC0P7BmYYWXAwg3bu+PljMHCE7JuRDhz96o=;7:PErXM+V6OpBaC8lAcg1vWH3tE6DO7228aSCH+IsIyPLXkB8W4GQmbvquksKhu8uCTGA+CLvsZtZNcr8bBhAIPB0qlG/LUMLPutxYbRqkEjQLFR1bj5DHDFOKOguQ+5EGLbp0Y+W+FyT9unC9My3BMI3Ica30C1iz1+B+6MTxBd/XtZy4+rRYStxIw2mNNdD/E74srG5ak60n2CWLbp7sS0t2YvLqODBvTzJKgsFyz1rU2mjUX3nYuk/fztkNP9h8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 08:25:41.0273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fddc7e4-caf1-4060-19c4-08d60bf6adc6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this hook so that it can be overridden with driver specific
implementations. We also let the original sdhci_adma_write_desc()
accept &desc so that the function can set its new value. Then export
the function so that it could be reused by driver's specific
implementations.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 37 +++++++++++++++++++++++--------------
 drivers/mmc/host/sdhci.h |  4 ++++
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 52ccf4644384..eb21d2db7f05 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -554,10 +554,10 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
 	local_irq_restore(*flags);
 }
 
-static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
-				  dma_addr_t addr, int len, unsigned cmd)
+void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
+			   dma_addr_t addr, int len, unsigned int cmd)
 {
-	struct sdhci_adma2_64_desc *dma_desc = desc;
+	struct sdhci_adma2_64_desc *dma_desc = *desc;
 
 	/* 32-bit and 64-bit descriptors have these members in same position */
 	dma_desc->cmd = cpu_to_le16(cmd);
@@ -566,6 +566,19 @@ static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
 
 	if (host->flags & SDHCI_USE_64_BIT_DMA)
 		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
+
+	*desc += host->desc_sz;
+}
+EXPORT_SYMBOL_GPL(sdhci_adma_write_desc);
+
+static inline void __sdhci_adma_write_desc(struct sdhci_host *host,
+					   void **desc, dma_addr_t addr,
+					   int len, unsigned int cmd)
+{
+	if (host->ops->adma_write_desc)
+		host->ops->adma_write_desc(host, desc, addr, len, cmd);
+
+	sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
 
 static void sdhci_adma_mark_end(void *desc)
@@ -618,28 +631,24 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 			}
 
 			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, align_addr, offset,
-					      ADMA2_TRAN_VALID);
+			__sdhci_adma_write_desc(host, &desc, align_addr,
+						offset, ADMA2_TRAN_VALID);
 
 			BUG_ON(offset > 65536);
 
 			align += SDHCI_ADMA2_ALIGN;
 			align_addr += SDHCI_ADMA2_ALIGN;
 
-			desc += host->desc_sz;
-
 			addr += offset;
 			len -= offset;
 		}
 
 		BUG_ON(len > 65536);
 
-		if (len) {
-			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, addr, len,
-					      ADMA2_TRAN_VALID);
-			desc += host->desc_sz;
-		}
+		/* tran, valid */
+		if (len)
+			__sdhci_adma_write_desc(host, &desc, addr, len,
+						ADMA2_TRAN_VALID);
 
 		/*
 		 * If this triggers then we have a calculation bug
@@ -656,7 +665,7 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 		}
 	} else {
 		/* Add a terminating entry - nop, end, valid */
-		sdhci_adma_write_desc(host, desc, 0, 0, ADMA2_NOP_END_VALID);
+		__sdhci_adma_write_desc(host, &desc, 0, 0, ADMA2_NOP_END_VALID);
 	}
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 25bddd21de31..2115416f973a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -606,6 +606,8 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
+	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
+				   dma_addr_t addr, int len, unsigned int cmd);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -736,6 +738,8 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
+void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
+			   dma_addr_t addr, int len, unsigned int cmd);
 
 #ifdef CONFIG_PM
 int sdhci_suspend_host(struct sdhci_host *host);
-- 
2.18.0

