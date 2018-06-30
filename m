Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B27AC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 06:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23FA27539
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 06:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23FA27539
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeF3GYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 02:24:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34096 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeF3GY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 02:24:29 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fZ9Id-0005KM-PM; Sat, 30 Jun 2018 08:23:59 +0200
Date:   Sat, 30 Jun 2018 08:23:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/4] x86/split_lock: Align x86_capability to unsigned
 long to avoid split locked access
In-Reply-To: <20180630001411.GD68178@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1806300803121.1595@nanos.tec.linutronix.de>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com> <1530282807-66555-3-git-send-email-fenghua.yu@intel.com> <ae0b8cb1-a8a9-f0ef-3c20-f4fe4b9b6f4a@intel.com> <alpine.DEB.2.21.1806291824010.1595@nanos.tec.linutronix.de>
 <20180629190346.GO18979@romley-ivt3.sc.intel.com> <alpine.DEB.2.21.1806292148510.1595@nanos.tec.linutronix.de> <20180629203844.GA68178@romley-ivt3.sc.intel.com> <8fdfb671-f223-163b-12cd-3c97d94f91b4@intel.com> <alpine.DEB.2.21.1806292334180.1595@nanos.tec.linutronix.de>
 <20180630000051.GC68178@romley-ivt3.sc.intel.com> <20180630001411.GD68178@romley-ivt3.sc.intel.com>
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

On Fri, 29 Jun 2018, Fenghua Yu wrote:
> On Fri, Jun 29, 2018 at 05:00:51PM -0700, Fenghua Yu wrote:

> diff --git a/arch/x86/boot/cpuflags.h b/arch/x86/boot/cpuflags.h
> index 2e20814d3ce3..29de0ff74351 100644
> --- a/arch/x86/boot/cpuflags.h
> +++ b/arch/x86/boot/cpuflags.h
> @@ -9,7 +9,7 @@ struct cpu_features {
>  	int level;		/* Family, or 64 for x86-64 */
>  	int family;		/* Family, always */
>  	int model;
> -	u32 flags[NCAPINTS];
> +	u32 flags[NCAPINTS] __aligned(sizeof(unsigned long));

Lacks a comment WHY this needs the aligned() as Dave already said.

>  };
>  
>  extern struct cpu_features cpu;
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 8c7b3e5a2d01..444a2275c1f8 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -133,7 +133,7 @@ struct mce_log_buffer {
>  	char signature[12]; /* "MACHINECHECK" */
>  	unsigned len;	    /* = MCE_LOG_LEN */
>  	unsigned next;
> -	unsigned flags;
> +	unsigned flags __aligned(sizeof(unsigned long));

And whats wrong with just making that flags field unsigned long and move it
behind recordlen?

flags is at offset 20 so forcing alignement puts it at offset 24 creating a
4 byte hole. While reordering it and making it type unsigned long just
fills the already existing hole and just works w/o the stray aligned()

struct mce_log_buffer {
        char                       signature[12];        /*     0    12 */
        unsigned int               len;                  /*    12     4 */
        unsigned int               next;                 /*    16     4 */
        unsigned int               flags;                /*    20     4 */
        unsigned int               recordlen;            /*    24     4 */

        /* XXX 4 bytes hole, try to pack */

        struct mce                 entry[32];            /*    32  3840 */

The point is, that there is no requirement that flags is unsigned int,
while the u32 type for the capability array has a reason.

So you need to analyse first whether the data type is required or can be
changed to unsigned long which is the right thing to do.

See?

Thanks,

	tglx
