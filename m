Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65E4C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D16021B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfBKRM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:12:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfBKRMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:12:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4603DA7393;
        Mon, 11 Feb 2019 17:12:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id C0E0860FDC;
        Mon, 11 Feb 2019 17:12:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 11 Feb 2019 18:12:54 +0100 (CET)
Date:   Mon, 11 Feb 2019 18:12:53 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ivan Delalande <colona@arista.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] exec: don't force_sigsegv processes with a pending
 fatal signal
Message-ID: <20190211171252.GE21430@redhat.com>
References: <20190205025308.GA24455@visor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205025308.GA24455@visor>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 11 Feb 2019 17:12:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, I couldn't look at this patch before.

On 02/04, Ivan Delalande wrote:
>
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1660,7 +1660,12 @@ int search_binary_handler(struct linux_binprm *bprm)
>  		if (retval < 0 && !bprm->mm) {
>  			/* we got to flush_old_exec() and failed after it */
>  			read_unlock(&binfmt_lock);
> -			force_sigsegv(SIGSEGV, current);
> +			if (!fatal_signal_pending(current)) {
> +				if (print_fatal_signals)
> +					pr_info("load_binary() failed: %d\n",
> +						retval);

I won't argue, but do we really want this spam?

> +				force_sigsegv(SIGSEGV, current);
> +			}
>  			return retval;
>  		}
>  		if (retval != -ENOEXEC || !bprm->file) {
> diff --git a/kernel/signal.c b/kernel/signal.c
> index e1d7ad8e6ab1..674076e63624 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2552,10 +2552,10 @@ static void signal_delivered(struct ksignal *ksig, int stepping)
>
>  void signal_setup_done(int failed, struct ksignal *ksig, int stepping)
>  {
> -	if (failed)
> -		force_sigsegv(ksig->sig, current);
> -	else
> +	if (!failed)
>  		signal_delivered(ksig, stepping);
> +	else if (!fatal_signal_pending(current))
> +		force_sigsegv(ksig->sig, current);

The changelog doesn't explain this change.

OK, I guess it comes from the previous discussion, setup_rt_frame() can equally fail
if fatal_signal_pending(). But this should be documented at least in the changelog,
and I still think we could simply change force_sigsegv() instead.

In any case, Eric has already mentioned that we going to give SIGKILL more priority,
so I think we can drop this patch?

Oleg.

