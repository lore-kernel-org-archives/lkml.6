Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF111C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2ED20878
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hHCSokx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2ED20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbeKVHKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:10:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47058 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKVHKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:10:00 -0500
Received: from zn.tnic (p200300EC2BD0AB00883B4D3E2A7F8FA4.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:ab00:883b:4d3e:2a7f:8fa4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20AB11EC09F7;
        Wed, 21 Nov 2018 21:34:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542832447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dJyFdZhd9sk7G8zixcYXBXLbCsUOG199CJpARPBJlKk=;
        b=hHCSokx4io0WlcJ35xcWU41yY/Cdl+1Ef9BOq7MLiBMYew4i0x/bDK2MbHVVrRR5ZuPBNM
        43hbEBDWotwdUYiFHpL6LxTKngu4zUL66LIhHl2QzFCZGiaVf/BfywdCYkHIeul3RVC0Df
        sIyEcK6mWAS2aGc1yepQn3PuW/Rje58=
Date:   Wed, 21 Nov 2018 21:33:53 +0100
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
Subject: Re: [patch 05/24] x86/speculation: Disable STIBP when enhanced IBRS
 is in use
Message-ID: <20181121203353.GD27559@zn.tnic>
References: <20181121201430.559770965@linutronix.de>
 <20181121201722.717439984@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181121201722.717439984@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 09:14:35PM +0100, Thomas Gleixner wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> If enhanced IBRS is active, STIBP is redundant for mitigating Spectre v2
> user space exploits from hyperthread sibling.
> 
> Disable STIBP when enhanced IBRS is used.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  arch/x86/kernel/cpu/bugs.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -321,6 +321,10 @@ static bool stibp_needed(void)
>  	if (spectre_v2_enabled == SPECTRE_V2_NONE)
>  		return false;
>  
> +	/* Enhanced IBRS makes using STIBP unnecessary. */
> +	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
> +		return false;
> +
>  	if (!boot_cpu_has(X86_FEATURE_STIBP))
>  		return false;
>  
> @@ -846,6 +850,9 @@ static ssize_t l1tf_show_state(char *buf
>  
>  static char *stibp_state(void)
>  {
> +	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
> +		return "";

If
	spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED

then SPEC_CTRL_STIBP should not be set in x86_spec_ctrl_base
(stibp_needed() prevents the setting in arch_smt_update()) so the above
check should not be needed.

I *think*.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
