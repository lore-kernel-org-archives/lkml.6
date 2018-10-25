Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C6BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9BA2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9BA2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeJZDAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:00:21 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54385 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeJZDAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:00:21 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gFkKw-0008NJ-7s; Thu, 25 Oct 2018 12:26:26 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gFkKg-0008KR-Ee; Thu, 25 Oct 2018 12:26:25 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, andrew@lunn.ch,
        Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
References: <20181025180957.7900-1-f.fainelli@gmail.com>
Date:   Thu, 25 Oct 2018 13:25:45 -0500
In-Reply-To: <20181025180957.7900-1-f.fainelli@gmail.com> (Florian Fainelli's
        message of "Thu, 25 Oct 2018 11:09:55 -0700")
Message-ID: <87tvl9nas6.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gFkKg-0008KR-Ee;;;mid=<87tvl9nas6.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Qny0LmlpzUwvIfAD2pOLKrf8cBeN5jhg=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS disabled
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> Some software such as perf makes unconditional use of the special
> [vectors] page which is only provided when CONFIG_KUSER_HELPERS is
> enabled in the kernel.
>
> Facilitate the debugging of such situations by printing a debug message
> to the kernel log showing the task name and the faulting address.

Can't someone trigger this segv deliberately and spam the kerne log?
Doesn't this need something like printk_ratelimit or something to ensure
this message only gets printed once?

Eric

> Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/mm/fault.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index f4ea4c62c613..f17471fbc1c4 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -173,6 +173,11 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
>  		show_regs(regs);
>  	}
>  #endif
> +#ifndef CONFIG_KUSER_HELPERS
> +	if ((sig == SIGSEGV) && ((addr & PAGE_MASK) == 0xffff0000))
> +		printk(KERN_DEBUG "%s: CONFIG_KUSER_HELPERS disabled at 0x%08lx\n",
> +		       tsk->comm, addr);
> +#endif
>  
>  	tsk->thread.address = addr;
>  	tsk->thread.error_code = fsr;
