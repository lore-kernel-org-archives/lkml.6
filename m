Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225y0z5MqoeMjljpXvPokEXATEpc/QTAInUBJDlwGZsJwS2aKDdp0ZQmnqm69u7wsn8UhGQk
ARC-Seal: i=1; a=rsa-sha256; t=1519218366; cv=none;
        d=google.com; s=arc-20160816;
        b=Yp0Z9lyYWIVFLxcXqwRx5bnDQBhrltxKkun6yGIK1aLB8qtj0zyu+uo5No4FcLUQg9
         8r/xuLcMc4z4nG9mAu/BYVmU2RlwEge81WNraRm7s1ogmltspsH8Dtgw/NgWlMr4J4ps
         ZdcTmz2OXRDcOPlj44wwyFjPsqU08+0v0Qc+VOzpeLnZxwX8VWEd6rRgWv2cFmhvRgF+
         c0GB5PdPwtwoXP8zUGhXL9lo/ZaJtX+c2sjY0jnyLzqC9j8t9J8u7CZD3ttc5gjQGBTh
         RsYMCtsddEp2fgPEMzDjumTeMggBqp6wOO2yutbnZPVjJ6fVJuP1JhXIQxXJIW6ikNGQ
         UMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GrHHLsISn+fwFs3S9M0N1ykWB3c1J0WGypeOw7I8TcI=;
        b=EFx/m05nOx8ZkF9Sr1wrIWrEm58ixwRDS+p/QaeGIUeb2h0EZ7BmAWI+OSIvhN6Rlh
         1T3G46JmojkL+ssSR5lLzhiJsntR71B28CM8Er8SsvrKArRdx76DhI+1v5wRCCAKa6rm
         DFZno4BM4tGa1EHnnvQj3BGFU01veGW2nr1M7nHvJ3D0DXsHmcxIPmzY1wziqeRMFfRz
         rtcfkqeOXHuZAu+e/oKJZeB/d4gHOB1eiHyxPCXqRVI+AifYvD+a7wvG4bOoLdQTZ0mr
         qv1KZ7Ww4Cumm/FXwVqBrhVkVFG3n4aZ1zjmyz+HOYQZIVez3WgpjLJAeMzz9RpuUwZS
         LkfA==
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
Subject: [PATCH 4.15 014/163] swiotlb: suppress warning when __GFP_NOWARN is set
Date: Wed, 21 Feb 2018 13:47:23 +0100
Message-Id: <20180221124530.872594930@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015420254067670?=
X-GMAIL-MSGID: =?utf-8?q?1593015917455479564?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -586,7 +586,7 @@ phys_addr_t swiotlb_tbl_map_single(struc
 
 not_found:
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
-	if (printk_ratelimit())
+	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
 	return SWIOTLB_MAP_ERROR;
 found:
@@ -713,6 +713,7 @@ void *
 swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		       dma_addr_t *dma_handle, gfp_t flags)
 {
+	bool warn = !(flags & __GFP_NOWARN);
 	dma_addr_t dev_addr;
 	void *ret;
 	int order = get_order(size);
@@ -738,8 +739,8 @@ swiotlb_alloc_coherent(struct device *hw
 		 * GFP_DMA memory; fall back on map_single(), which
 		 * will grab memory from the lowest available address range.
 		 */
-		phys_addr_t paddr = map_single(hwdev, 0, size,
-					       DMA_FROM_DEVICE, 0);
+		phys_addr_t paddr = map_single(hwdev, 0, size, DMA_FROM_DEVICE,
+					       warn ? 0 : DMA_ATTR_NO_WARN);
 		if (paddr == SWIOTLB_MAP_ERROR)
 			goto err_warn;
 
@@ -769,9 +770,11 @@ swiotlb_alloc_coherent(struct device *hw
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
