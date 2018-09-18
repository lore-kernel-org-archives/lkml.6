Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCF9ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC5F2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC5F2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbeISCHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:07:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58716 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeISCHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:07:35 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2MgO-0002GO-Cq; Tue, 18 Sep 2018 22:33:16 +0200
Date:   Tue, 18 Sep 2018 22:33:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: Re: [REVIEW][PATCH 08/20] signal/x86/traps: Move setting error_code
 and trap_nr into do_trap_no_signal
In-Reply-To: <20180918000546.12552-8-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182228350.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-8-ebiederm@xmission.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> Half of the times when error_code and trap_nr are set are already in

s/when// I think

> do_trap_no_signal.  Move the other time these are set into do_trap_no_signal,

Please write function as do_trap_no_signal() so it's more obvious what you
are talking about.

> and give do_trap_no_signal a single exit where a signals are sent.

s/a/// or s/a/all/ Not sure what you wanted to do here.

> After the move the comment documeting this all is much easier to follow
> as everything is together in one place.
> 
> Also update the string that is passed in to const.  The only user of that
> str is die and it already takes a const string, so this just makes it explicit

string

> that the string won't change.
> 
> This prepares the way for adding a second caller to do_trap_no_signal.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/x86/kernel/traps.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 31a689b67be3..f31c0ddee278 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -189,7 +189,7 @@ int fixup_bug(struct pt_regs *regs, int trapnr)
>  }
>  
>  static nokprobe_inline int
> -do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
> +do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
>  		  struct pt_regs *regs,	long error_code)
>  {
>  	if (v8086_mode(regs)) {
> @@ -202,10 +202,8 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
>  						error_code, trapnr))
>  				return 0;
>  		}
> -		return -1;
>  	}
> -
> -	if (!user_mode(regs)) {
> +	else if (!user_mode(regs)) {

Please put that 'else if' right after the closing bracket, i.e.

	} else if (...) {

>  		if (fixup_exception(regs, trapnr))
>  			return 0;

With that fixed:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

