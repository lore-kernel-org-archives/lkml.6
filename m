Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383F1C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972AE20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="eoFchRg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972AE20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeGYLBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:01:05 -0400
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:22080
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728699AbeGYLBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7iafxf17daJnbA03X1L1fF6SeMmbt272IvF7POJpYc=;
 b=eoFchRg3NzYIQ0WdNO6Mth4v3mxjG355cc6nHWTlybcR74xKrhddawP5dBBoaMI/FMAls4Rc98aIeTSPI7jj0SQ5j5G1dGZIQlF3J1Fmz3w0kWYEsSqEqzL/aQap7NMYqclWehtKz3N/D/mgW/xTbLvG/47uu5XPtZkFCmczDJs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1576.namprd03.prod.outlook.com (2a01:111:e400:526e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Wed, 25 Jul
 2018 09:50:04 +0000
Date:   Wed, 25 Jul 2018 17:47:49 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH mmc-next 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Message-ID: <20180725174749.6fc97d4d@xhacker.debian>
In-Reply-To: <20180725174235.1ca764cf@xhacker.debian>
References: <20180725174235.1ca764cf@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0146.jpnprd01.prod.outlook.com
 (2603:1096:402:1::22) To BY2PR0301MB1576.namprd03.prod.outlook.com
 (2a01:111:e400:526e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80c3348e-8b89-463c-0266-08d5f2140001
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1576;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;3:WRSryKkG1M0L89vwWwXE9v2biSVpRGyuLhyM46cvAyNfXrmisO6CNEPJ1QEQHhdfAiFqXxNFNBnGXrhoZLxnAf9IRS13qQ2jjWkWla1f0xDY3D9lLggxVJuYF3a/kxDWtlp+otnGO75KWGPoMIooujpaCiFaxdntU66xLPvCM+GYUiM60Sho0ysSSCd7KgrSRkq2zIpk56B96lfCPeEQL/oEkRxagfgF/tBZvNIF8HEPCGSea4MwTFZ9vVyGXAM5;25:bNGXlC5K5zjGbNCwoPp33i/nFoneW5lS2KtGrawuXDsO9x7FsA2LrVcc2Yj2I9GfjDA72LfuTxlNHY2VheqlwEZvVSBNmJqOLLOp/tenc0o0Zguv0M3+weAs5nOqzAkNZxVWm6NtkD8yFqoZJRGTCaNIxKPvXlJKmprLmISssSTJA81D/9Yqa+Hj5MdZFi8afz/fLP5DgdUYeCRZ+tR9RgjSIQmE8JNS3oyFOisMXKNlAa9COuSDTK5Z+rACi+jTvoTTFKK5UDltEp81EcJf+RAOkX8e3I2ikx4NBbZXe0Wari2FEnhWkJjtdpixhwbgeDhGnF4tMIUJSeVA8+H90A==;31:Fd9+VVudR7KCOnf85lklENXCEKI+15+TA+94Y7iy6j3HjHbeYsw1ZWGWdAhM4zVJ8rTXDYjhAUJPCDdlLa3SbuN+lg5RLDP4ymM1LJhIVBLWFEOL7L+HCMm7DpUVE2kwDoime+MMSBHK3TPfF9VF/lj+nWUS1NfmwnPYtn7zYUo8rau802+zi8py8jYfdltZe/dbey1UlclONlk5SWnYzGpnBsr0cOkSNnibNBhUtkg=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1576:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;20:lId/jwh386+D77SGr3T0zvhjhQgt1B6aBydCPoFrcZNSsiAZq1sC0TvbSj2+Lpws5qxiVce/E/Y835Gc+gcIRiHA93qA+ZE3nLHE3tzFM0IpmCVVgkWhwtoouH4hvJfs4/aTFog3C5O4VrI+YPnd9hqYPpLV2ws1jZhS+OrdoLLYNYlz1fGTi/kwayG5kLSGVi+oEB/hbdgu/SKouXUZn9qzt21MrA+T5ju1/+gRPrj14wAfzKNKgsgJQzjEj8fa9UESF0m54w4bgQXJNrIjAzhlYFfrSvy8ZELT1ze0R2e56f5PZsJt9z5HOaJE/uiJG6D403/HDJOHhnHNY+EhGK/E1OyCXHbFlD4geIpYs7/uxhEpOldFWEJ2Oy+PYU/2LH+BhtODdSN+cUBMdl9uYFdGz3Zx8RKTlSFPA1HnwXHSmpm2iyxlA72PhHzFVbIyNOK0INtLGL7HRi/OaqogEvMUOhfU/FlHMZQggMO4VHhEazzpt6cQs0sRBWxulKfT;4:LiV/oqVZA8CX6zcY/7Z9YzM8cYEwjy/AmSeBluWUzlUoLOCLPpcIWpMER026kx5sosMmQ5qRso7GHXqfRKyMDPH75RKhag9AJJgJOSe9UOJaENRDKHysidCKK0/344N/+Rzj4u8Yikk75q/bHQkH1leVPoU0MZQwi8yWdkR68n68TwexnZxZSNLNqzTPh2wEoqaaX9f4ZUzj4Bxu9bGTC5NSE5nEWZcjTqXTKGi3tYCbXgbmYlSiHZgWALabzAgN/IhCUSW/Y8NejnjiWwRliA==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB1576D45EED5B29AC4ADA7887ED540@BY2PR0301MB1576.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR0301MB1576;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1576;
X-Forefront-PRVS: 0744CFB5E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(97736004)(50466002)(2906002)(53936002)(105586002)(8936002)(86362001)(956004)(110136005)(106356001)(47776003)(305945005)(8676002)(81156014)(81166006)(6666003)(7736002)(5660300001)(66066001)(76176011)(1076002)(68736007)(230700001)(26005)(25786009)(55016002)(4326008)(23726003)(9686003)(6116002)(72206003)(33896004)(446003)(3846002)(50226002)(14444005)(6506007)(386003)(16526019)(316002)(11346002)(478600001)(476003)(486006)(186003)(7696005)(52116002)(133343001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1576;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1576;23:SLhR+/xNf3FAHvshbwJXYjcFQkMXExORfVUXTu1?=
 =?us-ascii?Q?L9Jq4iiB1crLU7ZFDk1Y3M4gnzAVClnxbJ+ZeqPS5cjAogh8gpD9L4OBkWOj?=
 =?us-ascii?Q?/lhPqC+PtbwCi48aAiUohYiez6FdYyk34CGyIXVcMdyPQuAph1MbETtMZL+7?=
 =?us-ascii?Q?cVWISU5w+52OTcayg75my7FyDxkweHM52s/fj8RxITF381lP1/gFFwmIafMS?=
 =?us-ascii?Q?OI2QXM1nKKwwNnkWzAzNQhim6eD1Fx+6GK/b+GPsfw37o1yiKfzvIWISHooJ?=
 =?us-ascii?Q?ZdtHZLwdQ5u059ftNR6cfpN7gGWaHOQcYojrL2i/dPTfBy6Y0IXx0c2SHL+A?=
 =?us-ascii?Q?4hcOpfzk9aXaiANySM6Vd28BR2EmWsnCDUA5qAiHv8I57oWtvGyZ9aZOt4kH?=
 =?us-ascii?Q?8zU09ZLiCOEdLbYTyi5OLQqFjguWHHhFd3H7i9vBUeZYGEUVFmfNi6NfbtU7?=
 =?us-ascii?Q?QCOQYl/hwyiIOxSy+gvyKQyIBawVvN56oZbF55x4zWw/aMsgHfkfrcU2cmBF?=
 =?us-ascii?Q?8MluAUwAgDpIMXP93+ZjCZ5Nyd0kL/8oZ3ZFXEm6XpZF+lkQRSeIT8P/nEj2?=
 =?us-ascii?Q?wK1sJdYv4OD+EeVCaZ8QqwGVc5meisyjGmoh0C+QAeYYadwAcJvkNgpcbR33?=
 =?us-ascii?Q?eKEjIILJgBcEW3+uVsL4KRrIJ0B+phjCO95UuKWV4xP+QnbN2DIsmGdRUQ/D?=
 =?us-ascii?Q?bL96XgwHDVYdi06YH3drPBczvf6s0o1xE4ja7AZ30ko6DfWfX5/hfiuWThyZ?=
 =?us-ascii?Q?JgXl04PQ46KzCep8BjaiRWwhKyG80ONpXX7C/iMm4KQuhFVuAM7bI28trEEW?=
 =?us-ascii?Q?Zqew7BERkut6IGTcuFJfmMHGAvSx4ahuqp5WY5BYeoLlpg6D8p9WmOU/ETgx?=
 =?us-ascii?Q?8ANnoNQIyfjtatCQ/qsX+Z40yhhDcc9A3g51jVhyMlzBefGBjRDq8P/8pdYy?=
 =?us-ascii?Q?Kq0eaiRfBwtVcT81j5l0AH1dscs5v7bqp7au6vl0B3Ooxmg3dWCDO9A42il9?=
 =?us-ascii?Q?aAUMKhaqRLq6GeahBfaF1oa4O+VgcEVQKFSB2IWrjID1I1a5193vlBawds+p?=
 =?us-ascii?Q?XjVWIO4xGBHUe8OZJi1E3T/HfFk+hec7/SLh7OaWUVw8b1uo87e6FEmwq2ns?=
 =?us-ascii?Q?SQzNNXqAmf5X3Ms0+OeCRLYPcHPccnI7Q5BPHiDuc9wGa1eknNqWOKWuxsJT?=
 =?us-ascii?Q?+4vAmGFGSfMv1TJ+c9XCw8bcReEsgCLD7qEdpF3zHQvCdFgKqPjzmuqtofOY?=
 =?us-ascii?Q?KUpBTp2blboA8PZmMMAmpe8/fAJEtHrImSyHzOnIU?=
X-Microsoft-Antispam-Message-Info: tLz8LufCV3K96UDWribDRvV53OhtbhBGNS0nHkXFojgfpfLp4rYq6M+NpeOSIsnK+lFjgu86NIqv8RVU19MynDi/bHhvV1A9+tHd2X9VQb7BG2/F6qXdrc40HR7mFItcx90R2YDo/xj24gi9VnIqkKhOB6Tcs5wP3QZjKUjbgbqowbBlgsrKUXYWdJnrueqbxK2GM2ZMIDQ/7Jst/5rdLGWvpR9IwY8NFJLRutaq2Voxd2mV9vlRg3UtLsK/gfy/l7hyHfHtJ+LoO/kzfAwaLR47FIyN8DgJ26ZjjQrNURckwof+X1noe9xg+iMFfPw6gjEE9bzSkonla/ru4HHhevwKo7V4PEXixZEYuxrepTo=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;6:wRju6PgNedl79V1f5emJalLEcAsxopu2ymWasYkecoLHsMju7peHqj/J8LZ76zMrUpnuSlwhNGirCMHpgjrHIo/58yrGonsvpT04tkCQMaofPGlK0jWXP7UAD4RKcV2ZUMEezVj/gam3+jR3fG31SIOcWbijBRKa3SP6nCMx4ySBR75RN+A5X/NSGl/PJgDA2uCoo0M4rE14v45OtjNcpKyz8upa8s/vQ/eXG/VSsIyXRAferF8bE2/ty2e4L7WuRInPP6R8BKoIrqp+8QsWztbxwmB22kc362eVJKrQgJGLk9kxX+OnQc6IfdzKgguDelJegAM40/aQ2ds5KEnM07KoZELsuoHRLYHEuaCzpNS7WRMfb7nC2Tse1XrDDVyEpFMbZFAwhQFAb/cXVgFiG/rGpZsVX0NHkYuqazLxUBGdQzd3KyrFSBpjfN4BQxlevm72kZvyqJUK0HsrjfnYSw==;5:S5NVXIpkSKatvnh1vlnY0hT3SGoGaadUFoCDo2v0z1rJGXCAgHp6S+KIEFqvphv3nmYzCyIHuoPbd8PvfKb6ivwYk3msoz2aUg7zNpq8YUiHWH+wbVoR+4bB3vhBw9IP8cS7HfXX2cl/7imd0Aqd7JqUYeRubFXTr20s8zDqbis=;7:xSR/da4Wit3C6C0dXpr+5hoZ3X6zv60ArFwQIu3sKaSsYZEjaMQkyk5PSwQKd+d/ZxgWRFvnNjVWzKvtkrQDz+hYs+5NlpLWyBhuMNWnWNoYBDTHjD/5EkOFpV+qHe9ebUwI7Vj+GHN2ws5Eacq424XZCn9sAp3HTYEmIJFkYPyXl2FoDLSTVRSVJipcr/ZTWDqhrjgvJBRtxUfbG+MaEjYeummvXkxuZ00Rr0OyxVgmJB6vknjVUYDdGGId98AJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 09:50:04.2532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c3348e-8b89-463c-0266-08d5f2140001
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using DMA, if the DMA addr spans 128MB boundary, we have to split
the DMA transfer into two so that each one doesn't exceed the boundary.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 1b7cd144fb01..01b5cb772554 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -13,16 +13,45 @@
 
 #include "sdhci-pltfm.h"
 
+#define BOUNDARY_OK(addr, len) \
+	((addr | (SZ_128M - 1)) == ((addr + len) | (SZ_128M - 1)))
+
 struct dwcmshc_priv {
 	struct clk	*bus_clk;
 };
 
+/*
+ * if DMA addr spans 128MB boundary, we split the DMA transfer into two
+ * so that the DMA transfer doesn't exceed the boundary.
+ */
+static unsigned int dwcmshc_adma_write_desc(struct sdhci_host *host,
+					    void *desc, dma_addr_t addr,
+					    int len, unsigned int cmd)
+{
+	int tmplen, offset;
+
+	if (BOUNDARY_OK(addr, len))
+		return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
+
+	offset = addr & (SZ_128M - 1);
+	tmplen = SZ_128M - offset;
+	_sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
+
+	addr += tmplen;
+	len -= tmplen;
+	desc += host->desc_sz;
+	_sdhci_adma_write_desc(host, desc, addr, len, cmd);
+
+	return host->desc_sz * 2;
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_uhs_signaling	= sdhci_set_uhs_signaling,
 	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
 	.reset			= sdhci_reset,
+	.adma_write_desc	= dwcmshc_adma_write_desc,
 };
 
 static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
@@ -36,12 +65,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
 	int err;
+	u32 extra;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
 				sizeof(struct dwcmshc_priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
+	/*
+	 * The DMA descriptor table number is calculated as the maximum
+	 * number of segments times 2, to allow for an alignment
+	 * descriptor for each segment, plus 1 for a nop end descriptor,
+	 * plus extra number for cross 128M boundary handling.
+	 */
+	extra = totalram_pages / (SZ_128M / PAGE_SIZE) + 1;
+	if (extra > SDHCI_MAX_SEGS)
+		extra = SDHCI_MAX_SEGS;
+	host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1 + extra;
+
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
 
-- 
2.18.0

