Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3320FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBE1208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QPB+EjqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBE1208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeLJKAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:00:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLJKAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rPwl9fqEb72RZcFmo4+3tdMtHiWPm91OHoUcws25PSI=; b=QPB+EjqRcEqqXZxFRWdTimBTv
        xOhgo0eD8ikSWLpX+GmjBhxdK4CVZZGEliy/PA00SKJkH1+JatB/UynpLBceTLKkk95Z1A2D3iwjm
        zyEbN6QJMxYW2xKtxpAqOCP43DcW3BbsNzKEFJpzRZ4mgyqjngbAdRpVQAA0XtUVzLCMtPtbUOZBI
        3BQRBnlru5M0wRpenpNQl+USe8IzDZLYLB4bCktKtIdIJNnZ/5EfO4rjfEQ1tlYQRb0JeqtU6SyoN
        87CDbBDkQ3eNwa+xNJa2tOzosAW7pZCNEhzKvO9fU0ovbGKdTaWTRYD2zqfwIzt5+YLgtSdXWXZEH
        aPg481Jkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWIM2-00076F-DK; Mon, 10 Dec 2018 09:59:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 041CC2075BD0C; Mon, 10 Dec 2018 10:59:56 +0100 (CET)
Date:   Mon, 10 Dec 2018 10:59:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] __wr_after_init: write rare for static allocation
Message-ID: <20181210095955.GI5289@hirez.programming.kicks-ass.net>
References: <20181204121805.4621-1-igor.stoppa@huawei.com>
 <20181204121805.4621-3-igor.stoppa@huawei.com>
 <CALCETrVvoui0vksdt0Y9rdGL5ipEn_FtSXVVUFdH03ZC93cy_A@mail.gmail.com>
 <20181206094451.GC13538@hirez.programming.kicks-ass.net>
 <d9382720-3c39-5f10-afcd-dc17727fe4dc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9382720-3c39-5f10-afcd-dc17727fe4dc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 12:32:21AM +0200, Igor Stoppa wrote:
> 
> 
> On 06/12/2018 11:44, Peter Zijlstra wrote:
> > On Wed, Dec 05, 2018 at 03:13:56PM -0800, Andy Lutomirski wrote:
> > 
> > > > +       if (op == WR_MEMCPY)
> > > > +               memcpy((void *)wr_poking_addr, (void *)src, len);
> > > > +       else if (op == WR_MEMSET)
> > > > +               memset((u8 *)wr_poking_addr, (u8)src, len);
> > > > +       else if (op == WR_RCU_ASSIGN_PTR)
> > > > +               /* generic version of rcu_assign_pointer */
> > > > +               smp_store_release((void **)wr_poking_addr,
> > > > +                                 RCU_INITIALIZER((void **)src));
> > > > +       kasan_enable_current();
> > > 
> > > Hmm.  I suspect this will explode quite badly on sane architectures
> > > like s390.  (In my book, despite how weird s390 is, it has a vastly
> > > nicer model of "user" memory than any other architecture I know
> > > of...).  I think you should use copy_to_user(), etc, instead.  I'm not
> > > entirely sure what the best smp_store_release() replacement is.
> > > Making this change may also mean you can get rid of the
> > > kasan_disable_current().
> > 
> > If you make the MEMCPY one guarantee single-copy atomicity for native
> > words then you're basically done.
> > 
> > smp_store_release() can be implemented with:
> > 
> > 	smp_mb();
> > 	WRITE_ONCE();
> > 
> > So if we make MEMCPY provide the WRITE_ONCE(), all we need is that
> > barrier, which we can easily place at the call site and not overly
> > complicate our interface with this.
> 
> Ok, so the 3rd case (WR_RCU_ASSIGN_PTR) could be handled outside of this
> function.
> But, since now memcpy() will be replaced by copy_to_user(), can I assume
> that also copy_to_user() will be atomic, if the destination is properly
> aligned? On x86_64 it seems yes, however it's not clear to me if this is the
> outcome of an optimization or if I can expect it to be always true.

This would be a new contraint; one that needs to be documented and
verified by the various arch maintainers as they enable this feature on
their platform.

