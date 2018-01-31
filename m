Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeAaI6b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:58:31 -0500
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:40721
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752276AbeAaI6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:58:30 -0500
X-ASG-Debug-ID: 1517389106-093b7e06e818930001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: Yang Shunyong <shunyong.yang@hxt-semitech.com>
To: <vinod.koul@intel.com>
CC: <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Yang Shunyong <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH v2] dmaengine: dmatest: add norandom option
Date: Wed, 31 Jan 2018 16:56:39 +0800
X-ASG-Orig-Subj: [PATCH v2] dmaengine: dmatest: add norandom option
Message-ID: <1517388999-15399-1-git-send-email-shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: localhost[10.128.0.14]
X-Barracuda-Start-Time: 1517389106
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4753 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.47444
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing option noverify disables both random src/dst address offset
setup and data verification. Sometimes, we need to control random
src/dst address setup and verification separately, such as disabling
random to make sure that test covers addresses in all interleaving
banks, but data verification is still performed.

This patch adds option norandom to disable random offset setup. Option
noverify has been changed to disable data verification only.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
---

v2: change to symbolic permissions.

---
 drivers/dma/dmatest.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 80cc2be6483c..e5e39f8131ab 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -74,7 +74,11 @@
 
 static bool noverify;
 module_param(noverify, bool, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(noverify, "Disable random data setup and verification");
+MODULE_PARM_DESC(noverify, "Disable data verification (default: verify)");
+
+static bool norandom;
+module_param(norandom, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(norandom, "Disable random offset setup (default: random)");
 
 static bool verbose;
 module_param(verbose, bool, S_IRUGO | S_IWUSR);
@@ -103,6 +107,7 @@ struct dmatest_params {
 	unsigned int	pq_sources;
 	int		timeout;
 	bool		noverify;
+	bool		norandom;
 };
 
 /**
@@ -575,7 +580,7 @@ static int dmatest_func(void *data)
 			break;
 		}
 
-		if (params->noverify)
+		if (params->norandom)
 			len = params->buf_size;
 		else
 			len = dmatest_random() % params->buf_size + 1;
@@ -586,17 +591,19 @@ static int dmatest_func(void *data)
 
 		total_len += len;
 
-		if (params->noverify) {
+		if (params->norandom) {
 			src_off = 0;
 			dst_off = 0;
 		} else {
-			start = ktime_get();
 			src_off = dmatest_random() % (params->buf_size - len + 1);
 			dst_off = dmatest_random() % (params->buf_size - len + 1);
 
 			src_off = (src_off >> align) << align;
 			dst_off = (dst_off >> align) << align;
+		}
 
+		if (!params->noverify) {
+			start = ktime_get();
 			dmatest_init_srcs(thread->srcs, src_off, len,
 					  params->buf_size, is_memset);
 			dmatest_init_dsts(thread->dsts, dst_off, len,
@@ -975,6 +982,7 @@ static void run_threaded_test(struct dmatest_info *info)
 	params->pq_sources = pq_sources;
 	params->timeout = timeout;
 	params->noverify = noverify;
+	params->norandom = norandom;
 
 	request_channels(info, DMA_MEMCPY);
 	request_channels(info, DMA_MEMSET);
-- 
1.8.3.1
