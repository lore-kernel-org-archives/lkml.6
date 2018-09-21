Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ACDECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2C521479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="S9uXydVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2C521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389938AbeIUR2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:28:18 -0400
Received: from mail-co1nam03on0077.outbound.protection.outlook.com ([104.47.40.77]:40394
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389643AbeIUR2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fl4nA7y38JqVh0y+9ZOMbkjwdwVWwGqmHHlXCB8czHs=;
 b=S9uXydVJ7d8ZNxku5ZGhiU5YpTPXSUmk/dWKH+UiPzmZPzoAnIXpOwtz58sjuO1DL0050M0bP+0grUyg/MzHs9yHsS5gYvAs8yBMkdZ4nal3ILjySCagEN3N6lNwvXuh9n5hSd9PI4a1Ip50e08lC5mB6vCH7gzLlpfHGb8GT20=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jampala.Srikanth@cavium.com; 
Received: from hyd1621.caveonetworks.com (115.113.156.2) by
 SN6PR07MB4622.namprd07.prod.outlook.com (2603:10b6:805:3a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 21 Sep 2018 11:39:09 +0000
From:   Srikanth Jampala <Jampala.Srikanth@cavium.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgadam@cavium.com, Jampala.Srikanth@cavium.com
Subject: [PATCH cryptodev-2.6 2/3] crypto: cavium/nitrox - add support for per device request statistics.
Date:   Fri, 21 Sep 2018 17:08:01 +0530
Message-Id: <20180921113802.26475-2-Jampala.Srikanth@cavium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921113802.26475-1-Jampala.Srikanth@cavium.com>
References: <20180921113802.26475-1-Jampala.Srikanth@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [115.113.156.2]
X-ClientProxiedBy: MA1PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::16) To SN6PR07MB4622.namprd07.prod.outlook.com
 (2603:10b6:805:3a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 868abcd5-ee16-4bd7-fc0d-08d61fb6d9c1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4622;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4622;3:SqaaQ6xTmDVMe25y57DWSxCXGkC9RdGwtAebPXj7Mqz9CGmaEx5+KKrGpWrEsPUDpMhNGCspWBYwcBkMrmLXjtBLNoMt2+vMuOy7+iw6LH9Sce0J/Nh0IYJ8jlDexvc/gkMfQWVKnJcfN6CMoBfslZx+a1C2qtJ9ilc3ZfqDTAkLz7NzGYWQJWMs/mK8aSDHps02nnHcFzSPMyMXFXuo5W/eGjYFUEIkM6hLGB8Q53cWQPSXaDLcFYKgcnrdl93j;25:CQ1pVeQm29UNMeINEfpaj5Pza871DaFO90b23zCFFt1lmI/S/+ZpTfkZfJ1DWZ1dNzj5EcVidtQEhtRnwsdHivpQ1lNHYEt8+UOd4TpyJT9of9/JuTnwwSUhzLwT7QgyhIlgaTRe4RbW1FbKFag0RAbSGeavET6e8aaFMPxcrw3lO2EPfNpcYXo58xczqrA2R52gbxbwhCXFYWAZSbMFM9P/n0Q/RohVUSZLuu9/1s7CiomaMxFZrY6596NaLvoVzLd7dMlYLmb5/0vAVMURrHh2qCFvh0waEaQpw9B7dCA1N8TP/9IXdQK6AGFavS4XwEmgIl4sC4i7BaaG6z5i2A==;31:GQTz39vt2O7Ef1FebRwLjyptao7E+Kt7IKyOuyhrSiheUwilWeYjKixypWsoloC4/s1DfzAgqLLkTrxZuGMommq6yM+6TcON549/0TscQyZE+/cznUpOCZESPGDM87udzra8S/aLIyQsztSynyri4OpFZJ8BGBcqiBDBQhrI5ZYhRt4GEy+aXJyq/NyTMVei7jAQrfTBLJAVF/tAga+HNEp40JxtZyVW1iDVGYAbtnc=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4622:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4622;20:+bK6ZYZUMMV0biQYtUAUWInZm0ZcJbdMCzFpNonH4k5nWf+sYrRdLHzl2PuA/lykqtfC+TZyQK6RWKG2Y+uerQs/pBaKgcPDrgLSHllaTwiLNohATC370wZxyAk19WGeb8V1rrom6Ijjpsc58/rFZrPENVJKC5kiCXe9Mvs4jvpdIkgrzwt36vsqg+mQFoVPL3KpSD5NVRw6QUFZt9QbC0YZQJ3fx1tHS+CCQpZHU8wOlq/a/+Gvx6l15zNEbN7xdnayx26jhXUDyB7z9YG3euHxLXhHqTI/iLri/5OPmmj64RBh1+A26AKVoSaG1yHH7LjoXgPJ4ciZjc2JlGyY9xlK9kTSwNe7EsmQVoPf+VpnzjoShXSxZaP7U5qA803TDPgMZInCHhipfC0h237MzlnxHPVv4/bdKafX5Dt+rrCaw38x+eZOUHpSZGd6eSdozP9Lt6TYgKXuhDRllL2iq5Qih1WOQl7+t/QQFKwXMeD3rYxQeMAcpUlvz7+riP2N;4:/bfb/Bhmmf9fp278V3TdOtoXR+IzYBlF4i+dowGkkuRLg0xTy17XERqDGWvKd3qNwm9l0NcEs1z4EQ4DpG3y8wrC5H9UQNxiLmILE9upYTK+AyweS12G754oxPV2/9gOIT5BTblUfwqAHCKjcuVoZ20acrlFPriFuILgNSikyzvp+wK0UQY/u4VgiQkd5c8/bg/r/z4l4D7MrY76qMS8xk/vVuAEHpnXjhA4sGwBbDwvVPLoyPnR/EEK2EMzyKJl67d7lXbX+kQgXeJ4n2MOIQ==
X-Microsoft-Antispam-PRVS: <SN6PR07MB46228FA28BD048202007605FF4120@SN6PR07MB4622.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:SN6PR07MB4622;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4622;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(376002)(39860400002)(136003)(366004)(396003)(346002)(189003)(199004)(316002)(97736004)(16586007)(6506007)(47776003)(16526019)(8936002)(76176011)(107886003)(106356001)(81166006)(53416004)(5660300001)(3846002)(69596002)(52116002)(51416003)(14444005)(575784001)(1076002)(105586002)(4326008)(86362001)(8676002)(6486002)(6116002)(305945005)(6512007)(186003)(6666003)(7736002)(476003)(72206003)(26005)(478600001)(446003)(48376002)(486006)(50466002)(11346002)(956004)(2616005)(25786009)(66066001)(386003)(81156014)(68736007)(36756003)(50226002)(2906002)(55236004)(53936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4622;H:hyd1621.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4622;23:yW9GV96Gb6wdqWrOtzeBB2/wvqt6sWncphIRQ5Rnc?=
 =?us-ascii?Q?81sZ/88M28Wi1lJSt7cagA1deNaF38Sbb4z8/T26hnsovuDFHvV9dVKusp8b?=
 =?us-ascii?Q?aUCte8Oe2XxbTFVtFyfNBYkG/WaAyQW3jGKaGpknMMIoKx4JoDsT0Z6wh514?=
 =?us-ascii?Q?V1nHtu/iKA9bZkhDnKlasY5b4CMDXL5uh6GDQGgbMVWkVMEASdu5tMoa63m+?=
 =?us-ascii?Q?nxwNU/fzab10jYP5ityqLv94aW/Tzlek4gmrq6xVrsBK0AGRo5bxw5/YoX5E?=
 =?us-ascii?Q?pvdJcesnnTY+ky8NNg4gfn+RlQkpVsLS+zYmbfV6TDFwSSdgzWoi4BpmOm5g?=
 =?us-ascii?Q?yUlrO3qPO+aW7uOtj4UuTCNwz3fzOsOE94Wsj671ocH8VQQbdDAJPOptmpWx?=
 =?us-ascii?Q?e/r8tyAPf+w9V5Pv216/eQPM2DTkva+o9HrqhEa88O/hx4gehXfIsxlR9S8H?=
 =?us-ascii?Q?PaR1uK3lngaYg2S3ptyf/cOdezUbkTCvVFmARWTb+OK+TokaVNloYsrPpWOB?=
 =?us-ascii?Q?3xL21RZ6KHu5mZC2VnOwMgsxhoFFWoWN5uzglULdsEEq0+HbvgU+N3B/N16b?=
 =?us-ascii?Q?A53B2Z3hKNTZOLPq6ZQiore+2mFSkVCrApTW0Kep6+asSH4cT5BS8XlcCAI9?=
 =?us-ascii?Q?VlEGltaNzeNS7oBJlC70lZaqvFkclDwJ9NxKl8Fuhsjq6ohcAWMBHF7sfcbB?=
 =?us-ascii?Q?2D4cAzCnKobBX7IWrUjGUyw4/fWINXjFjIHdIICxVlbwWIW85DM8nr+/lPot?=
 =?us-ascii?Q?1S6wNxZ1APDOAWFOhvHxvOH+k636l+NHyIvFKP3greDPk4JEIVqicirJNWKj?=
 =?us-ascii?Q?frML07KScIEpeUfLO/UM2XoZ+q99MUeTUolzUb8crf2ji7GrXRXwOjYqI7P7?=
 =?us-ascii?Q?fao/cJFeFXOUX6p8SK6ATl5LgTFHxDduoZtm71xW+TaGcUjEoNqHee8/Tg6v?=
 =?us-ascii?Q?L99Dr+lR3YP+n5qTTP5azjWhC1AL41r0bp/jl5EHomfTQkQ+KYtt2lPSrBYu?=
 =?us-ascii?Q?NYRDGXELQrrvplfPSTjbwEZNcGHwdg4EeKgOQDHSNgeaGoN55VnlRJ3pjZ19?=
 =?us-ascii?Q?Iy9GM+jIULFeDWXXYNEk/i1io2OCGxiTDmXOenXyI1QQcPVkNDBzDsrlVhk2?=
 =?us-ascii?Q?qHhuBNaF2sdQTsOJISQuSFh7p7QxIlp1o4quGQ4S/6+CEQ82i6P1dGY+iaxV?=
 =?us-ascii?Q?rhIB5cY6US7j+Bk5HqeBawVj3IQkTZmLAB1J6QWt5eSITiy3j98v2edg9nox?=
 =?us-ascii?Q?2cwRFsyxMZZTpu5GBgGJ4iN7LYDaGeVn1leMpHQQq3yVWTp/0agPm0OS05UO?=
 =?us-ascii?Q?8wFnWoLomswNVianaCugk+esTkZzs9EZod+KzW5D47Y+f/vWId3QJn/yhUYj?=
 =?us-ascii?Q?pT1CFisY2179MVpiTtDN5zue5OBc0mvFscYHx55i/k5YO85UfuZRh9gspCD1?=
 =?us-ascii?Q?reLYMwIRw=3D=3D?=
X-Microsoft-Antispam-Message-Info: jdEz9PtLSJXrkD2BP/+Y9A90X0Y5soFUyOv6bS+cPZPoHSHxTzMeGJ2qzmRapiIrkHYyrfjH90r+khJtDLF7Nk9AgwhWNX5xP/+aouz/yMSrRJFKcH0hj0YBWeKDH3gjnTsKDKV+0sVTHXG6ZS8rWEtIpN495MNjJj9SlhhqBjJBjNDKkNa0R2q2f4FlyAj5L2KhVVPqBM1qXHbT4XpZKnwbU0KCLIvq4djrfHQGx1bMDLsF75aGW5NtSQi97af1Th5K8blO/Uw1L2BS/nfnk9Wlz5xw/TGnTTyJJVnEQIe0KehpR6t27vzvtYvQV+4UqcyWRjmdqqAaBQcVEn+W1RbJt8Xk8ooHTWxsTBT3l0w=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4622;6:lFgQScMky3poty1ErjtVoblzhZ+6gaFz2Yj9IeZzCaLbBg6YBQGh9QIAYPO9r1xB1td78pS64bBC1Pr4Rxcj4+A4lLerss0JUtcUyP2cLVG4MNiNxtzd+mUQYMgcTPIW0vELMSNAwmX0CTBpN5X8n14jWzPy3LXPx4K/mi8N6LDlodc8SeZa8+Qwv9qGRgaTP7vqrSApw2t86oIgHNuq5j0y5pyYbWCRXyueRoUmJyu1lc7VwgqX7FjaiLbHfnqMIsHiwci8rG54EW2GC03uWliB4xzVNd4mfnp5mW3OhdUhaU1dys9Ma6TUBluqrfe9CqvqcryrFfl+IoN2x2TdOU/stp9qwVwbmDkm5qT2LEmcR+q/bZKBqwI+YeAcQVLtFSSCLfO7bWhL5bbpVsZ+exmHezbNf/RvWxCERFzyvEKkC4CZyAWYwLMIslWWePyZkOcG5sa4NijlG62XVPfOyw==;5:TlFItydBvCYgq40HtARVXFTR8Nu6h4C+m1D2dcM+DPsELQed46CsYxKq44psy567Tvq6sNHj0tpRAehaQ3sWWHu+V4o3LvfgmoVp/iya8R2/CMs3e9/xbn3nxQGaAzVOsUUij4OU05d7oE0U93aLnAlU51jkUrMq6PYleZvNNY4=;7:x4YQoLK7Q8RLgIkvf01PGjnMioKj70n5p8C4mFpHbljCIG2v34L6RUrXOaa+BaIGGmNIGmYcY5VZI0HIm5h5w6bHEI2NYPvJKKoISEQN3pA3sD27c64ATovbukbWlFXnDV69NqfqlA4CQHIxpoQ41E0lllXP09igfikRMGNWdIW07ADVdAYAQECmRd6a7eY7LTvr/A7lrBPCfpDxljZpBdDEeKinM22MEP/Z5y8BfFVD6yl7YN4nRyKhHuDghi0P
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 11:39:09.7507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868abcd5-ee16-4bd7-fc0d-08d61fb6d9c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add per device statistics like number of requests posted,
dropped and completed etc.

Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
---
 drivers/crypto/cavium/nitrox/nitrox_dev.h    | 7 +++++++
 drivers/crypto/cavium/nitrox/nitrox_main.c   | 5 +++++
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c | 9 ++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_dev.h b/drivers/crypto/cavium/nitrox/nitrox_dev.h
index 1059495ee541..a1442006f256 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_dev.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_dev.h
@@ -75,6 +75,12 @@ struct nitrox_hw {
 	u8 zip_cores;
 };
 
+struct nitrox_stats {
+	atomic64_t posted;
+	atomic64_t completed;
+	atomic64_t dropped;
+};
+
 #define MAX_MSIX_VECTOR_NAME	20
 /**
  * vectors for queues (64 AE, 64 SE and 64 ZIP) and
@@ -176,6 +182,7 @@ struct nitrox_device {
 	struct nitrox_msix msix;
 	struct nitrox_bh bh;
 
+	struct nitrox_stats stats;
 	struct nitrox_hw hw;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *debugfs_dir;
diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index acce0f0b9c7a..362e7217354c 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -542,6 +542,11 @@ static int nitrox_probe(struct pci_dev *pdev,
 	if (err)
 		goto pf_hw_fail;
 
+	/* clear the statistics */
+	atomic64_set(&ndev->stats.posted, 0);
+	atomic64_set(&ndev->stats.completed, 0);
+	atomic64_set(&ndev->stats.dropped, 0);
+
 	atomic_set(&ndev->state, __NDEV_READY);
 	/* barrier to sync with other cpus */
 	smp_mb__after_atomic();
diff --git a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
index 4a362fc22f62..f325b48ba904 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
@@ -460,6 +460,9 @@ static void post_se_instr(struct nitrox_softreq *sr,
 	cmdq->write_idx = incr_index(idx, 1, ndev->qlen);
 
 	spin_unlock_bh(&cmdq->cmdq_lock);
+
+	/* increment the posted command count */
+	atomic64_inc(&ndev->stats.posted);
 }
 
 static int post_backlog_cmds(struct nitrox_cmdq *cmdq)
@@ -508,8 +511,11 @@ static int nitrox_enqueue_request(struct nitrox_softreq *sr)
 	post_backlog_cmds(cmdq);
 
 	if (unlikely(cmdq_full(cmdq, ndev->qlen))) {
-		if (!(sr->flags & CRYPTO_TFM_REQ_MAY_BACKLOG))
+		if (!(sr->flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
+			/* increment drop count */
+			atomic64_inc(&ndev->stats.dropped);
 			return -ENOSPC;
+		}
 		/* add to backlog list */
 		backlog_list_add(sr, cmdq);
 		return -EBUSY;
@@ -694,6 +700,7 @@ static void process_response_list(struct nitrox_cmdq *cmdq)
 					    READ_ONCE(sr->resp.orh));
 		}
 		atomic_dec(&cmdq->pending_count);
+		atomic64_inc(&ndev->stats.completed);
 		/* sync with other cpus */
 		smp_mb__after_atomic();
 		/* remove from response list */
-- 
2.17.1

