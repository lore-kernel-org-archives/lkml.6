Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935208AbeEWX4G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 19:56:06 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51788 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934770AbeEWX4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 19:56:03 -0400
X-Google-Smtp-Source: AB8JxZos31h/YRQWbhuXa/GxPrimhd46ZxNkd6dGEaFClP/OAzNpPeom4X7gfp3idwrRwEMYexyrbNqjUArspSVVdrs=
MIME-Version: 1.0
References: <20180523001939.9431-1-labbott@redhat.com> <20180523001939.9431-3-labbott@redhat.com>
 <CALCETrX9P2Lwrx7wGc22poVWX2AHAqXbUdhcijyoJ3tGhaxijg@mail.gmail.com> <15dcff14-ea1b-18c8-4cd1-06586cf6f05b@redhat.com>
In-Reply-To: <15dcff14-ea1b-18c8-4cd1-06586cf6f05b@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 May 2018 16:55:52 -0700
Message-ID: <CA+55aFxxUadENxUWU8jZqLnG=hvNA-fKCPQUMCKs2r0yWHc=rA@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] x86/vdso: Add build salt to the vDSO
To: Laura Abbott <labbott@redhat.com>
Cc: Andrew Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nickc@redhat.com, ccoutant@gmail.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 3:53 PM Laura Abbott <labbott@redhat.com> wrote:

> Actually I remember now why this is necessary: there is not a simple way
> to encode a string into a linker file as it has to be spit out byte
> by byte.

I think you can use the "fill" thing to basically add any random data to a
section.

So you can do something like

        . = ALIGN(16);
        .salt : AT(ADDR(.salt) - LOAD_OFFSET) {
                LONG(0xffaa5500);
                . = ALIGN(16);
        } =0x01234567890abcdef

in the lds file, and you'll get a section that looks like this:

   [torvalds@i7 linux]$ objdump -h vmlinux -j .salt -s

   vmlinux:     file format elf64-x86-64

   Sections:
    Idx Name          Size      VMA               LMA               File off
  Algn
     15 .salt         00000010  ffffffff8432b000  000000000432b000  0352b000
  2**0
                      CONTENTS, ALLOC, LOAD, DATA
    Contents of section .salt:
     ffffffff8432b000 0055aaff 00123456 7890abcd ef001234  .U....4Vx......4

Now whether that is sufficient for your needs, I dunno.

               Linus
