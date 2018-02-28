Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbeB1KXe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:23:34 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:50681 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeB1KXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:23:32 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w1SAN8QZ016668
X-Nifty-SrcIP: [209.85.213.43]
X-Google-Smtp-Source: AG47ELti59pmP4KSfaTO/+/wk194vX8svN2wZ7nxIhl0zecxQXTKKbkJ9GhkB+fVdt+fxY19cAjmRbILQ6ohBwvXiUY=
MIME-Version: 1.0
In-Reply-To: <20180227174518.qzw6eqmuyggcvjl6@treble>
References: <cover.1519393674.git.robin.jarry@6wind.com> <cover.1519668832.git.robin.jarry@6wind.com>
 <20180227174518.qzw6eqmuyggcvjl6@treble>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 28 Feb 2018 19:22:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQLDRefb34KzF=3UUBdRLsDXtaZhRVQjRE2ZMaqNEb4LA@mail.gmail.com>
Message-ID: <CAK7LNAQLDRefb34KzF=3UUBdRLsDXtaZhRVQjRE2ZMaqNEb4LA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] kbuild: fix host progs build with libs in non
 standard locations
To: Josh Poimboeuf <jpoimboe@redhat.com>,
        Robin Jarry <robin.jarry@6wind.com>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-28 2:45 GMT+09:00 Josh Poimboeuf <jpoimboe@redhat.com>:
> On Mon, Feb 26, 2018 at 07:41:45PM +0100, Robin Jarry wrote:
>> This patchset allows to build host programs that depend on external libs
>> installed in non standard locations (i.e. not in /usr/include, /usr/lib,
>> etc.).  For now, the only way is to force HOSTCC to include both the
>> path to the host compiler and the build flags.
>>
>> I have encountered this issue when building linux into the buildroot
>> framework. host-* versions of libs may be compiled and installed in a
>> host staging dir removing the need to install them on the build system.
>>
>> I'm not really satisfied with the new HOST_{C,LD}FLAGS variables.  They
>> are too similar to HOST{C,LD}FLAGS and I find them confusing.  However,
>> HOST_EXTRA*FLAGS are already reserved for local use in makefiles (see
>> Documentation/kbuild/makefiles.txt).  And I didn't want to have even
>> longer USER_HOST_*FLAGS.  If someone has a better proposition, I'll
>> happily make a v3.
>
> In Documentation/kbuild/kbuild.txt, we have the following environment
> variables:
>
>   KCFLAGS
>   --------------------------------------------------
>   Additional options to the C compiler (for built-in and modules).
>
>   CFLAGS_KERNEL
>   --------------------------------------------------
>   Additional options for $(CC) when used to compile
>   code that is compiled as built-in.
>
>   CFLAGS_MODULE
>   --------------------------------------------------
>   Additional module specific options to use for $(CC).
>
>   LDFLAGS_MODULE
>   --------------------------------------------------
>   Additional options used for $(LD) when linking modules.
>
>   LDFLAGS_vmlinux
>   --------------------------------------------------
>   Additional options passed to final link of vmlinux.
>
> So instead of
>
>   HOST_CFLAGS
>   HOST_LDFLAGS
>
> maybe it would be more consistent to call them
>
>   CFLAGS_HOST
>   LDFLAGS_HOST
>
> ?
>
> Also, the new environment variables should be documented in the above
> file.
>
> --
> Josh



A generic rule I see is almost like this:


[1] "KBUILD_" + (Executable Name) + "FLAGS" = (Internal-use Variable)

[2] (Executable Name)  + "FLAGS" = (User Interface via Command Line)


They also derive

[3] (Internal-use Variable)  =
                      "KBUILD_" + (User Interface via Command Line)


The following is the current situation:


[1] Flags for $(CC)

           Internal use                  User interface via command line
---------------------------------------------------------------------------
(common)   KBUILD_CFLAGS                     KCFLAGS
(builtin)  KBUILD_CFLAGS_KERNEL              CFLAGS_KERNEL
(module)   KBUILD_CFLAGS_MODULE              CFLAGS_MODULE



[2] Flags for $(AS)

           Internal use                   User interface via command line
--------------------------------------------------------------------------
(common)   KBUILD_AFLAGS                      KAFLAGS
(builtin)  KBUILD_AFLAGS_KERNEL               AFLAGS_KERNEL
(module)   KBUILD_AFLAGS_MODULE               AFLAGS_MODULE


[3] Flags for $(CPP)

           Internal use                     User interface via command line
--------------------------------------------------------------------------
(common)   KBUILD_CPPFLAGS                    KCPPFLAGS



[4] Flags for $(LD)

           Internal use                     User interface via command line
--------------------------------------------------------------------------

(builtin)   [None]  #1                         [None]
(module)   KBUILD_LDFLAGS_MODULE              LDFLAGS_MODULE


  #1 (LDFLAGS_vmlinux is used for internal variable for builtin)


[5] Flags for HOSTCC, HOSTCXX

            Internal use                      User interface via command line
-----------------------------------------------------------------------------
C             HOSTCFLAGS                          [None]
C++           HOSTCXXFLAGS                        [None]
Link          HOSTLDFLAGS                         [None]
Library       HOST_LOADLIBES                      [None]



KCFLAGS, KAFLAGS, KCPPFLAGS are exceptions.
[5] is also an exception.




A consistent way could be

[5] Flags for HOSTCC, HOSTCXX

            Internal use                      User interface via command line
-----------------------------------------------------------------------------
C           KBUILD_HOSTCFLAGS                     HOSTCFLAGS
C++         KBUILD_HOSTCXXFLAGS                   HOSTCXXFLAGS
Link        KBUILD_HOSTLDFLAGS                    HOSTLDFLAGS
Lib         KBUILD_HOSTLDLIBS                     HOSTLDLIBS




Documentation/kbuild/kbuild.txt lists user interface parameters.
It is difficult to change them.  (probably, not allowed)



Documentation/kbuild/makefiles.txt lists Make variables
used in kernel sources.  So, it is easier to rename them.

Only the problem would be external modules that compile
their own host-programs with own flags. It is rare.
Anyway, external modules are often broken
when the kernel version is updated.


So, my idea is to rename existing

 HOSTCFLAGS     ->  KBUILD_HOSTCFLAGS
 HOSTCXXFLAGS   ->  KBUILD_HOSTCXXFLAGS
 HOSTLDFLAGS    ->  KBUILD_HOSTLDFLAGS
 HOST_LOADLIBES ->  KBUILD_HOSTLDLIBS


("LOADLIBES" is too long, so rename it to "LDLIBS")


Then, re-add no-prefix ones as user interface.



-- 
Best Regards
Masahiro Yamada
