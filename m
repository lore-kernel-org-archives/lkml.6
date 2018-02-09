Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbeBILtR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:49:17 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:51720 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeBILtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:49:15 -0500
X-Google-Smtp-Source: AH8x226b02CzFhPWdK5KVfKZ0S5OOXxR3RSZlu8S/14B/X7zqIFzVi93Dso9g2la3HAa07RpFRizDA==
Date: Fri, 9 Feb 2018 20:49:04 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: James Morse <james.morse@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        akpm@linux-foundation.org, mpe@ellerman.id.au, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        julien.thierry@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/11] arm64: kexec: add kexec_file_load() support
Message-ID: <20180209114903.gaex3pge4ndzgbhd@fireball>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, bauerman@linux.vnet.ibm.com,
        dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, akpm@linux-foundation.org, mpe@ellerman.id.au,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, julien.thierry@arm.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20171204025801.12161-1-takahiro.akashi@linaro.org>
 <5A7B4761.3000808@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A7B4761.3000808@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Wed, Feb 07, 2018 at 06:37:21PM +0000, James Morse wrote:
> Hi Akashi,
> 
> I'm still getting my head round how all this works, so please forgive what may
> be stupid questions!

It is my pleasure.
Hopefully I will be able to address all of your concerns before submitting
a new version sometime next week.

> 
> On 04/12/17 02:57, AKASHI Takahiro wrote:
> > This is the seventh round of implementing kexec_file_load() support
> > on arm64.[1]
> > Most of the code is based on kexec-tools (along with some kernel code
> > from x86, which also came from kexec-tools).
> > 
> > 
> > This patch series enables us to
> >   * load the kernel, Image, via kexec_file_load() system call, and
> >   * optionally verify its signature at load time for trusted boot.
> 
> Is kdump using kexec_file_load() possible? (questions on patch 3)
> I can't work out why additional elf-generating code would be necessary if kdump
> works today without it...

The code that probably you are mentioning is the one for
creating a content of an ELF header (elfcoreheader) of /proc/vmcore.
The memory region is allocated by the kernel, but the content itself
will be filled up by kexec-tools for kexec_load syscall, while by
the kernel for kexec_file_load syscall.
(In former case, a "user" buffer is passed via kexec_load syscall
and copied into the crash dump kernel memory.)

Please see kexec/crashdump.c and crashdump-elf.c on kexec-tools.

> 
> 
> > To load the kernel via kexec_file_load() system call, a small change
> > is also required on kexec-tools. See [2]. This enables '-s' option.
> > (Please use v7.2.1+ crash utility for v4.14+ kernel)
> 
> (what does the -s option do?)

It is a switch for using kexec_file_load syscall instead of kexec_load
syscall.

> 
> > As we discussed a long time ago, users may not be allowed to specify
> > device-tree file of the 2nd kernel explicitly with kexec-tools, hence
> > re-using the blob of the first kernel.
> > 
> > Regarding a kernel image verification, a signature must be presented
> > along with the binary itself. A signature is basically a hash value
> > calculated against the whole binary data and encrypted by a key which
> > will be authenticated by the system's trusted certificate.
> > Any attempt to read and load a to-be-kexec-ed kernel image through
> > a system call will be checked and blocked if the binary's hash value
> > doesn't match its associated signature.
> 
> > Concerns(or future works):
> 
> (lets keep this stuff in the future)

Sure.

> > * Even if the kernel is configured with CONFIG_RANDOMIZE_BASE, the 2nd
> >   kernel won't be placed at a randomized address. We will have to
> >   add some boot code similar to efi-stub to implement the randomization.
> 
> I think there are two parts to this. The efistub may copy the kernel to a new
> ~random location in physical memory. It also adds a seed used to randomise the
> virtual-addresses the kernel executes from.

> For kexec_file_load() the first-kernel could apply some randomness to the
> physical offset when it re-assembles the kexec-kernel. i.e. code in
> arm64_relocate_new_kernel(). I don't think we should do this without some hint
> that the new kernel supports this...

Indeed. arm64_relocate_new_kernel belongs to the first kernel, while
efistub to crash dump kernel.

> For the virtual-addresses it would need to add a new kaslr-seed to the
> DT/chosen, which should be harmless.

Yeah, adding a seed is quite easy.

> 
> > for approach (1),
> > * While big-endian kernel can support kernel signing, I'm not sure that
> >   Image can be recognized as in PE format because x86 standard only
> >   defines little-endian-based format.
> 
> What does the recognizing? (I don't think we should invent a new format..)

The obvious problem is that there exists no defition of PE format for
BE architecture. (I believe that MS only defines the format for x86).
For exmaple, what magic number should we use? Are the fields in a header
in BE or LE? I don't invent a new format, neither.

Anyhow, if we allow for IMA-base kexec_file_load, it perfectly resolve
the issue without any changes (maybe).

> 
> 
> > * vmlinux support
> 
> (Patch 3 is why I'm here)
> 
> I don't think we need to support this. I can't boot a vmlinux file via UEFI. As
> I understand it kexec_file_load() is all about the signature verification for
> UEFI:SecureBoot. The chances of me having a vmlinux signed for SecureBoot use is
> pretty low, chances are its a self-signed image I just built, in which case I
> can use the arm64 Image file that was built at the same time.
> 
> Supporting two file formats is going to be a headache. Distributions ship
> separate debug info packages for debugging, I don't think we need to make them
> bootable...

As I said somewhere before, the only reason that we may want to have
vmlinux support is that kexec-tools (and in turn kexec_load syscall)
supports both file types.
(I don't know why Jeoff added this support first.)

Thanks,
-Takahiro AKASHI


> 
> Thanks,
> 
> James
