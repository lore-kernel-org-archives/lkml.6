Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86385C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53465222FE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfAEUjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:39:12 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:43041 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfAEUjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:39:11 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id AD1BE20054;
        Sat,  5 Jan 2019 21:39:07 +0100 (CET)
Date:   Sat, 5 Jan 2019 21:39:06 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Subject: Re: [GIT PULL 1/4] Kbuild updates for v4.21
Message-ID: <20190105203906.GA22423@ravnborg.org>
References: <CAK7LNAQzEHv7Y69xFTPDEhyMP6JX4ghb96UMqMdxYyVyah6-VA@mail.gmail.com>
 <CAHk-=whg49nn5q_2QVMGN0u4rQFBmRKywtqJUSk+5=rBzTk1kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whg49nn5q_2QVMGN0u4rQFBmRKywtqJUSk+5=rBzTk1kg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=LPTCDaSw0Bjh60RHnGUA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

> But the reason for this email to you is simply to ask whether you
> use/have any tools for seeing these kinds of deep include chains.

Not exactly what you ask for - but we have make V=2

Example:

$ touch include/uapi/linux/elf-em.h
$ make V=2
  CALL    scripts/checksyscalls.sh - due to target missing
  DESCEND  objtool
  CC      init/main.o - due to: include/uapi/linux/elf-em.h
  CHK     include/generated/compile.h
  CC      init/version.o - due to: include/uapi/linux/elf-em.h
  CC      init/do_mounts.o - due to: include/uapi/linux/elf-em.h
  CC      init/do_mounts_initrd.o - due to: include/uapi/linux/elf-em.h
  CC      init/do_mounts_md.o - due to: include/uapi/linux/elf-em.h
...

With V=2 kbuild will try to tell you why a target is rebuild.
This can sometimes be useful.

Here kbuild will tell you: - due to: include/uapi/linux/elf-em.h
Which may be a good clue.

But you need to figure out yourself why a certain file
depends on include/uapi/linux/elf-em.h

One way is to look at the .cmd file for a target:

$ cat init/.do_mounts_md.o.cmd
...
  include/linux/module.h \
    $(wildcard include/config/modules/tree/lookup.h) \
    $(wildcard include/config/module/sig.h) \
    $(wildcard include/config/module/unload.h) \
    $(wildcard include/config/constructors.h) \
    $(wildcard include/config/function/error/injection.h) \
  include/linux/kmod.h \
  include/linux/umh.h \
  include/linux/elf.h \
  arch/x86/include/asm/elf.h \
  arch/x86/include/asm/user.h \
  arch/x86/include/asm/user_64.h \
  arch/x86/include/asm/fsgsbase.h \
  arch/x86/include/asm/msr-index.h \
  arch/x86/include/asm/vdso.h \
    $(wildcard include/config/x86/x32.h) \
  include/uapi/linux/elf.h \
  include/uapi/linux/elf-em.h \
...

In the above all the $(wildcard ...) is the CONFIG_ symbols
in the files that trigger a possible dependency on a file
representing the CONFIG_ symbol.

We can see that the target depends on elf-em.h and if we follow
it back we end up with module.h included from do_mounts_md.c

	Sam
