Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E7DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9292220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YPxQiB4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfANTBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:01:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANTBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HY7j9/aCkrGW2PRuhe+XteHi0vqCgIgftLyHMDJvmkc=; b=YPxQiB4UkuD/ZDI2CJ92Ce2uH
        FqZpbRxvkYgr2PtF6gJdiTuD0CK+Nve7AUy/IsV+7pp8Ah5vdzyX5Z0Tb7gz5QDXvYbelJswQ1FGO
        CGHO0ZqgdGaJdrZEcuKf9aK9jK7tg7UbtqY0G7aEt1LO0XFecv9kI6PsgY735YSOU0N//OSQAWSSs
        JMhoPyCS1USlX1OrvfGId3avJ/QE5mwyw2xCvDIQ0rbJPFfpQQ9HZ6ECSY8hikiUCHUVoebxsDa5N
        lDBMVQpF85gVlGM4LNDMaP2W2hTRBO4Fw0gZ7N1lVGEuDIuOborzee8Pzvxo4BMcizDtDbmBDLkIX
        chUCF+MGw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj7U8-0002uQ-6Q; Mon, 14 Jan 2019 19:01:20 +0000
Date:   Mon, 14 Jan 2019 11:01:20 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: xarray: Fix potential out of bounds access
Message-ID: <20190114190119.GZ6310@bombadil.infradead.org>
References: <20190114184741.GF17906@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114184741.GF17906@uranus.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 09:47:41PM +0300, Cyrill Gorcunov wrote:
> Since the mark is used as an array index we should use
> preincrement to not access the XA_MARK_MAX index.

But XA_MARK_MAX is inclusive:

include/linux/xarray.h:#define XA_MARK_MAX              XA_MARK_2

so we actually want to access XA_MARK_MAX.  Now, we don't have a test
in the test-suite that fails as a result of your patch, so that needs to get
fixed.  How about this:

From: Matthew Wilcox <willy@infradead.org>
Date: Mon, 14 Jan 2019 13:57:31 -0500
Subject: [PATCH] XArray tests: Check mark 2 gets squashed

We do not currently check that the loop in xas_squash_marks() doesn't have
an off-by-one error in it.  It didn't, but a patch which introduced an
off-by-one error wasn't caught by any existing test.  Switch the roles
of XA_MARK_1 and XA_MARK_2 to catch that bug.

Reported-by: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 lib/test_xarray.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 3cf17338b0a4..c596a957f764 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -199,7 +199,7 @@ static noinline void check_xa_mark_1(struct xarray *xa, unsigned long index)
 		XA_BUG_ON(xa, xa_store_index(xa, index + 1, GFP_KERNEL));
 		xa_set_mark(xa, index + 1, XA_MARK_0);
 		XA_BUG_ON(xa, xa_store_index(xa, index + 2, GFP_KERNEL));
-		xa_set_mark(xa, index + 2, XA_MARK_1);
+		xa_set_mark(xa, index + 2, XA_MARK_2);
 		XA_BUG_ON(xa, xa_store_index(xa, next, GFP_KERNEL));
 		xa_store_order(xa, index, order, xa_mk_index(index),
 				GFP_KERNEL);
@@ -209,8 +209,8 @@ static noinline void check_xa_mark_1(struct xarray *xa, unsigned long index)
 			void *entry;
 
 			XA_BUG_ON(xa, !xa_get_mark(xa, i, XA_MARK_0));
-			XA_BUG_ON(xa, !xa_get_mark(xa, i, XA_MARK_1));
-			XA_BUG_ON(xa, xa_get_mark(xa, i, XA_MARK_2));
+			XA_BUG_ON(xa, xa_get_mark(xa, i, XA_MARK_1));
+			XA_BUG_ON(xa, !xa_get_mark(xa, i, XA_MARK_2));
 
 			/* We should see two elements in the array */
 			rcu_read_lock();
-- 
2.20.1

