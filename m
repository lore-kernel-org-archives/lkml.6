Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C39D21525
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="imyrJaoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C39D21525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbeHWNmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:42:49 -0400
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:55712
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726676AbeHWNms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bon9+liMmvla43DwIjLyvZGi6jeqHc3DRek38ffmlY=;
 b=imyrJaoTZOlwV1YPuEhIe/PO/fFGhBIzhiwChQseFl5Z5R8db7Fu9rxHUnfJX7DpRn/OolRqjwAD7irn47iWNzDXneiCUbq5H5B9pC/5Mamdx/gTuMJIb58zb4d5KB91PVAM6GJNf3ySyvKfB8Yqn+kSy4EIGJANZlTpYNQ6icg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1579.namprd03.prod.outlook.com (2a01:111:e400:529c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Thu, 23 Aug
 2018 10:09:53 +0000
Date:   Thu, 23 Aug 2018 18:07:00 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 1/3] mmc: sdhci: add adma_table_cnt member to struct
 sdhci_host
Message-ID: <20180823180700.3432c4db@xhacker.debian>
In-Reply-To: <20180823180549.78e508db@xhacker.debian>
References: <20180823180549.78e508db@xhacker.debian>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0067.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::31) To CY1PR0301MB1579.namprd03.prod.outlook.com
 (2a01:111:e400:529c::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71ac459e-c399-4fc1-9af9-08d608e092fa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1579;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1579;3:p9xsUimXJDeEgOzpcYBM/UAWDso3YHMAV6nJxUM1j2eczos+Q91j6BMQRdq56gn1gKYpYHVRu3AdJwWJGL74b16GgvNxY11SS4e/cv1B3Nh0hDubpGdlc7QlTQYS8y/lxhtuJXFbe7Tt+XO127E8pXRKYZV85p5Wh972amP8VWDNjE0xaORcJiGklbr8YMJ+Cg6qopsDuagTn3haU6Juxe17N+AwSJ/oc86CDZ6KT+ssIi6zn1zT4ZeJNnytNlVh;25:dpaaLr0TsiZjSAHNpIu+tZww0ovs6NURUEctMQbRYNJadmy6aI/pOHqMlq3Xt4xaLJTqrXYKENbluIlTZNsX74pH06VtDLF6kEkgH3RGkf5fi1Na4gWpNT6IP+bC+DgkUyTfvxCwNhIiDRrCHmES35wTi1yxIKOG61OumkqU9NajKunAk8lcuaw5mSOvnlX8Q+a2SFWZLDqGN+aeaRujlyWZFOFyUGthbbBBk9H2XGbTvQBypC+yTMxIqtz7s+bW5zzRUcZSYETBHM/OhXl9zLtfNQr5MI0moH6CeNq/ICzMMXKVU0hn7VO62VKVqkf1nJt/KoERGNdZ+B/4EveQBA==;31:KHGp2l/ZVyukdlhylGUfautZwopcR2YRlEp4EzHluxP0hG/P5eRtBF1oP7NN9R0h+8A5SPi0H9Fd0PfytHXaJdz/wLSPjF7Izcw+6y4YKxu5hcsr0YkWeyJxQUnHqbhEEDO9SOtla4x/+E23TWBKl5CKm9sUEzcH8M+m62U6Zq06UTVubsjlAbBbVr2kvK5FP/vEp3eY9vmdEOuWRiO30kV0YlYkaSaZzFMNryJhOJU=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1579:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1579;20:lDgjL/otj91Be033UZzsWf7h2ej+Adn6M5GVU/LacZywTPcrfHTLKqc/30vJU/Lh6PDq1OKhmaP8S9RK+lDyZXktFICIwOyKM0IbznMo/sic+FIhyjafygCBkSbSl1m24HsCWmM/HqKt9Te7ScSJLfl32Miuj4L0Yqzj29ZqY1G9ZaK4LpD7/P6hVP9HoUzjV9GxDfVQlXNn5OCm4zrHJiGuNfQG32yVhTYuosxSbcdPTuLSjzrdX0SOPvr+eB6fLEphiCS73nlguXCruaWPBYo1p+aIj84Pr8mNoAZrExoWHCvXXK3OzKil59MHOyQcDL3ZzWwy9let3Hc8B1KRGuap9t9L7so+SeZyUKl7wDbg8GQDFRkg5DlU350lgnN/HbgTP0EOHjEt75oqo8O8/CPou74bi4jlt1cyR0FCQ8M1XH7ARAAZ2S27IswG3BJW5ILzfPxRXkcIWhP4dTWKdUoBMqp3KxMOxl0SQc8gnT8lti0kS59MBkdrnFTbnrST;4:Nue+9A5YGAh3w+7x4bY4eeL4jxirf6KCUmLyexZQq7vUMaNoc80KLf8+mmd9xERoTmKXI/9daQ0KyPSPlKjLLh7oeGYtDRw/UmxUagSkSW62Drch5FrR462Cb9zzwmpaGq8L3DvimkcUa87CVM61sRpRUB0Csug/xBxC/b5ipvWXLMelcisQyqVkLvLvwwirUIAlRDY7M4Xe54VwLzBfXVbzZCcOOVh98V+K3/XtIJ+NQ5SW2N3MifBWAN6zpYAT+C7NFzUwj3ufklh5dtFdEA==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB1579F70C9A9C81973146CDA0ED370@CY1PR0301MB1579.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:CY1PR0301MB1579;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1579;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(478600001)(47776003)(66066001)(72206003)(55016002)(9686003)(53936002)(26005)(3846002)(575784001)(486006)(1076002)(7696005)(52116002)(6116002)(86362001)(76176011)(50466002)(110136005)(6506007)(386003)(33896004)(54906003)(23726003)(186003)(16526019)(11346002)(476003)(956004)(446003)(316002)(2906002)(8676002)(7736002)(68736007)(230700001)(105586002)(106356001)(8936002)(81156014)(81166006)(50226002)(305945005)(5660300001)(6666003)(97736004)(25786009)(4326008)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1579;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1579;23:uUEpgc2xeygkF5Hm1XOUFMaMmgOrj9f8vgyLAJh?=
 =?us-ascii?Q?t5zynP8SajQOBZUqDz5ma56yfyPHOKIr7Di/M2S5ChkUvxife+3k1B7TA3We?=
 =?us-ascii?Q?3N6qjmVSlvUdcre/VXpUdk0kJnbV+tlOlkZ5jYPsGY6EFxREgnY1nsf0X0QW?=
 =?us-ascii?Q?jDsSY/G5MxIylgeEURC08HW51P39PadmsWbNz8BVCBd0BNVBO0dMKafmF8/g?=
 =?us-ascii?Q?Zmu8Hk990j8UouLu/1JkbreMXrmQmar3XDMw2+7rpv/vr4twvvTZdiK0VTJM?=
 =?us-ascii?Q?EzOVsJasPvDQTdOf+p2s5zr7O+WP99QjdqWyola7nLlO/J6z4XeLMaT5ISpi?=
 =?us-ascii?Q?dpdhIk9qRr1UGQ5NWwGxaJvTdQiGXBXv68rN3mgnIH5/Xy0NSmh2GQXdCnEJ?=
 =?us-ascii?Q?vfJCHAGlFq/zVQYlwKEPnMxptofpgRoRXJkJPbHMNyq2p7Ay0rUWvO1Cr/7s?=
 =?us-ascii?Q?qi60jRBM6oBH/etw3T04M5BGjJ0IJPh4ckO3yBzU8+Hvh+OP2W4H/zAEZHhc?=
 =?us-ascii?Q?L+vgJBSHQ/vHvMjKKLFU+3QWNrcHp3oJsVllpcO2oGHYFR0Y1da35+H09HVT?=
 =?us-ascii?Q?bxCc5JEiJCRhKMWPXrQOvtKwphFYqIoXJIigMzkcxnkIkJk6XTTvdGzX8p5p?=
 =?us-ascii?Q?Nb/j7CwHUU8b4mmvYYbZzZaE/r+Bm9AHVKPRWsz/D/He969BLO615+SHciDf?=
 =?us-ascii?Q?h6Nq40IqHtJeb6GY0Ofss8OQGBk+MPGFT2XuGdawxSGdrSkib5KzOaOD7t4X?=
 =?us-ascii?Q?5QPmGB80aNr95eKmo81z9YIta9B1z3BztqcpFw9Eae0MfgsTAMbIAf4A/g89?=
 =?us-ascii?Q?THPCcPQuXPNGKifJh8iH05nIUso2eop1HflsAGD76oiO81uEA5AVm8et6NQC?=
 =?us-ascii?Q?uZDPQzH0rXWA3hXgc38lsJ0nO8C0o7fnSpuf0LrKo936QSKMpt8OsJQqDCpS?=
 =?us-ascii?Q?NdN5WKJV2c8ik7laMF26GgGy/k5FdPbn+hcmVAaJCQmpVBCtOjE8af0P8hsU?=
 =?us-ascii?Q?Y+lcUKFXsG04NJIZJOAYGFEgqLH6lOC/2BAgkPy9c38uvFboUlbkuLA4X6iu?=
 =?us-ascii?Q?KutTAOlQmD1RB50HXoPZYLyny7ZTiF0F4cJavgIcVeypCBceYN3zkRo/a4vE?=
 =?us-ascii?Q?4e9eSD2BmslEP6oX/FvChly1tHoL1juqhhcCrVrxWn2Hb1rKWZOfgNAHKxZe?=
 =?us-ascii?Q?0dNmQNanlRXa/OnMDaV4VHZwB1kmprj4MFx9sXA6lK19Y4CN/S0wPx9Cwsy0?=
 =?us-ascii?Q?kZWIlLsHEDrplHNdyhueXbXRvzvmg+U73WN+UfO/R?=
X-Microsoft-Antispam-Message-Info: qCBhCejDCmgp92iX+kOe2L7d9BSKRnehy2pOTinw9EW30B4jCTZuTtIq+s7Xn0JRz6s69H9Fbrpwqb8NAbHALlij72SgLd63Ah2j2jY3Xm1nAdXUOVns7arI36e89ZpYxbR+MT7AhrX9yCk58KiuN34dmGpzvUENKUdBazLPnBQZSGaByXXHq7kX9SmCco4JlcUb/liVilwzVvyDZzs0oriRkeK0EXQlW0UVAr+jfqXoBNsq1M/B+uEx1yk1aGJFUMD7mdAaJaIk5szk+p1rGcMk6Nb5qQITqyUxysE3NWaoSg7SeCBNQYvcKJknF5E4N7RqhT/ip7VMUJl6zfTO9oXU7jvpb9emMj3zU4fhULU=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1579;6:8+/Z5ntT7CyDsr2cBZ7ow4Qwahtr+lxP5pSTL8YbpTsY3nFi+2V0kzLYr0p7ywpyvkdZ+JWblI+BnSNrwrpP21mcGK8cJJfQpOUM0AO2SG1bKr6iE3fkKkT9diu0mgFGzqeca9hdr/FaMitAl77mXvA9aBc/n49uWcnkNVMBlo8w4yy/xmmcsbLhjF4wWRELBes19zSE9J9fE+I0GumkOhDUQA78iqkITzuJwQGa+P0ZlhpDDsq+Z540w7cnMBnc/kt4xwStKvJkrpl2/JXP7+kskcEe+9ZRWc+Naunbhri/Z1A2S0iqsxRJu+jhoXa744mPqAUj7ysq7G3FWhMv5WTseRsTpUHuv1JQ9a8GYosK0M/tvB2x5+AwNqzxRWV/D1VXWgn5FRnu5U05sl/17qV4u/7OiZ7Nv2T9p0oMRKjPHmfqOIp7CJ7pljEqBuCP8QLRSSVVW034C3hc5lAzFw==;5:3Qhk4sk2Cq+qWKk9a1xedehdDlYRP9rYYny4S1occNsiH98BmLWjC+vWJTYargDC8OzqA+ZQ4aNAVk7y/35TnE5I7qeVIlb6FM5RMo8l2J0OVCy6s8J3pQuvzuSMTNQlYxvN8cg1cusaukCu37ogumdHqk2LySybjjQZHYkKzlk=;7:06vqGp5xbyEy+mRGIssBFhh9Hd8wXtQ852d4j0zS8idhnEqFx03/OHjRPWSPRSHPT+7gXPdDJ1+uk4BNmrXVhxY6GJJo+aCdzTA3m3t4DS0BKcvIDlviTO9zmrUmRupb+dnn9ExkAy/dxOlHhhvCuiKNiYF/SkA61qFDYmqh6Tu/d24KfCQJcjSKenRG3djd8BU1WMNJl7CiIiTvvD2oT1HBORLyqvZoNAJVW8iZTbaVSlNN2wNFnYEhfuIiZYP9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 10:09:53.6798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ac459e-c399-4fc1-9af9-08d608e092fa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1579
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds adma_table_cnt member to struct sdhci_host to give more
flexibility to drivers to control the ADMA table count.

Default value of adma_table_cnt is set to (SDHCI_MAX_SEGS * 2 + 1).

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
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

