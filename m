Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965312AbeBMRml (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:42:41 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52569 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934695AbeBMRmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:42:39 -0500
X-Google-Smtp-Source: AH8x225sVfXqsU5NrNmIPnNSPJxn5AtrgrRZU3QylM/WrMmzax+v2/bq5tBh3+OpPDy9olLyCvIqwQ==
Date: Tue, 13 Feb 2018 20:42:36 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        luto@amacapital.net, mingo@kernel.org, kirill.shutemov@linux.intel.com,
        gorcunov@openvz.org, bp@suse.de, peterz@infradead.org,
        torvalds@linux-foundation.org, willy@infradead.org
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Handle 5-level paging
 boot if kernel is above 4G
Message-ID: <20180213174236.gv3ve7wdyrpzrcxi@node.shutemov.name>
References: <20180209142228.21231-5-kirill.shutemov@linux.intel.com>
 <tip-89674e91fcf51f77dc4e87b77c6840f31b85077d@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-89674e91fcf51f77dc4e87b77c6840f31b85077d@git.kernel.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 09:21:58AM -0800, tip-bot for Kirill A. Shutemov wrote:
> Commit-ID:  89674e91fcf51f77dc4e87b77c6840f31b85077d
> Gitweb:     https://git.kernel.org/tip/89674e91fcf51f77dc4e87b77c6840f31b85077d
> Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> AuthorDate: Fri, 9 Feb 2018 17:22:28 +0300
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 13 Feb 2018 18:16:22 +0100
> 
> x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G
> 
> This patch addresses a shortcoming in current boot process on machines
> that supports 5-level paging.
> 
> If a bootloader enables 64-bit mode with 4-level paging, we might need to
> switch over to 5-level paging. The switching requires the disabling
> paging. It works fine if kernel itself is loaded below 4G.
> 
> But if the bootloader put the kernel above 4G (not sure if anybody does
> this), we would lose control as soon as paging is disabled, because the
> code becomes unreachable to the CPU.
> 
> This patch implements a trampoline in lower memory to handle this
> situation.
> 
> We only need the memory for a very short time, until the main kernel
> image sets up own page tables.
> 
> We go through the trampoline even if we don't have to: if we're already
> in 5-level paging mode or if we don't need to switch to it. This way the
> trampoline gets tested on every boot.
> 
> Debugged-by: "Kirill A. Shutemov" <kirill@shutemov.name>
> Tested-by: "Kirill A. Shutemov" <kirill@shutemov.name>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Cyrill Gorcunov <gorcunov@openvz.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mm@kvack.org
> Link: http://lkml.kernel.org/r/20180209142228.21231-5-kirill.shutemov@linux.intel.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

Tested-by should be attributed to Andrei.

And please ingore my stand-alone fix that I've just posted.

-- 
 Kirill A. Shutemov
