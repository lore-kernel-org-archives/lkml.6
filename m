Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B4CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D772C218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfAYTCN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:02:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33105 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfAYTCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:02:12 -0500
Received: from [IPv6:2601:646:8881:66f1:3131:71d3:81a5:3525] ([IPv6:2601:646:8881:66f1:3131:71d3:81a5:3525])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0PJ0YK0239202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 25 Jan 2019 11:00:38 -0800
Date:   Fri, 25 Jan 2019 11:00:25 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190124205929.GA141510@google.com>
References: <20190119103606.GA17400@kroah.com> <8BD4CB7A-944C-4EC5-A198-1D85C9EE28D6@zytor.com> <20190120161003.GB23827@google.com> <A40C22DF-B43F-44BA-8148-FC0881087315@zytor.com> <20190121014553.GD23827@google.com> <BC774ED4-C0FC-4AA6-9BAF-36930A661D9B@zytor.com> <20190122133901.GA189736@google.com> <117d2f96-b0e9-2376-69b7-836fa0c52539@opersys.com> <CAKOZuesWgo3CZj49aUChX_-dpijCrVLxgVZChyLLmOWXCLQf-Q@mail.gmail.com> <6f82d99a-d877-aeae-3e63-95dff260c445@opersys.com> <20190124205929.GA141510@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the kernel
To:     Joel Fernandes <joel@joelfernandes.org>,
        Karim Yaghmour <karim.yaghmour@opersys.com>
CC:     Daniel Colascione <dancol@google.com>,
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
From:   hpa@zytor.com
Message-ID: <50511D3D-7193-4B1C-952E-CCC37FA71388@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 24, 2019 12:59:29 PM PST, Joel Fernandes <joel@joelfernandes.org> wrote:
>On Thu, Jan 24, 2019 at 07:57:26PM +0100, Karim Yaghmour wrote:
>> 
>> On 1/23/19 11:37 PM, Daniel Colascione wrote:
>[..]
>> > > Personally I advocated a more aggressive approach with Joel in
>private:
>> > > just put the darn headers straight into the kernel image, it's
>the
>> > > *only* artifact we're sure will follow the Android device
>whatever
>> > > happens to it (like built-in ftrace).
>> > 
>> > I was thinking along similar lines. Ordinarily, we make loadable
>> > kernel modules. What we kind of want here is a non-loadable kernel
>> > module --- or a non-loadable section in the kernel image proper.
>I'm
>> > not familiar with early-stage kernel loader operation: I know it's
>> > possible to crease discardable sections in the kernel image, but
>can
>> > we create sections that are never slurped into memory in the first
>> > place? If not, maybe loading and immediately discarding the header
>> > section is good enough.
>> 
>> Interesting. Maybe just append it to the image but have it not loaded
>and
>> have a kernel parameter than enables a "/proc/kheaders" driver to
>know where
>> the fetch the appended headers from storage at runtime. There would
>be no
>> RAM loading whatsoever of the headers, just some sort of
>> "kheaders=/dev/foobar:offset:size" parameter. If you turn the option
>on, you
>> get a fatter kernel image size to store on permanent storage, but no
>impact
>> on what's loaded at boot time.
>
>Embedding anything into the kernel image does impact boot time though
>because
>it increase the time spent by bootloader. A module OTOH would not have
>such
>overhead.
>
>Also a kernel can be booted in any number of ways other than mass
>storage so
>it is not a generic Linux-wide solution to have a kheaders= option like
>that.
>If the option is forgotten, then the running system can't use the
>feature.
>The other issue is it requires a kernel command line option /
>bootloader
>changes for that which adds more configuration burden, which not be
>needed
>with a module.
>
>> > Would such a thing really do better than LZMA? LZMA already has
>very
>> > clever techniques for eliminating long-range redundancies in
>> > compressible text, including redundancies at the sub-byte level. I
>can
>> > certainly understand the benefit of stripping comments, since
>removing
>> > comments really does decrease the total amount of information the
>> > compressor has to preserve, but I'm not sure how much the encoding
>> > scheme you propose below would help, since it reminds me of the
>> > encoding scheme that LZMA would discover automatically.
>> 
>> I'm no compression algorithm expert. If you say LZMA would do the
>> same/better than what I suggested then I have no reason to contest
>that. My
>> goal is to see the headers as part of the kernel image that's
>distributed on
>> devices so that they don't have to be chased around. I'm just trying
>to make
>> it as palatable as possible.
>
>I believe LZMA is really good at that sort of thing too.
>
>Also at 3.3MB of module size, I think we are really good size-wise. But
>Dan
>is helping look at possibly reducing further if he gets time. Many
>modules in
>my experience are much bigger. amdgpu.ko on my Linux machine is 6.1MB.
>
>I really think making it a module is the best way to make sure this is
>bundled with the kernel on the widest number of Android and other Linux
>systems, without incurring boot time overhead, or any other command
>line
>configuration burden.
>
>I spoke to so many people at LPC personally with other kernel
>contributors,
>and many folks told me one word - MODULE :D.  Even though I hesitated
>at
>first, now it seems the right solution.
>
>If no one seriously objects, I'll clean this up and post a v2 and with
>the
>RFC tag taken off. Thank you!
>
> - Joel

So let me throw in a different notion.

A kernel module really is nothing other than a kernel build system artifact stored in the filesystem.

I really don't at any reason whatsoever why this is direct from just producing an archive and putting it in the module directory, except that the latter is far simpler.

I see literally *no* problem, social or technical, you are solvin by actually making it a kernel ELF object.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
