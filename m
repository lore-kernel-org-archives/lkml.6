Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvQcWG7hNeqLzLI0dH05mEtFFt3P/zv4LOQxLY/ieopI2bYcLOfCnpfOagOxvRvOQAvrRkq
ARC-Seal: i=1; a=rsa-sha256; t=1519981347; cv=none;
        d=google.com; s=arc-20160816;
        b=TirnvlcVOLfxWsnQMpoL4v+BXv16iImd1HnC5KsHADssuSP8u3C9Ze2JFUHzIZQ8dz
         +TjGhOBYSuX2Vn2cuyaLPsVSQCir/xcThfjNs4dQw2x5t6sLzdFqhFn20txVei2FYHSP
         RG3+mvFqGhOH9IOnua5NnD6qCrko+M0IK44EHmY9E2Dz8CrXaih4OaZFiUktZyMMu2MA
         6TwAoLXI/XlccZKHfzepOI20jePDqmigdlOEG6LuM2FWaLOYQtnASCkZK2W9T1BHSVOU
         DfOXKUfaIzr8m7i6pZjCL3LZIOqlZhd7dGq9lUpdQF5GGvkZvjCT1wt+Zjo+A1jcDUlN
         BTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6PXue4gIKUF2CcdknBMFMc19/WRp2WRi8CfnKveUyB4=;
        b=jjbpmPdA2ywHCsG3thNU4mTDtq06BVMyu3jl0vMQLQDPtCC0+ZT2ML6pO+CpER8Omq
         0BFVsxODmHdMgtKYdWziHRA+ZPhLuwv//w7zr/s3Ie7XJXjwjrGI8S4zQFkXYCULnoQC
         hXQyOOkfnE4yloX8QGrkpWuksf4Y3iAm4G5WnWCJSCYcSVGGOyFrPXQShG7fdZRrqON1
         zqG6yI3co5+C3b17xODi5XQXEvXRNBZjY2eeOoOOnTnxE+N7p5EJfUg3qlheCZM3wfJY
         dvN0OMf+jM7+868Oou06tw6enJ2rwgJPa3RYP3BK1EHp2E1AoJpLVdKzjq4WdoO1Jji/
         PS5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Laura Abbott <labbott@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Archit Taneja <architt@codeaurora.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dmitry Shmidt <dimitrysh@google.com>,
	Todd Kjos <tkjos@google.com>,
	Amit Pundir <amit.pundir@linaro.org>,
	John Stultz <john.stultz@linaro.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 028/115] staging: ion: Fix ion_cma_heap allocations
Date: Fri,  2 Mar 2018 09:50:31 +0100
Message-Id: <20180302084505.020839840@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815961486298814?=
X-GMAIL-MSGID: =?utf-8?q?1593815961486298814?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Stultz <john.stultz@linaro.org>


[ Upstream commit f292b9b28097d8fe870336108e91bd95a14294bf ]

In trying to add support for drm_hwcomposer to HiKey,
I've needed to utilize the ION CMA heap, and I've noticed
problems with allocations on newer kernels failing.

It seems back with 204f672255c2 ("ion: Use CMA APIs directly"),
the ion_cma_heap code was modified to use the CMA API, but
kept the arguments as buffer lengths rather then number of pages.

This results in errors as we don't have enough pages in CMA to
satisfy the exaggerated requests.

This patch converts the ion_cma_heap CMA API usage to properly
request pages.

It also fixes a minor issue in the allocation where in the error
path, the cma_release is called with the buffer->size value which
hasn't yet been set.

Cc: Laura Abbott <labbott@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Shmidt <dimitrysh@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Amit Pundir <amit.pundir@linaro.org>
Fixes: 204f672255c2 ("staging: android: ion: Use CMA APIs directly")
Acked-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/android/ion/Kconfig        |    2 +-
 drivers/staging/android/ion/ion_cma_heap.c |   15 +++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/staging/android/ion/Kconfig
+++ b/drivers/staging/android/ion/Kconfig
@@ -37,7 +37,7 @@ config ION_CHUNK_HEAP
 
 config ION_CMA_HEAP
 	bool "Ion CMA heap support"
-	depends on ION && CMA
+	depends on ION && DMA_CMA
 	help
 	  Choose this option to enable CMA heaps with Ion. This heap is backed
 	  by the Contiguous Memory Allocator (CMA). If your system has these
--- a/drivers/staging/android/ion/ion_cma_heap.c
+++ b/drivers/staging/android/ion/ion_cma_heap.c
@@ -39,9 +39,15 @@ static int ion_cma_allocate(struct ion_h
 	struct ion_cma_heap *cma_heap = to_cma_heap(heap);
 	struct sg_table *table;
 	struct page *pages;
+	unsigned long size = PAGE_ALIGN(len);
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	unsigned long align = get_order(size);
 	int ret;
 
-	pages = cma_alloc(cma_heap->cma, len, 0, GFP_KERNEL);
+	if (align > CONFIG_CMA_ALIGNMENT)
+		align = CONFIG_CMA_ALIGNMENT;
+
+	pages = cma_alloc(cma_heap->cma, nr_pages, align, GFP_KERNEL);
 	if (!pages)
 		return -ENOMEM;
 
@@ -53,7 +59,7 @@ static int ion_cma_allocate(struct ion_h
 	if (ret)
 		goto free_mem;
 
-	sg_set_page(table->sgl, pages, len, 0);
+	sg_set_page(table->sgl, pages, size, 0);
 
 	buffer->priv_virt = pages;
 	buffer->sg_table = table;
@@ -62,7 +68,7 @@ static int ion_cma_allocate(struct ion_h
 free_mem:
 	kfree(table);
 err:
-	cma_release(cma_heap->cma, pages, buffer->size);
+	cma_release(cma_heap->cma, pages, nr_pages);
 	return -ENOMEM;
 }
 
@@ -70,9 +76,10 @@ static void ion_cma_free(struct ion_buff
 {
 	struct ion_cma_heap *cma_heap = to_cma_heap(buffer->heap);
 	struct page *pages = buffer->priv_virt;
+	unsigned long nr_pages = PAGE_ALIGN(buffer->size) >> PAGE_SHIFT;
 
 	/* release memory */
-	cma_release(cma_heap->cma, pages, buffer->size);
+	cma_release(cma_heap->cma, pages, nr_pages);
 	/* release sg table */
 	sg_free_table(buffer->sg_table);
 	kfree(buffer->sg_table);
