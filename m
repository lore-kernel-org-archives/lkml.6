Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B355C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92661208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qSu8MQoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92661208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754619AbeGIXR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:17:59 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:17208 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbeGIXRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:17:54 -0400
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com [209.85.213.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w69NHlkM022291;
        Tue, 10 Jul 2018 08:17:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w69NHlkM022291
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531178268;
        bh=z1T7hxuqWmYjykMaESK1bV3W1a0udgdwW+sUNK+07YA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=qSu8MQoWQlGtadO8WOeuxq9RRMbtwYkibt0X46OBfdjpQeYxEeTdptT2zXZkKPAuR
         oiW1wz9DThBtOf4oUbTWm86nuJ6kxF/gwGiGDN+d00UqOOsmSJPgCNsatxJIke7Ymo
         YiR/ciytzWwinPf4LvQ2vU2iya1dM5BO04uYo4GQUpDeS/SPY1Sn1ZcBhbM8HDYpjp
         PwbRyLH/HZglsyr+bGt0mkNpcqhKCYdGULAhaWikEf5OoLqujQL7EOY1n9V/qxcIc9
         4X+NTvaS07nQ3Vv6l92i0a6Ts7ukYoM6K+uNk0ivCeXkUP1RxXntRS+XcEDVOUS/U1
         QalsV+JqfXzLQ==
X-Nifty-SrcIP: [209.85.213.52]
Received: by mail-vk0-f52.google.com with SMTP id l143-v6so4062530vke.1;
        Mon, 09 Jul 2018 16:17:48 -0700 (PDT)
X-Gm-Message-State: APt69E0X96LfwRM3dg1yoENGiBkG4DyR6/3hjzYy6Cx7XVbQ7Z8RZo1a
        FXxn4QylOhi7ftAJ9e32bw+g4RDNcfGTtusujJ0=
X-Google-Smtp-Source: AAOMgpc4E/N821QJ5yi1Va/1cH5UrvECQGEdLdAeE+2dxckHFriY+OqyA88+IXHfjylH+V9cbbHadoj7F6IfQ1PsgSQ=
X-Received: by 2002:a1f:c102:: with SMTP id r2-v6mr12993923vkf.34.1531178267306;
 Mon, 09 Jul 2018 16:17:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 16:17:06 -0700 (PDT)
In-Reply-To: <20180709192134.vhd4lh443fymthfs@treble>
References: <1531043982-13325-1-git-send-email-yamada.masahiro@socionext.com> <20180709192134.vhd4lh443fymthfs@treble>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 10 Jul 2018 08:17:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR25_zLXmiyEs4N44Pi0qsyPGiuqSUUw-BbtQXyNmh-Og@mail.gmail.com>
Message-ID: <CAK7LNAR25_zLXmiyEs4N44Pi0qsyPGiuqSUUw-BbtQXyNmh-Og@mail.gmail.com>
Subject: Re: [PATCH] objtool: move libelf detection to Kconfig from Makefile
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-10 4:21 GMT+09:00 Josh Poimboeuf <jpoimboe@redhat.com>:
> On Sun, Jul 08, 2018 at 06:59:42PM +0900, Masahiro Yamada wrote:
>> Currently, users are allowed to enable STACK_VALIDATION regardless
>> of the compiler capability.  The top-level Makefile warns or breaks
>> the build if it turns out that the host compiler cannot link libelf.
>>
>> Move the libelf test to Kconfig so that users can enable the feature
>> only when the host compiler can build the objtool.  The ugly check
>> in the Makefile will go away.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Thanks for cleaning this up!
>
>> I am sure about this patch only from the build system point of view.
>>
>> Please review this from x86 and objtool point of view.
>>
>> In my understanding:
>>
>>  - UNWINDER_ORC _requires_ objtool,
>>    so I added 'depends on STACK_VALIDATION'.
>>    ('select' would end up with unmet depenency)
>
> Correct.
>
>>  - RETPOLINE _wants_ objtool, so I added 'imply'
>
> Yeah, I think this is fine.
>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>


Thanks for your review!


I have one question.


The package information is contained in the warning/error message.
Is it better to keep this?

If so, I will send v2
to move the information to the help, like this:



 config STACK_VALIDATION
         bool "Compile-time stack metadata validation"
         depends on HAVE_STACK_VALIDATION
         depends on $(success,echo "int main() {}" | $(HOSTCC) -xc -o
/dev/null -lelf -)
         help
          Add compile-time checks to validate stack metadata, including frame
          pointers (if CONFIG_FRAME_POINTER is enabled).  This helps ensure
          that runtime stack traces are more reliable.

          This is also a prerequisite for generation of ORC unwind data, which
          is needed for CONFIG_UNWINDER_ORC.

+         To enable this, the host compiler needs to be able to link libelf.
+         If it is missing, please install libelf-dev, libelf-devel or
+         elfutils-libelf-devel.

          For more information, see
          tools/objtool/Documentation/stack-validation.txt.


-- 
Best Regards
Masahiro Yamada
