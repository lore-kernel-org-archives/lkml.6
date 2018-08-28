Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC375C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A932208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="ZM0Jrs/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A932208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeH1Nkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:40:31 -0400
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:63990
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727747AbeH1Nk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yvprez3azRSi1qUZTkuWZTzIjc29OUayx4JB5SrF0mI=;
 b=ZM0Jrs/LxAza53Ha+CS/OWozCFwhrCFKzr8+9DcUxhA+Bajn/alSNXREzOOFXL6YPet49HZqdzNxeALgza1r33XAMrkI5HZll48E317EWA8Eyu2hdomgL/IYfbbkeos6nQgDUDqlTI/IMfk8/yjtaOw3N/4asvk2aIq7Z/s1obY=
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1582.namprd03.prod.outlook.com (2a01:111:e400:5232::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.13; Tue, 28 Aug
 2018 09:49:36 +0000
Date:   Tue, 28 Aug 2018 17:46:35 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 1/3] mmc: sdhci: add adma_table_cnt member to struct
 sdhci_host
Message-ID: <20180828174635.4bba02ee@xhacker.debian>
In-Reply-To: <20180828174534.00fb5e24@xhacker.debian>
References: <20180828174534.00fb5e24@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0198.jpnprd01.prod.outlook.com (2603:1096:403::28)
 To SN1PR0301MB1582.namprd03.prod.outlook.com (2a01:111:e400:5232::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec7faa7c-b4d7-4e4b-5784-08d60ccb916a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1582;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;3:KrZM2ycC0D+T8XfGsPMQ6fRaymIq4dN+6az3QC3F0RVmTTpTAbs0AbWiGW7RIrODtC+YZYUfTPHAk1ZqdXc7Vd9XI4AbWtLPBRl0QHmEAsV897/T/AJ1/CYzb27qs5CIHU5zExxeVu2mm91nUTnpLwlO0udhyQaLlfdN/nntuukask6s+Lsybv3sXimSAPJ2C8ihb+hnubz7bpdpY5mqAi217vHb6MSVQ+o4e6YPcCm7FBTheaiTXuVjA13eY97e;25:vqbdGaBnlnN6s1XrsDzpoWeocZ8D17UgiPFQmfUL3g4Rq8oB7au036Xpk0EqDXVcwUop3T6oJhdy8RKpg0JOrh3ZPiy2D8EIethDAr8aLQcfFCTCGj6RiG+egj6zI7fw9s2Tswq67qsKbj4ugT8XURxUrMLzuwmZ5/BS2mkXxuTeFT+1A4hl0DUWg1r9Zx0Pq4dQk7TOzHIIGUdwtv7sxmO2W9JSAjF6+g6Ry3wnyW2AaUtfWlum1ls71SpN+4XIKYYN5LJg7aLnbUhWcRsQENpKmHCBdIWEAMHXi528W/be5gMQUpPFfr8IqdOLubSs9Ke6KXjydPN7/rZ5nXzDTg==;31:AfojAZRVJU2bZkdoA7hDvNQHEwUiU4jYI1SL8Fi+bLhUfhF0molXskaNrCvQn9CWNvZXpOuf96xqEVGb36aarUCAowjK63yr8ueCV/cb7l77OebMfilF9UDAUeFJcAjW6kHMGTf2vgY3KFVbdbxHFU/lYkBPyTuuY25OHT6YyCA/plTyDK7Z42m8NSBIepBF0KF4A6sV/yAPAoT2CRI1jztENLos/vxgDP8J4I90Gvk=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1582:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;20:sNOiMhvDRwHB5SEwguS2Q8pLG3bz+8gHxBA2JykWi4RVd5rNNoctY711N2CIrsf/cnZeIdbz3u0ygBnqv5/huaKtUwZJE5R/oB2IxSLwxOE2+4+xz5UxwxhyXdhelJaRnlvKhui1pY+A+2HXmeOq+e+cYGY24Xqv6WtrGZa68u+jkFGRfO5nVqS3bCAvSu+CXysFZpSzEQmQI8fxWU8haw3dzwLRi7bq1ooxk4eSPEc7mINwFM2517J/FOsMVVOgukbPingryMee2yWA2H3qVNntVnIj5wg/i3/EzBg0/QTN/QYtfUZt/DXP4P9hgu5dhbwMnpkF2QdXxRcBNfpE0VunFcAsa39YIQf34XM552lnJzYscwdQ1iK4Qr8/djNGsLR+BnXpNbO40rciBtlN+GcobOPGxEkUp7zPFThfF8unksRFlfwzB752sn/qOXxfNNXFVpjU7lM8OGgiadx6hDexs9EIvKvlFXRDiMIFr/scklb8j3VICem7NHa+lIGD;4:GsqhprybCCJCqXOesvVjAElgE6l2FC83l/eOkORceBycn+yKz4MkGhU0vyzmG3QgIMHifqZvMy3+LGZbUr2XR1bWfJo0o2BktTkWjfJALVCzp7g8rT+qZ1aGQWUgiFuTIOyLiJQfm3exkZQv7b2lkoEK7D52a8i3qiLv5nIU5ziZ3lVIyk9kZahdhJ41GUuxWA9k7PdYnE/CwZ22DW6lgksLCtqy/VdaF0QleU6q61w9XPRGpxAdcmIrQfUfgxnUXiAo2G4G+ET4uoNqhOdadmAoJneOuLzvus+dT33jqHwAGb3AG+WM1Ym+tldy3nlF
X-Microsoft-Antispam-PRVS: <SN1PR0301MB158265371A26A310218AA73CED0A0@SN1PR0301MB1582.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:SN1PR0301MB1582;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1582;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(50466002)(230700001)(68736007)(956004)(478600001)(446003)(72206003)(5660300001)(2906002)(11346002)(110136005)(1076002)(54906003)(23726003)(316002)(476003)(6116002)(3846002)(9686003)(55016002)(25786009)(7696005)(33896004)(52116002)(76176011)(105586002)(106356001)(50226002)(26005)(486006)(16526019)(186003)(7736002)(8676002)(8936002)(305945005)(97736004)(53936002)(6506007)(386003)(4326008)(81166006)(81156014)(47776003)(66066001)(86362001)(575784001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1582;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1582;23:ACgJkqnzwhWea39heknPzISFdgFhnO/6K4a+v0s?=
 =?us-ascii?Q?mdDZ3IoJl49hhYzBeA6Vo40wUgpPbxzl0sPvF7R0477WZKUU2RGm8d5pNaiF?=
 =?us-ascii?Q?QL3JS84lNohP4NO+2/ji5NBwy5T93JqoN/3hbsbAILdeKnQhuRKdOPDAz0sP?=
 =?us-ascii?Q?WkxxKljfTomuHdAuUuDHz8FzEzjd3tuTR8lgeXUHtDM/8EW46a7LX1viAr5/?=
 =?us-ascii?Q?ekoF4z60BT05KNWgC6wyCcNyaAc5aKZFyMF19Rpo8odgM5r7e1HWE6JdKK5T?=
 =?us-ascii?Q?Z6XcSH1FBnsYAIcZJUVpV39ruGcuF6q8T8SJqNe4qkBpLBWq0BFyvk8UJwL5?=
 =?us-ascii?Q?qGdAdMhbNVYXzyUB5TW/zY+CS73zUBBru8lPAqbmnG0u3+8KRWF1AIG3ZBXO?=
 =?us-ascii?Q?s7kIAAUg6YjOtrh2KapMcsMGgDlk2KK9y1Y3GrLo9+9edve89p/HIm0QhXxo?=
 =?us-ascii?Q?aBF2UCvNmi5HzPO1o98XfEl+Gru0TjkKkfzpNLaTHQTICOCiy9CuHoaIHnAO?=
 =?us-ascii?Q?A7B2FvpdyoN35FNRM+wfeAEfr450eSIf03OmQC/F67HfNyhIue35DgEEuqRj?=
 =?us-ascii?Q?bEgheKxLrB54CdpgirlWs0nsjfruEruEiAsSg3i9qFF7GcyinILiozm+tRQv?=
 =?us-ascii?Q?vokR6P/EcPNDrYYbabKVHU3V9TVVGwA9YjuQzhRckAQZ3MhcMaeXdW+/q9I8?=
 =?us-ascii?Q?nMNDob5cZsSD2mrbNSc+4BFB6G7zZPqfy1wPG93zGoNi+vamUuayZ+w6c/tv?=
 =?us-ascii?Q?w4M9yp4Hup6CexfNoqG/hIchIdp/jiGmivAgQ/zC8+lMaTd9IM1Zr4rhxnd4?=
 =?us-ascii?Q?JnmYNV0SysnSaa+qHYC94o+k2o1ozVdg97ZQbqE9JaFYnZckkaMkfLL0/M4/?=
 =?us-ascii?Q?Slct3bD/Zc4uC1RngCq9CM8PSjwRb7t8KYztrpSRBHhFjv/JsIBKsr1Y4CJq?=
 =?us-ascii?Q?cfbB45WRc7PIPqvCEZtwZyO4r3fcMMO+Mg9UQXmHvYTilxzXQdfNW/xN8dKX?=
 =?us-ascii?Q?cZKhHbdJNzcRTSe56GSsx0Zrhw9M/iZpupOTjmFuoLtCkhL5zmWXI3MK1SDb?=
 =?us-ascii?Q?zLTt5M2rBP2ioPLWKmxaVZLDQsCJ+/Afv+fdZnEcdTyyd5uhojPsz05y0RyF?=
 =?us-ascii?Q?aHcG5uoWIBTq7cddmTePjxd5oBe8faVlOanVhobSn3I13lj068rnvNQXhQZb?=
 =?us-ascii?Q?10dv88B4HRHt0WWwq18e3rtgMky6uEvSczu9fGXFMyCnFdO67G/vcMb3KG9V?=
 =?us-ascii?Q?zuljvLsd/MiZyGU2xYDU=3D?=
X-Microsoft-Antispam-Message-Info: r/95miWyOUPdVP6IIXCcvVvVzaCuRKsg/yj6vV7IdNxMkApgHtvh+j2UCfuiJmfpuh0D4CWCjibiuTlq11g9DJ7wIOZjv74OqUPKfVUeEesIzGXDteAHWLW+wkJ4+SbkokuxF19T1B4Jj+/B+dtjJ8Cv0syzH/1b1eg7GvAQ2fWeu+7gMmav9SO3tQJF2QRhXp4TKqmqX49LEAmF68wIwTA4m+af1Ls6o/6rZvj28jEx20W3XS9tp3xDtiIdn03O5/pJDMgDxiuj28wJIDGEW94LDB+SZo5jKhfB/SWrihnO9R7X7RYKzjV5V9QRKAHLovLmbOs3uxtxBQpNsgQGM4QiLAdsXTOWE33CdykpyIQ=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;6:/k09iRh0xIelnoVIKHU7n0gSiebQDHX96ymypijRBcI2kK4s2OoEH23zntKSP/soJCk78Nw8SyadC37SoeB3yCYCYOCpLNvegFI+WTjzz+oGutnTvk35IIcWVobVEkoL7Yq2cY4ZSVsd2SXTReDlLtYFr2PJFio2wH5Zi8sX1BP5Xr47HnN3fkpj1AU0ZIncm1RHMk4S79sXuX4N6Uq31qssvXWrKcZlQWRX+Hm2tf+wLBnldovIKbTZZFZiSrvW3DkAvLqYtbSQIIyfvQKFD9HGQYtvMztd0lqHtSsqY7xqOyzbVBgjjgEwGcvJmL3xzquBTMpEeaxR8ISAD0XlvZYW5Szr5FT3+ZK8w735AOAyR36jZHhVJvxomLIJS2uJKtPybdu+arLKWODxEmRnKydgCOELJEVY0zoQIqSNVvgGIEGL3gCWba3BI/S/xx/AgwNopbX6czQtEEhncD2B+A==;5:tS/hPn2M4dZoo504i/gX5KV21Zcn6nXhz6TbEG/mW8KWr79RmlAPa7eXKElvRwJdnC/VLzqgETxIrX5hfTB8gAQaKr6CT5PtTHNtumgWJHQGcJRgTRiuhaZr/kyorqSizdyzBt8T/PnmGu2bIn1+MBzAEDIsJmc7JZmeXS/oVQQ=;7:fxu/mHlL7H+IWqT90w3KhSxNQbB3nIsPqpAFSV8C7mCo85Ko/KdGowOAiDiXdSDu3ZxQuR8fQFEt8M0/52BBzShGITRGfkttiswe5QruSSTss+JS8rWYQA3nhQAj4c4gySNEgKxuiHWF4hxufCda4ux9ZvVzmq/Ez5Fvp+5fdM/RgB+jk18tJPXt39ps7mCW/piq7E+BstG5CTHlYHPJoe/6usORTO/WOAEnzur/BCJRUccx9S39YyIbgg+ahBOM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 09:49:36.2531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7faa7c-b4d7-4e4b-5784-08d60ccb916a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds adma_table_cnt member to struct sdhci_host to give more
flexibility to drivers to control the ADMA table count.

Default value of adma_table_cnt is set to (SDHCI_MAX_SEGS * 2 + 1).

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 17 +++++++++--------
 drivers/mmc/host/sdhci.h |  3 +++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1b3fbd9bd5c5..52ccf4644384 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3322,6 +3322,13 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->sdma_boundary = SDHCI_DEFAULT_BOUNDARY_ARG;
 
+	/*
+	 * The DMA table descriptor count is calculated as the maximum
+	 * number of segments times 2, to allow for an alignment
+	 * descriptor for each segment, plus 1 for a nop end descriptor.
+	 */
+	host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1;
+
 	return host;
 }
 
@@ -3567,18 +3574,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 		dma_addr_t dma;
 		void *buf;
 
-		/*
-		 * The DMA descriptor table size is calculated as the maximum
-		 * number of segments times 2, to allow for an alignment
-		 * descriptor for each segment, plus 1 for a nop end descriptor,
-		 * all multipled by the descriptor size.
-		 */
 		if (host->flags & SDHCI_USE_64_BIT_DMA) {
-			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
+			host->adma_table_sz = host->adma_table_cnt *
 					      SDHCI_ADMA2_64_DESC_SZ;
 			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ;
 		} else {
-			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
+			host->adma_table_sz = host->adma_table_cnt *
 					      SDHCI_ADMA2_32_DESC_SZ;
 			host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
 		}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f0bd36ce3817..25bddd21de31 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -563,6 +563,9 @@ struct sdhci_host {
 	/* Host SDMA buffer boundary. */
 	u32			sdma_boundary;
 
+	/* Host ADMA table count */
+	u32			adma_table_cnt;
+
 	u64			data_timeout;
 
 	unsigned long private[0] ____cacheline_aligned;
-- 
2.18.0

