Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753037AbeEPJxv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:53:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38136 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbeEPJxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:53:47 -0400
Date: Wed, 16 May 2018 11:53:41 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] x86/boot/compressed/64: Fix moving page table out
 of trampoline memory
In-Reply-To: <20180516080131.27913-3-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1805161153220.1627@nanos.tec.linutronix.de>
References: <20180516080131.27913-1-kirill.shutemov@linux.intel.com> <20180516080131.27913-3-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018, Kirill A. Shutemov wrote:

> cleanup_trampoline() relocates the top-level page table out of
> trampoline memory. We use 'top_pgtable' as our new top-level page table.
> 
> But if the 'top_pgtable' would be referenced from C in a usual way,
> the address of the table will be calculated relative to RIP.
> After kernel gets relocated, the address will be in the middle of
> decompression buffer and the page table may get overwritten.
> This leads to a crash.
> 
> We calculate the address of other page tables relative to the relocation
> address. It makes them safe. We should do the same for 'top_pgtable'.
> 
> Calculate the address of 'top_pgtable' in assembly and pass down to
> cleanup_trampoline().
> 
> Move the page table to .pgtable section where the rest of page tables
> are. The section is @nobits so we save 4k in kernel image.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: e9d0e6330eb8 ("x86/boot/compressed/64: Prepare new top-level page table for trampoline")

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
