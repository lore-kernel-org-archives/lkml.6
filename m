Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC3AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4709720852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VBwMbPrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4709720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbeGWX6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:58:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbeGWX6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CX16x5cyOJ8CtJJDMrQr5iF1k8tI5ZfPMhVdT30nfJw=; b=VBwMbPrWCjD27ped0yk8PFzb7
        swaXSV9O4JlkDqORhMOhovpKX0Q7XCrVcHjYTcxmPRiYYHK52yJ66HLPH9pjeK/TfM/MkUBtyY09c
        HjU819kOD9OcJvWM2VF6vbxJRPAxSi2VcLU4msGyVlY3eGE+qrLIi038kF2TBImTT1Y/H7of2ByJg
        Zlxx9jWOv0Gg9Fgz3ErcdOWoZKEr4FdjBNvWTMetxva7E4xmgrjsiMGjclVF51MYwL6XfhYJ36QTE
        UP9WiUIYTT5o5qte3gD6pxDARbpDHvWnaRe6so5RvMVYhF1x2spT//kGvTuf1RrxERDGOnpWbO4+1
        O4wZZ+usw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhjjC-00080D-Uh; Mon, 23 Jul 2018 22:54:54 +0000
Date:   Mon, 23 Jul 2018 15:54:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/shmem.c:LINE!
Message-ID: <20180723225454.GC18236@bombadil.infradead.org>
References: <000000000000d624c605705e9010@google.com>
 <20180709143610.GD2662@bombadil.infradead.org>
 <alpine.LSU.2.11.1807221856350.5536@eggly.anvils>
 <20180723140150.GA31843@bombadil.infradead.org>
 <alpine.LSU.2.11.1807231111310.1698@eggly.anvils>
 <20180723203628.GA18236@bombadil.infradead.org>
 <alpine.LSU.2.11.1807231531240.2545@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1807231531240.2545@eggly.anvils>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 03:42:22PM -0700, Hugh Dickins wrote:
> On Mon, 23 Jul 2018, Matthew Wilcox wrote:
> > I figured out a fix and pushed it to the 'ida' branch in
> > git://git.infradead.org/users/willy/linux-dax.git
> 
> Great, thanks a lot for sorting that out so quickly. But I've cloned
> the tree and don't see today's patch, so assume you've folded the fix
> into an existing commit? If possible, please append the diff of today's
> fix to this thread so that we can try it out. Or if that's difficult,
> please at least tell which files were modified, then I can probably
> work it out from the diff of those files against mmotm.

Sure!  It's just this:

diff --git a/lib/xarray.c b/lib/xarray.c
index 32a9c2a6a9e9..383c410997eb 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -660,6 +660,8 @@ void xas_create_range(struct xa_state *xas)
 	unsigned char sibs = xas->xa_sibs;
 
 	xas->xa_index |= ((sibs + 1) << shift) - 1;
+	if (!xas_top(xas->xa_node) && xas->xa_node->shift == xas->xa_shift)
+		xas->xa_offset |= sibs;
 	xas->xa_shift = 0;
 	xas->xa_sibs = 0;
 

The only other things changed are the test suite, and removing an
unnecessary change, so they can be ignored:

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 8a67d4bb1788..ec06c3ca19e9 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -695,19 +695,20 @@ static noinline void check_move(struct xarray *xa)
 		check_move_small(xa, (1UL << i) - 1);
 }
 
-static noinline void check_create_range_1(struct xarray *xa,
+static noinline void xa_store_many_order(struct xarray *xa,
 		unsigned long index, unsigned order)
 {
 	XA_STATE_ORDER(xas, xa, index, order);
-	unsigned int i;
+	unsigned int i = 0;
 
 	do {
 		xas_lock(&xas);
+		XA_BUG_ON(xa, xas_find_conflict(&xas));
 		xas_create_range(&xas);
 		if (xas_error(&xas))
 			goto unlock;
 		for (i = 0; i < (1U << order); i++) {
-			xas_store(&xas, xa + i);
+			XA_BUG_ON(xa, xas_store(&xas, xa_mk_value(index + i)));
 			xas_next(&xas);
 		}
 unlock:
@@ -715,7 +716,29 @@ static noinline void check_create_range_1(struct xarray *xa,
 	} while (xas_nomem(&xas, GFP_KERNEL));
 
 	XA_BUG_ON(xa, xas_error(&xas));
-	xa_destroy(xa);
+}
+
+static noinline void check_create_range_1(struct xarray *xa,
+		unsigned long index, unsigned order)
+{
+	unsigned long i;
+
+	xa_store_many_order(xa, index, order);
+	for (i = index; i < index + (1UL << order); i++)
+		xa_erase_value(xa, i);
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+
+static noinline void check_create_range_2(struct xarray *xa, unsigned order)
+{
+	unsigned long i;
+	unsigned long nr = 1UL << order;
+
+	for (i = 0; i < nr * nr; i += nr)
+		xa_store_many_order(xa, i, order);
+	for (i = 0; i < nr * nr; i++)
+		xa_erase_value(xa, i);
+	XA_BUG_ON(xa, !xa_empty(xa));
 }
 
 static noinline void check_create_range(struct xarray *xa)
@@ -729,6 +752,8 @@ static noinline void check_create_range(struct xarray *xa)
 		check_create_range_1(xa, 2U << order, order);
 		check_create_range_1(xa, 3U << order, order);
 		check_create_range_1(xa, 1U << 24, order);
+		if (order < 10)
+			check_create_range_2(xa, order);
 	}
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index af2d7fa05af7..3ac507803787 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -589,8 +589,8 @@ static int shmem_add_to_page_cache(struct page *page,
 	VM_BUG_ON(expected && PageTransHuge(page));
 
 	page_ref_add(page, nr);
-	page->index = index;
 	page->mapping = mapping;
+	page->index = index;
 
 	do {
 		void *entry;
