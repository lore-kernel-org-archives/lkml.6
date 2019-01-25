Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F73C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA02221872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ab2BnOS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfAYU2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:28:49 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41855 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYU2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:28:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id 189so6155891qkj.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 12:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rloHtCzsoeLaTQKYgrEGKieu6LvAn6lHlK+PiRSdvck=;
        b=ab2BnOS7dEcTEbQ6bG45KiicHHApZnLV/eV9bhB6IjqeGxJ93YwBctmScADULqSTGZ
         mQHZ/4CckO3xXV6sEDGim4X4bGY/i/j07oAiEtIAOMPc9xiEKinUBCUB3uD1ho8inGBz
         OtdXZHFGXeobUwhGcduGykc9L/hpcWFZwQEXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rloHtCzsoeLaTQKYgrEGKieu6LvAn6lHlK+PiRSdvck=;
        b=eiI4s5Y7RK7yyo/isLM9eD0PFGo90k7umDCmY99Dof0kd4KcsgKkTrgcH+taew1PAO
         5s9rBt3cdTYLfw+zzvX06YgEFnXOl7bKywGbnjk0+slJPc7gODzo+EuB4pEz1NU3FxXA
         vlXi2Vz9z1pliOcMyXpn4Nz/DEopaS0Hivap5tptk8OPwEkolz4a8UYCOAfCUcuWLIKN
         3noMjPE4gG+2EFNy/puKZFP9XU+9nBQIisZb/8ev+c1kN5vdua1HnHWWuE12Q5/svDnH
         kbZX7SL3B0+gXTPZu9S8L24Dzh0zSyGf1DjyqC+Tbf+ClTpqCCmZ77eOTGQN4NMr4R+2
         nFbw==
X-Gm-Message-State: AJcUukfyyyJ5AXYER33RDsvQ05DzuI7yZh3yhBF/S+VeNwTXonrguD/B
        9aamrdpK7RBaWw64DwL/jH+T0A==
X-Google-Smtp-Source: ALg8bN6FZf8Zn8ICgt+YYNOYtJShBXgGr3V+FayYAaSnq60ThavCLwOyf2+fPY0WFZNZ/mMfhPiTgg==
X-Received: by 2002:a05:620a:1435:: with SMTP id k21mr10678200qkj.83.1548448127212;
        Fri, 25 Jan 2019 12:28:47 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id w15sm82990902qta.16.2019.01.25.12.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 12:28:46 -0800 (PST)
Date:   Fri, 25 Jan 2019 15:28:45 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     hpa@zytor.com
Cc:     Karim Yaghmour <karim.yaghmour@opersys.com>,
        Daniel Colascione <dancol@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atish patra <atishp04@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
Message-ID: <20190125202845.GA235983@google.com>
References: <20190120161003.GB23827@google.com>
 <A40C22DF-B43F-44BA-8148-FC0881087315@zytor.com>
 <20190121014553.GD23827@google.com>
 <BC774ED4-C0FC-4AA6-9BAF-36930A661D9B@zytor.com>
 <20190122133901.GA189736@google.com>
 <117d2f96-b0e9-2376-69b7-836fa0c52539@opersys.com>
 <CAKOZuesWgo3CZj49aUChX_-dpijCrVLxgVZChyLLmOWXCLQf-Q@mail.gmail.com>
 <6f82d99a-d877-aeae-3e63-95dff260c445@opersys.com>
 <20190124205929.GA141510@google.com>
 <50511D3D-7193-4B1C-952E-CCC37FA71388@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50511D3D-7193-4B1C-952E-CCC37FA71388@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:00:25AM -0800, hpa@zytor.com wrote:
> On January 24, 2019 12:59:29 PM PST, Joel Fernandes <joel@joelfernandes.org> wrote:
> >On Thu, Jan 24, 2019 at 07:57:26PM +0100, Karim Yaghmour wrote:
> >> 
> >> On 1/23/19 11:37 PM, Daniel Colascione wrote:
> >[..]
> >> > > Personally I advocated a more aggressive approach with Joel in
> >private:
> >> > > just put the darn headers straight into the kernel image, it's
> >the
> >> > > *only* artifact we're sure will follow the Android device
> >whatever
> >> > > happens to it (like built-in ftrace).
> >> > 
> >> > I was thinking along similar lines. Ordinarily, we make loadable
> >> > kernel modules. What we kind of want here is a non-loadable kernel
> >> > module --- or a non-loadable section in the kernel image proper.
> >I'm
> >> > not familiar with early-stage kernel loader operation: I know it's
> >> > possible to crease discardable sections in the kernel image, but
> >can
> >> > we create sections that are never slurped into memory in the first
> >> > place? If not, maybe loading and immediately discarding the header
> >> > section is good enough.
> >> 
> >> Interesting. Maybe just append it to the image but have it not loaded
> >and
> >> have a kernel parameter than enables a "/proc/kheaders" driver to
> >know where
> >> the fetch the appended headers from storage at runtime. There would
> >be no
> >> RAM loading whatsoever of the headers, just some sort of
> >> "kheaders=/dev/foobar:offset:size" parameter. If you turn the option
> >on, you
> >> get a fatter kernel image size to store on permanent storage, but no
> >impact
> >> on what's loaded at boot time.
> >
> >Embedding anything into the kernel image does impact boot time though
> >because
> >it increase the time spent by bootloader. A module OTOH would not have
> >such
> >overhead.
> >
> >Also a kernel can be booted in any number of ways other than mass
> >storage so
> >it is not a generic Linux-wide solution to have a kheaders= option like
> >that.
> >If the option is forgotten, then the running system can't use the
> >feature.
> >The other issue is it requires a kernel command line option /
> >bootloader
> >changes for that which adds more configuration burden, which not be
> >needed
> >with a module.
> >
> >> > Would such a thing really do better than LZMA? LZMA already has
> >very
> >> > clever techniques for eliminating long-range redundancies in
> >> > compressible text, including redundancies at the sub-byte level. I
> >can
> >> > certainly understand the benefit of stripping comments, since
> >removing
> >> > comments really does decrease the total amount of information the
> >> > compressor has to preserve, but I'm not sure how much the encoding
> >> > scheme you propose below would help, since it reminds me of the
> >> > encoding scheme that LZMA would discover automatically.
> >> 
> >> I'm no compression algorithm expert. If you say LZMA would do the
> >> same/better than what I suggested then I have no reason to contest
> >that. My
> >> goal is to see the headers as part of the kernel image that's
> >distributed on
> >> devices so that they don't have to be chased around. I'm just trying
> >to make
> >> it as palatable as possible.
> >
> >I believe LZMA is really good at that sort of thing too.
> >
> >Also at 3.3MB of module size, I think we are really good size-wise. But
> >Dan
> >is helping look at possibly reducing further if he gets time. Many
> >modules in
> >my experience are much bigger. amdgpu.ko on my Linux machine is 6.1MB.
> >
> >I really think making it a module is the best way to make sure this is
> >bundled with the kernel on the widest number of Android and other Linux
> >systems, without incurring boot time overhead, or any other command
> >line
> >configuration burden.
> >
> >I spoke to so many people at LPC personally with other kernel
> >contributors,
> >and many folks told me one word - MODULE :D.  Even though I hesitated
> >at
> >first, now it seems the right solution.
> >
> >If no one seriously objects, I'll clean this up and post a v2 and with
> >the
> >RFC tag taken off. Thank you!
> >
> > - Joel
> 
> So let me throw in a different notion.
> 
> A kernel module really is nothing other than a kernel build system artifact stored in the filesystem.
> 
> I really don't at any reason whatsoever why this is direct from just producing an archive and putting it in the module directory, except that the latter is far simpler.
> 
> I see literally *no* problem, social or technical, you are solvin by actually making it a kernel ELF object.

I think you may not be seeing the point being made here, Hans. A module can
be in any number of locations. The work to do the search of the modules is
already done by modprobe. Diverse userspaces already know how to look for and
load modules - whether its Android or some other user space. Modules are
universal and integrated well within the kernel's ecosystem even though the
Linux systems are so diverse.

Also, as I was saying before - there is an option to build it into the kernel
too with this proposal, if you hate modules so much.

This is exactly why /proc/config.gz is so popular and used widely by people
debugging the kernel. Same with /proc/kallsysms. So if we had it your way,
then you might as well make those non-ELF artifacts right?

You can look at it as a convenince option. Making things more convenient for
users is solving problems, I'm sorry you don't see it that way.

thanks,

 - Joel

