Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E80C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D003E2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D003E2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeJRUr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:47:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34410 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeJRUr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:47:59 -0400
Received: from [213.61.215.195] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gD7hV-0007ky-8m; Thu, 18 Oct 2018 14:46:53 +0200
Date:   Thu, 18 Oct 2018 14:46:52 +0200 (CEST)
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
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v3 02/13] x86/speculation: Remove unnecessary ret variable
 in cpu_show_common
In-Reply-To: <9d339e4671b53acad22e442e30907643327b529a.1539798901.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810181443390.1647@nanos.tec.linutronix.de>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com> <9d339e4671b53acad22e442e30907643327b529a.1539798901.git.tim.c.chen@linux.intel.com>
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

On Wed, 17 Oct 2018, Tim Chen wrote:

> Remove unecessary ret variable in cpu_show_common.
>
> Break up long lines too to make the code more concise
> and easier to read and modify in later patches.

So this does two things at once.

>  static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
>  			       char *buf, unsigned int bug)
>  {
> -	int ret;
> -
>  	if (!boot_cpu_has_bug(bug))
>  		return sprintf(buf, "Not affected\n");
>  
> @@ -873,13 +871,17 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
>  		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
>  
>  	case X86_BUG_SPECTRE_V2:
> -		ret = sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
> -			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
> -			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
> -			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
> -			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
> -			       spectre_v2_module_string());
> -		return ret;
> +		return sprintf(buf, "%s%s%s%s%s%s\n",
> +			spectre_v2_strings[spectre_v2_enabled],
> +			boot_cpu_has(X86_FEATURE_USE_IBPB) ?
> +				   ", IBPB" : "",
> +			boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ?
> +				   ", IBRS_FW" : "",
> +			(x86_spec_ctrl_base & SPEC_CTRL_STIBP) ?
> +				   ", STIBP" : "",
> +			boot_cpu_has(X86_FEATURE_RSB_CTXSW) ?
> +				   ", RSB filling" : "",

And I do not agree at all that this is more readable.

IMO it's actually worse and I do not see how that makes it easier to
modify.

Thanks,

	tglx


