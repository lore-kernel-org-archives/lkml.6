Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0BBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB3D20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T4HnRfSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB3D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395061AbeKVXMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:12:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390958AbeKVXMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=femvbVFtBpRYNNc/ZyctjfMjetOb258DickiR4eKZXo=; b=T4HnRfSxDUcKV9akxMOq1gPgi
        Vrtm2WQo5T4TMmlv/tdRISBnB2Bco7bR5H6OjNv7hCTRgFv8rfKBZnChuFOquvEh0c63qtc5XFSEr
        GjzWThL2waEEMFBN+fGOuLdcy6DjFFqDH8GKVGCs4Hb0zUekOPcRaLekrOsk45MUT/gnPRk6ZMw0s
        5LueWulm5Ut54kq7cSnBZKKjHEOmbPjYdkcYbhGEMW0NVCP3wK12ZA64YMHiFuLMq2QRPrEAzeR8f
        I15bYSj5RMQAmT6EQig1ApGnog5Bs0tk/uBTUFLqgs3wY9legBfHadxCijSg/Hp9VcFJJoFkk0gCx
        Aegdr0XCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPoAc-00071H-Qy; Thu, 22 Nov 2018 12:33:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 786022029FD58; Thu, 22 Nov 2018 13:33:16 +0100 (CET)
Date:   Thu, 22 Nov 2018 13:33:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [patch 22/24] x86/speculation: Create PRCTL interface to
 restrict indirect branch speculation
Message-ID: <20181122123316.GT2131@hirez.programming.kicks-ass.net>
References: <20181121201430.559770965@linutronix.de>
 <20181121201724.414692525@linutronix.de>
 <20181122122638.GC10365@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122122638.GC10365@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 01:26:38PM +0100, Borislav Petkov wrote:
> Perhaps merge the two DISABLE branches to make it obvious what the
> difference between them is:
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 6eac074e3935..28cece3a067b 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -769,7 +769,9 @@ static int indir_branch_prctl_set(struct task_struct *task, unsigned long ctrl)
>  		task_clear_spec_indir_branch_disable(task);
>  		task_update_spec_tif(task, TIF_SPEC_IB, false);
>  		break;
> +
>  	case PR_SPEC_DISABLE:
> +	case PR_SPEC_FORCE_DISABLE:
>  		/*
>  		 * Indirect branch speculation is always allowed when
>  		 * mitigation is force disabled.
> @@ -780,16 +782,11 @@ static int indir_branch_prctl_set(struct task_struct *task, unsigned long ctrl)
>  			return 0;
>  		task_set_spec_indir_branch_disable(task);
>  		task_update_spec_tif(task, TIF_SPEC_IB, true);
> +
> +		if (ctrl == PR_SPEC_FORCE_DISABLE)
> +			task_set_spec_indir_branch_force_disable(task);
>  		break;
> -	case PR_SPEC_FORCE_DISABLE:
> -		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_NONE)
> -			return -EPERM;
> -		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_STRICT)
> -			return 0;
> -		task_set_spec_indir_branch_disable(task);
> -		task_set_spec_indir_branch_force_disable(task);
> -		task_update_spec_tif(task, TIF_SPEC_IB, true);
> -		break;
> +
>  	default:
>  		return -ERANGE;
>  	}

I like that; maybe also do the same to the ssb code, for symmetry.
