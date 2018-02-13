Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935399AbeBMOcG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:32:06 -0500
Received: from one.firstfloor.org ([193.170.194.197]:47362 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935289AbeBMOcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:32:04 -0500
Date: Tue, 13 Feb 2018 06:32:02 -0800
From: Andi Kleen <andi@firstfloor.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andi Kleen <andi@firstfloor.org>, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, jpoimboe@redhat.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/2] x86/retpoline: Fix return buffer filling
Message-ID: <20180213143202.7logf7thlozro6op@two.firstfloor.org>
References: <20180213000422.16916-1-andi@firstfloor.org>
 <20180213000422.16916-2-andi@firstfloor.org>
 <1518530301.12890.66.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518530301.12890.66.camel@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> However... that was supposed to be a 'clear RSB' operation, with 32
> CALLs in sequence. And Boris changed it to 16 by calling __fill_rsb()
> instead of __clear_rsb():

True. That's even worse.
> 
> -       asm volatile (ANNOTATE_NOSPEC_ALTERNATIVE
> -                     ALTERNATIVE("jmp 910f",
> -                                 __stringify(__FILL_RETURN_BUFFER(%0, RSB_CLEAR_LOOPS, %1)),
> -                                 X86_FEATURE_RETPOLINE)
> -                     "910:"
> -                     : "=r" (loops), ASM_CALL_CONSTRAINT
> -                     : : "memory" );
> +       alternative_input("",
> +                         "call __fill_rsb",
> +                         X86_FEATURE_RETPOLINE,
> +                         ASM_NO_INPUT_CLOBBER(_ASM_BX, "memory"));
> 
> I think we do need to revert that patch. And perhaps stop accepting any
> more similar bikeshedding.

Yes revertion would be the right way.

I already regret the time I wasted trying to fix it.

-Andi
