Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086D0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19A12082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kG3enaGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19A12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeK0JRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:17:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55652 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbeK0JRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:17:06 -0500
Received: from zn.tnic (p200300EC2BDEFE00DCA0409AA15535E1.dip0.t-ipconnect.de [IPv6:2003:ec:2bde:fe00:dca0:409a:a155:35e1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D092A1EC04BC;
        Mon, 26 Nov 2018 23:21:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543270890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uLhX5yOGKw/WFPwKbN/n/DuVvw0mSQ1I1Z+QLB0g79I=;
        b=kG3enaGYi6SBQg8jpwsLBmNcbb1RIYn/Z1COWKWIScBPzDEgvwFZ0J4vaQROJLAFFcNYiK
        gvn8mdY6Qgu7hB77M4IZcZcWaM0898+lLdZ1i5Ci6oWWPzVNrUE5+WbLa9rZhfNzJ/MUWr
        0MNHr+3jGl18h7UT0xK8OrQ5X75f//Y=
Date:   Mon, 26 Nov 2018 23:21:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 13/28] x86/speculation: Reorder the spec_v2 code
Message-ID: <20181126222124.GQ4843@zn.tnic>
References: <20181125183328.318175777@linutronix.de>
 <20181125185004.707122879@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181125185004.707122879@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 07:33:41PM +0100, Thomas Gleixner wrote:
> Reorder the code so it is better grouped.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  arch/x86/kernel/cpu/bugs.c |  168 ++++++++++++++++++++++-----------------------
>  1 file changed, 84 insertions(+), 84 deletions(-)

...

>  static const struct {
>  	const char *option;
>  	enum spectre_v2_mitigation_cmd cmd;
>  	bool secure;
>  } mitigation_options[] = {

Yeah, now that we have ssb_mitigation_options and v2_user_options also,
those should probably be called "spectre_v2_options" or something more
specific to have the code more clear which options the code is using...


> -	{ "off",               SPECTRE_V2_CMD_NONE,              false },
> -	{ "on",                SPECTRE_V2_CMD_FORCE,             true },
> -	{ "retpoline",         SPECTRE_V2_CMD_RETPOLINE,         false },
> -	{ "retpoline,amd",     SPECTRE_V2_CMD_RETPOLINE_AMD,     false },
> -	{ "retpoline,generic", SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
> -	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
> +	{ "off",		SPECTRE_V2_CMD_NONE,		  false },
> +	{ "on",			SPECTRE_V2_CMD_FORCE,		  true  },
> +	{ "retpoline",		SPECTRE_V2_CMD_RETPOLINE,	  false },
> +	{ "retpoline,amd",	SPECTRE_V2_CMD_RETPOLINE_AMD,	  false },
> +	{ "retpoline,generic",	SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
> +	{ "auto",		SPECTRE_V2_CMD_AUTO,		  false },
>  };

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
