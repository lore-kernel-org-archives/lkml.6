Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3099FC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 01:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0AD20844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 01:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGNITIw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0AD20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeIHGAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:00:13 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41418 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeIHGAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:00:12 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so30503728oiw.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 18:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzAFH5NSuWBveeR4MPaOTk11ST2HN8AR5GuWbmgNR8U=;
        b=lGNITIw5R0JxdBtXHOHOgU+4zh+tfVZgNIlMLw4++KhnHMo6Ds8lXUW9vR9o8Jhrm7
         jUZ//sS9KcyUiRoNMj+AmUD7IcLU0P0dEse9g6xTitTWAusty5XXy/bjtII2BHbivnbO
         v3Kj+G8FnL1GhXr4KHwq+PEYkWRzsxqGJXbjNpQruI86JApNtHSxYxsidYaoUOboAkCA
         4c+ymwqBh47ETFaJqaX8KfeZzjPPsur/f6DJ7/yNeE4Exwfeul/KYFPjwrdrvWF5e+QP
         dTT0b4oyp+DvSjsuDA4QK6v6le6muhpM7imUyb9s/Aek/ktDGhGurUFqYEiBgL9proPx
         cQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzAFH5NSuWBveeR4MPaOTk11ST2HN8AR5GuWbmgNR8U=;
        b=KJyx8g97yIy4mHECzx6BrjYiN7jt+tyLIH63TNdzLeMUGCDRLoKRGOOS3OyaTESqf7
         08mtTUYUcdfNKeLCM7OmMjjgTn8y5h/yCrSkBC8m+ufSy7RZzT9Td8vWMir29xxCgd19
         HoWvHRoAKnOFxe6gE6tXf6pkGh6zRzUNXueea8rXgTSjU2opMmOHxw+s7w1Eui/eWt5z
         sJ5+ADWtA4jNotU3IEkpvFSbXLIgMpwDKRUrqmbdYLwMIrchaFmnNm0zQayb5JjQXGXW
         kj9dy4qavTFIia0kNzzeaCAFwf5ToFEASIoaz2+925Wg8QFskhreCU4g452jlGjQlynT
         EAUA==
X-Gm-Message-State: APzg51BbMSv2/kCH/sJroqLkdhdQaerZYf8mplfJUsYFSBUR0FgEL1Si
        TcTF8mmiqR+To+dilWPQNvG6dMp3wpBQRVdj4SdkBA==
X-Google-Smtp-Source: ANB0VdYivjRn9LD40b7Cs89ps7hsSrtuDBrllaykv/0WrBoOlxOOUA+WbIpJhnMUA6x9ivGUHkenQWJHROjuH7K0R+k=
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr11036848oif.348.1536369395961;
 Fri, 07 Sep 2018 18:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180907194852.3C351B82@viggo.jf.intel.com> <20180907194902.63F36CFE@viggo.jf.intel.com>
In-Reply-To: <20180907194902.63F36CFE@viggo.jf.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 8 Sep 2018 03:16:09 +0200
Message-ID: <CAG48ez2e8yJJjHeKRTbu46=5mbssZo84iMinBx6B5BgziDJiVQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 7/8] x86/mm/vsyscall: consider vsyscall page part of
 user address space
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 2:28 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
> The vsyscall page is weird.  It is in what is traditionally part of the
> kernel address space.  But, it has user permissions and we handle faults
> on it like we would on a user page: interrupts on.
>
> Right now, we handle vsyscall emulation in the "bad_area" code, which
> is used for both user-address-space and kernel-address-space faults.  Move
> the handling to the user-address-space code *only* and ensure we get there
> by "excluding" the vsyscall page from the kernel address space via a check
> in fault_in_kernel_space().
[...]
>  static int fault_in_kernel_space(unsigned long address)
>  {
> +       /*
> +        * The vsyscall page is at an address above TASK_SIZE_MAX,
> +        * but is not considered part of the kernel address space.
> +        */
> +       if (is_vsyscall_vaddr(address))
> +               return false;

I think something should check for "#ifdef CONFIG_X86_64"? 32-bit
doesn't have a vsyscall page, right? And this code probably shouldn't
veer off into the userspace-area fault handling code for addresses in
the range 0xff600000-0xff600fff... what is in that region on 32-bit?
Modules or something like that?
Maybe change is_vsyscall_vaddr() so that it always returns false on
32-bit, or put both the definition of is_vsyscall_vaddr() and this
code behind #ifdef guards.
And, in a separate patch, maybe also #ifdef-guard the definition of
VSYSCALL_ADDR in vsyscall.h? Nothing good is going to result from
making a garbage VSYSCALL_ADDR available to 32-bit code.

> +#ifdef CONFIG_X86_64
> +       /*
> +        * Instruction fetch faults in the vsyscall page might need
> +        * emulation.  The vsyscall page is at a high address
> +        * (>PAGE_OFFSET), but is considered to be part of the user
> +        * address space.
> +        *
> +        * The vsyscall page does not have a "real" VMA, so do this
> +        * emulation before we go searching for VMAse

"VMAse"? Is that a typo?
