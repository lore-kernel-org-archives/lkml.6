Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818D9C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292F320846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="fXmEopCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292F320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeGZI34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:29:56 -0400
Received: from mail-bn3nam01on0062.outbound.protection.outlook.com ([104.47.33.62]:4026
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbeGZI34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBNdgngxV6F5slvk6l8KUn4Gw+nIUof/U1bct/+gEzA=;
 b=fXmEopCX4mABPyVvk9vh4L+fVKlq3mWoef2IGthBeJ2kUKECQizKDyi5ykeH/pMJ3X3OsdnQR43+2uJGO25elChiwj4mGABOJ8k/TvippHoNVi3H8Q5TT7+Gz/SnqBsTGtwI5VTIB+y/wd9Mg2aATHwr5Wv6BBpF1qx0JY8VGUA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1583.namprd03.prod.outlook.com (2a01:111:e400:5232::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Thu, 26 Jul
 2018 07:14:23 +0000
Date:   Thu, 26 Jul 2018 15:12:07 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH mmc-next v2 1/3] mmc: sdhci: add adma_table_num member to
 struct sdhci_host
Message-ID: <20180726151207.6d8898f4@xhacker.debian>
In-Reply-To: <20180726151017.4da1e336@xhacker.debian>
References: <20180726151017.4da1e336@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0129.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::21) To SN1PR0301MB1583.namprd03.prod.outlook.com
 (2a01:111:e400:5232::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8042e27c-022a-4c7c-3830-08d5f2c76b31
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1583;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;3:EEt/8wOGbKDPia+zkKto4BD+4JP/sEz7o9io3eTe9rU0AYfu9CDoYh0iNr5VaRXCHwtU20VPLBAG8K/oSsTyzAPuWcxFo7eMtpAeLQMg3IO8EmQDPpca9dOTyrVWevjXXfaHY/G/6NXr9oPEKGg//kwxSa+fNxmMJPWAH5OVUuQyrdDSVQcFRIEj227TYFbRjVaPczr+wyv8UgER4tUhZQjqalfpSlUsyNhNc0l19wAKM90PfJIyB2f0G4tRlcmQ;25:v5SEdIGJoKh8dhK8Yx655FusTCceTHc5k8CvBjATTft9GsKeDlzDgKAobc7kEPh3A1Iq02jGgmReuhdS1jsxZdmvUAK0J2eYnB1fnyUtEJK6N4x1nrv/+Gn7K8bFHSpROuEvGKr3XnvjqGgtjDcr7U+sD4rEZMYjwe3spAwzP9QYsxHDDL6RL2YP4C8rqs1qFfBL29u3cxj7arSiO0L6l2jtmDAhIpUkKFlerqETxj7J7DQ9+8nAtr9cSolS6mkZXc/gZUMTOt2YOueXpWneIBE/ral3QUaq8oSJCbRU0MQ7mHhMLNaUdb+rRT2UhuBTrvj3zG9+xN7USn3MuuLtsQ==;31:L+Iv2DAtxEQ9NWFYO17+d8RJUSq6+LABRTFvTVs9oSJ/Wz/XNNS4y150zUFmXsNgZA94YbPaU7O+8Dkw4uch6/ym4o3ZfDiUU/qyiPTMz9SHyeuTtC4OCGafYwLhdVePviTS62XbrDbsEoggTp3wwD+WMyEPW2lHgCn5YKrB0C4LvqgPhlDbH1f6BBp0dPMA0Pl2D2irl+y2rtmDOFPkeiv/m9pBIkznYoNoc69eULA=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1583:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;20:l1bzqzRHF5NSelPOiN+GsmjdbuIjSl3qysHtnvGbtXLPueyByJ8vzybEc48ddEWJNY14y6ZAOKETeHBton4yoByJkJdADUNXxkyorbwsUNx5MfnO2ssaU3GMhuWVcwC1Bwcu57LST2WBvFHodW0LYQMXcRzLFzc0UOAhHKPDm/hb2i2kMgm4eK/JiQgW5m6SWg+dWaR2EvqRpwlG/KPc3PFXRdCLe/8h4CNqVqE/epKfhzmZ0vla1FWqgaXx7v9bQFd72CNGTd1qEZE+74baltyeEesB3nw0iLvaMwpaNbkWW4Rc16khOvyXNyPdCmwKqeZFp+ovd1Cto3uYr3kDaa1o5M0rIxsU8STjvPdxvh19Gjfmdexbe9vgOY9YKLGzphTJgGrvm+qMSyNW6sBbTnjMX1nMGm+0c1RIkvPCFTIDKXCBYASrthnJXoKcQbtCND/V5+/AzgG6dkG+c64Kb1kqzwuiQjXppIfYkx5z0kkZ2b35uZ3u4n9L8LFhEDa/;4:Du1Ju6g2Hg9QOFfcymY/gBjxexFDLg2xrWY3HSbA0GPFmMj8vlZXsJA0v2E2jzFXGXkYRX3ypA6517nrp9NmzEmLjMsFb3Ipc/k4K3FkO0SVeQ+2tSx6wU0IRIKGPDE0wRO7FK/xzTILzivz0hG2uJwTPfN4wFJJqKYAERlQiJ0Rr338y/fgFfolxZAw7HFgrfU7svZeU447xPeOhBeuF3hXgtdjqXVJOi1ARv+YHLhyGgitYZDU/VMncz6px9/LecaUxGptpwuVJGFH/e0Ong==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB1583087BAD99596563D4D67CED2B0@SN1PR0301MB1583.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR0301MB1583;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1583;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(16526019)(26005)(5660300001)(186003)(68736007)(486006)(2906002)(97736004)(50466002)(7736002)(316002)(476003)(72206003)(86362001)(478600001)(11346002)(305945005)(6666003)(110136005)(956004)(106356001)(6506007)(3846002)(6116002)(9686003)(50226002)(23726003)(446003)(4326008)(1076002)(55016002)(33896004)(105586002)(76176011)(230700001)(53936002)(47776003)(8936002)(66066001)(7696005)(52116002)(81156014)(25786009)(81166006)(8676002)(386003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1583;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1583;23:gubZaA1GcO4sOgegN4wAxzQ2crdzo2DaJEdy6hZ?=
 =?us-ascii?Q?Z35UhRZXFV2vNO7ipQZqGcFQ7MpEdhioM8KYdFANf6Jdf7dBMDpu34M/tN7O?=
 =?us-ascii?Q?8o1m0DNL+A7RS4UIXgnblxjSVTelGIMMpB+uNNfzqpZZi4JYBtrUsPwiA7aY?=
 =?us-ascii?Q?BChjRywSJcqG+i06GnbNDfSfm5o69mm03+7GkwJ7am6D2AV/2oNHbyF4G28m?=
 =?us-ascii?Q?xMGyIC8VOFVvTTtD9Sy1BsLBwNdA7qo7IPpVlVz3csZUCNqucND5NiQjz2kG?=
 =?us-ascii?Q?TuBfg7Tjkme76IzokX1UWBrXvvNSK44SCs3o2obPffggAPtKxrzoXPmz2X2x?=
 =?us-ascii?Q?IYF/P0TZ501LuT3Q4WVKvMxliR7prD6Cu+uOn/CgyQ5euF2Occ8VW7lg18gG?=
 =?us-ascii?Q?+DoyZ7Tnle/pvepaVL/rhxJT1hb0hfgx/yAiUqyK7VEMjV0w1UX4wVbEi2yC?=
 =?us-ascii?Q?G2ZEcxzVdFoAhmmeJbV3Q8AhatEvAIM0WyD3/2JvUyrsrhk9v8BdZRI1Idh4?=
 =?us-ascii?Q?Mw7QHwx6nZ+z33bI/ccwE3K3PFHjbOZ+BZludaRzO3wcBNJ/22yp0XAM3lEx?=
 =?us-ascii?Q?MkI0tM+25lJ3PADlERRxEuvBeRdzM4qHQMQrvCERkRRAtbqr+chHF8P9OLxo?=
 =?us-ascii?Q?pNN0lrec+vPp+4kuvI553a21ie0311qPaqCEj1BIjavvJRb7K2DP3c4OigTc?=
 =?us-ascii?Q?JPdTPNAXGYHH8FP605fsZxq8chfJq+rY+yY0kAMewgTcXiyU9y5DgGVdHuYT?=
 =?us-ascii?Q?Slz8XP6WJiCXgcRM3jIVIDppgudm3xRqpUPtSZG9nikPWlXLnzxWy/OqJFNl?=
 =?us-ascii?Q?FuG14y17CqHsFIYEyEApCi0+UHWfLOhjVIkIQ8MnbusQ5AnJ2wQUNMLkcJ5y?=
 =?us-ascii?Q?7GWT0cSbDJew4chSG7O7oxIYvxa+rYGFgUWj02HoFCemjthSkr8mrhwzDD3t?=
 =?us-ascii?Q?xVeMlLykR8kDXFIcJNGBuDX5BByLAGHgX7hU4dU9OKcRrn5r0Q/LoAtg9jJC?=
 =?us-ascii?Q?a3EP+JZiwaO8UPKRNtnfHgnzGpgg96lA/kRl42GL8OrWeefxIlzCqIW6fi7n?=
 =?us-ascii?Q?xcD5y0EximrZXqbXTgJx+mvyYC8W0J8NwrB9jPIgCpGhathTkVkB7VpLjgmk?=
 =?us-ascii?Q?5Qu59OmjGU+qnAftH1ncd8Ko1AZr3KtFVR8RlfrQDLFJj5tXAKYFahnIuxr2?=
 =?us-ascii?Q?btiN4yna0we1glhIy0i+nZ7Ck0OhI//6a7Abjy02S7oOxv+PqK8GxLG6y8g?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: CIC4yWoSv4Nqa3WGRwdO2X3VqG+If/aF7M3Z+JAjDNIv17X7oHGCil4fazjQHJHJ2RLvT2aV+Bt9QhZxrSnUJ27fcZ0NzAp6G2KyBd964cCNUcruV8FYdEqrh4jSaVjssaIYGgXKHbrwFYedS+yGoAKnFh5tcaOvnMcJeEY2p8U1N6F1eQws+8SoiRYXadgXHLXY6njWiOKIg2FhAnjINU5ds8Q+BySq4W6Sntz4qZgznz8M6lHcaM8FcneEzynI5NfRO8b8IG2unvEW6V5u857Icfd24Kt8RhmW/A8p78ZRaraTq+PDxDDBcKW/NITkiGxQyd3L/C9aMNitLyIIgTpBkUnQ62oHJBQwYSQ0fNg=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;6:MHqPbmxrkHAQVym+L2yhcQc3LwCJxBZfOHuIwL8V2doBrpU5vGAoy6euK2k4kXLCdsA3sjMVT9yW4YzQyuwVdiHYGJV1opU83578eEMflSbul7WNcxjjJT8+4IxoGs7LYIS8GIHMjAGSS14THLUVU/l5LQHMXQOv3Gd7RuXn5x3LZndfyZ4VFsWdDIoFFCdM83HSlvyqXBliv461/u3qzq7Dy4fcDhAFv/K0cQ+Sk9Ut9N4VT3bUb4kzxaWzklhU2KKH1qCONCDBuTV9xE8XMCLouRwxv+Z+8Pnbvxm2v4B+R1tDoT3GJEfn/JVRHxIhdS+LPP+xzkXncMKPNzcakYcU3vumWuEMQZBueYxK7ukanKyTNNNoMissu2eCSk62M3XVsuZfqRDPtJuyKFkNoBlkHMVZluFYDuNnwF92CoJAICW69shpMY1+orNCF+ZY2k2++vNzkaYdlKowWk5Qgw==;5:N4m6Ba+ZLAYHgzV9+8YcAU/qJk0mKsYKodIAzLUiG48q8p2/Aau4IR2ziVuddjaKbBMzBpDd5nkAzpMOTT9vitEUQmwrGoBmQ9mpqi5oK+1oU7frTFn+DZKHVY1T8UZpDuoHyAYi9PRlW45J4vbzxwV0XBDyuV1a/uw+yzLFezs=;7:VmBrdlJVs2AgPPlx3r672CDd/GdKjlRz7+O1qRcx+7fxM5wk5ghwWELj9ktWmWf2CkngsmfRIdDTu1WAoznvHGXVchLiqwZFGjyGglogMAGqFkJ/TmaTaiJS6NUu581tJdxv2U1nRKYQUw7qO9KQeRO8Rs+qoDa9jqiWj5ycLkefHKGzTO5iQV7m0CWQVg+VThAPJHyuoN7k56sfU2Aj97Ag/5MHDiAzmFs2uCjk2fCVcClU1IhVr8tTgDUJA35+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 07:14:23.9183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8042e27c-022a-4c7c-3830-08d5f2c76b31
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds adma_table_num member to struct sdhci_host to give more
flexibility to drivers to control the ADMA table number.

Default value of adma_table_num is set to (SDHCI_MAX_SEGS * 2 + 1).

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci.c | 17 +++++++++--------
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a7b5602ef6f7..14dd4a49e03b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3316,6 +3316,13 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->sdma_boundary = SDHCI_DEFAULT_BOUNDARY_ARG;
 
+	/*
+	 * The DMA descriptor table number is calculated as the maximum
+	 * number of segments times 2, to allow for an alignment
+	 * descriptor for each segment, plus 1 for a nop end descriptor.
+	 */
+	host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1;
+
 	return host;
 }
 
@@ -3561,18 +3568,12 @@ int sdhci_setup_host(struct sdhci_host *host)
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
+			host->adma_table_sz = host->adma_table_num *
 					      SDHCI_ADMA2_64_DESC_SZ;
 			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ;
 		} else {
-			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
+			host->adma_table_sz = host->adma_table_num *
 					      SDHCI_ADMA2_32_DESC_SZ;
 			host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
 		}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f887da6..d55fd7033e93 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -563,6 +563,8 @@ struct sdhci_host {
 	/* Host SDMA buffer boundary. */
 	u32			sdma_boundary;
 
+	u32			adma_table_num;
+
 	u64			data_timeout;
 
 	unsigned long private[0] ____cacheline_aligned;
-- 
2.18.0

