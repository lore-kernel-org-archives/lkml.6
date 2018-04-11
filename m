Return-Path: <kernel-hardening-return-12964-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49mHEJaSqkULQKqdhMCFXcmLmTvumHdr9B/Imbivp1xDGKoZE1NwvR5kVB3uL085Gva0H7m
ARC-Seal: i=1; a=rsa-sha256; t=1523408570; cv=none;
        d=google.com; s=arc-20160816;
        b=KAaqyoFJ0ujUggNI/yNuCfssY4nDBdL3kuHcSngwihSnohZ1G1MynSne9K1L1BI2Zz
         0+4KT/vLAKrLMSEisektxJms4hV3/tTFmtSyWWp60+pdflcBgx+szyT2aYiMc1W5v6U2
         DUA/tEjDFsrephr8pLo2OvhES05eVQ7lcslDTvuxLWH9XfxMLfyoU1NlFCf2g/grzstj
         MGANXNbi9AqoGdoYIHGuytD9VrBax+NQ9e+CJJM0cm0GGFjI/r2l83R7scxSF24kpKKb
         E7v+og5PvW44NEYsggF7U+y068C/wxAjlQqIV+MAdB/52pPqYGO1PQjAgBsSo/oj0VGJ
         voYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=O8WfciiDYl7Lhr+NJARHFTMcRAkCHWWB76RpECIFM0U=;
        b=mDyMirHQJt8jX+URDyEGOGKg1K3NHEfXETMJiiYiILRqiDXPFZHqmM3pUC28JqVAHm
         9sanUwp18YKa2THFRY+E+BpF2GX495enu8TH3zvJz1F0tY62ayMQ1nPgXcMMB9iXOt3t
         OpDW8oVHgtOdqQkd8bWZ76DIC7zBnhvWbB80CVdOBF54RFj3L/3VDJAfIb5ZItVzTXs+
         CBoNtfKSzxQXLtCQagHEB+cOIU5aQcT66WzHOr0V3RUpdCKJXmodRcpYcjf2mJVahZgT
         CXNzTDXf83QNtw+ELexIQ0JfDf3TDatbvj+cT92e+KgyUl3HeMhSfPux0iPgCsArONcF
         9WkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12964-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12964-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12964-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12964-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Vinod Koul <vinod.koul@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Laura Abbott <labbott@redhat.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>,
	Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCHv2] dmaengine: dmatest: Remove use of VLAs
Date: Tue, 10 Apr 2018 18:02:16 -0700
Message-Id: <20180411010216.17702-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597409665574809172?=
X-GMAIL-MSGID: =?utf-8?q?1597409665574809172?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There's an ongoing effort to remove VLAs from the kernel
(https://lkml.org/lkml/2018/3/7/621) to eventually turn on -Wvla.
The test already pre-allocates some buffers with kmalloc so turn
the two VLAs in to pre-allocated kmalloc buffers.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Switch to using kmalloc buffers instead of putting a large array on
the stack.
---
 drivers/dma/dmatest.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 80cc2be6483c..9730956dfbe3 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -463,6 +463,8 @@ static int dmatest_func(void *data)
 	unsigned long long	total_len = 0;
 	u8			align = 0;
 	bool			is_memset = false;
+	dma_addr_t		*srcs;
+	dma_addr_t		*dma_pq;
 
 	set_freezable();
 
@@ -546,6 +548,14 @@ static int dmatest_func(void *data)
 
 	set_user_nice(current, 10);
 
+	srcs = kcalloc(src_cnt, sizeof(dma_addr_t), GFP_KERNEL);
+	if (!srcs)
+		goto err_dstbuf;
+
+	dma_pq = kcalloc(dst_cnt, sizeof(dma_addr_t), GFP_KERNEL);
+	if (!dma_pq)
+		goto err_srcs_array;
+
 	/*
 	 * src and dst buffers are freed by ourselves below
 	 */
@@ -556,7 +566,6 @@ static int dmatest_func(void *data)
 	       && !(params->iterations && total_tests >= params->iterations)) {
 		struct dma_async_tx_descriptor *tx = NULL;
 		struct dmaengine_unmap_data *um;
-		dma_addr_t srcs[src_cnt];
 		dma_addr_t *dsts;
 		unsigned int src_off, dst_off, len;
 
@@ -669,8 +678,6 @@ static int dmatest_func(void *data)
 						      srcs, src_cnt,
 						      len, flags);
 		else if (thread->type == DMA_PQ) {
-			dma_addr_t dma_pq[dst_cnt];
-
 			for (i = 0; i < dst_cnt; i++)
 				dma_pq[i] = dsts[i] + dst_off;
 			tx = dev->device_prep_dma_pq(chan, dma_pq, srcs,
@@ -772,6 +779,9 @@ static int dmatest_func(void *data)
 	runtime = ktime_to_us(ktime);
 
 	ret = 0;
+	kfree(dma_pq);
+err_srcs_array:
+	kfree(srcs);
 err_dstbuf:
 	for (i = 0; thread->udsts[i]; i++)
 		kfree(thread->udsts[i]);
-- 
2.14.3
