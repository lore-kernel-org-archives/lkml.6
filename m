Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57896C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 14:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29EC2083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 14:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29EC2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeIASaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 14:30:19 -0400
Received: from nautica.notk.org ([91.121.71.147]:55304 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbeIASaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 14:30:18 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id BCB5EC009; Sat,  1 Sep 2018 16:18:02 +0200 (CEST)
Date:   Sat, 1 Sep 2018 16:17:47 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 7/7] Compiler Attributes: use feature checks instead of
 version checks
Message-ID: <20180901141747.GA20900@nautica>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com>
 <20180901101430.GA21877@nautica>
 <CANiq72=pMSOaY5rYvJFgWKjiqAMjEVFu8GXRHx=Tz4sXqP-SSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72=pMSOaY5rYvJFgWKjiqAMjEVFu8GXRHx=Tz4sXqP-SSw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda wrote on Sat, Sep 01, 2018:
>>> +/*
>>> + * To check for optional attributes, we use __has_attribute, which is supported
>>> + * on gcc >= 5, clang >= 2.9 and icc >= 17. In the meantime, to support
>>> + * 4.6 <= gcc < 5, we implement __has_attribute by hand.
>>> + */
>>> +#ifndef __has_attribute
>>> +#define __has_attribute(x) __GCC4_has_attribute_##x
>>> +#define __GCC4_has_attribute_externally_visible 1
>>> +#define __GCC4_has_attribute_noclone 1
>>> +#define __GCC4_has_attribute_optimize 1
>>> +#if __GNUC_MINOR__ >= 8
>>> +#define __GCC4_has_attribute_no_sanitize_address 1
>>> +#endif
>>> +#if __GNUC_MINOR__ >= 9
>>> +#define __GCC4_has_attribute_assume_aligned 1
>>> +#endif
>>> +#endif
>>
>> Hmm, if this is in this file and not compiler-gcc, I am not sure about
>> using GNUC_MINOR without checking the major -- I have no idea what kind
>> of versions e.g. icc will use (or what attributes ancients version of
>> clang or old icc support, actually)
> 
> The idea here is that all non-gcc recent compilers that we may care
> about support __has_attribute,so if we are inside the #ifndef, we
> *have* to be gcc < 5 (see https://godbolt.org/z/NQFdsK).

That really makes me want to have these in compiler-gcc though :)

But I guess I can also understand wanting to include this file as early
as possible, although I do not think any of the compiler-specific
headers use any of this they could eventually want to override something
from it at some point... Leaving it as an open question, feel free to do
as you prefer here.


> By the way, do you know if there are some public docs on the
> attributes supported by icc that we can link to? I couldn't find
> anything in a quick search, both in google and in the icc's
> "Compatibility" pages...

I'm honestly not using icc much, I just have access to machines where it
is installed...
Actually, now I'm looking there is some html documentation installed
along with icc, but it does not seem complete; instead it points to
software.intel.com ... which has _some_ documentation on attributes, but
is missing a _lot_ of them, see :
https://software.intel.com/en-us/cpp-compiler-18.0-developer-guide-and-reference-attributes

I saw that a lot of these attributes were defined as #pragma first for
icc and had hoped to see something like 'alternative forms' in the
pragma documentations but there does not seem to be anything there
either... Afraid I won't be of much help there.



(from another reply)
> Because of that logic, I tried to simplify as much as possible all
> existing things (e.g. assume_aligned by removing __CHECKER__) so that
> they could be moved to compiler_attributes.h. In a way,
> compiler_attributes.h defines some extensions to the C language that
> all code could use anywhere (actually whether we can move them out of
> __KERNEL__ etc. is another question)

(very good question, though! Figuring out how to share these with the
tools/include/linux/compiler* instead of having an old copy would be a
good start... For another patchset though)

-- 
Dominique
