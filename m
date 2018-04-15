Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeDOEj3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 00:39:29 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40581 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbeDOEj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 00:39:28 -0400
X-Google-Smtp-Source: AIpwx4+SEtBXbGINnfWOJGAXg9RfRf7nspghz9V4el+MFPsk30yVtyl/5SyXZYw6r9CLfub/VGWuog==
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: instant reboot caused by 194a9749c73d650c0
Message-ID: <5ecfeb13-84e4-f1ef-bd30-391674b2050a@gmail.com>
Date: Sat, 14 Apr 2018 21:39:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill

For some reason, my hosts instantly crash at boot time, with absolutely no log on console.

Bisection pointed to :

$ git bisect bad
194a9749c73d650c0b1dfdee04fb0bdf0a888ba8 is the first bad commit
commit 194a9749c73d650c0b1dfdee04fb0bdf0a888ba8
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Mon Mar 12 13:02:46 2018 +0300

    x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G
    
    This patch addresses a shortcoming in current boot process on machines
    that supports 5-level paging.
    
    If a bootloader enables 64-bit mode with 4-level paging, we might need to
    switch over to 5-level paging. The switching requires the disabling
    paging. It works fine if kernel itself is loaded below 4G.
    
    But if the bootloader put the kernel above 4G (not sure if anybody does
    this), we would lose control as soon as paging is disabled, because the
    code becomes unreachable to the CPU.
    
    This patch implements a trampoline in lower memory to handle this
    situation.
    
    We only need the memory for a very short time, until the main kernel
    image sets up own page tables.
    
    We go through the trampoline even if we don't have to: if we're already
    in 5-level paging mode or if we don't need to switch to it. This way the
    trampoline gets tested on every boot.
    
    Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    Cc: Andy Lutomirski <luto@amacapital.net>
    Cc: Andy Lutomirski <luto@kernel.org>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Borislav Petkov <bp@suse.de>
    Cc: Brian Gerst <brgerst@gmail.com>
    Cc: Cyrill Gorcunov <gorcunov@openvz.org>
    Cc: Denys Vlasenko <dvlasenk@redhat.com>
    Cc: H. Peter Anvin <hpa@zytor.com>
    Cc: Josh Poimboeuf <jpoimboe@redhat.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Matthew Wilcox <willy@infradead.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: linux-mm@kvack.org
    Link: http://lkml.kernel.org/r/20180312100246.89175-5-kirill.shutemov@linux.intel.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>


Reverting this patch solves the problem for me.

Thanks.
