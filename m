Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99E3C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787A620C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VQKTxg9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787A620C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeHTUYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:24:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeHTUYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l8aFa40Vi7Sszsphg0yzSXuipsctzw7GyuBLhREIxMs=; b=VQKTxg9cUUFQnjSwFFNfPy6Oe
        cVo6h5WcnUrGAuzdEW+3c/N3TyJR5iSP5Qx9bXlVtbOy8+9ydVXJoEFGzOEU5UyOBO9R0VWpW3wZV
        qCwULcBgPLC+leQSJqrs+WRtw3v5R7vxLX/x6JfW3yFOg42KTKYEkrRTqC4UVWKXLdSfv8Zqd4iIf
        76m79dx6XkLdiBtk3TqQDo8/LDolKwWn5HJC+B/h7dnhKHXzmGn5mLcFPwx3uSGHYMpvAiyQM0QMv
        mQEmmNnMq1bGxZ7gx7k/bOkd2/mGBeArpG6Ezaj7wbUCqetI6RnP2H1bPTBog6ypSHaGDywkBDTel
        0dizQRDWw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1frnea-0003p5-TU; Mon, 20 Aug 2018 17:07:44 +0000
Date:   Mon, 20 Aug 2018 10:07:44 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Li RongQing <lirongqing@baidu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        darrick.wong@oracle.com
Subject: Re: [PATCH] mm: introduce kvvirt_to_page() helper
Message-ID: <20180820170744.GD25153@bombadil.infradead.org>
References: <1534596541-31393-1-git-send-email-lirongqing@baidu.com>
 <20180820144116.GO29735@dhcp22.suse.cz>
 <20180820144923.GA25153@bombadil.infradead.org>
 <20180820162406.GQ29735@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820162406.GQ29735@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 06:24:06PM +0200, Michal Hocko wrote:
> On Mon 20-08-18 07:49:23, Matthew Wilcox wrote:
> > On Mon, Aug 20, 2018 at 04:41:16PM +0200, Michal Hocko wrote:
> > > On Sat 18-08-18 20:49:01, Li RongQing wrote:
> > > > The new helper returns address mapping page, which has several users
> > > > in individual subsystem, like mem_to_page in xfs_buf.c and pgv_to_page
> > > > in af_packet.c, unify them
> > > 
> > > kvvirt_to_page is a weird name. I guess you wanted it to fit into
> > > kv*alloc, kvfree naming, right? If yes then I guess kvmem_to_page
> > > would be slightly better.
> > > 
> > > Other than that the patch makes sense to me. It would be great to add
> > > some documentation and be explicit that the call is only safe on
> > > directly mapped kernel address and vmalloc areas.
> > 
> > ... and not safe if the length crosses a page boundary.  I don't want to
> > see new code emerge that does kvmalloc(PAGE_SIZE * 2, ...); kvmem_to_page()
> > and have it randomly crash when kvmalloc happens to fall back to vmalloc()
> > under heavy memory pressure.
> > 
> > Also, people are going to start using this for stack addresses.  Perhaps
> > we should have a debug option to guard against them doing that.
> 
> I do agree that such an interface is quite dangerous. That's why I was
> stressing out the proper documentation. I would be much happier if we
> could do without it altogether. Maybe the existing users can be rewoked
> to not rely on the addr2page functionality. If that is not the case then
> we should probably offer a helper. With some WARN_ONs to catch misuse
> would be really nice. I am not really sure how many abuses can we catch
> actually though.

I certainly understand the enthusiasm for sharing this code rather than
having dozens of places outside the VM implement their own version of it.
But I think most of these users are using code that's working at the wrong
level.  Most of them seem to have an address range which may-or-may-not-be
virtually mapped and they want to get an array-of-pages for that.

Perhaps we should offer -that- API instead.  vmalloc/vmap already has
an array-of-pages, and the various users could be given a pointer to
that array.  If the memory isn't vmapped, maybe the caller could pass
an array pointer like XFS does, or we could require them to pass GFP flags
to allocate a new array.
