Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB33EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAB32087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAB32087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeJRVAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:00:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34466 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeJRVAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:00:09 -0400
Received: from [213.61.215.195] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gD7tB-00087v-6G; Thu, 18 Oct 2018 14:58:57 +0200
Date:   Thu, 18 Oct 2018 14:58:56 +0200 (CEST)
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
Subject: Re: [Patch v3 04/13] x86/speculation: Disable STIBP when enhanced
 IBRS is in use
In-Reply-To: <a96456805e51e234d1bae30837366243e24a4b83.1539798901.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810181451460.1647@nanos.tec.linutronix.de>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com> <a96456805e51e234d1bae30837366243e24a4b83.1539798901.git.tim.c.chen@linux.intel.com>
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

> With enhanced IBRS in use, the application running on sibling CPU will not

  on a hyperthread sibling

> be able to launch Spectre v2 attack to the application on current CPU.

That's technically wrong. It still can launch an attack, but the attack
wont work.

So this wants to be:

  will not be able to exploit the Spectre V2 vulnerability.

> @@ -881,7 +889,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
>  				   ", IBPB" : "",
>  			boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ?
>  				   ", IBRS_FW" : "",
> -			(x86_spec_ctrl_base & SPEC_CTRL_STIBP) ?
> +			spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED ?
> +				   ", Enhanced IBRS" :
> +			    (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ?
>  				   ", STIBP" : "",

This is more than horrible, really. Can you please do the following:

1) Split the sprintf() into a helper function in a first patch, which
   spares a ibdentation level. i.e. what you tried in 2/13

2) If that condition still needs ugly unreadable line breaks, then split it
   out into a helper function as well.

Thanks,

	tglx
