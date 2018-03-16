Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbeCPAii (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 20:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751791AbeCPAih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 20:38:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E863C21777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELvPzji7W02/MBkxaLODRZTGx+ImUlNn82OEHxaAMWD+GqQ+GzDa23QDFxcEXfRs4EJJxFgIQYcungw8d644W0w=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2-XfeM5J0dq0kiOSiQC4T4p7cggNbuMDoCmnqjKC9tEQ@mail.gmail.com>
References: <20180315190529.20943-1-linux@dominikbrodowski.net> <CAK8P3a2-XfeM5J0dq0kiOSiQC4T4p7cggNbuMDoCmnqjKC9tEQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 16 Mar 2018 00:38:15 +0000
X-Gmail-Original-Message-ID: <CALCETrX_1pxfB10k-uj7vSyXm7hH4MeJiEY=+A3FzViaozb+BA@mail.gmail.com>
Message-ID: <CALCETrX_1pxfB10k-uj7vSyXm7hH4MeJiEY=+A3FzViaozb+BA@mail.gmail.com>
Subject: Re: [PATCH v2 00/36] remove in-kernel syscall invocations (part 1)
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 9:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Mar 15, 2018 at 8:04 PM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
>> Here is a re-spin of the first set of patches which reduce the number of
>> syscall invocations from within the kernel; the RFC may be found at
>>
>> The rationale for this change is described in patch 1 as follows:
>>
>>         The syscall entry points to the kernel defined by SYSCALL_DEFINEx()
>>         and COMPAT_SYSCALL_DEFINEx() should only be called from userspace
>>         through kernel entry points, but not from the kernel itself. This
>>         will allow cleanups and optimizations to the entry paths *and* to
>>         the parts of the kernel code which currently need to pretend to be
>>         userspace in order to make use of syscalls.
>>
>> The whole series can be found at
>>
>>         https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git syscalls-next
>>
>> and will be submitted for merging for the v4.17-rc1 cycle, probably together
>> with another batch of related patches I hope to send out tomorrow as a RFC.
>
> Nice work!
>
> I've already commented on a few patches that now have a kernel-internal
> helper function that takes a __user pointer. I think those are all only used
> in the early boot code (initramfs etc) that runs before we set_fs() to the
> user address space, but it also causes warnings with sparse. If we
> can change all of them to take kernel pointers, that would let us avoid
> the sparse warnings and start running with a normal user address space
> view. Unfortunately, some of the syscall seem to be harder to change to
> that than others, so not sure if it's worth the effort.

It would be fantastic to get rid of set_fs() entirely and make it
impossible for get_user(), etc to ever access kernel memory.  And this
effort is necessary to ever achieve that.

I don't think this patch series should wait for any of these cleanups,
though.  We need these patches to change the x86_64 internal syscall
function signature, which we've been wanting to do for a little while.
