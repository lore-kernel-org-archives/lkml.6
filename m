Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6F9C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FC42084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q8NPuOa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FC42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeLKWXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:23:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46072 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeLKWXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:23:08 -0500
Received: from zn.tnic (p200300EC2BCD2B0010F6E1EC68D6BA6C.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:10f6:e1ec:68d6:ba6c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2AF361EC0B6D;
        Tue, 11 Dec 2018 23:23:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544566986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Of+0Jcz3tMNKEXWWw6q+gddFzpsqcaSB2yL+b6/CgCI=;
        b=Q8NPuOa0e+qLuiCCOrnxlX5/zjGpqLmSgRqR0cmeLdxrcmf8im6m8AZGjtjmBgtp4TJexo
        jlcHcbbrLZ9ydjmg6UDWB8zJUEF9N5uILF0li9/SyVVzErWfzg5i1uTvb9gULxTonJO5zV
        d6fYAY9NbwZj5GL0vXM+GOLxkztk2Xs=
Date:   Tue, 11 Dec 2018 23:22:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH] x86/speculation: Add support for STIBP always-on
 preferred mode
Message-ID: <20181211222259.GU27375@zn.tnic>
References: <20181211190959.28321.56433.stgit@tlendack-t1.amdoffice.net>
 <3308b5d2-0c59-fa33-472b-f56633d39575@amd.com>
 <20181211211944.GT27375@zn.tnic>
 <d054e17f-87e4-a8cc-425c-f56b9c6d4588@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d054e17f-87e4-a8cc-425c-f56b9c6d4588@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:17:30PM +0000, Lendacky, Thomas wrote:
> If using just SPECTRE_V2_USER_STRICT then the code in stibp_state() would
> have to be able differentiate between the case where the mode was switched
> because of X86_FEATURE_AMD_STIBP_ALWAYS_ON vs a kernel command line with
> "spectre_v2_user=on". I could always set and use a static variable in the
> file just for the stibp_state() case.

Does it matter on X86_FEATURE_AMD_STIBP_ALWAYS_ON CPUs?

I mean, we want STIBP to be always on there so you can do:

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 25e914f77bb8..d14860d1cf9c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1089,7 +1089,10 @@ static char *stibp_state(void)
 	case SPECTRE_V2_USER_NONE:
 		return ", STIBP: disabled";
 	case SPECTRE_V2_USER_STRICT:
-		return ", STIBP: forced";
+		if (boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
+			return ", STIBP: always on";
+		else
+			return ", STIBP: forced";
 	case SPECTRE_V2_USER_PRCTL:
 	case SPECTRE_V2_USER_SECCOMP:
 		if (static_key_enabled(&switch_to_cond_stibp))

so if user has booted with spectre_v2_user=on, we say, "oh well, it is always
enabled anyway"... or?

> I'll give it a bit of time and see if there's any other discussion and
> re-submit without the new SPECTRE_V2_USER_STRICT_PREFERRED value.

Sure.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
