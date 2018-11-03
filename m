Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05098C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2D1204FD
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2D1204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbeKDDUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:20:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60374 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeKDDUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:20:02 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJ0Kf-00072J-US; Sat, 03 Nov 2018 19:07:38 +0100
Date:   Sat, 3 Nov 2018 19:07:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
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
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [Patch v4 03/18] x86/speculation: Reorganize cpu_show_common()
In-Reply-To: <30b577cf0ceba2ee7612fa7150a86f248b27a08e.1540923609.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811031851010.3160@nanos.tec.linutronix.de>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com> <30b577cf0ceba2ee7612fa7150a86f248b27a08e.1540923609.git.tim.c.chen@linux.intel.com>
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

Tim,

On Tue, 30 Oct 2018, Tim Chen wrote:
> Extract the logic to show IBPB, STIBP usages in cpu_show_common()
> into helper functions.
> 
> Later patches will add other userspace Spectre v2 mitigation modes.
> This patch makes it easy to show IBPB and STIBP
> usage scenario according to the mitigation mode.

First of all, I asked you before to do:

# git grep 'This patch' Documentation/process

This leads you to:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Documentation is there for a reason.

Aside of that, I'd really have a hard time to figure out what you are
trying to say, if I didn't have the context already. Change logs need to
make sense on their own. So something like this:

  The Spectre V2 printout in cpu_show_common() handles conditionals for the
  various mitigation methods directly in the sprintf() argument list. That's
  hard to read and will become unreadable if more complex decisions need to
  be made for a particular method.

  Move the conditionals for STIBP and IBPB string selection into helper
  functions, so they can be extended later on.

follows the obvious ordering for change logs:

  1) Describe context and problem
  
  2) Describe the solution

and is understandable without needing to know about the context in which
this change was developed.

Hmm? This is a suggestion, feel free to rewrite it in you own words. The
same applies to other change logs as well. I won't comment on those.
 
>  static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
>  			       char *buf, unsigned int bug)
>  {
> @@ -872,9 +888,8 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
>  
>  	case X86_BUG_SPECTRE_V2:
>  		return sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
> -			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
>  			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
> -			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
> +			       ibpb_state(), stibp_state(),
>  			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
>  			       spectre_v2_module_string());

Any particular reason for changing the output ordering here? If yes, then
the changelog should mention it. If no, why?

Thanks,

	tglx
