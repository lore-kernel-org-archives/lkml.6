Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544BAC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D926A2064E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="c1AQaosZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D926A2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeI2Ord (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:47:33 -0400
Received: from mail-by2nam01on0062.outbound.protection.outlook.com ([104.47.34.62]:46160
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727639AbeI2Orc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I6pGhUaMK3dAr1XOOqwwKwVd/ELa3EvJN1u5cPShZ4=;
 b=c1AQaosZXsxRaCLRJON/WKstV8KjY+Wh/b9n3wJp2Wel+K5+zuWg5Bxca3wDYvfCEB6dLhKiry2FDd7esebeLB3wXtwXwN+DxgPwzz1xVWkkCzw8nHrvlA1/HT5kIUc8ii1ILI34AptEvhdz8L/oTGzkVk/gDFljb9pN+CRUDM4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jampala.Srikanth@cavium.com; 
Received: from hyd1621.caveonetworks.com (115.113.156.2) by
 BN7PR07MB4610.namprd07.prod.outlook.com (2603:10b6:406:f2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Sat, 29 Sep 2018 08:19:57 +0000
From:   Srikanth Jampala <Jampala.Srikanth@cavium.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgadam@cavium.com, Jampala.Srikanth@cavium.com
Subject: [PATCH cryptodev-2.6 4/4] crypto: cavium/nitrox - use pci_alloc_irq_vectors() while enabling MSI-X.
Date:   Sat, 29 Sep 2018 13:49:10 +0530
Message-Id: <20180929081910.17652-4-Jampala.Srikanth@cavium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929081910.17652-1-Jampala.Srikanth@cavium.com>
References: <20180929081910.17652-1-Jampala.Srikanth@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [115.113.156.2]
X-ClientProxiedBy: PN1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::34) To BN7PR07MB4610.namprd07.prod.outlook.com
 (2603:10b6:406:f2::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12b0bb8b-ea64-4809-2e8f-08d625e458ab
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4610;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4610;3:orUb6QtpBUuta7mfiBv1h05SD/EZLIOgIymecDJwwv7M3E9BvWknExgPDeMwb1hblSBylP53QUP4GaIbH0LG9oN6ZXiIVT6hhwOcSMkrqXgNgGnPw+aovMNBcIvUEPnMz72vY5MXJeSa3e7ZVkR0i8wV7Xd1vN/mRfafPocDKpWMdJSm8Uyy9yYJsW4l5xK2/Q9H/i1t5HEA6wsvHRtrBkgwsQuYyB4uYMxG9wZn1emrtxins/49+AFNDUdL376e;25:IdHhKCMHuhk+BdCKpjXdO901QS2US4P9tJZC2xb2gBMfFShWq1ezr4cgImeHagqHCU+Wc55Fq4GE6KV49HfPbavunKQ9CNpg+RPKcu3tLRvTNeGNmeQzFX6vYhJJpfSMGWE8uOQrthrSjTZoOGPLPLGLI4RZvMgkHf8O9LWm4w8BC/5vSq8RyzcF3PSZVCJq70l6+aXEneveLK32ex6gQTn2UhPC4Rify5y2Of1EyBHls6AZQoosPyup3717PUvFhPz2a6plaGOJ1isd4z0ulcm2gERuvu3E22TF30L/jXuCQcX2dYAcHBEsbixBfvfNGArQiUdPsaysgMDnHhDDlg==;31:9GrlEZhN5EC/Rgfj4hhz+DAayA+K0GwzsoRVgh9S1enJFXhgLqMls4g0l55fN4HAMEv1eDseLN+DMLVwAMds4Oqk1FzNt57paR/E4D+Q99cFLGg8seqx6+0FeM4vxw1Fh5ueLgFHIJu6vaw0+Bdr1KyXZLGhg9gqZgfjSqQdykTGwfGh+klitto8JV9YwyKAdMnaXN9aFZa0ZCukrn6/dL7wqb1XKWCWprmyfWlkGdQ=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4610:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4610;20:sY1owsvxq094IELIpx5qWfcq4rjiqdhJyfsECStXarhLFsI3xMwaSOTjSykY6SiDD7bm040cGraQ3JCDG8faeiBUEoflLvc3e/b2Ml1eK4QAxiPeJjVRWKYjDw1Xkx5+peUuRq7O9tnqihOb45wF8wk90uvltrExVBki9VFUcgU97u0Y+rz5ZUJpuic+vUi5Ha3Dh5rfg8YrrdgSWgrhrQZ9WEfF5B+pw+JBVvZ/1COmpgmm3nACaPI3bQDGpSZ4+bYPI8KSxkKsCdA8vshplOD9oB9VXe8Z07aB2/MF0jam1qVNRqXNBUeAAxVJPzPDaW3QtL3zJOCRrnvi2DNMWEoFdPlvkTlAlhiCzbWOiu42bGKn/kN7hwpde7rv7pf2QSiJcj574STBdwQBd5vfzKIiyHOw00A+vOapLTzNp8GVoV4DZrnlyX6HVImsuv1vfFTWHnYcGaIm7JN6DtOHApIEwlJ6111zLNcnwMb42V4PFeFS3mtFLWGrXYAyRaJP;4:oIKWE3dBR/2TjPCLMW7y/5SfwvD70hfnJdxA3RFIdtUsfaqE/YXZZOGLCmA32FsminyhNofypYq4ghuWdss9Xlm63rOZc6D4P17Om8neD0b+/302za5SNZHs7FG1lyW2SX66e9qpKQcVyxSJ+YcOdYNaAsnuJQKn/P9twDhdmj5/b5+ABYy7hiuqYOj8GovSQ1q3Nr6btP/aHhrgIP+gA1Y8LXXj/pmV01x7Z2hsVcH4O40mlusIHFsFzxy3DDDwJdGmeMkE9VDg4vnGurr5B8EUeqY1tM2MrNg3XGtGl7Fwb0TRnz9bFx0SicJLCAkh
X-Microsoft-Antispam-PRVS: <BN7PR07MB46108FD51251377184414A03F4ED0@BN7PR07MB4610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:BN7PR07MB4610;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4610;
X-Forefront-PRVS: 0810818DA0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(7736002)(11346002)(69596002)(956004)(386003)(53936002)(50466002)(81166006)(105586002)(81156014)(2616005)(68736007)(52116002)(186003)(6506007)(6512007)(50226002)(106356001)(8936002)(16526019)(26005)(53416004)(575784001)(86362001)(76176011)(5660300001)(16586007)(48376002)(316002)(6486002)(25786009)(51416003)(478600001)(72206003)(3846002)(8676002)(66066001)(6116002)(6666003)(47776003)(446003)(2906002)(476003)(1076002)(107886003)(36756003)(97736004)(305945005)(486006)(4326008)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4610;H:hyd1621.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4610;23:3GRqF7zTp9/l3T6aj8uJrcbF3hmVWdvgKmkZfaVfY?=
 =?us-ascii?Q?s265vGd1EkwS8WjLHBaVLDzYZetBU6cPrCnm7KZ1aGZA62d7ie19D1TBagto?=
 =?us-ascii?Q?cyRT1LfD0vKlsk2YJ7TcblAducASSsE+7MufQy7Tnf1VPkBMnsJtABkln4M6?=
 =?us-ascii?Q?XydpmXeaje6T+rqB5rg6BYH48kqWH9wPz/N2InmPQZhzGD2yo6upnmLkz3hq?=
 =?us-ascii?Q?vfUCuhY8vCzk3HivrhVbBPvgpVpAyhZIT5/RlR594duuNatKIwSArq/P77o6?=
 =?us-ascii?Q?DRxSNkJQrEe5vc3mVJ2rAOK48NSF4kXJwjFGHFufg23+8ZCkiLvIA3u0pRjL?=
 =?us-ascii?Q?9OXI+zYTUJysYjVGjPNMl0U13uQ/bqdbHFKV2RzI3KVpKlKanKJIO1CTffcb?=
 =?us-ascii?Q?lECkh0HJ0cdRF2GXmxNQaqIt94C7yTR2fxi9HjJgBWzyYL9AJjKoFtH+SfCf?=
 =?us-ascii?Q?54thOgHYfsPTD/RXQeiLa8PI5dlxi8ucnNFrV1OI4zhU2onlrIw7uXoJy8/S?=
 =?us-ascii?Q?+4MDHiV5HU9JUHbNWPHLQqhRdasnJGzkOoQFebfMcTJ67VyVJ8xZ2Z+vjCKg?=
 =?us-ascii?Q?gxRAbIWZyJ/aAvvYrvCfMrO5NonLlZcg5G+kfctV0AjmZLkonRVaG+kMaK8H?=
 =?us-ascii?Q?cTP+sVE9MjGhEVYFUg6KfZ9PpbaZTjymJq+tUbtoyv5P+aNOk1w/kyQXuYvu?=
 =?us-ascii?Q?SuHtZT/FtOID680isaCo5skRN7wrauO3uRMaRPd3XPPigSo6WKOY6m80rTTN?=
 =?us-ascii?Q?l1RLFU1s+0IiUji6BHBgJbQtJ6ygpRaJGzthJBMLD9k4DxW42uqx0cH6CTk3?=
 =?us-ascii?Q?o7lEqLiNWm6hkAEYi9tzwuAUynTu38FYV075dD7IQW8iS3y5pQWMts4oEO/7?=
 =?us-ascii?Q?qwuYcLx7zTiLtVg5zySTTw9fLkQ4EFLgQZBgDEUWNvvax9bhwGJ32jLNsD3d?=
 =?us-ascii?Q?O+bTtX43K9aF3kN4XTBjNfP++Y6zzpEW2oiYf9fMXuyyykLXculjMO+bJKFm?=
 =?us-ascii?Q?9V5wmme6KzJLk5DjdThPyPBITuLBdXuOThlDES1VjiAI5rvlyL95ShDOgXhW?=
 =?us-ascii?Q?na/P1pAsr30yTslN+qixsn/U9fJxAzA9fhXgduEsAUUtIx1kTsENWjwiULDA?=
 =?us-ascii?Q?/6XR9dQFQamPBj/3iZZaVlYV02b/c9lVyRm4cvkQqxQodFwKbQ+0naj1Q3aR?=
 =?us-ascii?Q?U1mLMHaDd0wGmZBY0WzGO3564low6uTpIQeHxQ3jFUTYZbpNYshpiklUttN6?=
 =?us-ascii?Q?lQ5fjICb2P650novXIkouJI9egFefYZCDKDvboHtACm57UpCewdteWsSFmQI?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: TKKGvfIU+Z//vrZtjRUJ8R9FzYU7CeDhY6ksMwPJDGKa7czIs6S3nSvbaoWCPWLZrzJmla8PWZXC3YTl7Kwjv0gVkqVmRaf0VDrShic1r/pVsgDtOcl4MBlQqbxqv2fdaaWdRKOtdj1XcMcbCuP1rHH0legUWg27gPfyBgt4CTlyG7QuXsNSRjY8xDcMtEJk79I8WPFBffRKCWLDCC58R6imHtz1SoX4YA+XeVvQhIqYfP7yE8IP1wq1v7sGK5BhpfsD7W8C9MMhmtnyAsfpyfk10QRP9LPWBFVYv5PF+T3ZoMhWThxG5kkiiBWmrTNWjsniULbN1a085fxwWn70pOniKoaSDnVmIbVpxcB6FTk=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4610;6:LCHchaX47G1WcjA7x/GANgGpE8twpATEeGIgTvs+/DEdZfDQmnrlnZ7N3rkfKE82f3ujXfGvccDUSR5nZ6/x4tgWTFJgAYruegnYGqC34y0KOqO/7waN8xtjnOMlsGa9jpowjPxnEmcbXLHf3W/oXvrz687CX74c1cM+tohCIGbzEW4g3jF3m95Wommg97qFfawP5cPUnchQ+9gkEWLarUezNgU7LDy5JsvzZHsJXmjeh1q3FoJ2Bh4NOnUcyejdSNUsfEwcVxc9nBx5izamWkhaE6xxz0YR2+WsRF0QLRoJI9uLMivJ8VZVfrqmMmk7GIh1p9/YknpC/kNrzcyiPXtjqpuQeRbP2I1dzTQdH8lnzdnpcMatjjkUbTkLFLcJuoyCwWuxvK4jnI8qOBCAIFDAux/Eb/Vj2akJDZhu7eDHUOMIT/mNFdnMUglvrxZPlmzl0UTCcyxlkMDwYqMtXQ==;5:S7oVNvMTHXckGV+JRv+GIY0KWInjuZynXGPOM/JV5oOsHOqxVQhIJedsHswjgGHvzoBJzQKwGtNAkEi0Ah2TBaXvlgcpDpkBnEDosEtFDBOiJM7vYemy9ZYgVmgmVo07gaWlBwbHpFig1G7OhPZqtOOKsh9eCWZd5GYtXTBE6D4=;7:X6K2PmOY+61BLQiHT93u3ML4bv1If7FLYilgXz2crRLxU0LcUthJIsY9nU63JE4USrtJKSIL0LTlr3+iVL9IDdMcTFlfnaFkv5geJLCp4/mJdEixs+DixpHPremFx5J44NaTu/+lKMlNGLe6EduNIj2J7MgTuVMyHuIx9lBubXKVo8iMNteG0RULOY23OvX3uUdlzhNZgp5M+UnK/yxGMuTLLKJdUhTx5Y7wEOKVSKrlOd6yun0DF8nDsJOmNdbX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2018 08:19:57.2836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b0bb8b-ea64-4809-2e8f-08d625e458ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace pci_enable_msix_exact() with pci_alloc_irq_vectors(). get the
required vector count from pci_msix_vec_count().
use struct nitrox_q_vector as the argument to tasklets.

Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
Reviewed-by: Gadam Sreerama <sgadam@cavium.com>
---
 drivers/crypto/cavium/nitrox/nitrox_common.h |   5 +-
 drivers/crypto/cavium/nitrox/nitrox_dev.h    |  44 +--
 drivers/crypto/cavium/nitrox/nitrox_isr.c    | 336 +++++++------------
 drivers/crypto/cavium/nitrox/nitrox_isr.h    |  10 +
 drivers/crypto/cavium/nitrox/nitrox_lib.c    |   4 +
 drivers/crypto/cavium/nitrox/nitrox_main.c   |   5 +-
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c |  16 +-
 drivers/crypto/cavium/nitrox/nitrox_sriov.c  |   5 +-
 8 files changed, 162 insertions(+), 263 deletions(-)
 create mode 100644 drivers/crypto/cavium/nitrox/nitrox_isr.h

diff --git a/drivers/crypto/cavium/nitrox/nitrox_common.h b/drivers/crypto/cavium/nitrox/nitrox_common.h
index 00ef931115da..863143a8336b 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_common.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_common.h
@@ -12,13 +12,10 @@ void crypto_free_context(void *ctx);
 struct nitrox_device *nitrox_get_first_device(void);
 void nitrox_put_device(struct nitrox_device *ndev);
 
-void nitrox_pf_cleanup_isr(struct nitrox_device *ndev);
-int nitrox_pf_init_isr(struct nitrox_device *ndev);
-
 int nitrox_common_sw_init(struct nitrox_device *ndev);
 void nitrox_common_sw_cleanup(struct nitrox_device *ndev);
 
-void pkt_slc_resp_handler(unsigned long data);
+void pkt_slc_resp_tasklet(unsigned long data);
 int nitrox_process_se_request(struct nitrox_device *ndev,
 			      struct se_crypto_request *req,
 			      completion_t cb,
diff --git a/drivers/crypto/cavium/nitrox/nitrox_dev.h b/drivers/crypto/cavium/nitrox/nitrox_dev.h
index 62fb75923bfe..283e252385fb 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_dev.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_dev.h
@@ -18,6 +18,7 @@
  * @response_head: submitted request list
  * @backlog_head: backlog queue
  * @dbell_csr_addr: doorbell register address for this queue
+ * @compl_cnt_csr_addr: completion count register address of the slc port
  * @base: command queue base address
  * @dma: dma address of the base
  * @pending_count: request pending at device
@@ -39,6 +40,7 @@ struct nitrox_cmdq {
 	struct list_head backlog_head;
 
 	u8 __iomem *dbell_csr_addr;
+	u8 __iomem *compl_cnt_csr_addr;
 	u8 *base;
 	dma_addr_t dma;
 
@@ -88,30 +90,17 @@ struct nitrox_stats {
 	atomic64_t dropped;
 };
 
-#define MAX_MSIX_VECTOR_NAME	20
-/**
- * vectors for queues (64 AE, 64 SE and 64 ZIP) and
- * error condition/mailbox.
- */
-#define MAX_MSIX_VECTORS	192
-
-struct nitrox_msix {
-	struct msix_entry *entries;
-	char **names;
-	DECLARE_BITMAP(irqs, MAX_MSIX_VECTORS);
-	u32 nr_entries;
-};
-
-struct bh_data {
-	/* slc port completion count address */
-	u8 __iomem *completion_cnt_csr_addr;
-
-	struct nitrox_cmdq *cmdq;
-	struct tasklet_struct resp_handler;
-};
-
-struct nitrox_bh {
-	struct bh_data *slc;
+#define IRQ_NAMESZ	32
+
+struct nitrox_q_vector {
+	char name[IRQ_NAMESZ];
+	bool valid;
+	int ring;
+	struct tasklet_struct resp_tasklet;
+	union {
+		struct nitrox_cmdq *cmdq;
+		struct nitrox_device *ndev;
+	};
 };
 
 /*
@@ -160,8 +149,7 @@ enum vf_mode {
  * @mode: Device mode PF/VF
  * @ctx_pool: DMA pool for crypto context
  * @pkt_inq: Packet input rings
- * @msix: MSI-X information
- * @bh: post processing work
+ * @qvec: MSI-X queue vectors information
  * @hw: hardware information
  * @debugfs_dir: debugfs directory
  */
@@ -186,8 +174,8 @@ struct nitrox_device {
 	struct dma_pool *ctx_pool;
 	struct nitrox_cmdq *pkt_inq;
 
-	struct nitrox_msix msix;
-	struct nitrox_bh bh;
+	struct nitrox_q_vector *qvec;
+	int num_vecs;
 
 	struct nitrox_stats stats;
 	struct nitrox_hw hw;
diff --git a/drivers/crypto/cavium/nitrox/nitrox_isr.c b/drivers/crypto/cavium/nitrox/nitrox_isr.c
index baeacacbddbe..88a77b8fb3fb 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_isr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_isr.c
@@ -8,8 +8,14 @@
 #include "nitrox_common.h"
 #include "nitrox_hal.h"
 
+/**
+ * One vector for each type of ring
+ *  - NPS packet ring, AQMQ ring and ZQMQ ring
+ */
 #define NR_RING_VECTORS 3
-#define NPS_CORE_INT_ACTIVE_ENTRY 192
+/* base entry for packet ring/port */
+#define PKT_RING_MSIX_BASE 0
+#define NON_RING_MSIX_BASE 192
 
 /**
  * nps_pkt_slc_isr - IRQ handler for NPS solicit port
@@ -18,13 +24,14 @@
  */
 static irqreturn_t nps_pkt_slc_isr(int irq, void *data)
 {
-	struct bh_data *slc = data;
-	union nps_pkt_slc_cnts pkt_slc_cnts;
+	struct nitrox_q_vector *qvec = data;
+	union nps_pkt_slc_cnts slc_cnts;
+	struct nitrox_cmdq *cmdq = qvec->cmdq;
 
-	pkt_slc_cnts.value = readq(slc->completion_cnt_csr_addr);
+	slc_cnts.value = readq(cmdq->compl_cnt_csr_addr);
 	/* New packet on SLC output port */
-	if (pkt_slc_cnts.s.slc_int)
-		tasklet_hi_schedule(&slc->resp_handler);
+	if (slc_cnts.s.slc_int)
+		tasklet_hi_schedule(&qvec->resp_tasklet);
 
 	return IRQ_HANDLED;
 }
@@ -191,165 +198,92 @@ static void clear_bmi_err_intr(struct nitrox_device *ndev)
 	dev_err_ratelimited(DEV(ndev), "BMI_INT  0x%016llx\n", value);
 }
 
+static void nps_core_int_tasklet(unsigned long data)
+{
+	struct nitrox_q_vector *qvec = (void *)(uintptr_t)(data);
+	struct nitrox_device *ndev = qvec->ndev;
+
+	/* if pf mode do queue recovery */
+	if (ndev->mode == __NDEV_MODE_PF) {
+	} else {
+		/**
+		 * if VF(s) enabled communicate the error information
+		 * to VF(s)
+		 */
+	}
+}
+
 /**
- * clear_nps_core_int_active - clear NPS_CORE_INT_ACTIVE interrupts
- * @ndev: NITROX device
+ * nps_core_int_isr - interrupt handler for NITROX errors and
+ *   mailbox communication
  */
-static void clear_nps_core_int_active(struct nitrox_device *ndev)
+static irqreturn_t nps_core_int_isr(int irq, void *data)
 {
-	union nps_core_int_active core_int_active;
+	struct nitrox_device *ndev = data;
+	union nps_core_int_active core_int;
 
-	core_int_active.value = nitrox_read_csr(ndev, NPS_CORE_INT_ACTIVE);
+	core_int.value = nitrox_read_csr(ndev, NPS_CORE_INT_ACTIVE);
 
-	if (core_int_active.s.nps_core)
+	if (core_int.s.nps_core)
 		clear_nps_core_err_intr(ndev);
 
-	if (core_int_active.s.nps_pkt)
+	if (core_int.s.nps_pkt)
 		clear_nps_pkt_err_intr(ndev);
 
-	if (core_int_active.s.pom)
+	if (core_int.s.pom)
 		clear_pom_err_intr(ndev);
 
-	if (core_int_active.s.pem)
+	if (core_int.s.pem)
 		clear_pem_err_intr(ndev);
 
-	if (core_int_active.s.lbc)
+	if (core_int.s.lbc)
 		clear_lbc_err_intr(ndev);
 
-	if (core_int_active.s.efl)
+	if (core_int.s.efl)
 		clear_efl_err_intr(ndev);
 
-	if (core_int_active.s.bmi)
+	if (core_int.s.bmi)
 		clear_bmi_err_intr(ndev);
 
 	/* If more work callback the ISR, set resend */
-	core_int_active.s.resend = 1;
-	nitrox_write_csr(ndev, NPS_CORE_INT_ACTIVE, core_int_active.value);
-}
-
-static irqreturn_t nps_core_int_isr(int irq, void *data)
-{
-	struct nitrox_device *ndev = data;
-
-	clear_nps_core_int_active(ndev);
+	core_int.s.resend = 1;
+	nitrox_write_csr(ndev, NPS_CORE_INT_ACTIVE, core_int.value);
 
 	return IRQ_HANDLED;
 }
 
-static int nitrox_enable_msix(struct nitrox_device *ndev)
+void nitrox_unregister_interrupts(struct nitrox_device *ndev)
 {
-	struct msix_entry *entries;
-	char **names;
-	int i, nr_entries, ret;
-
-	/*
-	 * PF MSI-X vectors
-	 *
-	 * Entry 0: NPS PKT ring 0
-	 * Entry 1: AQMQ ring 0
-	 * Entry 2: ZQM ring 0
-	 * Entry 3: NPS PKT ring 1
-	 * Entry 4: AQMQ ring 1
-	 * Entry 5: ZQM ring 1
-	 * ....
-	 * Entry 192: NPS_CORE_INT_ACTIVE
-	 */
-	nr_entries = (ndev->nr_queues * NR_RING_VECTORS) + 1;
-	entries = kcalloc_node(nr_entries, sizeof(struct msix_entry),
-			       GFP_KERNEL, ndev->node);
-	if (!entries)
-		return -ENOMEM;
-
-	names = kcalloc(nr_entries, sizeof(char *), GFP_KERNEL);
-	if (!names) {
-		kfree(entries);
-		return -ENOMEM;
-	}
-
-	/* fill entires */
-	for (i = 0; i < (nr_entries - 1); i++)
-		entries[i].entry = i;
-
-	entries[i].entry = NPS_CORE_INT_ACTIVE_ENTRY;
-
-	for (i = 0; i < nr_entries; i++) {
-		*(names + i) = kzalloc(MAX_MSIX_VECTOR_NAME, GFP_KERNEL);
-		if (!(*(names + i))) {
-			ret = -ENOMEM;
-			goto msix_fail;
-		}
-	}
-	ndev->msix.entries = entries;
-	ndev->msix.names = names;
-	ndev->msix.nr_entries = nr_entries;
-
-	ret = pci_enable_msix_exact(ndev->pdev, ndev->msix.entries,
-				    ndev->msix.nr_entries);
-	if (ret) {
-		dev_err(&ndev->pdev->dev, "Failed to enable MSI-X IRQ(s) %d\n",
-			ret);
-		goto msix_fail;
-	}
-	return 0;
-
-msix_fail:
-	for (i = 0; i < nr_entries; i++)
-		kfree(*(names + i));
-
-	kfree(entries);
-	kfree(names);
-	return ret;
-}
-
-static void nitrox_cleanup_pkt_slc_bh(struct nitrox_device *ndev)
-{
-	int i;
-
-	if (!ndev->bh.slc)
-		return;
-
-	for (i = 0; i < ndev->nr_queues; i++) {
-		struct bh_data *bh = &ndev->bh.slc[i];
-
-		tasklet_disable(&bh->resp_handler);
-		tasklet_kill(&bh->resp_handler);
-	}
-	kfree(ndev->bh.slc);
-	ndev->bh.slc = NULL;
-}
-
-static int nitrox_setup_pkt_slc_bh(struct nitrox_device *ndev)
-{
-	u32 size;
+	struct pci_dev *pdev = ndev->pdev;
 	int i;
 
-	size = ndev->nr_queues * sizeof(struct bh_data);
-	ndev->bh.slc = kzalloc(size, GFP_KERNEL);
-	if (!ndev->bh.slc)
-		return -ENOMEM;
+	for (i = 0; i < ndev->num_vecs; i++) {
+		struct nitrox_q_vector *qvec;
+		int vec;
 
-	for (i = 0; i < ndev->nr_queues; i++) {
-		struct bh_data *bh = &ndev->bh.slc[i];
-		u64 offset;
+		qvec = ndev->qvec + i;
+		if (!qvec->valid)
+			continue;
 
-		offset = NPS_PKT_SLC_CNTSX(i);
-		/* pre calculate completion count address */
-		bh->completion_cnt_csr_addr = NITROX_CSR_ADDR(ndev, offset);
-		bh->cmdq = &ndev->pkt_inq[i];
+		/* get the vector number */
+		vec = pci_irq_vector(pdev, i);
+		irq_set_affinity_hint(vec, NULL);
+		free_irq(vec, qvec);
 
-		tasklet_init(&bh->resp_handler, pkt_slc_resp_handler,
-			     (unsigned long)bh);
+		tasklet_disable(&qvec->resp_tasklet);
+		tasklet_kill(&qvec->resp_tasklet);
+		qvec->valid = false;
 	}
-
-	return 0;
+	kfree(ndev->qvec);
+	pci_free_irq_vectors(pdev);
 }
 
-static int nitrox_request_irqs(struct nitrox_device *ndev)
+int nitrox_register_interrupts(struct nitrox_device *ndev)
 {
 	struct pci_dev *pdev = ndev->pdev;
-	struct msix_entry *msix_ent = ndev->msix.entries;
-	int nr_ring_vectors, i = 0, ring, cpu, ret;
-	char *name;
+	struct nitrox_q_vector *qvec;
+	int nr_vecs, vec, cpu;
+	int ret, i;
 
 	/*
 	 * PF MSI-X vectors
@@ -358,112 +292,76 @@ static int nitrox_request_irqs(struct nitrox_device *ndev)
 	 * Entry 1: AQMQ ring 0
 	 * Entry 2: ZQM ring 0
 	 * Entry 3: NPS PKT ring 1
+	 * Entry 4: AQMQ ring 1
+	 * Entry 5: ZQM ring 1
 	 * ....
 	 * Entry 192: NPS_CORE_INT_ACTIVE
 	 */
-	nr_ring_vectors = ndev->nr_queues * NR_RING_VECTORS;
-
-	/* request irq for pkt ring/ports only */
-	while (i < nr_ring_vectors) {
-		name = *(ndev->msix.names + i);
-		ring = (i / NR_RING_VECTORS);
-		snprintf(name, MAX_MSIX_VECTOR_NAME, "n5(%d)-slc-ring%d",
-			 ndev->idx, ring);
+	nr_vecs = pci_msix_vec_count(pdev);
 
-		ret = request_irq(msix_ent[i].vector, nps_pkt_slc_isr, 0,
-				  name, &ndev->bh.slc[ring]);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to get irq %d for %s\n",
-				msix_ent[i].vector, name);
-			return ret;
-		}
-		cpu = ring % num_online_cpus();
-		irq_set_affinity_hint(msix_ent[i].vector, get_cpu_mask(cpu));
-
-		set_bit(i, ndev->msix.irqs);
-		i += NR_RING_VECTORS;
-	}
-
-	/* Request IRQ for NPS_CORE_INT_ACTIVE */
-	name = *(ndev->msix.names + i);
-	snprintf(name, MAX_MSIX_VECTOR_NAME, "n5(%d)-nps-core-int", ndev->idx);
-	ret = request_irq(msix_ent[i].vector, nps_core_int_isr, 0, name, ndev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to get irq %d for %s\n",
-			msix_ent[i].vector, name);
+	/* Enable MSI-X */
+	ret = pci_alloc_irq_vectors(pdev, nr_vecs, nr_vecs, PCI_IRQ_MSIX);
+	if (ret < 0) {
+		dev_err(DEV(ndev), "msix vectors %d alloc failed\n", nr_vecs);
 		return ret;
 	}
-	set_bit(i, ndev->msix.irqs);
+	ndev->num_vecs = nr_vecs;
 
-	return 0;
-}
-
-static void nitrox_disable_msix(struct nitrox_device *ndev)
-{
-	struct msix_entry *msix_ent = ndev->msix.entries;
-	char **names = ndev->msix.names;
-	int i = 0, ring, nr_ring_vectors;
-
-	nr_ring_vectors = ndev->msix.nr_entries - 1;
-
-	/* clear pkt ring irqs */
-	while (i < nr_ring_vectors) {
-		if (test_and_clear_bit(i, ndev->msix.irqs)) {
-			ring = (i / NR_RING_VECTORS);
-			irq_set_affinity_hint(msix_ent[i].vector, NULL);
-			free_irq(msix_ent[i].vector, &ndev->bh.slc[ring]);
-		}
-		i += NR_RING_VECTORS;
+	ndev->qvec = kcalloc(nr_vecs, sizeof(*qvec), GFP_KERNEL);
+	if (!ndev->qvec) {
+		pci_free_irq_vectors(pdev);
+		return -ENOMEM;
 	}
-	irq_set_affinity_hint(msix_ent[i].vector, NULL);
-	free_irq(msix_ent[i].vector, ndev);
-	clear_bit(i, ndev->msix.irqs);
 
-	kfree(ndev->msix.entries);
-	for (i = 0; i < ndev->msix.nr_entries; i++)
-		kfree(*(names + i));
+	/* request irqs for packet rings/ports */
+	for (i = PKT_RING_MSIX_BASE; i < (nr_vecs - 1); i += NR_RING_VECTORS) {
+		qvec = &ndev->qvec[i];
 
-	kfree(names);
-	pci_disable_msix(ndev->pdev);
-}
-
-/**
- * nitrox_pf_cleanup_isr: Cleanup PF MSI-X and IRQ
- * @ndev: NITROX device
- */
-void nitrox_pf_cleanup_isr(struct nitrox_device *ndev)
-{
-	nitrox_disable_msix(ndev);
-	nitrox_cleanup_pkt_slc_bh(ndev);
-}
+		qvec->ring = i / NR_RING_VECTORS;
+		if (qvec->ring >= ndev->nr_queues)
+			break;
 
-/**
- * nitrox_init_isr - Initialize PF MSI-X vectors and IRQ
- * @ndev: NITROX device
- *
- * Return: 0 on success, a negative value on failure.
- */
-int nitrox_pf_init_isr(struct nitrox_device *ndev)
-{
-	int err;
+		snprintf(qvec->name, IRQ_NAMESZ, "nitrox-pkt%d", qvec->ring);
+		/* get the vector number */
+		vec = pci_irq_vector(pdev, i);
+		ret = request_irq(vec, nps_pkt_slc_isr, 0, qvec->name, qvec);
+		if (ret) {
+			dev_err(DEV(ndev), "irq failed for pkt ring/port%d\n",
+				qvec->ring);
+			goto irq_fail;
+		}
+		cpu = qvec->ring % num_online_cpus();
+		irq_set_affinity_hint(vec, get_cpu_mask(cpu));
 
-	err = nitrox_setup_pkt_slc_bh(ndev);
-	if (err)
-		return err;
+		tasklet_init(&qvec->resp_tasklet, pkt_slc_resp_tasklet,
+			     (unsigned long)qvec);
+		qvec->cmdq = &ndev->pkt_inq[qvec->ring];
+		qvec->valid = true;
+	}
 
-	err = nitrox_enable_msix(ndev);
-	if (err)
-		goto msix_fail;
+	/* request irqs for non ring vectors */
+	i = NON_RING_MSIX_BASE;
+	qvec = &ndev->qvec[i];
 
-	err = nitrox_request_irqs(ndev);
-	if (err)
+	snprintf(qvec->name, IRQ_NAMESZ, "nitrox-core-int%d", i);
+	/* get the vector number */
+	vec = pci_irq_vector(pdev, i);
+	ret = request_irq(vec, nps_core_int_isr, 0, qvec->name, qvec);
+	if (ret) {
+		dev_err(DEV(ndev), "irq failed for nitrox-core-int%d\n", i);
 		goto irq_fail;
+	}
+	cpu = num_online_cpus();
+	irq_set_affinity_hint(vec, get_cpu_mask(cpu));
+
+	tasklet_init(&qvec->resp_tasklet, nps_core_int_tasklet,
+		     (unsigned long)qvec);
+	qvec->ndev = ndev;
+	qvec->valid = true;
 
 	return 0;
 
 irq_fail:
-	nitrox_disable_msix(ndev);
-msix_fail:
-	nitrox_cleanup_pkt_slc_bh(ndev);
-	return err;
+	nitrox_unregister_interrupts(ndev);
+	return ret;
 }
diff --git a/drivers/crypto/cavium/nitrox/nitrox_isr.h b/drivers/crypto/cavium/nitrox/nitrox_isr.h
new file mode 100644
index 000000000000..63418a6cc52c
--- /dev/null
+++ b/drivers/crypto/cavium/nitrox/nitrox_isr.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NITROX_ISR_H
+#define __NITROX_ISR_H
+
+#include "nitrox_dev.h"
+
+int nitrox_register_interrupts(struct nitrox_device *ndev);
+void nitrox_unregister_interrupts(struct nitrox_device *ndev);
+
+#endif /* __NITROX_ISR_H */
diff --git a/drivers/crypto/cavium/nitrox/nitrox_lib.c b/drivers/crypto/cavium/nitrox/nitrox_lib.c
index ed08aa9380ee..2260efa42308 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_lib.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_lib.c
@@ -69,6 +69,7 @@ static void nitrox_cmdq_cleanup(struct nitrox_cmdq *cmdq)
 	nitrox_cmdq_reset(cmdq);
 
 	cmdq->dbell_csr_addr = NULL;
+	cmdq->compl_cnt_csr_addr = NULL;
 	cmdq->unalign_base = NULL;
 	cmdq->base = NULL;
 	cmdq->unalign_dma = 0;
@@ -112,6 +113,9 @@ static int nitrox_alloc_pktin_queues(struct nitrox_device *ndev)
 		/* packet input ring doorbell address */
 		offset = NPS_PKT_IN_INSTR_BAOFF_DBELLX(i);
 		cmdq->dbell_csr_addr = NITROX_CSR_ADDR(ndev, offset);
+		/* packet solicit port completion count address */
+		offset = NPS_PKT_SLC_CNTSX(i);
+		cmdq->compl_cnt_csr_addr = NITROX_CSR_ADDR(ndev, offset);
 
 		err = nitrox_cmdq_init(cmdq, PKTIN_Q_ALIGN_BYTES);
 		if (err)
diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index 13436ca98cb5..6595c95af9f1 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -12,6 +12,7 @@
 #include "nitrox_common.h"
 #include "nitrox_csr.h"
 #include "nitrox_hal.h"
+#include "nitrox_isr.h"
 
 #define CNN55XX_DEV_ID	0x12
 #define MAX_PF_QUEUES	64
@@ -244,7 +245,7 @@ static int nitrox_pf_sw_init(struct nitrox_device *ndev)
 	if (err)
 		return err;
 
-	err = nitrox_pf_init_isr(ndev);
+	err = nitrox_register_interrupts(ndev);
 	if (err)
 		nitrox_common_sw_cleanup(ndev);
 
@@ -253,7 +254,7 @@ static int nitrox_pf_sw_init(struct nitrox_device *ndev)
 
 static void nitrox_pf_sw_cleanup(struct nitrox_device *ndev)
 {
-	nitrox_pf_cleanup_isr(ndev);
+	nitrox_unregister_interrupts(ndev);
 	nitrox_common_sw_cleanup(ndev);
 }
 
diff --git a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
index d606c7af4667..3987cd84c033 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
@@ -721,18 +721,18 @@ static void process_response_list(struct nitrox_cmdq *cmdq)
 }
 
 /**
- * pkt_slc_resp_handler - post processing of SE responses
+ * pkt_slc_resp_tasklet - post processing of SE responses
  */
-void pkt_slc_resp_handler(unsigned long data)
+void pkt_slc_resp_tasklet(unsigned long data)
 {
-	struct bh_data *bh = (void *)(uintptr_t)(data);
-	struct nitrox_cmdq *cmdq = bh->cmdq;
-	union nps_pkt_slc_cnts pkt_slc_cnts;
+	struct nitrox_q_vector *qvec = (void *)(uintptr_t)(data);
+	struct nitrox_cmdq *cmdq = qvec->cmdq;
+	union nps_pkt_slc_cnts slc_cnts;
 
 	/* read completion count */
-	pkt_slc_cnts.value = readq(bh->completion_cnt_csr_addr);
+	slc_cnts.value = readq(cmdq->compl_cnt_csr_addr);
 	/* resend the interrupt if more work to do */
-	pkt_slc_cnts.s.resend = 1;
+	slc_cnts.s.resend = 1;
 
 	process_response_list(cmdq);
 
@@ -740,7 +740,7 @@ void pkt_slc_resp_handler(unsigned long data)
 	 * clear the interrupt with resend bit enabled,
 	 * MSI-X interrupt generates if Completion count > Threshold
 	 */
-	writeq(pkt_slc_cnts.value, bh->completion_cnt_csr_addr);
+	writeq(slc_cnts.value, cmdq->compl_cnt_csr_addr);
 	/* order the writes */
 	mmiowb();
 
diff --git a/drivers/crypto/cavium/nitrox/nitrox_sriov.c b/drivers/crypto/cavium/nitrox/nitrox_sriov.c
index 453d920fbd69..30c0aa874583 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_sriov.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_sriov.c
@@ -5,6 +5,7 @@
 #include "nitrox_dev.h"
 #include "nitrox_hal.h"
 #include "nitrox_common.h"
+#include "nitrox_isr.h"
 
 static inline bool num_vfs_valid(int num_vfs)
 {
@@ -55,7 +56,7 @@ static void pf_sriov_cleanup(struct nitrox_device *ndev)
 	nitrox_crypto_unregister();
 
 	/* cleanup PF resources */
-	nitrox_pf_cleanup_isr(ndev);
+	nitrox_unregister_interrupts(ndev);
 	nitrox_common_sw_cleanup(ndev);
 }
 
@@ -68,7 +69,7 @@ static int pf_sriov_init(struct nitrox_device *ndev)
 	if (err)
 		return err;
 
-	err = nitrox_pf_init_isr(ndev);
+	err = nitrox_register_interrupts(ndev);
 	if (err) {
 		nitrox_common_sw_cleanup(ndev);
 		return err;
-- 
2.17.1

