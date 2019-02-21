Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B93C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C042147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550749959;
	bh=/3LIAZcMC9N6Z7sOp3p5c8kMCIjrgtD0Wa5XJ+qCfFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qeWD905cAI/INjhPK2s+SmP+TDN161B8MkjNo9wCGFOsXxyvJEmBHrSru8Ihg+Fu5
	 g5ctFF4k+7bZWEjsh0VGbn2jnHJeH/o18XKfQDcvMvJnCiVTHxG/5s+6/JLCDARWpg
	 6GJtmmNz3XhAZQRUN+bx8PGkuuqOO6fhUnxwwSC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfBULwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:52:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfBULwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:52:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A42C20880;
        Thu, 21 Feb 2019 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550749953;
        bh=/3LIAZcMC9N6Z7sOp3p5c8kMCIjrgtD0Wa5XJ+qCfFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wFGj19yv9G/VdfEjfQZ/0pvJGGmsJD6BL3F/I06cuL46hm7qT5U/iI2dhI7QvSS8r
         4IsdZSEgFTHqFAqF3ph4z0Ra0gIv0WzDXyL9CH/t+Qi86mts8wPnVbkyiL4SdxA96e
         6MOnBr1+y/w8WKcSSnCKdwNfF/6ZbtYwBFDfAMGw=
Date:   Thu, 21 Feb 2019 12:52:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     stable <stable@vger.kernel.org>, linux-tip-commits@vger.kernel.org,
        suravee.suthikulpanit@amd.com, jiaxun.yang@flygoat.com,
        tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        sherry.hurwitz@amd.com, mingo@redhat.com, mingo@kernel.org,
        thomas.lendacky@amd.com, hpa@zytor.com,
        Erwan Velu <e.velu@criteo.com>
Subject: Re: [tip:x86/cpu] x86/CPU/AMD: Set the CPB bit unconditionally on
 F17h
Message-ID: <20190221115230.GB25198@kroah.com>
References: <20181120030018.5185-1-jiaxun.yang@flygoat.com>
 <tip-0237199186e7a4aa5310741f0a6498a20c820fd7@git.kernel.org>
 <20190220085334.GA5177@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220085334.GA5177@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 09:53:34AM +0100, Borislav Petkov wrote:
> On Fri, Jan 18, 2019 at 07:48:59AM -0800, tip-bot for Jiaxun Yang wrote:
> > Commit-ID:  0237199186e7a4aa5310741f0a6498a20c820fd7
> > Gitweb:     https://git.kernel.org/tip/0237199186e7a4aa5310741f0a6498a20c820fd7
> > Author:     Jiaxun Yang <jiaxun.yang@flygoat.com>
> > AuthorDate: Tue, 20 Nov 2018 11:00:18 +0800
> > Committer:  Borislav Petkov <bp@suse.de>
> > CommitDate: Fri, 18 Jan 2019 16:44:03 +0100
> > 
> > x86/CPU/AMD: Set the CPB bit unconditionally on F17h
> > 
> > Some F17h models do not have CPB set in CPUID even though the CPU
> > supports it. Set the feature bit unconditionally on all F17h.
> > 
> >  [ bp: Rewrite commit message and patch. ]
> > 
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
> > Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: x86-ml <x86@kernel.org>
> > Link: https://lkml.kernel.org/r/20181120030018.5185-1-jiaxun.yang@flygoat.com
> > ---
> >  arch/x86/kernel/cpu/amd.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> > index 69f6bbb41be0..01004bfb1a1b 100644
> > --- a/arch/x86/kernel/cpu/amd.c
> > +++ b/arch/x86/kernel/cpu/amd.c
> > @@ -819,11 +819,9 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
> >  static void init_amd_zn(struct cpuinfo_x86 *c)
> >  {
> >  	set_cpu_cap(c, X86_FEATURE_ZEN);
> > -	/*
> > -	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
> > -	 * all up to and including B1.
> > -	 */
> > -	if (c->x86_model <= 1 && c->x86_stepping <= 1)
> > +
> > +	/* Fix erratum 1076: CPB feature bit not being set in CPUID. */
> > +	if (!cpu_has(c, X86_FEATURE_CPB))
> >  		set_cpu_cap(c, X86_FEATURE_CPB);
> 
> Stable folks, please take this one above into those stable trees which
> have backported
> 
> f7f3dc00f612 ("x86/cpu/AMD: Fix erratum 1076 (CPB bit)")

I would, but I do not see this patch in Linus's tree yet :)

thanks,

greg k-h
