Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D2BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8072175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8072175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbeHCPfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:35:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729841AbeHCPfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:35:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 322BD40216F7;
        Fri,  3 Aug 2018 13:39:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id F009410CD79E;
        Fri,  3 Aug 2018 13:39:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  3 Aug 2018 15:39:25 +0200 (CEST)
Date:   Fri, 3 Aug 2018 15:39:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Ivan Delalande <colona@arista.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH RESEND] exec: don't force_sigsegv processes with a
 pending fatal signal
Message-ID: <20180803133923.GA19752@redhat.com>
References: <20180731005615.GA2911@visor>
 <CAJwJo6bmFZ+2wni1d-t2hh_RqYvnN2c+NJPNyrBLp9H=StTZFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwJo6bmFZ+2wni1d-t2hh_RqYvnN2c+NJPNyrBLp9H=StTZFg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 03 Aug 2018 13:39:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 03 Aug 2018 13:39:26 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02, Dmitry Safonov wrote:
>
> Hi Ivan,
>
> 2018-07-31 1:56 GMT+01:00 Ivan Delalande <colona@arista.com>:
> > We were seeing unexplained segfaults in coreutils processes and other
> > basic utilities that we tracked down to binfmt_elf failing to load
> > segments for ld.so. Digging further, the actual problem seems to occur
> > when a process gets sigkilled while it is still being loaded by the
> > kernel. In our case when _do_page_fault goes for a retry it will return
> > early as it first checks for fatal_signal_pending(), so load_elf_interp
> > also returns with error and as a result search_binary_handler will
> > force_sigsegv() which is pretty confusing as nothing actually failed
> > here.
> >
> > Fixes: 19d860a140be ("handle suicide on late failure exits in execve() in search_binary_handler()")
> > Reference: https://lkml.org/lkml/2013/2/14/5
> > Signed-off-by: Ivan Delalande <colona@arista.com>
>
> +Cc: Oleg Nesterov <oleg@redhat.com>
> +Cc: Andy Lutomirski <luto@kernel.org>

Thanks...

and sorry, I fail to understand the problem and what/how this patch tries to fix.

Hmm. After I read the next email from Dmitry it seems to me that the whole purpose
of this patch is to avoid print_fatal_signal()? If yes, the changelog should clearly
explain this.

> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1656,7 +1656,8 @@ int search_binary_handler(struct linux_binprm *bprm)
> >                 if (retval < 0 && !bprm->mm) {
> >                         /* we got to flush_old_exec() and failed after it */
> >                         read_unlock(&binfmt_lock);
> > -                       force_sigsegv(SIGSEGV, current);
> > +                       if (!fatal_signal_pending(current))
> > +                               force_sigsegv(SIGSEGV, current);

I won't argue, but may be force_sigsegv() should check fatal_signal_pending()
itself. setup_rt_frame() can too fail if fatal_signal_pending() by the same
reason.

Oleg.

