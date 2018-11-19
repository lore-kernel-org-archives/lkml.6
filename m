Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C63AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD20208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD20208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeKSXWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:22:03 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38377 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbeKSXWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:22:03 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gOj83-0006su-Jw; Mon, 19 Nov 2018 13:58:15 +0100
Date:   Mon, 19 Nov 2018 13:58:15 +0100 (CET)
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
Subject: Re: [Patch v5 08/16] smt: Create cpu_smt_enabled static key for SMT
 specific code
In-Reply-To: <91b719e53640f60666b40a3516da2b80703b2f76.1542418937.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811191355270.1537@nanos.tec.linutronix.de>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <91b719e53640f60666b40a3516da2b80703b2f76.1542418937.git.tim.c.chen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018, Tim Chen wrote:
> In later code, STIBP will be turned on/off in the context switch code
> path when SMT is enabled.  Checks for SMT is best
> avoided on such hot paths.
> 
> Create cpu_smt_enabled static key to turn on such SMT specific code
> statically.
> 
> This key is set in code under hot plug, so it is limited in
> scope to architecture supporting CPU hotplug, like x86.

The key is enabled by default and its scope has nothing to do with CPU
hotplug. It depends on CONFIG_HOTPLUG_SMT which is the extra SMT control
code which is currently only enabled on x86.

> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 218df7f..b54f085 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -188,5 +188,6 @@ static inline void cpu_smt_disable(bool force) { }
>  static inline void cpu_smt_check_topology_early(void) { }
>  static inline void cpu_smt_check_topology(void) { }
>  #endif
> +DECLARE_STATIC_KEY_TRUE(cpu_smt_enabled);

And here it is declared unconditionally which allows code to use it despite
CONFIG_HOTPLUG_SMT=n and subsequently breaks the build.
  
Thanks,

	tglx
