Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569D3C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB832064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uUCa5p5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB832064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbeGZPvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:51:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbeGZPvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=52yzPSHXQvPXq6R6eUFm+UkOoKYuGo+Ah4R3UBQFFuY=; b=uUCa5p5IsI7Xmi2GQPCitSKJo
        Ckiq/lyTZeWbb81SstUK78jk3O4YSIVrSOOqKYjImHQB4uqG3c0GylFc0/dXZKbBeou6g2KcMORVo
        95X6nWvu88HLnPAAC8Ty+9SAW/gWDzeI0Mw+n/xKSsQp3+nx5bMxhNTJy8bSTCL1iWAeh1/NJMy4Z
        YLUYpDaLplAdAMOZIlDG4U8MJOfpxIz4JP5ha9TKiQvW2gO2OVjChyEOehsEWqCqJAHUe7LB8u3lS
        x72TOV6Nz3ySbF1XEXcOz8zzTJjTqrul/nQszpJMABT4RVhgCxOJXad+cAv5z5F3qUOSMbOlS/H6R
        G6yCJPqUA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fihKz-0003oa-P7; Thu, 26 Jul 2018 14:33:53 +0000
Date:   Thu, 26 Jul 2018 07:33:53 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/shmem.c:LINE!
Message-ID: <20180726143353.GA27612@bombadil.infradead.org>
References: <000000000000d624c605705e9010@google.com>
 <20180709143610.GD2662@bombadil.infradead.org>
 <alpine.LSU.2.11.1807221856350.5536@eggly.anvils>
 <20180723140150.GA31843@bombadil.infradead.org>
 <alpine.LSU.2.11.1807231111310.1698@eggly.anvils>
 <20180723203628.GA18236@bombadil.infradead.org>
 <alpine.LSU.2.11.1807231531240.2545@eggly.anvils>
 <20180723225454.GC18236@bombadil.infradead.org>
 <alpine.LSU.2.11.1807240121590.1105@eggly.anvils>
 <alpine.LSU.2.11.1807252334420.1212@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1807252334420.1212@eggly.anvils>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:53:15PM -0700, Hugh Dickins wrote:
> Now I've learnt that an oops on 0xffffffffffffffbe points to EEXIST,
> not to EREMOTE, it's easy: patch below fixes those four xfstests
> (and no doubt a similar oops I've seen occasionally under swapping
> load): so gives clean xfstests runs for non-huge and huge tmpfs.

Excellent!

I'm adding this:

+++ b/lib/test_xarray.c
@@ -741,6 +741,13 @@ static noinline void check_create_range_2(struct xarray *xa
, unsigned order)
        XA_BUG_ON(xa, !xa_empty(xa));
 }
 
+static noinline void check_create_range_3(void)
+{
+       XA_STATE(xas, NULL, 0);
+       xas_set_err(&xas, -EEXIST);
+       xas_create_range(&xas);
+}
+
 static noinline void check_create_range(struct xarray *xa)
 {
        unsigned int order;
@@ -755,6 +762,8 @@ static noinline void check_create_range(struct xarray *xa)
                if (order < 10)
                        check_create_range_2(xa, order);
        }
+
+       check_create_range_3();
 }
 
 static LIST_HEAD(shadow_nodes);

and fixing the bug differently ;-)  But many thanks for spotting it!

I'll look into the next bug you reported ...
