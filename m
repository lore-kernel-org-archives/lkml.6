Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F257C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEA820684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GKJK6TOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEA820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395043AbeKVXF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:05:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55660 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394865AbeKVXFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:05:55 -0500
Received: from zn.tnic (p200300EC2BDC9100898E5A1DF8FAB135.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:9100:898e:5a1d:f8fa:b135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9622B1EC06CA;
        Thu, 22 Nov 2018 13:26:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542889604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2nkS/vyfMpcXqPrRDlywSEwnWD2aQO5tYYcJsd0LxZg=;
        b=GKJK6TOzv6XPBTNqnHlaHEEUu2NKm0cIORN12NVsdaViYtcC4u9anDG3M+ZXcMyxRmgDqZ
        oYTQpVO9wN1KnaCa2P082cgOSsQyBvXbwAl0PC4A9AcCnQ8slqaTQ0PCNoWBVxhO3XKHKB
        R/NVvrlZeFpNCG993o6mWAqsDFiW+H8=
Date:   Thu, 22 Nov 2018 13:26:38 +0100
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
Subject: Re: [patch 22/24] x86/speculation: Create PRCTL interface to
 restrict indirect branch speculation
Message-ID: <20181122122638.GC10365@zn.tnic>
References: <20181121201430.559770965@linutronix.de>
 <20181121201724.414692525@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181121201724.414692525@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 09:14:52PM +0100, Thomas Gleixner wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> Add the PR_SPEC_INDIR_BRANCH option for the PR_GET_SPECULATION_CTRL and
> PR_SET_SPECULATION_CTRL prctls to allow fine grained per task control of
> indirect branch speculation via STIBP.
> 
> Invocations:
>  Check indirect branch speculation status with
>  - prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, 0, 0, 0);
> 
>  Enable indirect branch speculation with
>  - prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);
> 
>  Disable indirect branch speculation with
>  - prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_DISABLE, 0, 0);
> 
>  Force disable indirect branch speculation with
>  - prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);
> 
> See Documentation/userspace-api/spec_ctrl.rst.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  Documentation/userspace-api/spec_ctrl.rst |    9 +++
>  arch/x86/include/asm/nospec-branch.h      |    1 
>  arch/x86/kernel/cpu/bugs.c                |   71 ++++++++++++++++++++++++++++++
>  include/linux/sched.h                     |    9 +++
>  include/uapi/linux/prctl.h                |    1 
>  tools/include/uapi/linux/prctl.h          |    1 
>  6 files changed, 92 insertions(+)

> @@ -753,12 +755,56 @@ static int ssb_prctl_set(struct task_str
>  	return 0;
>  }
>  
> +static int indir_branch_prctl_set(struct task_struct *task, unsigned long ctrl)
> +{
> +	switch (ctrl) {
> +	case PR_SPEC_ENABLE:
> +		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_NONE)
> +			return 0;
> +		/*
> +		 * Indirect branch speculation is always disabled in strict
> +		 * mode.
> +		 */
> +		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_STRICT)
> +			return -EPERM;
> +		task_clear_spec_indir_branch_disable(task);
> +		task_update_spec_tif(task, TIF_SPEC_IB, false);
> +		break;
> +	case PR_SPEC_DISABLE:
> +		/*
> +		 * Indirect branch speculation is always allowed when
> +		 * mitigation is force disabled.
> +		 */
> +		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_NONE)
> +			return -EPERM;
> +		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_STRICT)
> +			return 0;
> +		task_set_spec_indir_branch_disable(task);
> +		task_update_spec_tif(task, TIF_SPEC_IB, true);
> +		break;
> +	case PR_SPEC_FORCE_DISABLE:
> +		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_NONE)
> +			return -EPERM;
> +		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_STRICT)
> +			return 0;
> +		task_set_spec_indir_branch_disable(task);
> +		task_set_spec_indir_branch_force_disable(task);
> +		task_update_spec_tif(task, TIF_SPEC_IB, true);
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +	return 0;
> +}

Perhaps merge the two DISABLE branches to make it obvious what the
difference between them is:

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6eac074e3935..28cece3a067b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -769,7 +769,9 @@ static int indir_branch_prctl_set(struct task_struct *task, unsigned long ctrl)
 		task_clear_spec_indir_branch_disable(task);
 		task_update_spec_tif(task, TIF_SPEC_IB, false);
 		break;
+
 	case PR_SPEC_DISABLE:
+	case PR_SPEC_FORCE_DISABLE:
 		/*
 		 * Indirect branch speculation is always allowed when
 		 * mitigation is force disabled.
@@ -780,16 +782,11 @@ static int indir_branch_prctl_set(struct task_struct *task, unsigned long ctrl)
 			return 0;
 		task_set_spec_indir_branch_disable(task);
 		task_update_spec_tif(task, TIF_SPEC_IB, true);
+
+		if (ctrl == PR_SPEC_FORCE_DISABLE)
+			task_set_spec_indir_branch_force_disable(task);
 		break;
-	case PR_SPEC_FORCE_DISABLE:
-		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_NONE)
-			return -EPERM;
-		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_STRICT)
-			return 0;
-		task_set_spec_indir_branch_disable(task);
-		task_set_spec_indir_branch_force_disable(task);
-		task_update_spec_tif(task, TIF_SPEC_IB, true);
-		break;
+
 	default:
 		return -ERANGE;
 	}

> @@ -1453,6 +1453,8 @@ static inline bool is_percpu_thread(void
>  #define PFA_SPREAD_SLAB			2	/* Spread some slab caches over cpuset */
>  #define PFA_SPEC_SSB_DISABLE		3	/* Speculative Store Bypass disabled */
>  #define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
> +#define PFA_SPEC_INDIR_BRANCH_DISABLE	5	/* Indirect branch speculation restricted */
> +#define PFA_SPEC_INDIR_BRANCH_FORCE_DISABLE 6	/* Indirect branch speculation permanentely restricted */

permanently

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
