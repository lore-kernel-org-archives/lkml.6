Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427AFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B1E217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="y+pY68Sv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B1E217A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbeHDBNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 21:13:40 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:36148 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731991AbeHDBNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 21:13:40 -0400
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 0BBD9134B;
        Fri,  3 Aug 2018 16:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1533338118;
        bh=4LeQT5WcMU1UX2T6k+s/AiPrc1NuP6kqTQlfPn2hupU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=y+pY68SviPZjBiTECX6WOZ3RVl01isMvj+VFdcwRqXzjQB0G6QcpW4U24TZDNofa1
         U3+XzW9A15RotgFbayltnJqP++s+zUCKClJwW65Ju6VJ7ClQASlSuY5z++zUy/Z8eT
         IBgr0xaNZYllpkOg+YkV5/RB+5v3VWrcBEGbl0GytFTL2OMP5A6cQrNmh53Rnjr5Jq
         aTKKNBGgZBeHFdenAP14P0FAhNfXxphSakJu32V3viekgDgDB7BxsL8vfWkzYBtZnl
         RSWJsQ2iazKw8iWz6RmCpVxWgromnacHC8NFQsNeqvoVILqJPjBBFxEruZ8yiK1nKj
         h6NO5kEiL3xSA==
Received: from visor (unknown [172.20.208.17])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 08F6D1348;
        Fri,  3 Aug 2018 16:15:18 -0700 (PDT)
Date:   Fri, 3 Aug 2018 16:15:18 -0700
From:   Ivan Delalande <colona@arista.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH RESEND] exec: don't force_sigsegv processes with a
 pending fatal signal
Message-ID: <20180803231518.GC6187@visor>
References: <20180731005615.GA2911@visor>
 <CAJwJo6bmFZ+2wni1d-t2hh_RqYvnN2c+NJPNyrBLp9H=StTZFg@mail.gmail.com>
 <20180803133923.GA19752@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803133923.GA19752@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 03, 2018 at 03:39:24PM +0200, Oleg Nesterov wrote:
> On 08/02, Dmitry Safonov wrote:
> > 2018-07-31 1:56 GMT+01:00 Ivan Delalande <colona@arista.com>:
> > > We were seeing unexplained segfaults in coreutils processes and other
> > > basic utilities that we tracked down to binfmt_elf failing to load
> > > segments for ld.so. Digging further, the actual problem seems to occur
> > > when a process gets sigkilled while it is still being loaded by the
> > > kernel. In our case when _do_page_fault goes for a retry it will return
> > > early as it first checks for fatal_signal_pending(), so load_elf_interp
> > > also returns with error and as a result search_binary_handler will
> > > force_sigsegv() which is pretty confusing as nothing actually failed
> > > here.
> > >
> > > Fixes: 19d860a140be ("handle suicide on late failure exits in execve() in search_binary_handler()")
> > > Reference: https://lkml.org/lkml/2013/2/14/5
> > > Signed-off-by: Ivan Delalande <colona@arista.com>
> >
> > +Cc: Oleg Nesterov <oleg@redhat.com>
> > +Cc: Andy Lutomirski <luto@kernel.org>
> 
> Thanks...
> 
> and sorry, I fail to understand the problem and what/how this patch tries to fix.
> 
> Hmm. After I read the next email from Dmitry it seems to me that the whole purpose
> of this patch is to avoid print_fatal_signal()? If yes, the changelog should clearly
> explain this.

Sorry about that, yes this is purely to avoid printing the segfault
messages for these processes when they were in fact killed.
I'll definitely send a v2 to clarify that, and probably add the helpful
message Dimitry suggested as well.

> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> > > @@ -1656,7 +1656,8 @@ int search_binary_handler(struct linux_binprm *bprm)
> > >                 if (retval < 0 && !bprm->mm) {
> > >                         /* we got to flush_old_exec() and failed after it */
> > >                         read_unlock(&binfmt_lock);
> > > -                       force_sigsegv(SIGSEGV, current);
> > > +                       if (!fatal_signal_pending(current))
> > > +                               force_sigsegv(SIGSEGV, current);
> 
> I won't argue, but may be force_sigsegv() should check fatal_signal_pending()
> itself. setup_rt_frame() can too fail if fatal_signal_pending() by the same
> reason.

I'm not sure, I think it would feel out of place in force_sigsegv() as
other callers might not expect this check in different contexts. I could
add a similar call to fatal_signal_pending() in signal_setup_done()
though, if you think we can hit the same problem from setup_rt_frame().

Thanks,
-- 
Ivan Delalande
Arista Networks
