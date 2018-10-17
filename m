Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E81ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D657214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D657214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeJQWCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:02:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52344 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJQWCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:02:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E51AC80D;
        Wed, 17 Oct 2018 07:06:58 -0700 (PDT)
Received: from [10.1.196.72] (unknown [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D16493F71A;
        Wed, 17 Oct 2018 07:06:54 -0700 (PDT)
Subject: Re: [PATCH v7 0/8] arm64: untag user pointers passed to the kernel
To:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Evgeniy Stepanov <eugenis@google.com>
References: <cover.1538485901.git.andreyknvl@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <be684ce5-92fd-e970-b002-83452cf50abd@arm.com>
Date:   Wed, 17 Oct 2018 15:06:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cover.1538485901.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 02/10/2018 14:12, Andrey Konovalov wrote:
> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> tags into the top byte of each pointer. Userspace programs (such as
> HWASan, a memory debugging tool [1]) might use this feature and pass
> tagged user pointers to the kernel through syscalls or other interfaces.
> 
> Right now the kernel is already able to handle user faults with tagged
> pointers, due to these patches:
> 
> 1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
>              tagged pointer")
> 2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
> 	      pointers")
> 3. 276e9327 ("arm64: entry: improve data abort handling of tagged
> 	      pointers")
> 
> When passing tagged pointers to syscalls, there's a special case of such a
> pointer being passed to one of the memory syscalls (mmap, mprotect, etc.).
> These syscalls don't do memory accesses but rather deal with memory
> ranges, hence an untagged pointer is better suited.
> 
> This patchset extends tagged pointer support to non-memory syscalls. This
> is done by reusing the untagged_addr macro to untag user pointers when the
> kernel performs pointer checking to find out whether the pointer comes
> from userspace (most notably in access_ok).
> 
> The following testing approaches has been taken to find potential issues
> with user pointer untagging:
> 
> 1. Static testing (with sparse [2] and separately with a custom static
>    analyzer based on Clang) to track casts of __user pointers to integer
>    types to find places where untagging needs to be done.
> 
> 2. Dynamic testing: adding BUG_ON(has_tag(addr)) to find_vma() and running
>    a modified syzkaller version that passes tagged pointers to the kernel.
> 
...

I have been thinking a bit lately on how to address the problem of user tagged pointers passed to the kernel through syscalls, and IMHO probably the best way we have to catch them all and make sure that the approach is maintainable in the long term is to introduce shims that tag/untag the pointers passed to the kernel.

In details, what I am proposing can live either in userspace (preferred solution so that we do not have to relax the ABI) or in kernel space and can be summarized as follows:
 - A shim is specific to a syscall and is called by the libc when it needs to invoke the respective syscall.
 - It is required only if the syscall accepts pointers.
 - It saves the tags of a pointers passed to the syscall in memory (same approach if the we are passing a struct that contains pointers to the kernel, with the difference that all the tags of the pointers in the struct need to be saved singularly)
 - Untags the pointers
 - Invokes the syscall
 - Retags the pointers with the tags stored in memory
 - Returns

What do you think?

-- 
Regards,
Vincenzo
