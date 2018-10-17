Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3734FECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0021E21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0021E21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeJQUiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbeJQUiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:38:02 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24BA42150D;
        Wed, 17 Oct 2018 12:42:30 +0000 (UTC)
Date:   Wed, 17 Oct 2018 08:42:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jann Horn <jannh@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH] seq_buf: Make seq_buf_puts() NULL terminate the buffer
Message-ID: <20181017084228.725dd349@gandalf.local.home>
In-Reply-To: <CAG48ez2W8HeJcuPwA25vSqTco3B=CRzycSA0=--pG=7jWi3pPw@mail.gmail.com>
References: <20181017121000.30240-1-mpe@ellerman.id.au>
        <CAG48ez2W8HeJcuPwA25vSqTco3B=CRzycSA0=--pG=7jWi3pPw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 14:26:37 +0200
Jann Horn <jannh@google.com> wrote:

> > diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> > index 11f2ae0f9099..b1570204cde3 100644
> > --- a/lib/seq_buf.c
> > +++ b/lib/seq_buf.c
> > @@ -144,9 +144,13 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
> >
> >         WARN_ON(s->size == 0);
> >
> > +       /* Add 1 to len for the trailing NULL which must be there */  
> 
> Nit: In the comments, I would prefer either "null byte" or "NUL"
> instead of "NULL" when talking about something that is not a pointer.
> 
> > +       len += 1;  
> 
> It looks like you're using an "unsigned int" for the length, meaning
> that this can in theory (e.g. when operating on a string from a big
> vmalloc buffer) overflow. You should be using size_t here.

seq_buf is not meant for gigabytes of data. We'll change it when that
ever happens.

-- Steve


> 
> >         if (seq_buf_can_fit(s, len)) {
> >                 memcpy(s->buffer + s->len, str, len);
> > -               s->len += len;
> > +               /* Don't count the trailing NULL against the capacity */
> > +               s->len += len - 1;
> >                 return 0;
> >         }
> >         seq_buf_set_overflow(s);
> > --
> > 2.17.1
> >  

