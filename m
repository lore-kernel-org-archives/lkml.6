Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A66BC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 00:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26693222C0
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 00:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i0NsD4cD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfAFALp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 19:11:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfAFALp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 19:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hrWMddqDVg55lVU7GWrgf6C5GPOqZ5qTBBQkTmgMG20=; b=i0NsD4cDbJfDVcVT2Vf0bgcLK
        +bI6mAXzF4IhznJ1yfw9xF7toCT46yU+za3AqoNR3Up1jaDOhcPDTmwbvSyyKruQYkgHc9uL2WFfh
        ij6dKZjt5dKq9cot2+RGs65x1p8ahNKwyAtdPLfcvbVcMlKfIp7KiXYAMShhkC7Z9Cg2uEQ8b1lxB
        HtKuskOhsKKt71fGq0kiG2ae1Q0EocD55AeDVI9Yrsli57pK5e9r+QgZXQbZcR/ZFarTKb5HVKPZO
        b6xaa6l9TSJne0S54uu9f2QoSpFONutQRGEFQdE7zK3ryqva9zLlP5gby0ubKTJri7xHbYv3s4nof
        2gaH4nivw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gfw2U-0007jO-SK; Sun, 06 Jan 2019 00:11:38 +0000
Date:   Sat, 5 Jan 2019 16:11:38 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Jiri Kosina <jikos@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190106001138.GW6310@bombadil.infradead.org>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com>
 <CAHk-=whL4sZiM=JcdQAYQvHm7h7xEtVUh+gYGYhoSk4vi38tXg@mail.gmail.com>
 <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
 <CAHk-=wiMQeCEKESWTmm15x79NjEjNwFvjZ=9XenxY7yH8zqa7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiMQeCEKESWTmm15x79NjEjNwFvjZ=9XenxY7yH8zqa7A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 03:39:10PM -0800, Linus Torvalds wrote:
> On Sat, Jan 5, 2019 at 3:16 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It goes back to forever, it looks like. I can't find a reason.
> 
> mincore() was originally added in 2.3.52pre3, it looks like. Around
> 2000 or so. But sadly before the BK history.
> 
> And that comment about
> 
>   "Later we can get more picky about what "in core" means precisely."
> 
> that still exists above mincore_page() goes back to the original patch.

FreeBSD claims to have a manpage from SunOS 4.1.3 with mincore (!)

https://www.freebsd.org/cgi/man.cgi?query=mincore&apropos=0&sektion=0&manpath=SunOS+4.1.3&arch=default&format=html

DESCRIPTION
       mincore()  returns  the primary memory residency	status of pages	in the
       address space covered by	mappings in the	range [addr, addr + len).  The
       status is returned as a char-per-page in	the character array referenced
       by *vec (which the system assumes to be large enough to	encompass  all
       the  pages  in  the  address range).  The least significant bit of each
       character is set	to 1 to	indicate that the referenced page is  in  pri-
       mary  memory, 0 if it is	not.  The settings of other bits in each char-
       acter is	undefined and may contain other	information in the future.

