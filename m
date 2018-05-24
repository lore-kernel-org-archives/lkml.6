Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935237AbeEXAMy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 20:12:54 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:26694 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933416AbeEXAMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 20:12:51 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w4O0CSeS026312
X-Nifty-SrcIP: [209.85.213.43]
X-Google-Smtp-Source: AB8JxZqfxXwBC6zdVNNrQkKDGc54vEsXejCh22eL6KCdgqoVUSjwPd4x/tYSTv5DkvOajGnGjQuaekea9D4kD9EOqq4=
MIME-Version: 1.0
In-Reply-To: <15dcff14-ea1b-18c8-4cd1-06586cf6f05b@redhat.com>
References: <20180523001939.9431-1-labbott@redhat.com> <20180523001939.9431-3-labbott@redhat.com>
 <CALCETrX9P2Lwrx7wGc22poVWX2AHAqXbUdhcijyoJ3tGhaxijg@mail.gmail.com> <15dcff14-ea1b-18c8-4cd1-06586cf6f05b@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 24 May 2018 09:11:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARMJ0WNnxWXPxpyq_K_osBTRZB+0-Vo5XS_ME9GyZ0UxQ@mail.gmail.com>
Message-ID: <CAK7LNARMJ0WNnxWXPxpyq_K_osBTRZB+0-Vo5XS_ME9GyZ0UxQ@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] x86/vdso: Add build salt to the vDSO
To: Laura Abbott <labbott@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-24 7:53 GMT+09:00 Laura Abbott <labbott@redhat.com>:
> On 05/22/2018 05:33 PM, Andy Lutomirski wrote:
>>
>> On Tue, May 22, 2018 at 5:19 PM Laura Abbott <labbott@redhat.com> wrote:
>>
>>
>>> The vDSO is linked separately from the kernel and modules. Ensure it
>>> picks
>>> up the comment section, if available.
>>
>>
>> Did you end up preferring this to just sticking the kernel version in a
>> .comment in the vDSO for some reason?
>>
>
> Actually I remember now why this is necessary: there is not a simple way
> to encode a string into a linker file as it has to be spit out byte
> by byte. The autogeneration was the easiest way to make that happen.
> Maybe there's some horrific c preprocessing or other generation that
> could happen but I doubt that's any worse than the generated linker
> script.
>


I am personally prefer CONFIG option (as you did in v2) to KERNELVERSION.


If you use "hex" type instead of "string" type in Kconfig,
and LONG() instead of BYTE() in the script script,
this can be much simpler, right?





config BUILD_ID_SALT
        hex "Build ID Salt"
        help
           ...




Then, in scripts/Makefile,


define filechk_build-salt.lds
        { \
                echo "SECTIONS {"; \
                echo ".comment (INFO) : { LONG($(CONFIG_BUILD_ID_SALT)); }"; \
                echo "}"; \
        }
endef

$(obj)/build-salt.lds: $(src)/Makefile FORCE
        $(call filechk,build-salt.lds)




This is now so simple that we can even remove the shell script.





-- 
Best Regards
Masahiro Yamada
