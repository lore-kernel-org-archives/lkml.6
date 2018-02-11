Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbeBKLhO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 06:37:14 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55280 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753344AbeBKLhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 06:37:12 -0500
X-Google-Smtp-Source: AH8x227NeN/fW6LO3QVXr4JMXTr0FL0KT2HR1c/p31eh+Agw5v4/tVTboCVYn78Yb0DQOW2892cx5w==
Date: Sun, 11 Feb 2018 12:37:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 0/4] x86: 5-level related changes into decompression
 code
Message-ID: <20180211113708.mtloh22id57nn32g@gmail.com>
References: <20180209142228.21231-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209142228.21231-1-kirill.shutemov@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> These patcheset is a preparation for boot-time switching between paging
> modes. Please apply.
> 
> The first patch is pure cosmetic change: it gives file with KASLR helpers
> a proper name.
> 
> The last three patches bring support of booting into 5-level paging mode if
> a bootloader put the kernel above 4G.
> 
> Patch 2/4 Renames l5_paging_required() into paging_prepare() and change
> interface of the function.
> Patch 3/4 Handles allocation of space for trampoline and gets it prepared.
> Patch 4/4 Gets trampoline used.
> 
> v9:
>  - Patch 3 now saves and restores lowmem used for trampoline.
> 
>    There was report the patch causes issue on a machine. I suspect it's
>    BIOS issue that doesn't report proper bounds of usable lowmem.
> 
>    Restoring memory back to oringinal state makes problem go away.
> v8:
>  - Support switching from 5- to 4-level paging.
> v7:
>  - Fix booting when 5-level paging is enabled before handing off boot to
>    the kernel, like in kexec() case.
> 
> Kirill A. Shutemov (4):
>   x86/boot/compressed/64: Rename pagetable.c to kaslr_64.c
>   x86/boot/compressed/64: Introduce paging_prepare()
>   x86/boot/compressed/64: Prepare trampoline memory
>   x86/boot/compressed/64: Handle 5-level paging boot if kernel is above
>     4G
> 
>  arch/x86/boot/compressed/Makefile                  |   2 +-
>  arch/x86/boot/compressed/head_64.S                 | 178 ++++++++++++++-------
>  .../boot/compressed/{pagetable.c => kaslr_64.c}    |   0
>  arch/x86/boot/compressed/pgtable.h                 |  18 +++
>  arch/x86/boot/compressed/pgtable_64.c              | 100 ++++++++++--
>  5 files changed, 232 insertions(+), 66 deletions(-)
>  rename arch/x86/boot/compressed/{pagetable.c => kaslr_64.c} (100%)
>  create mode 100644 arch/x86/boot/compressed/pgtable.h

Ok, this series looks pretty good - I've applied it to tip:x86/boot for an 
eventual 4.17 merge and will push it out if it passes local testing.

Thanks,

	Ingo
