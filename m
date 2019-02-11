Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A183C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A17A2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TUEDAyfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfBKXUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:20:43 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:46962 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727014AbfBKXUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:20:43 -0500
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 98773EA4;
        Mon, 11 Feb 2019 15:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1549927242;
        bh=Kloo2aFhfszLvQHvB8Afgs6t/ERY+7Y84crY8DTfkFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=TUEDAyfgtDThNDO3jDl2wX0Ve0LWBLNbwThG+ZDH0VY7LtZuWHeIUl27b32Pi2Mrt
         zK2IKbbwpdVaOEObzvt/fkbomxt+lpbtAWmkx9PuucPqYZQ+p7Rym1qwPjPZdL3WUo
         mitfRHTLKfsbNDS5gcPhJkD0wnFgZu14W+Lc2V5mHO7kgwf14E4BRdO/aNrSG0knXi
         mM0//mt8sBE73Dc/Tq8tg+mX1W/Az8XDK0MQDBvknr6uBAKbQaXktwkRrsb+scsYWu
         CzQ1JfL4ThKFyAOVInC9TmkC7c6HYNpLopw2ddj9Q7cwU0MyihQs9eRMCVXWVoOyCH
         ZJhPEM6Nfet4g==
Received: from visor (unknown [172.20.208.17])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 8A60FEA2;
        Mon, 11 Feb 2019 15:20:42 -0800 (PST)
Date:   Mon, 11 Feb 2019 15:20:42 -0800
From:   Ivan Delalande <colona@arista.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] exec: don't force_sigsegv processes with a pending
 fatal signal
Message-ID: <20190211232042.GA18232@visor>
References: <20190205025308.GA24455@visor>
 <20190211171252.GE21430@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211171252.GE21430@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 06:12:53PM +0100, Oleg Nesterov wrote:
> sorry, I couldn't look at this patch before.
> 
> On 02/04, Ivan Delalande wrote:
> >
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1660,7 +1660,12 @@ int search_binary_handler(struct linux_binprm *bprm)
> >  		if (retval < 0 && !bprm->mm) {
> >  			/* we got to flush_old_exec() and failed after it */
> >  			read_unlock(&binfmt_lock);
> > -			force_sigsegv(SIGSEGV, current);
> > +			if (!fatal_signal_pending(current)) {
> > +				if (print_fatal_signals)
> > +					pr_info("load_binary() failed: %d\n",
> > +						retval);
> 
> I won't argue, but do we really want this spam?
> 
> > +				force_sigsegv(SIGSEGV, current);
> > +			}
> >  			return retval;
> >  		}
> >  		if (retval != -ENOEXEC || !bprm->file) {
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index e1d7ad8e6ab1..674076e63624 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2552,10 +2552,10 @@ static void signal_delivered(struct ksignal *ksig, int stepping)
> >
> >  void signal_setup_done(int failed, struct ksignal *ksig, int stepping)
> >  {
> > -	if (failed)
> > -		force_sigsegv(ksig->sig, current);
> > -	else
> > +	if (!failed)
> >  		signal_delivered(ksig, stepping);
> > +	else if (!fatal_signal_pending(current))
> > +		force_sigsegv(ksig->sig, current);
> 
> The changelog doesn't explain this change.
> 
> OK, I guess it comes from the previous discussion, setup_rt_frame() can equally fail
> if fatal_signal_pending(). But this should be documented at least in the changelog,
> and I still think we could simply change force_sigsegv() instead.
> 
> In any case, Eric has already mentioned that we going to give SIGKILL more priority,
> so I think we can drop this patch?

Yes, I've been running our tests on top of Eric's tree over the week-end
and haven't seen any new hit. I also see that Andrew has dropped the
patch from -mm, so no futher action should be required here.

Thank you for taking a look at the patch anyway.

-- 
Ivan Delalande
Arista Networks
