Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C30C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6042A2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfBTSzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:55:50 -0500
Received: from mother.openwall.net ([195.42.179.200]:52511 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725798AbfBTSzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:55:50 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2019 13:55:50 EST
Received: (qmail 30382 invoked from network); 20 Feb 2019 18:49:08 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 20 Feb 2019 18:49:08 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 067D8AA7D0; Wed, 20 Feb 2019 19:48:59 +0100 (CET)
Date:   Wed, 20 Feb 2019 19:48:59 +0100
From:   Solar Designer <solar@openwall.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        x86@kernel.org
Subject: Re: [PATCH v2] x86/asm: Pin sensitive CR4 bits
Message-ID: <20190220184859.GA6429@openwall.com>
References: <20190220180934.GA46255@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220180934.GA46255@beast>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:09:34AM -0800, Kees Cook wrote:
> +extern volatile unsigned long cr4_pin;
> +
>  static inline void native_write_cr4(unsigned long val)
>  {
> +again:
> +	val |= cr4_pin;
>  	asm volatile("mov %0,%%cr4": : "r" (val), "m" (__force_order));
> +	/*
> +	 * If the MOV above was used directly as a ROP gadget we can
> +	 * notice the lack of pinned bits in "val" and start the function
> +	 * from the beginning to gain the cr4_pin bits for sure.
> +	 */
> +	if (WARN_ONCE((val & cr4_pin) != cr4_pin, "cr4 bypass attempt?!\n"))
> +		goto again;
>  }

I think "goto again" is too mild a response given that it occurs after a
successful write of a non-pinned value to CR4.  I think it'd allow some
exploits to eventually win the race: make their desired use of whatever
functionality SMEP, etc. would have prevented - which may be just a few
instructions they need to run - before the CR4 value is reverted after
"goto again".  I think it's one of those cases where a kernel panic
would be more appropriate.

Also, WARN_ONCE possibly introduces a delay sufficient to realistically
win this race on the first try.  If we choose to warn, we should do it
after having reverted the CR4 value, not before.

Alexander
