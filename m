Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40A8C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB6924B56
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DSHaJBTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB6924B56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeFWHrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 03:47:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeFWHrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 03:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/kgsQLGrKqaEmU15Z2pSz5r30S+VuIl29vuBTr8doXk=; b=DSHaJBTGXV2YviMMGy+4GoZ3K
        UJHVXjpvxPB1s1xcHPfFVcOqTAKLqGBXydTmMoqubxHel+F6vCmzHvfHNnhdzjKcBKE8y8tiQrL1u
        8N5CmG6YeMvMPc8qG+HxbD/UDx6J9KXJG76G+KA+tOkNUJU86zKHi4dfDmTMQW2wN01Jib2CUZrHg
        ElNv22RbKCutnWr8VKhgGpkSg5HGcyMhk3Jvy1SnW3VZ4Vd0DkWK3KnTeQUW/0CQGudWpZAAeK4dC
        HeUKap7fYXzr1nOOnooZ8aIdmE8W31G+POmT1Ebbm0yUv/F95B+TU+wgD5ySlcRCsD+WcxStBLIbe
        77Y/YpnKA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWdFy-0006Ow-R5; Sat, 23 Jun 2018 07:46:50 +0000
Date:   Sat, 23 Jun 2018 00:46:50 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Josef Bacik <jbacik@fb.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: m68k boot failure in -next bisected to 'xarray: Replace
 exceptional entries'
Message-ID: <20180623074650.GC18630@bombadil.infradead.org>
References: <20180622184246.GA21226@roeck-us.net>
 <20180622210519.GA18630@bombadil.infradead.org>
 <20180622223335.GA12581@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622223335.GA12581@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 03:33:35PM -0700, Guenter Roeck wrote:
> On Fri, Jun 22, 2018 at 02:05:19PM -0700, Matthew Wilcox wrote:
> > On Fri, Jun 22, 2018 at 11:42:46AM -0700, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > a few days ago, m68k boot tests in linux-next started to crash.
> > > I bisected the problem to commit 'xarray: Replace exceptional entries'.
> > > Bisect and crash logs are attached below.
> > 
> > Thank you!  I was afraid something like this might happen.  
> > 
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 1 at lib/idr.c:42 idr_alloc_u32+0x44/0xe8
> > 
> > Line 42 is:
> > 
> >         if (WARN_ON_ONCE(radix_tree_is_internal_node(ptr)))
> >                 return -EINVAL;
> > 
> > The pointer passed in to idr_alloc() is not 4-byte aligned; it's aligned
> > to a 2 byte boundary.  I'm having a little trouble seeing who it is that's
> > passing in what pointer ...
> > 
> > > Call Trace: [<000180d6>] __warn+0xc0/0xc2
> > >  [<000020e8>] do_one_initcall+0x0/0x140
> > >  [<0001816a>] warn_slowpath_null+0x26/0x2c
> > >  [<002b50e4>] idr_alloc_u32+0x44/0xe8
> > >  [<002b50e4>] idr_alloc_u32+0x44/0xe8
> > >  [<002b51e4>] idr_alloc+0x5c/0x76
> > >  [<00247160>] genl_register_family+0x14c/0x54c
> > 
> > It makes sense to here (other than idr_alloc being listed twice)
> > 
> > >  [<000020e8>] do_one_initcall+0x0/0x140
> > >  [<003f0f02>] genl_init+0x0/0x34
> > 
> > Assuming this is right, that would imply that genl_ctrl is not 4-byte
> > aligned.  Is that true?  I'm not familiar with the m68k alignment rules,
> > but it has a lot of 4-byte sized quantities in the struct, so I would
> > assume it's 4-byte aligned.
> > 
> > >  [<003f0ce6>] bpf_lwt_init+0x10/0x14
> > 
> > I don't think this is the caller.
> > 
> 
> Here is the culprit:
> 
> genl_register_family(0x36dd7a) registering VFS_DQUOT
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at lib/idr.c:42 idr_alloc_u32+0x44/0xe8
> 
> It may be odd that fs/quota/netlink.c:quota_genl_family is not word
> aligned, but on the other side I don't think there is a rule that
> the function parameter to genl_register_family() - or the second
> parameter of idr_alloc() - must be word aligned. Am I missing
> something ? After all, it could be a pointer to the nth element
> of a string, or the caller could on purpose allocate IDRs for
> (ptr), (ptr + 1), and so on.

There actually is a rule that pointers passed to the IDR be aligned.
It might not be written down anywhere ;-)  And I'm quite happy to lift
that restriction; after all I don't want to force everybody to decorate
definitions with __aligned(4).

I'll see what I can do to fix it.  I'm actually on holiday this week,
so a fix may be delayed.
