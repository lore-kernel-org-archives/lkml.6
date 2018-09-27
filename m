Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D00C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4362156E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4362156E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeI0ODL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:03:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:50041 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbeI0ODL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:03:11 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8R7jRht016721;
        Thu, 27 Sep 2018 02:45:27 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w8R7jPMR016712;
        Thu, 27 Sep 2018 02:45:25 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 27 Sep 2018 02:45:25 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] powerpc/32: add stack protector support
Message-ID: <20180927074525.GQ23155@gate.crashing.org>
References: <d6c43ab708bf9ae1266c745fece457ed2da43d7c.1537961921.git.christophe.leroy@c-s.fr> <20180926191615.GO23155@gate.crashing.org> <220fbef8-429c-9485-d10e-c1eaa989918d@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220fbef8-429c-9485-d10e-c1eaa989918d@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 08:20:00AM +0200, Christophe LEROY wrote:
> Le 26/09/2018 à 21:16, Segher Boessenkool a écrit :
> >On Wed, Sep 26, 2018 at 11:40:38AM +0000, Christophe Leroy wrote:
> >>+static __always_inline void boot_init_stack_canary(void)
> >>+{
> >>+	unsigned long canary;
> >>+
> >>+	/* Try to get a semi random initial value. */
> >>+	get_random_bytes(&canary, sizeof(canary));
> >>+	canary ^= mftb();
> >>+	canary ^= LINUX_VERSION_CODE;
> >>+
> >>+	current->stack_canary = canary;
> >>+}
> >
> >I still think you should wait until there is entropy available.  You
> >haven't answered my questions about that (or I didn't see them): what
> >does the kernel do in other similar cases?
> >
> >Looks great otherwise!
> 
> What do you mean by 'other similar cases' ? All arches have similar 
> boot_init_stack_canary().

Yes, those, and other things that want entropy early.

> x86 uses rdtsc() which is equivalent to our 
> mftb(). Most arches xor it with LINUX_VERSION_CODE.
> 
> The issue is that it is called very early in start_kernel(), however 
> they try to set some entropy anyway:
> 
> 	boot_cpu_init();
> 	page_address_init();
> 	pr_notice("%s", linux_banner);
> 	setup_arch(&command_line);
> 	/*
> 	 * Set up the the initial canary and entropy after arch
> 	 * and after adding latent and command line entropy.
> 	 */
> 	add_latent_entropy();
> 	add_device_randomness(command_line, strlen(command_line));
> 	boot_init_stack_canary();
> 
> Apparently, it is too early for calling wait_for_random_bytes(), see below.

Hrm.  Too early to call wait_event_interruptible?  From there it went
into schedule(), which blew up.  Well you say we have only one context
at this point, so that is not too surprising then :-)

> However this is the canary for initial startup only. Only idle() still 
> uses this canary once the system is running. A new canary is set for any 
> new forked task.

Ah, that makes things a lot better!  Do those new tasks get a canary
from something with sufficient entropy though?

> Maybe should the idle canary be updated later once there is more entropy 

That is tricky to do, but sure, if you can, that should help.

> ? Today there is a new call to boot_init_stack_canary() in 
> cpu_startup_entry(), but it is enclosed inside #ifdef CONFIG_X86.

It needs to know the details of how ssp works on each platform.


Segher
