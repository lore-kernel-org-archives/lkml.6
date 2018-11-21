Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A440C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB66204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB66204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389281AbeKVH1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:27:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:47358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388933AbeKVH1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:27:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B5C7AFFD;
        Wed, 21 Nov 2018 20:51:21 +0000 (UTC)
Date:   Wed, 21 Nov 2018 21:51:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/speculation: Revert turning on STIBP all the time
In-Reply-To: <0693f05ac4b041ee2f988dfec31ebc81f4f28f17.1542830344.git.tim.c.chen@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1811212149080.21108@cbobk.fhfr.pm>
References: <0693f05ac4b041ee2f988dfec31ebc81f4f28f17.1542830344.git.tim.c.chen@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Tim Chen wrote:

> Commit 53c613fe "x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation"
> turns on STIBP all the time.
> 
> This causes large performance regression in many workloads.
> 
> One case is perlbench in the SpecInt Rate 2006 test suite which shows a
> 21% reduction in throughput.
> There're also other reports of drop in performance on Python and PHP benchmarks:
> https://www.phoronix.com/scan.php?page=article&item=linux-420-bisect&num=2
> 
> STIBP on all the time should not be the default option.
> 
> Turn off STIBP all the time for now till STIBP can be applied on
> a per task basis.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index c37e66e..21a8f39 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -332,7 +332,7 @@ static bool stibp_needed(void)
>  	if (!boot_cpu_has(X86_FEATURE_STIBP))
>  		return false;
>  
> -	return true;
> +	return false;
>  }

For -stable, which actually makes it to production, I already asked Greg 
to drop it.

For -rc, I don't think we need to do this at this moment, given the 
prctl+seccomp fixup is basically ready, do we?

Thanks,

-- 
Jiri Kosina
SUSE Labs

