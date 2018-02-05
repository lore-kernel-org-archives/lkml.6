Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeBEVso (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:48:44 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37373 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeBEVsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:48:37 -0500
X-Google-Smtp-Source: AH8x2269Ye5zbTbnoggQEGz0FMFSZDGBFcWB5bu9s/ZpLVZtkCSrN83YfFas7PqGMspICDQbJktO643SYnmWf96fyKI=
MIME-Version: 1.0
In-Reply-To: <20180205213911.2auyud6a3k2ng7jx@treble>
References: <20180202145634.200291-1-arnd@arndb.de> <tip-ebfc15019cfa72496c674ffcb0b8ef10790dcddc@git.kernel.org>
 <CAK8P3a3MMwRQ00YxuPhEmNzqiMn4+VX48b82831i+kCqruCMfQ@mail.gmail.com> <20180205213911.2auyud6a3k2ng7jx@treble>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 5 Feb 2018 22:48:36 +0100
X-Google-Sender-Auth: qRPcNHlVDprwvvR8qovfqsSDNw4
Message-ID: <CAK8P3a3ZeU9Qs34yZ6keoZTO+p4rRq2F25fmJW33VL5n895v_A@mail.gmail.com>
Subject: Re: [tip:x86/urgent] x86/dumpstack: Avoid uninitlized variable
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Nicolas Pitre <nico@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        bpetkov@suse.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 10:39 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Mon, Feb 05, 2018 at 10:21:06PM +0100, Arnd Bergmann wrote:
>> On Fri, Feb 2, 2018 at 11:36 PM, tip-bot for Arnd Bergmann
>> <tipbot@zytor.com> wrote:
>> > Commit-ID:  ebfc15019cfa72496c674ffcb0b8ef10790dcddc
>> > Gitweb:     https://git.kernel.org/tip/ebfc15019cfa72496c674ffcb0b8ef10790dcddc
>> > Author:     Arnd Bergmann <arnd@arndb.de>
>> > AuthorDate: Fri, 2 Feb 2018 15:56:17 +0100
>> > Committer:  Thomas Gleixner <tglx@linutronix.de>
>> > CommitDate: Fri, 2 Feb 2018 23:33:50 +0100
>> >
>> > x86/dumpstack: Avoid uninitlized variable
>> >
>> > In some configurations, 'partial' does not get initialized, as shown by
>> > this gcc-8 warning:
>> >
>> > arch/x86/kernel/dumpstack.c: In function 'show_trace_log_lvl':
>> > arch/x86/kernel/dumpstack.c:156:4: error: 'partial' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>> >     show_regs_if_on_stack(&stack_info, regs, partial);
>> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >
>> > This initializes it to false, to get the previous behavior in this case.
>> >
>> > Fixes: a9cdbe72c4e8 ("x86/dumpstack: Fix partial register dumps")
>>
>>
>> I just noticed my annotation got lost when I sent the patch. I originally
>> meant to ask Josh to double-check whether it should be 'false' or 'true'
>> here, or if we maybe need a larger change.
>>
>> Josh, could you take a look? Unfortunately I did not really understand
>> your original commit, so I don't know what the safe choice is here
>> in those cases in which 'partial' is uninitialized.
>
> I think it doesn't matter, it seems to be a false positive warning.
>
> The 'partial' variable is only used when 'regs' is non-NULL, and 'regs'
> is only set in unwind_get_entry_regs() after 'partial' gets initialized.

Right, got it now. So my patch is correct either way, just the description
could have been better.

       Arnd
