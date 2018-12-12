Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247B5C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E183E20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E183E20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeLLDhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 22:37:47 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40962 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLDhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 22:37:47 -0500
Received: from [67.139.178.66] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gWvL9-0000II-QL; Wed, 12 Dec 2018 04:37:40 +0100
Date:   Tue, 11 Dec 2018 19:37:26 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] x86/speculation: Add support for STIBP always-on
 preferred mode
In-Reply-To: <20181212000518.GX27375@zn.tnic>
Message-ID: <alpine.DEB.2.21.1812111910520.22893@nanos.tec.linutronix.de>
References: <20181211224615.5373.65736.stgit@tlendack-t1.amdoffice.net> <20181212000518.GX27375@zn.tnic>
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

On Wed, 12 Dec 2018, Borislav Petkov wrote:
> On Tue, Dec 11, 2018 at 10:46:16PM +0000, Lendacky, Thomas wrote:
> > +	/*
> > +	 * At this point, an STIBP mode other than "off" has been set.
> > +	 * If STIBP support is not being forced, check if STIBP always-on
> > +	 * is preferred.
> > +	 */
> > +	if (mode != SPECTRE_V2_USER_STRICT &&
> > +	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON)) {
> > +		stibp_always_on = true;
> > +		mode = SPECTRE_V2_USER_STRICT;
> > +		pr_info("mitigation: STIBP always-on is preferred\n");
> > +	}
> > +
> >  	/* Initialize Indirect Branch Prediction Barrier */
> >  	if (boot_cpu_has(X86_FEATURE_IBPB)) {
> >  		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
> > @@ -1088,7 +1102,8 @@ static char *stibp_state(void)
> >  	case SPECTRE_V2_USER_NONE:
> >  		return ", STIBP: disabled";
> >  	case SPECTRE_V2_USER_STRICT:
> > -		return ", STIBP: forced";
> > +		return stibp_always_on ? ", STIBP: always-on"
> > +				       : ", STIBP: forced";
> 
> I still don't like that separate stibp_always_on variable when we can do
> all the querying just by using mode and X86_FEATURE_AMD_STIBP_ALWAYS_ON.

Hmmm. I've not seen the V1 of this (it's not in my inbox) but the v1->v2
changes contain:

> > - Removed explicit SPECTRE_V2_USER_STRICT_PREFERRED mode

Now I really have to ask why?

Neither the extra variable nor the cpu feature check are pretty. An
explicit mode is way better in terms of code clarity and you get the proper
printout via spectre_v2_user_strings.

Hmm?

	tglx
