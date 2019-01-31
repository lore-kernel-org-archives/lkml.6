Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21ABC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E59218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548934491;
	bh=SFVfJoJ5TREELE0WD6PH6m5/w/yW7Aknfnn9AUYvQP0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=F4ZDLofwuyH+tdSJmXv72EqyyXzqFWSbjK73MjL2g78xcQo98waWx0kfiQtRSrRLx
	 kY0vpRc7fHUderIDfcgSpDC9o57oOk5bbt4Ra4wt/ZwljrkyWmQGuficKeWsAkPi4A
	 UaORIhcMStq65YD9ODZzzy1X54HsWE9rnWtxc0zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbfAaLeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:34:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfAaLet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:34:49 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1859C218AF;
        Thu, 31 Jan 2019 11:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548934489;
        bh=SFVfJoJ5TREELE0WD6PH6m5/w/yW7Aknfnn9AUYvQP0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=AhA68lecaRUyoHyE8td5xQh/w2blB1dTK5V42cd/a1IxY1uNaZMgLj0HIlwxbFjM+
         yxCss+2pzG5OI/nbVrL5M2v1rtvk3vJ/Af+jBtXP7g/zo3vwo9/ivJ3l2OqkROiAHA
         NLGcJFt00TOEsgplHJ4wFQmV2eQ8amQeX/+1Fpo0=
Date:   Thu, 31 Jan 2019 12:34:44 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>
Subject: Re: [PATCH 2/3] mm/filemap: initiate readahead even if IOCB_NOWAIT
 is set for the I/O
In-Reply-To: <87imy5f6ir.fsf@oldenburg2.str.redhat.com>
Message-ID: <nycvar.YFH.7.76.1901311223270.3281@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-3-vbabka@suse.cz> <87munii3uj.fsf@oldenburg2.str.redhat.com> <nycvar.YFH.7.76.1901301614501.6626@cbobk.fhfr.pm>
 <87imy5f6ir.fsf@oldenburg2.str.redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019, Florian Weimer wrote:

> >> I think this needs to use a different flag because the semantics are so
> >> much different.  If I understand this change correctly, previously,
> >> RWF_NOWAIT essentially avoided any I/O, and now it does not.
> >
> > It still avoid synchronous I/O, due to this code still being in place:
> >
> >                 if (!PageUptodate(page)) {
> >                         if (iocb->ki_flags & IOCB_NOWAIT) {
> >                                 put_page(page);
> >                                 goto would_block;
> >                         }
> >
> > but goes the would_block path only after initiating asynchronous 
> > readahead.
> 
> But it wouldn't schedule asynchronous readahead before?

It would, that's kind of the whole point.

> I'm worried that something, say PostgreSQL doing a sequential scan, 
> would implement a two-pass approach, first using RWF_NOWAIT to process 
> what's in the kernel page cache, and then read the rest without it.  If 
> RWF_NOWAIT is treated as a prefetch hint, there could be much more read 
> activity, and a lot of it would be pointless because the data might have 
> to be evicted before userspace can use it.

So are you aware of anything already existing, that'd implement this 
semantics? I've quickly grepped https://github.com/postgres/postgres for 
RWF_NOWAIT, and they don't seem to use it at all. RWF_NOWAIT is rather 
new.

The usecase I am aware of is to make sure that the thread doing 
io_submit() doesn't get blocked for too long, because it has other things 
to do quickly in order to avoid starving other sub-threads (and delegate 
the I/O submission to asynchronous context).

-- 
Jiri Kosina
SUSE Labs

