Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39ACC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357D02075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="ZyB5lS6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357D02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeIGXTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:19:43 -0400
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:15448
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbeIGXTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDt1K0BhXbXfZ9g9byhaTriLxkkVGrPdX/y2ve6WYyE=;
 b=ZyB5lS6WSmOZJsKdyh6tlCYa1UGdVKotEiIJC97fSiaHBhNMKGawYNligwzXrHYxXV7rLWVWjS3VW6x40AWEFRCbflgY1hFInlszw2zF1HyjAZi1YyvIehfTOyIu0K4QEVothTcD1zBYBo48/KZCXwn+P92UphKWkIqHWWlVNpA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Volodymyr_Babchuk@epam.com; 
Received: from EPUAKYIW2556.kyiv.epam.com (85.223.209.57) by
 DB7PR03MB3772.eurprd03.prod.outlook.com (2603:10a6:5:7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Fri, 7 Sep 2018 18:37:23 +0000
Received: by EPUAKYIW2556.kyiv.epam.com (sSMTP sendmail emulation); Fri, 07 Sep 2018 21:37:18 +0300
From:   Volodymyr Babchuk <volodymyr_babchuk@epam.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Volodymyr Babchuk <vlad.babchuk@gmail.com>,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        rouven@czerwinskis.de
Subject: [PATCH v2] optee: allow to work without static shared memory
Date:   Fri,  7 Sep 2018 21:37:07 +0300
Message-Id: <1536345427-31425-1-git-send-email-volodymyr_babchuk@epam.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529320275-30079-1-git-send-email-volodymyr_babchuk@epam.com>
References: <1529320275-30079-1-git-send-email-volodymyr_babchuk@epam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.223.209.57]
X-ClientProxiedBy: VI1PR08CA0205.eurprd08.prod.outlook.com
 (2603:10a6:802:15::14) To DB7PR03MB3772.eurprd03.prod.outlook.com
 (2603:10a6:5:7::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8059522-dd1c-4f7e-08da-08d614f0f470
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR03MB3772;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR03MB3772;3:vv5gipFH/YsDgpE8QOLOcA4xR6eP9955NHc76qx7xVOYeKl//MBv1uaP04vqjG5k4ckH8+8R3nHwkFQDXy532xJ9KndDgbVW9wdemJKFWLOzucaxaUMI5N+cmH4WPbWflBtFZGCQhAffUuaU9SzJ9oQv2sElvgY3t2JTNGWnYmFI0FWSX2Bb3N2+qtDjFtArnE+lTLaFQqILo2MCEiMz7w5O9/boIRL8E2PjUSmzyMlR5Whdpp2cAmW5MUXX4mZj;25:M03G4Z6MgZDVCdhhchsc2kaYHSbscrslRNgHru1pEMoVdfgyk1WTg9Wh01fOPuSIsExyaV4IduLKKKwdk5QH3eroNqi77lHHutNCNP/ZaW4IyluxFdK4CzL1Bv0o7bPYxzWYOQ0WPEUGYNBEBEdRACXETCe71bS1pG4kPJHHJE9BnLukH2ezpKrohb+n0oH+gR3Q06pd1/GeJOmHdBdSNPCN0Wb4vok2NExCT/5ZQNFQ7+2TeKV0ZKIB/Urh9vQAgviLHnXH/wunXCM2j32I7bHYD/k1+uBvm7J9paIjXgr8WZ1fDLBRiYFCbMAc4ZM0XSNj6xhlF3otR8izug5P1w==;31:l76A83nxsGF0hTgYYmpsYtgZE9+J8gc87MpWAgMcRP4J86vwU8Pb88gWA62KVf4ziuS4wzxfPdxdQQnbcbhXuKWYcJX3SFVVx9HTc98rJsltPzAcXVrNVBRfN9JmlQJyWUVOUu/ftwJmIiUjl3HVAzLt4uc3K/+P3jk+W7q6ACdPI2XPjOZq7oBW0vaPbX/fP5TlgQH8Fep222DozWXEEO9EJOTYWU5P1KaBcA/iGDE=
X-MS-TrafficTypeDiagnostic: DB7PR03MB3772:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR03MB3772;20:Y08LPiVELNYjV2VOegtDerqA7OCoEnq78IJ5AnXvu8vOKWbVKSITARGpFegzkuL+jeiZZM0L/BqONAWk8s5lgPcbw79OnPPDKQZy/d1fSQH15L/ENEHrZATZ4R2umR2FWMEeAnAX4UZ/z5MoK698MngIg1X9WWpg4+pPAhwLvJh1w8DT7IBIfnw+OwPILIQdYZBq3QlK0p+2wryQD5IU2gTpscAUSqoPzCCHZhhbOmUbu8YvjFe8t2Y2t3Z3sfmkCmLuUzx9/BbE+0a8gnbKaDvzLXk5yNdwe2t5OIqBlPHh0yWh6VbGNa3b/xBUTUI81WubHAo3KGGVnCw4k87Kejy7pfoPpnkY3YbOXAGx1HBeG5DnxCWf6/onTT0BCaweutLQkvto8LSBqaCGMefOUPxd9yax8N2kRjUZQ5fBhi+P5GhhOTnHRCQ2uUSlqd3T7dqkKUO23N9ClLwEMbt4czBpTNS6qfYQLYu3xCL0Ycya4TnkyTdl/CH7vZ8j50Ht;4:PSlOcGfYnqrBEF+00JfAqyZyu6puMp+34+fPyVNh5sLzmwpi9SpNWqy8xnLI3UC87Kjye8ccnvsDCkvrmWfU/RMrAFMsKhclR/tVnTIsQMuZJDwGhB8pq8tMzuZpaRO7UAaiArQjlTK7gs4IH1Nyv3ns60SXf33pYKQ2WUPebQP10BsMaUX8rPV14mXntTaxhJY4x9QCdS7OlzhjuvTlmD/AFZKD6BhPzLui1ex2cmSru/qbnnAL2yWTNbFx2lmHzGYG2QYoMknfvhAawuJIuRIFZMUn4JGx4sD5YpmSyh63nmqR5Wx3+7CiYdU0TBSE
X-Microsoft-Antispam-PRVS: <DB7PR03MB377240A6FD21C83F0DA6F30EE6000@DB7PR03MB3772.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:DB7PR03MB3772;BCL:0;PCL:0;RULEID:;SRVR:DB7PR03MB3772;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(305945005)(2616005)(7736002)(426003)(6666003)(48376002)(50466002)(6916009)(5660300001)(36756003)(4326008)(50226002)(39060400002)(81156014)(2906002)(81166006)(66066001)(8936002)(72206003)(47776003)(86362001)(42186006)(316002)(8676002)(486006)(478600001)(105586002)(80792005)(16586007)(6116002)(53936002)(97736004)(186003)(122856001)(52116002)(76176011)(476003)(26005)(68736007)(106356001)(3846002)(386003)(446003)(11346002)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR03MB3772;H:EPUAKYIW2556.kyiv.epam.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR03MB3772;23:A79pKk7p/ajOF+4RxjxJnk+jLMskZWEnZNU8n2L40?=
 =?us-ascii?Q?K+VkUHdhIKscC13lMEpBTDjrnKuAIo5qepHFRRspA2qHeCEIW11j/+Yoqnib?=
 =?us-ascii?Q?AEINmxFRsT4Frp5jZYhzVc/HYXISiqyr1eUFWch8PwKPvePNTm0EbHWmTWC7?=
 =?us-ascii?Q?59YwzLU7uk00aiKQgR7dAFBtKOUace4X+L8TSmCRfLjInfTPUnmRkRxJJyGS?=
 =?us-ascii?Q?7HZNopYRtaGCYFl1NTrnp657V32rfMcEKRv9SlNvFrDEOAQeSSgeyMWWFGe3?=
 =?us-ascii?Q?ltxbY1RIkrOVnyxDKaGiMSx/miQ736PV9tG8OxYCRgSdy2zRv5ufm457sN0Q?=
 =?us-ascii?Q?WzeIcbPqEvJdChp+wdQ2DHFhHfgdXEyaBRXc5e4d3V/ykU5J8/HBHXRsB8RE?=
 =?us-ascii?Q?f4/kJdZM8BKFGyrpWl/kn4rX1q/Ghbu8kMNwFdvl4xesWGUslxcraEqISgvX?=
 =?us-ascii?Q?5WgLKaPGpmJhUVjtzXiIbtOTfa5Z//JTmJv4YC30cuUivkAV1aX1EN1Xfq3N?=
 =?us-ascii?Q?fv137SayMHtlVKi5qSwnyYGhfcMEQJAa6RDRbT/FQvap9wiEVI0j+zf1hMRx?=
 =?us-ascii?Q?iSH1LQygi+q22OmZKj1NCKoFv8nn7iRd3EmZY+GbmuMtzYN7No7cw6PgJB5I?=
 =?us-ascii?Q?E+jpKFhhvGDdA32Z/VFyZn73nAGVZ5NvV84jBd2KSOO2T6B6lKgJI/F2O3lU?=
 =?us-ascii?Q?KEqLz5/r9yrNOiCfdbEcisBQMPbQoXm0lD6omFPrfLx99u5GttX9md2iMgBc?=
 =?us-ascii?Q?DfYlmSkwhmcmfmANoxl3X2WLxzbD8WfebqcbGXr/RVDNhPx0OISTLbZjuVLL?=
 =?us-ascii?Q?9sT9vxn9mfECdbMscQFdhGsTVZvApcrTcYlFYEmoePrSbqsmdwI3GONNozxv?=
 =?us-ascii?Q?YeU3N9rihYV+ClU9sdyoTqclgTE1bSNB+El/hI+d34zMKm1o53sSOO8TYF9B?=
 =?us-ascii?Q?QmH4HrkliCYfnTVrea2dKkWLv2l6nmOmn7PqqUbnkRcAWW7UDSSkBIeLbBuc?=
 =?us-ascii?Q?NpLJv3ktdD1he7Cmetfc/w+CSNzhjVyHacRpmH2EicrPW6byF70UEE66RRLK?=
 =?us-ascii?Q?p6syFWyh+WhElMo8WOrrY53ZpMFJDE6971DPs8oVWEgJX70SERosTJowmQMV?=
 =?us-ascii?Q?a12eWtX7FIlsWUFeNMTibPuxp0S6Ilr8HKKiLTzS6Ll/7L6LpSGEzZgziNLO?=
 =?us-ascii?Q?Eefni4S7w2BdqA=3D?=
X-Microsoft-Antispam-Message-Info: x4p7UJq8/wXJSjSWstU1ySFv+kZfOUaqlczDD/UT04d4qAR2Pmz0PrW9CIk5HKrTvE87CsVfgCfWtX0qZEZBLh72I2S623pDfRQ537pIX2QOvOuFTXL5FrFgmSzTeIdOXOIgCTBOgO4Amrl5SKvyiMEQUChPI4yBQvxEIDFKPJg9c0biqcDo19xh7QAuxH1H4Jfgi87c8vOK0Tj1MrFfj2ZPOgqaH4Pq+0Fj8yaywwxvKRX0w05yYT4Qz9+KomCSQfjHbmkOKoxSiUpoEFbXOjCNiY8fbdCOHSRZ7K+guDETrlC5wxzxsBVZ1fnRrJuUMRh7PWKv9AU/Q1HvZ8tyIcJaPvb7kYNevAo2r8yap9o=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR03MB3772;6:vNWIg0AkNMAindBfq8z8eg1u7q2A/pCtR5GeuFLyAb3xJ1vHPiBA533+FbiS8Imvfc+3FM9M3GYcCt4HYP46VvNCYtD3nlfj/ApafjYYeemZiug1j6So9/WSD36QkdNKhpoWugJ0toAiPsqcQTpegQDNbhn8JvSIIz5wsgtHvYCnys/ctazrozKyCTtx/BzaZsWc21QToHnhEGe6FzK6q8s2Mw73Y0ukJS2pktgPEZz72FyidiukT7rnhdvx04Joje4BioKXHzHprq/yznHYlm6Rzfe48WOAyBQO/+7hh23/hJ3VrGnvvaZ4OY3OpU6BI1rIzar5VjJh9XFB+2+iBsBiIdya63wiZWqkJA7Sn9SkqnlQij6+jYKoLnLPwjuhFSsktKm0m4p4cDgcvMBivDFyevaVMgVvnLZu7z4n2NEAiwDJCB593RS3XkVV3DboebqMHTcKjBLrzuscZKn33w==;5:X/YRfTUsGnCVtTTsqbbDa8n0m7CGeTqvTDHlXI1wzmTQ+LklYFqMGgmCP1vXCG8tUCCzYM4m59fK/k14jQ4IFPZA2OughJCjeWjFBMWYDJuysY8lO3Xr4ziW2we9oUr57ujSwMRGA1TqDU8XZ9HKmI34EDf227lRvC28g07B6n0=;7:aJ676V1bWAP+yD93LcUGO/kbHPvZ1OMRNs0FeVjBuQ1RIzgklINTKPYGbZqk+c5FkPzNwMnUBXFN7Wkn4vbWWEYpIp935O/AGVfvv1vHUb2SoHLg66UZqA8clLX3nurDeftuj7LoHPJSIjZ0CzawqwQjPDYOhTM1kk4WftiBoee4Re60OLhEY6uFu81tcP5pvyHPjwYF/qeJl5QkqHYGNallU75stOgA28usKc1U+en/pZrd/ALxgj6uJ51Awmql
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 18:37:23.9339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8059522-dd1c-4f7e-08da-08d614f0f470
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Volodymyr Babchuk <vlad.babchuk@gmail.com>

On virtualized systems it is possible that OP-TEE will provide
only dynamic shared memory support. So it is fine to boot
without static SHM enabled if dymanic one is supported.

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---

 Changes from v1:
   Patch is now can be applied to vanilla kernel instead of
   linaro's op-tee branch

 drivers/tee/optee/core.c | 80 +++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index e1aafe8..efd2e5c 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -419,9 +419,35 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 	return true;
 }
 
+static struct tee_shm_pool *optee_config_dyn_shm(void)
+{
+	struct tee_shm_pool_mgr *priv_mgr;
+	struct tee_shm_pool_mgr *dmabuf_mgr;
+	void *rc;
+
+	rc = optee_shm_pool_alloc_pages();
+	if (IS_ERR(rc))
+		return rc;
+	priv_mgr = rc;
+
+	rc = optee_shm_pool_alloc_pages();
+	if (IS_ERR(rc)) {
+		tee_shm_pool_mgr_destroy(priv_mgr);
+		return rc;
+	}
+	dmabuf_mgr = rc;
+
+	rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
+	if (IS_ERR(rc)) {
+		tee_shm_pool_mgr_destroy(priv_mgr);
+		tee_shm_pool_mgr_destroy(dmabuf_mgr);
+	}
+
+	return rc;
+}
+
 static struct tee_shm_pool *
-optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm,
-			  u32 sec_caps)
+optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
 {
 	union {
 		struct arm_smccc_res smccc;
@@ -436,10 +462,11 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm,
 	struct tee_shm_pool_mgr *priv_mgr;
 	struct tee_shm_pool_mgr *dmabuf_mgr;
 	void *rc;
+	const int sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
 
 	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
 	if (res.result.status != OPTEE_SMC_RETURN_OK) {
-		pr_info("shm service not available\n");
+		pr_err("static shm service not available\n");
 		return ERR_PTR(-ENOENT);
 	}
 
@@ -465,28 +492,15 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm,
 	}
 	vaddr = (unsigned long)va;
 
-	/*
-	 * If OP-TEE can work with unregistered SHM, we will use own pool
-	 * for private shm
-	 */
-	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM) {
-		rc = optee_shm_pool_alloc_pages();
-		if (IS_ERR(rc))
-			goto err_memunmap;
-		priv_mgr = rc;
-	} else {
-		const size_t sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
-
-		rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
-						    3 /* 8 bytes aligned */);
-		if (IS_ERR(rc))
-			goto err_memunmap;
-		priv_mgr = rc;
-
-		vaddr += sz;
-		paddr += sz;
-		size -= sz;
-	}
+	rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
+					    3 /* 8 bytes aligned */);
+	if (IS_ERR(rc))
+		goto err_memunmap;
+	priv_mgr = rc;
+
+	vaddr += sz;
+	paddr += sz;
+	size -= sz;
 
 	rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
 	if (IS_ERR(rc))
@@ -552,7 +566,7 @@ static optee_invoke_fn *get_invoke_func(struct device_node *np)
 static struct optee *optee_probe(struct device_node *np)
 {
 	optee_invoke_fn *invoke_fn;
-	struct tee_shm_pool *pool;
+	struct tee_shm_pool *pool = ERR_PTR(-EINVAL);
 	struct optee *optee = NULL;
 	void *memremaped_shm = NULL;
 	struct tee_device *teedev;
@@ -581,13 +595,17 @@ static struct optee *optee_probe(struct device_node *np)
 	}
 
 	/*
-	 * We have no other option for shared memory, if secure world
-	 * doesn't have any reserved memory we can use we can't continue.
+	 * Try to use dynamic shared memory if possible
 	 */
-	if (!(sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
-		return ERR_PTR(-EINVAL);
+	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
+		pool = optee_config_dyn_shm();
+
+	/*
+	 * If dynamic shared memory is not available or failed - try static one
+	 */
+	if (IS_ERR(pool) && (sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
+		pool = optee_config_shm_memremap(invoke_fn, &memremaped_shm);
 
-	pool = optee_config_shm_memremap(invoke_fn, &memremaped_shm, sec_caps);
 	if (IS_ERR(pool))
 		return (void *)pool;
 
-- 
2.7.4

