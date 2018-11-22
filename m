Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E99BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3C220878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6UNB55T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3C220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392325AbeKVRg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:36:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392311AbeKVRg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:36:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE2F20865;
        Thu, 22 Nov 2018 06:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542869932;
        bh=s19qSokm/XU2WAphuGr6P8xDNduky4UTmSCxlcuH9P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h6UNB55TiSR6v2s7fS8hC0/5ufJK6yd5GmnFsGu4xGacCMhXIgEqzTTtpw4sM7jK1
         3F77QiL9KJ0T0BDJmtr0dLbDwCoNkb3cj/9cD/hhlBmuboE8gY8Z1fBb7X6Fdco6Bm
         t57gZJvixCe40Km8KZ8U36Z6zzaVpMfaSotsOCcg=
Date:   Thu, 22 Nov 2018 07:58:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Dave Stewart <david.c.stewart@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/speculation: Revert turning on STIBP all the time
Message-ID: <20181122065850.GA11963@kroah.com>
References: <0693f05ac4b041ee2f988dfec31ebc81f4f28f17.1542830344.git.tim.c.chen@linux.intel.com>
 <nycvar.YFH.7.76.1811212149080.21108@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1811212149080.21108@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 09:51:19PM +0100, Jiri Kosina wrote:
> On Wed, 21 Nov 2018, Tim Chen wrote:
> 
> > Commit 53c613fe "x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation"
> > turns on STIBP all the time.
> > 
> > This causes large performance regression in many workloads.
> > 
> > One case is perlbench in the SpecInt Rate 2006 test suite which shows a
> > 21% reduction in throughput.
> > There're also other reports of drop in performance on Python and PHP benchmarks:
> > https://www.phoronix.com/scan.php?page=article&item=linux-420-bisect&num=2
> > 
> > STIBP on all the time should not be the default option.
> > 
> > Turn off STIBP all the time for now till STIBP can be applied on
> > a per task basis.
> > 
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  arch/x86/kernel/cpu/bugs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index c37e66e..21a8f39 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -332,7 +332,7 @@ static bool stibp_needed(void)
> >  	if (!boot_cpu_has(X86_FEATURE_STIBP))
> >  		return false;
> >  
> > -	return true;
> > +	return false;
> >  }
> 
> For -stable, which actually makes it to production, I already asked Greg 
> to drop it.

It's in the latest stable -rc releases, and if all goes well, they will
be released tomorrow.

thanks,

greg k-h
