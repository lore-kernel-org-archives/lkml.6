Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227gzzK1hDctDlyqchVeFMO2glC8WHkaZ8Y6xU84FMJ+9ynOdlX0vMxRq20+kZfnkZL2l3/K
ARC-Seal: i=1; a=rsa-sha256; t=1519217891; cv=none;
        d=google.com; s=arc-20160816;
        b=WNHU8VzpPhOuDAyFsd06jodLgQNwdzR87njubf3oHRa4tMz4eQaoifP6rT+qZs8zp9
         xb271476/Qi9blVLLlW53CzJ7A9ctYe+yHvsyjVdr1eP4enDwFm/p4ziPrUhOZ/GEtT7
         G9KAzr4tfUTyc96oysZemK+A929d0ChJH+SMZ18Ui3XyVcTzmHzwtN3/nmg4amBetfTw
         hFoQxIeb06AU6U7UNIWMKjglXeVCY++N2fxWVM1/k966muUaP4Awl16Gqxz4NEN1DElm
         f34Y6H5cdhfYAJuFW+T8Lc+a0SLthSB7fPsVzkixcMMNsIvRWZIUrqUu+BYnfceyVRH8
         6B2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HqsdRS5bl2vI7YwONHlC2bonYK2JNqJYYOxYsa3Qzh8=;
        b=ohAShA4OYtCXcC2Vo+0+ol6ey+wmgkGd4p0kiJxM/b3eKvpipoPTd+eCBGe8pq6n7j
         ypwJmLcUwzgNnbBHgSoTaxs7bEQ4K4FNrtp7ySJc2Ubs50jnnbG6jRpDnWrARzWJODKF
         Tj517J3eKJwSUdzU/0nvT2Rl6UmYA+0SCeZ7psSStIUeFAu6DzcaajhMvThJ60e44a+V
         6DLAMljOkqT6NdfLcDcWV32vnuflzoBuBmqoFs67+sKmuJ7hCnxBPx2Xst+SMckAqyMa
         WL5fmCnqWdPeCwhiPmZGIeliz/lIuGctWQUdCB0mQCQNWHpWEgvfhdrR+3wePQ88nM56
         NViw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Mike Galbraith <efault@gmx.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.14 015/167] swiotlb: suppress warning when __GFP_NOWARN is set
Date: Wed, 21 Feb 2018 13:47:06 +0100
Message-Id: <20180221124525.450387495@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015420254067670?=
X-GMAIL-MSGID: =?utf-8?q?1593015420254067670?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <ckoenig.leichtzumerken@gmail.com>

commit d0bc0c2a31c95002d37c3cc511ffdcab851b3256 upstream.

TTM tries to allocate coherent memory in chunks of 2MB first to improve
TLB efficiency and falls back to allocating 4K pages if that fails.

Suppress the warning when the 2MB allocations fails since there is a
valid fall back path.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reported-by: Mike Galbraith <efault@gmx.de>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Bug: https://bugs.freedesktop.org/show_bug.cgi?id=104082
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/swiotlb.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -585,7 +585,7 @@ phys_addr_t swiotlb_tbl_map_single(struc
 
 not_found:
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
-	if (printk_ratelimit())
+	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
 	return SWIOTLB_MAP_ERROR;
 found:
@@ -712,6 +712,7 @@ void *
 swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		       dma_addr_t *dma_handle, gfp_t flags)
 {
+	bool warn = !(flags & __GFP_NOWARN);
 	dma_addr_t dev_addr;
 	void *ret;
 	int order = get_order(size);
@@ -737,8 +738,8 @@ swiotlb_alloc_coherent(struct device *hw
 		 * GFP_DMA memory; fall back on map_single(), which
 		 * will grab memory from the lowest available address range.
 		 */
-		phys_addr_t paddr = map_single(hwdev, 0, size,
-					       DMA_FROM_DEVICE, 0);
+		phys_addr_t paddr = map_single(hwdev, 0, size, DMA_FROM_DEVICE,
+					       warn ? 0 : DMA_ATTR_NO_WARN);
 		if (paddr == SWIOTLB_MAP_ERROR)
 			goto err_warn;
 
@@ -768,9 +769,11 @@ swiotlb_alloc_coherent(struct device *hw
 	return ret;
 
 err_warn:
-	pr_warn("swiotlb: coherent allocation failed for device %s size=%zu\n",
-		dev_name(hwdev), size);
-	dump_stack();
+	if (warn && printk_ratelimit()) {
+		pr_warn("swiotlb: coherent allocation failed for device %s size=%zu\n",
+			dev_name(hwdev), size);
+		dump_stack();
+	}
 
 	return NULL;
 }
