Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9078EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E222208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E222208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbeGaLqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:46:40 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:32754 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbeGaLqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:46:39 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 0D08641113;
        Tue, 31 Jul 2018 12:07:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id c-3RN5yAc0lw; Tue, 31 Jul 2018 12:07:02 +0200 (CEST)
Date:   Tue, 31 Jul 2018 12:07:01 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Martijn Coenen <maco@android.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, rlove@google.com,
        ben@decadent.org.uk
Subject: Re: [PATCH 1/4] file: export __alloc_fd()
Message-ID: <20180731100701.GA18871@mailbox.org>
References: <20180730143710.14413-1-christian@brauner.io>
 <20180730143710.14413-2-christian@brauner.io>
 <20180730163155.GA27761@infradead.org>
 <20180730203633.GC12962@bombadil.infradead.org>
 <CAB0TPYG5T_d32iwt8Lgq_nDO_COWfWBfuSzErraASSuTYGm3yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB0TPYG5T_d32iwt8Lgq_nDO_COWfWBfuSzErraASSuTYGm3yQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:44:33AM +0200, Martijn Coenen wrote:
> On Mon, Jul 30, 2018 at 10:36 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > I'm not entirely sure I understand the binder code (... does anyone?)
> > but from what I can see, it intends to open a file descriptor in the
> > process which is the target of the message being sent.
> 
> You're right.
> 
> > That strikes
> > me as wrong-headed; it should be allocating a struct file and passing
> > that file to the other process.  When that process receives the message,
> > *it* allocates a file descriptor for itself.ho
> 
> We're looking into cleaning this up (historically it was done this way
> because VIVT caches made this not very efficient), and this is indeed
> a very good candidate for fixing it.

Ah, this wasn't brought up in the original thread when discussing to
turn this into a module. If using internal functions like this is going
away it makes sense to wait for this work to happen first. Is there a
time-frame for this?

Thanks!
Christian

> 
> >
> > But I think the binder user-space API relies on this.  The userspace API
> > seems to rely on passing fd numbers around ... but I'm having trouble
> > figuring most of this user API out.  Perhaps Martijn can help here.
> 
> The UAPI does expect a file descriptor, but we may be able to do the
> mapping from fd to struct file (and vice-versa) in the kernel driver,
> so userspace wouldn't notice.
> 
> Thanks,
> Martijn
