Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935222AbeEXABI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 20:01:08 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36580 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934770AbeEXABD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 20:01:03 -0400
X-Google-Smtp-Source: AB8JxZohgMTlYyrIMx7avpsL62ffTGS16591Z+VRfFLug6uoFV7BXXB+oD4CDqgDzoTGvgWxzkDH8A==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCHv3 2/2] x86/vdso: Add build salt to the vDSO
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15E302)
In-Reply-To: <CA+55aFxxUadENxUWU8jZqLnG=hvNA-fKCPQUMCKs2r0yWHc=rA@mail.gmail.com>
Date: Wed, 23 May 2018 17:01:00 -0700
Cc: Laura Abbott <labbott@redhat.com>, Andrew Lutomirski <luto@kernel.org>,
        mjw@fedoraproject.org, "H.J. Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nickc@redhat.com, ccoutant@gmail.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Message-Id: <195C83C0-067C-4B55-89BD-9CF3155C6E69@amacapital.net>
References: <20180523001939.9431-1-labbott@redhat.com> <20180523001939.9431-3-labbott@redhat.com> <CALCETrX9P2Lwrx7wGc22poVWX2AHAqXbUdhcijyoJ3tGhaxijg@mail.gmail.com> <15dcff14-ea1b-18c8-4cd1-06586cf6f05b@redhat.com> <CA+55aFxxUadENxUWU8jZqLnG=hvNA-fKCPQUMCKs2r0yWHc=rA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4O01EWo007709



> On May 23, 2018, at 4:55 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Wed, May 23, 2018 at 3:53 PM Laura Abbott <labbott@redhat.com> wrote:
>> 
>> Actually I remember now why this is necessary: there is not a simple way
>> to encode a string into a linker file as it has to be spit out byte
>> by byte.
> 
> I think you can use the "fill" thing to basically add any random data to a
> section.
> 
> So you can do something like
> 
>        . = ALIGN(16);
>        .salt : AT(ADDR(.salt) - LOAD_OFFSET) {
>                LONG(0xffaa5500);
>                . = ALIGN(16);
>        } =0x01234567890abcdef
> 
> in the lds file, and you'll get a section that looks like this:
> 
>   [torvalds@i7 linux]$ objdump -h vmlinux -j .salt -s
> 
>   vmlinux:     file format elf64-x86-64
> 
>   Sections:
>    Idx Name          Size      VMA               LMA               File off
>  Algn
>     15 .salt         00000010  ffffffff8432b000  000000000432b000  0352b000
>  2**0
>                      CONTENTS, ALLOC, LOAD, DATA
>    Contents of section .salt:
>     ffffffff8432b000 0055aaff 00123456 7890abcd ef001234  .U....4Vx......4
> 
> Now whether that is sufficient for your needs, I dunno.
> 

I don’t know whether I’m missing something obvious, but can’t this be in C?

asm (“.pushsection \”.comment\”; .ascii \”” WHATEVER “\”; .popsection”);

Or the .S equivalent.
