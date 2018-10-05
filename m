Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BCCC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371112064E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYYY0I+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371112064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeJESbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:31:00 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45622 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJESbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:31:00 -0400
Received: by mail-qk1-f194.google.com with SMTP id m8-v6so7665814qka.12;
        Fri, 05 Oct 2018 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=t/iFC8Pcj1eF9sD0qlwu60t61PqTsPMrYHkQvjGK2Sg=;
        b=GYYY0I+0ZEcHhQhTJ+kZgTPhZSJhqbc4hGqNZnxcVFQyBOHOgri9b56xrHmDFKsQic
         AhkISHFZq0r21Zx8Io4f4Qtz54uZN4eyf4VdH3Kr1f3iaMotW8rwVfzUbLfYjK8wOSb2
         1d/rUZ2/2aXCIswuGNFK5Q875NIHWL8yuyYclVpNnHnZZtZ2IS4pDsFvCi8q3iGPWwxU
         G+AidkZPr7QGWawsqXxB7UKzsVyNohmlJIV+peX6/k6IyyvzzcD4PbeB8+M794eCjAxw
         ZAJWiot2b4o+fxOq5LX6sjLGtQ2KYkDMcIp+5H3EPQrGht7QuuSiJnueHD5D8Zb7cCXb
         oy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=t/iFC8Pcj1eF9sD0qlwu60t61PqTsPMrYHkQvjGK2Sg=;
        b=jtHB5EnrjC3IVuyFsHM5Uur0ezRiDr+l1/cPJUOoVJwRd80jawvX6VUKiZQqse66Dm
         K4EAYkOCbt9Ew2nZqdmbdNQJr761BVm+WulE/QFCoQTvuei24m85QNh+MKGEcWHHUSnk
         /OVqkbfcFraRhkHc6IjtwOATNps8xYxJaSAkw0gJFMIosGKnPBIOLSFpQ0QK/bEqgfNL
         PxlV/op6L8UcCkaBZ/Jmrl+0MHaCSZrFV9L0kWKgfAy4zgedvU+t9kXmg9bLV4vdmi+h
         cWgLXHieuXAX43BKAhT2kkBTylBhA/GgHyFVPNFGFtCjrf8e0jOzcNjcbVUd7CrG480V
         C+8A==
X-Gm-Message-State: ABuFfoiysVLxIFIIDXiys9rX4jwQKN87omxguQIqQOm38ixR3zRESadI
        MR13Br5vv38JhzIHl2g/N8Zdjj2NR+Gt0tMQNpI=
X-Google-Smtp-Source: ACcGV60ASAFV3bazoyOhyC8WCMJGfdKgNT2YGvo1NnVmcn36poo609H6UkEQDw6juzkaoiGE0EEg1IHI92M4P95yq6U=
X-Received: by 2002:a37:7a05:: with SMTP id v5-v6mr8455036qkc.129.1538739156777;
 Fri, 05 Oct 2018 04:32:36 -0700 (PDT)
MIME-Version: 1.0
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 5 Oct 2018 13:32:25 +0200
Message-ID: <CANiq72kuTr09CjE0jcNFkdO-gOFCjYp+REuLPq5V9c4Y8KvWXA@mail.gmail.com>
Subject: [GIT PULL linux-next] Add Compiler Attributes (v6) tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

As discussed, here it is the Compiler Attributes series for
linux-next. This time the original v6, based on -rc6.

The changes w.r.t. v5:

  - Added latest Reviewed-by's and Tested-by's.

The conflicts are trivial to solve, but if you want a reference, take
a look at (rebased on top of next-20181005):

  https://github.com/ojeda/linux.git compiler-attributes-rebased

Thanks!

Cheers,
Miguel

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git compiler-attributes

for you to fetch changes up to f0604f63033d4020f019d2aaee805c1075b1077b:

  Compiler Attributes: ext4: remove local __nonstring definition
(2018-09-30 20:14:04 +0200)

----------------------------------------------------------------
Miguel Ojeda (15):
      Compiler Attributes: remove unused attributes
      Compiler Attributes: always use the extra-underscores syntax
      Compiler Attributes: remove unneeded tests
      Compiler Attributes: homogenize __must_be_array
      Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
      Compiler Attributes: add missing SPDX ID in compiler_types.h
      Compiler Attributes: use feature checks instead of version checks
      Compiler Attributes: KENTRY used twice the "used" attribute
      Compiler Attributes: remove uses of __attribute__ from compiler.h
      Compiler Attributes: add Doc/process/programming-language.rst
      Compiler Attributes: add MAINTAINERS entry
      Compiler Attributes: add support for __nonstring (gcc >= 8)
      Compiler Attributes: enable -Wstringop-truncation on W=1 (gcc >= 8)
      Compiler Attributes: auxdisplay: panel: use __nonstring
      Compiler Attributes: ext4: remove local __nonstring definition

 Documentation/process/index.rst                |   1 +
 Documentation/process/programming-language.rst |  45 +++++
 MAINTAINERS                                    |   5 +
 drivers/auxdisplay/panel.c                     |   7 +-
 fs/ext4/ext4.h                                 |   9 -
 include/linux/compiler-clang.h                 |   5 -
 include/linux/compiler-gcc.h                   |  70 +------
 include/linux/compiler-intel.h                 |   9 -
 include/linux/compiler.h                       |  19 +-
 include/linux/compiler_attributes.h            | 258 +++++++++++++++++++++++++
 include/linux/compiler_types.h                 | 101 ++--------
 scripts/Makefile.extrawarn                     |   1 +
 12 files changed, 341 insertions(+), 189 deletions(-)
 create mode 100644 Documentation/process/programming-language.rst
 create mode 100644 include/linux/compiler_attributes.h
