Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B1CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C2720880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C2720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbeIJWNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:13:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727701AbeIJWNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:13:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B65FB4B75B;
        Mon, 10 Sep 2018 17:18:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id F231742238;
        Mon, 10 Sep 2018 17:18:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 10 Sep 2018 19:18:25 +0200 (CEST)
Date:   Mon, 10 Sep 2018 19:18:22 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Stanislav Kozina <skozina@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: get_arg_page() && ptr_size accounting
Message-ID: <20180910171822.GA27005@redhat.com>
References: <20180910122907.GA23963@redhat.com>
 <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 10 Sep 2018 17:18:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 10 Sep 2018 17:18:25 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10, Kees Cook wrote:
>
> > So get_arg_page() does
> >
> >                 /*
> >                  * Since the stack will hold pointers to the strings, we
> >                  * must account for them as well.
> >                  *
> >                  * The size calculation is the entire vma while each arg page is
> >                  * built, so each time we get here it's calculating how far it
> >                  * is currently (rather than each call being just the newly
> >                  * added size from the arg page).  As a result, we need to
> >                  * always add the entire size of the pointers, so that on the
> >                  * last call to get_arg_page() we'll actually have the entire
> >                  * correct size.
> >                  */
> >                 ptr_size = (bprm->argc + bprm->envc) * sizeof(void *);
> >                 if (ptr_size > ULONG_MAX - size)
> >                         goto fail;
> >                 size += ptr_size;
> >
> > OK, but
> >                 acct_arg_size(bprm, size / PAGE_SIZE);
> >
> > after that doesn't look exactly right. This additional space will be used later
> > when the process already uses bprm->mm, right? so it shouldn't be accounted by
> > acct_arg_size().
>
> My understanding (based on the comment about acct_arg_size()) is that
> before exec_mmap() happens, the memory used to build the new arguments
> copy memory area gets accounted to the MM_ANONPAGES resource limit of
> the execing process.

Yes, because otherwise oom-killer can't account the memory populated by
get_arg_page() in bprm->mm.

> I couldn't find any place where the argc/envc
> pointers were being included in the count,

But why??? To clarify,

	size += ptr_size;

after acct_arg_size() is clear and correct, we are going to check rlim_stack
and thus the size should include the pointers we will add in create_elf_tables().


But acct_arg_size() should only account the pages we allocate for bprm->mm,
nothing more. create_elf_tables() does not allocate the memory when it populates
arg_start/arg_end/env_start/env_end. Plus at this time the process has already
switched to bprm->mm.

> > Not to mention that ptr_size/PAGE_SIZE doesn't look right in any case...
>
> Hm? acct_arg_size() takes pages, not bytes. I think this is correct?
> What doesn't look right to you?

Please forget. I meant that _if_ we actually wanted to account this additional
memory in bprm->pages, than we would probably need something like
acct_arg_size(size/PAGE_SIZE + DIV_ROUND_UP(ptr_size, PAGE_SIZE)).

> > In short. Am I totally confused or the patch below makes sense? This way we do
> > not need the fat comment.
>
> Even if I'm wrong about acct_arg_size(), we need to keep the comment

I won't argue, but to me evrything looks obvious as long as we don't pass
ptr_size acct_arg_size().

Oleg.

