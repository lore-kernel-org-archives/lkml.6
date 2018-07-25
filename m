Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CFAC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B9120852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B9120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeGYO5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:57:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729258AbeGYO5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:57:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED843401FF5A;
        Wed, 25 Jul 2018 13:45:14 +0000 (UTC)
Received: from treble (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FD712026D68;
        Wed, 25 Jul 2018 13:45:14 +0000 (UTC)
Date:   Wed, 25 Jul 2018 08:45:12 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/bugs: protect against userspace-userspace spectreRSB
Message-ID: <20180725134512.uquatm2neqr5jy7b@treble>
References: <nycvar.YFH.7.76.1807242147560.997@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1807242147560.997@cbobk.fhfr.pm>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 25 Jul 2018 13:45:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 25 Jul 2018 13:45:15 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 09:53:30PM +0200, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> The article "Spectre Returns! Speculation Attacks using the Return Stack
> Buffer" [1] describes two new (sub-)variants of spectrev2-like attack,
> making use solely of the RSB contents even on CPUs that don't fallback to
> BTB on RSB underflow (Skylake+).
> 
> Mitigate userspace-userspace attacks by always unconditionally filling RSB on
> context switch when generic spectrev2 mitigation has been enabled.
> 
> [1] https://arxiv.org/pdf/1807.07940.pdf
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

While I generally agree with this patch, isn't it odd that we would do
RSB filling on every context switch, but almost never do IBPB?

> +	 *	- RSB underflow (and switch to BTB) on Skylake+
> +	 *	- sepctreRSB variant of spectre v2 on X86_BUG_SPECTRE_V2 CPUs

"SpectreRSB"

>  	 */
> -	if ((!boot_cpu_has(X86_FEATURE_PTI) &&
> -	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
> -		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
> -		pr_info("Spectre v2 mitigation: Filling RSB on context switch\n");
> -	}
> +	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
> +	pr_info("Spectre v2 / spectreRSB mitigation: Filling RSB on context switch\n");

"SpectreRSB" (capitalized)

-- 
Josh
