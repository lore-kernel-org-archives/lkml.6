Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4616C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8F82086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfASXqP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 18:46:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58327 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfASXqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 18:46:14 -0500
Received: from [IPv6:2607:fb90:2843:591a:6d1d:ce2f:69d2:7e68] ([172.56.41.105])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0JNiuYi1819236
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 19 Jan 2019 15:44:57 -0800
Date:   Sat, 19 Jan 2019 15:44:48 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190119232503.GA149403@google.com>
References: <20190118225543.86996-1-joel@joelfernandes.org> <20190119082532.GA9004@kroah.com> <20190119162754.GC231277@google.com> <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com> <20190119232503.GA149403@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the kernel
To:     Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
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
Message-ID: <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 19, 2019 3:25:03 PM PST, Joel Fernandes <joel@joelfernandes.org> wrote:
>On Sat, Jan 19, 2019 at 12:43:35PM -0500, Daniel Colascione wrote:
>> On Sat, Jan 19, 2019 at 11:27 AM Joel Fernandes
><joel@joelfernandes.org> wrote:
>> >
>> > On Sat, Jan 19, 2019 at 09:25:32AM +0100, Greg KH wrote:
>> > > On Fri, Jan 18, 2019 at 05:55:43PM -0500, Joel Fernandes wrote:
>> > > > --- /dev/null
>> > > > +++ b/kernel/kheaders.c
>> 
>> Thanks a ton for this work. It'll make it much easier to do cool
>> things with BPF.
>
>You're welcome, thanks.
>
>> One question: I can imagine wanting to probe
>> structures that are defined, not in headers, but in random
>> implementation files. Would it be possible to optionally include
>*all*
>> kernel source files?
>
>That would be prohibitively too large to justify keeping it in memory,
>even
>compressed. Arguably, such structures should be moved into include/ if
>modules or whatever is extending the kernel like eBPF needs them.
>
>> If not, what about a hash, so we could at least
>> do precise correlation between a candidate local tree and what's
>> actually on device?
>
>That would make a tool too difficult to write wouldn't it, since they
>you have to
>correlate every possible hash and keep updating eBPF tools with new
>hashes -
>probably not scalable. I think what you want is to use the kernel
>version to
>assume what such internal structures look like although that's still
>not
>robust.
>
>> BTW, I'm not sure that the magic constants you've defined are long
>> enough.  I'd feel more comfortable with two UUIDs (16 bytes each).
>
>Ok, I'll expand it.
>
>> I'd also strongly consider LZMA compression: xz -9 on the kernel
>> headers (with comments) brings the size down to 5MB, compared to the
>> 7MB I get for gzip -9. Considering that this feature is optional, I
>> think it's okay to introduce a dependency on widespread modern
>> compression tools. (For comparison, bzip2 -9 gets us 6MB.)
>
>Ok, I'll look into LZMA. Thanks for checking the compression sizes.
>
>- Joel

Don't use lzma, use xz if you are going to do something.

However, it seems unlikely to me that someone not willing to spend the space in the filesystem will spend unswappable kernel memory.

It would seem that a far saner way to do this is to use inittmpfs or perhaps an auxiliary "ktmpfs" so it can at least be swapped out if you have swap.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
