Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A484E2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="SLdvjRj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A484E2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeH1NlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:41:22 -0400
Received: from mail-eopbgr680070.outbound.protection.outlook.com ([40.107.68.70]:45024
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727101AbeH1NlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t34Jq3WRCfdlEWi8ntOQHsyGNkAU8Rm7d/6CzQM9b18=;
 b=SLdvjRj33bu/GGe/ty3VplFAF8x8tlTp7GZgseUrXTjcaPfPNKFrNi5Jp1mLmhPsiMsJn0NvrNALR0OIGUfGTeQoga0Cvs+wr7S5eiwyW2BmDwZRtAD88FtJJVJaLAZ77ccumfgDQcs0ObKc5F7d3COi+RxksVsSMvH871LNZcI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1572.namprd03.prod.outlook.com (2a01:111:e400:52a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Tue, 28 Aug
 2018 09:50:24 +0000
Date:   Tue, 28 Aug 2018 17:47:23 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 2/3] mmc: sdhci: introduce adma_write_desc() hook to
 struct sdhci_ops
Message-ID: <20180828174723.4e729a27@xhacker.debian>
In-Reply-To: <20180828174534.00fb5e24@xhacker.debian>
References: <20180828174534.00fb5e24@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSAPR01CA0147.jpnprd01.prod.outlook.com
 (2603:1096:604:d::15) To BLUPR0301MB1572.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce65cb5-1e2f-4171-b878-08d60ccbae20
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1572;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1572;3:4ORWQ+9LhsSpml9lMOeMFrM0AI7ieYeBtu+Cmoa0Z0MD8B/5Q/f9g65268yxyTW9RtBdKwRsqV6mrt93Zy9EE62BIf8EqL3e0MUqoTTFN66F7vpHVAvFbo1ikP7k56grQoW0qoyM3vpvJPfQlIRaBt6FN/FaNDUoHOBmD1wPdlEOcWD/MxwMYhyAbFDDGyhRb3IzFZM4SgPFrtISGsu25IAuoXi17gMbL0l0u+4EGRSLxmWZBUZQri6XfE9WX7Rj;25:iNazw2zsgDmt9+B5IISoE/UGdAjO7zzinEgoPrnDxAe8MBkdbDCRwS42d0VkZnl2rw9N8ypSVFJ6GCqBO1ObXLiZ5f9Lt9NnP0spjEiHl10Lb7S1nKiHjZAYAso7uUEme1OjinltoPMK9KVWrTH3Jc4/YeAYUBOZIR6KuAz9mNjNzTBi3KkETnCz9zKVvwYPNn7xa6A0nwBSpnvmvqEDW/zMOjkgXiGctCWHXW4S56DLHXR7c6DrIp+PxfxXAFWFeUITNSfj8w7HCOJB2MewOZk+MRicG//sgHzv0+vgqDBAlaQRMbBW+SN9rLB/3SnViwXH7GcbhBM2t8RNy2hFLA==;31:b9kn4Tjq6ERQB1i0EE9Em2g81dzL8ceCUqz4UcjKyme+KKvbCFKSHNSSAP7oaHmtSfy4lW/mM8IP7c/OPCRHOAMB4in6WSBrPFIe/WwbVsnSc0/BLjSYsTowY4agHIZFF4ypHiZvTxMyWEBdSJSg5MCvmVYmz+kL1ri0JKQmefnw1hCHhePdcOfv6AeH6pVBmzhJT8sW4niE9Jfxz07MrH2jCPqbzteJ5SD6EEdmo/I=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1572:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1572;20:caqV2Vt3HMddbBPs62YFpWa6AFtdShnY0nao/FhF1yG2iEUv4Tk2aEQB5wCd4IYhXU1zRLV8raSZjQpJJ2hiltpzMO24dFaQpI6OAVNschIJo22+qPbvXpuWrEKOXEDGl1VNGDHePyjkc+9SvvErivhFq1je5RdSy32BcJT1NP3vYIhXzQgIekI8tSgatv7lbU63sHBKipN05gO4Brhgc2GbQgR5dmBR14Esd7jRRYkhZcmX30V3vz6Pl29H2FNOrZd/FIaeCiQxTaIhGONMScFveH4sgtt3p4gJS4rEIInKib0SmJRAqVjHwjkWUIT/PZL9ay8MKYsAh0Z4cKSb86QHOtBRQzHA095r9esahIG0bg7mn8hClDFn4OMM5OWlHnc2p5Mdw9Op4G/3ttR4VgP82FU1sXHpPFUy1fyKWTmHqGFcV2ArpEzcKHXUchysjCBF73SXQQHuWdCqDUfNGI8lZPDglHJwNKk/F0ZmvGd3kfiv+/n1DEf8buKw9GP7;4:+s3AR9+Ma08UkpfCccS/wZBQfp+CfxwKoiFnCa/Cs8b8YNJ6Jcjdh31qwu29fKW4qrVCdJokzGV+xJct86RSjWUarb+WWC39PIvgrSKENOyNk+0a0YmXNFMukLNYz55okcC0MkBxpoSwuQXdoRMWYUK6XrqwLITJhTRbOLELOOcFlO7U5AvLGivs3nBw2GbvTGZzRIMTwximHSC/RkO19rAG2nZWrpkCnAYNDuKz0r6PvgfgWvqiYQFLPgDd+rMx76oBN7hV4tGA4TbgsULfxCFknYbhOITQbPu6y6o42y5IyPVNUxOx640EuKVTWThq
X-Microsoft-Antispam-PRVS: <BLUPR0301MB15727AB1CB0FD8738AAFAB8BED0A0@BLUPR0301MB1572.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BLUPR0301MB1572;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1572;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(39860400002)(346002)(189003)(199004)(7696005)(54906003)(6506007)(478600001)(110136005)(26005)(72206003)(386003)(186003)(16526019)(14444005)(76176011)(5660300001)(33896004)(2906002)(52116002)(446003)(106356001)(105586002)(1076002)(53936002)(55016002)(11346002)(316002)(81166006)(486006)(23726003)(3846002)(9686003)(6116002)(305945005)(50226002)(7736002)(68736007)(8936002)(230700001)(81156014)(8676002)(86362001)(476003)(4326008)(97736004)(956004)(66066001)(50466002)(47776003)(25786009)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1572;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1572;23:9u08ubP2LBACsxQlIO0qTMw24KTE8ro3CvVoUy0?=
 =?us-ascii?Q?nRvdOh1HVjsJSHuwpuucfJYM6OnPsDyzBBjTduQ0N85r5BA6ShBCAZLIwlck?=
 =?us-ascii?Q?x2SB1DveNEFoIbG1iLNwQsWGd7tEzKfc3pv+R11pRD0S3Gz2oaJ/S8++ipnt?=
 =?us-ascii?Q?EUXJlWhZUyAnQeGKGNF9pbHAaDl6KAMIrMjHp4KDOj8G9TWBC55LQuGuwBHF?=
 =?us-ascii?Q?Kdk8bN5rmWCpSePWjOL0MhNaGipK9SZyl+606QaMnw1FzohIiFTC34+xp7+B?=
 =?us-ascii?Q?sOnfF+2yzP4Nw7yqqT9zwqjauFb5HpKbIavU1DAnIihlxQsetU/mJ4S+YhO0?=
 =?us-ascii?Q?osnQ9EfxMOwjAjYHRgrqI85orbBxli453TyDPDuXHnGGBRakSovBiWIuPYPj?=
 =?us-ascii?Q?KJ478vWIeuwIXKuOIG1CiOI8BYX9m0shTUYthBIGkmUT7+ND3tsrRhbm32Hc?=
 =?us-ascii?Q?UzfVevdUAxBFkwJkp3FwZGaDRbtmb7f8mn5gPe112ruh22/3LNmChRG1EEeS?=
 =?us-ascii?Q?LnV/C9hHFLEM7q3F0EwVxfwoSx5C7YfdMnx16OUADr2uM9vfxNVJbsqbzYUO?=
 =?us-ascii?Q?VM0xGcawyIi0K3iZftmOG90CqMmf6TdGuswlAgsk/TOCepFURKLDqU0H9AJH?=
 =?us-ascii?Q?CTvZkJv3W6s7fAkAs2wVoIKixj8kxS0BwjidjW8BGHWwvl/NB+PMVRn6d+iI?=
 =?us-ascii?Q?L/QLHo/ovrVGaZyRL0w4JBPtzko+7il3Yyk3BxhcHXRKNCb1NAqVLUTjKKoC?=
 =?us-ascii?Q?M9aB+/dUIoyM0IqbhNL0D3lXmDgsfgIJoOO5PsIHPM7tz+QvUEoOPrXn3Tld?=
 =?us-ascii?Q?nUKhaB7SkiK10sdBLkoWJZMxS3ivmYjeimIhAbMFghqtMiSyualYqrUA9rrq?=
 =?us-ascii?Q?KqV5bSSM1NgYb0ebZzxMhABo0DmG0cRF4ZJ00rTXbYRFih5keFP+LWo7epEz?=
 =?us-ascii?Q?cGSAnN96UVh3fa5wT0PunTVa8Z6jBFlHoqCt6xWRPDv3xMQ3a3gmqQW9YUc9?=
 =?us-ascii?Q?3nh6bAXB6zEeSPYesENhoVNoy5TDDJ2RAxYbOUFObS1o8JFZmVF/Tt4kSwTo?=
 =?us-ascii?Q?CJ4kdGGAnyIHqfh7LVl0gvtlwTVqNzvrh71qahKxKkjEWISlSE7f8nJJeQbX?=
 =?us-ascii?Q?MKe8QnioYHp9wpg6zzGG3rDNm4akylHP54VssPJj1tuZ8rFmyxGIXTHRqxr7?=
 =?us-ascii?Q?sVsRYA27fSf+4jYVeiyAkSvDgecsGCTcFTUuH3Fjr289FPP4KVVAkVSM3zIw?=
 =?us-ascii?Q?IrS8Lwx/9fIqPZtCJV30=3D?=
X-Microsoft-Antispam-Message-Info: K09ng+RN9Jw9MslWrEgwHBNy2C1OmPLzI/3iFkAjO43rapHSsxwgm668zL7YXNNNa21G0H2LSYPUvPNTyy1Lre9mD38wwD3THc80MvgjAKam1iswRnQM59OXjd2MqGIlnIino8/Nsw9A1egwQjq5zvromxc3rHGCR9Q2ZJSmaZU6QSP5/gKHIaGkO32sxmkHlCMePYEw650NTSz/qr5YMM3ENttyRDRmPPOmt15ufQ0riSpWniGAKnIhkWyAaSL7f/mj9HRZVR2KM22c5Q+4Nk1Z2OoK5P2VAcT0feduNeqR0Vgom7BALfOqqn0ybhZfCurN3JCfw7dRAm8kXUDbMNjMZQvrKXEMe7jQXLQcPCI=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1572;6:XV0uawrQwcQf4yfU1N1wHzM+3qSBN/FoAguzd/EYUUEs3qjohK3AOmXyaosdOF/pP+ce0Dl8NcRnK8bJFFGN5EHYuYnI32IcZz0VG8wn4svMdjTj02TnvQ24PAd3wKvMrLTNzfmHDNL4wLNZ8gz88Q9KP9z+vhKPBy7kGvW2xuBE3v64LuKsZHYh61Y006z70kv2QGJwlHQ5cH2fhLPPLIaz3gS6avS41LBODQs2dXDUzIsZr0fHtqKUghHV9EJFp8XJ8TNxt+cFDnOMXDi69M3CA3G7uP5FT2k2OTZ46OLt+PaUrpZnun7QWGBUapv3svBghTz/lWI9QHU+aMWakTF64j08RMaFn7WhaLXq2oFTisP0cMKCjADvOz5n0VkaWB7gIbW76S5eApWwO6xrNL68WzscM9YNHjwjMCxlC4mX0ODyW6bMnFCMrNuewxjzz4pg+gMn63JHPKHm05OmKw==;5:SwDZQaary4aySxJwj8vbEns3yoxpFiX0gKHoLzcAGdJx/JX00wLZpOZHCsTic0ibd40iGZ/f8Kx0EAEWYxWWzXKNG7eZ2DKsVmGIm168SahhovAospTXkNNuevqSirbdf5p3caynbAvEVG2W5Urp6oX80arxaYZtBFlfZz3l1tk=;7:zNYGX2QTPP6RZWyHVBDf3WZzkbGSFWbWe5KS/BZaFcN18TheEzy6ZQIb6H3mSZSZ0YbThqonXv6RMquS6BZcL5loPiTYV1fYSc7uuLBwbWXM65xgp2sEokWzXybv3GIQBuMT5PM3b/JjrUIF89bOiu8qTbtuZSXgIpCE3eYS2fsKDZ5CWbtGsAELlDc57S35tQiEud5VRhpb5+IH8z1WvULrvqUzpMUh1yvPDTTRKEaRyHANKxPzlYE0iM6d2Ggg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 09:50:24.1642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce65cb5-1e2f-4171-b878-08d60ccbae20
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1572
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

