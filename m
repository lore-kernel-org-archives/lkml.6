Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbeBGSjx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:39:53 -0500
Received: from foss.arm.com ([217.140.101.70]:54862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754547AbeBGSjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:39:49 -0500
Message-ID: <5A7B4761.3000808@arm.com>
Date: Wed, 07 Feb 2018 18:37:21 +0000
From: James Morse <james.morse@arm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
MIME-Version: 1.0
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
CC: catalin.marinas@arm.com, will.deacon@arm.com,
        bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        akpm@linux-foundation.org, mpe@ellerman.id.au, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        julien.thierry@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/11] arm64: kexec: add kexec_file_load() support
References: <20171204025801.12161-1-takahiro.akashi@linaro.org>
In-Reply-To: <20171204025801.12161-1-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

I'm still getting my head round how all this works, so please forgive what may
be stupid questions!


On 04/12/17 02:57, AKASHI Takahiro wrote:
> This is the seventh round of implementing kexec_file_load() support
> on arm64.[1]
> Most of the code is based on kexec-tools (along with some kernel code
> from x86, which also came from kexec-tools).
> 
> 
> This patch series enables us to
>   * load the kernel, Image, via kexec_file_load() system call, and
>   * optionally verify its signature at load time for trusted boot.

Is kdump using kexec_file_load() possible? (questions on patch 3)
I can't work out why additional elf-generating code would be necessary if kdump
works today without it...


> To load the kernel via kexec_file_load() system call, a small change
> is also required on kexec-tools. See [2]. This enables '-s' option.
> (Please use v7.2.1+ crash utility for v4.14+ kernel)

(what does the -s option do?)


> As we discussed a long time ago, users may not be allowed to specify
> device-tree file of the 2nd kernel explicitly with kexec-tools, hence
> re-using the blob of the first kernel.
> 
> Regarding a kernel image verification, a signature must be presented
> along with the binary itself. A signature is basically a hash value
> calculated against the whole binary data and encrypted by a key which
> will be authenticated by the system's trusted certificate.
> Any attempt to read and load a to-be-kexec-ed kernel image through
> a system call will be checked and blocked if the binary's hash value
> doesn't match its associated signature.

> Concerns(or future works):

(lets keep this stuff in the future)

> * Even if the kernel is configured with CONFIG_RANDOMIZE_BASE, the 2nd
>   kernel won't be placed at a randomized address. We will have to
>   add some boot code similar to efi-stub to implement the randomization.

I think there are two parts to this. The efistub may copy the kernel to a new
~random location in physical memory. It also adds a seed used to randomise the
virtual-addresses the kernel executes from.

For kexec_file_load() the first-kernel could apply some randomness to the
physical offset when it re-assembles the kexec-kernel. i.e. code in
arm64_relocate_new_kernel(). I don't think we should do this without some hint
that the new kernel supports this...

For the virtual-addresses it would need to add a new kaslr-seed to the
DT/chosen, which should be harmless.


> for approach (1),
> * While big-endian kernel can support kernel signing, I'm not sure that
>   Image can be recognized as in PE format because x86 standard only
>   defines little-endian-based format.

What does the recognizing? (I don't think we should invent a new format..)


> * vmlinux support

(Patch 3 is why I'm here)

I don't think we need to support this. I can't boot a vmlinux file via UEFI. As
I understand it kexec_file_load() is all about the signature verification for
UEFI:SecureBoot. The chances of me having a vmlinux signed for SecureBoot use is
pretty low, chances are its a self-signed image I just built, in which case I
can use the arm64 Image file that was built at the same time.

Supporting two file formats is going to be a headache. Distributions ship
separate debug info packages for debugging, I don't think we need to make them
bootable...


Thanks,

James
