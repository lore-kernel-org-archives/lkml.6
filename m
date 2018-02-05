Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeBEPhu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:37:50 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:43653 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeBEPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:37:42 -0500
X-Google-Smtp-Source: AH8x227a9VY7PPkR0UW4+9Anrdg1mpAKWB7fI1QCJXwStuUR0fz8kvn9nlRQhflQ/jaL6otzc6Zu8g==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/3] x86/entry: Clear extra registers beyond syscall arguments for 64bit kernels
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15C202)
In-Reply-To: <20180205114250.zd3nbe5yl2mnd54m@gmail.com>
Date: Mon, 5 Feb 2018 07:37:40 -0800
Cc: Dan Williams <dan.j.williams@intel.com>, tglx@linutronix.de,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        torvalds@linux-foundation.org
Message-Id: <6CCF65EF-325A-4207-9C5E-2CD2D8E2A7E4@amacapital.net>
References: <151776623555.23236.14152911329227555005.stgit@dwillia2-desk3.amr.corp.intel.com> <151776624080.23236.1865339140666550495.stgit@dwillia2-desk3.amr.corp.intel.com> <20180205114250.zd3nbe5yl2mnd54m@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w15Fc1GC023361



> On Feb 5, 2018, at 3:42 AM, Ingo Molnar <mingo@kernel.org> wrote:
> 
> 
> * Dan Williams <dan.j.williams@intel.com> wrote:
> 
>> +    /*
>> +     * Sanitize extra registers of values that a speculation attack
>> +     * might want to exploit. In the CONFIG_FRAME_POINTER=y case,
>> +     * the expectation is that %ebp will be clobbered before it
>> +     * could be used.
>> +     */
>> +    .macro CLEAR_EXTRA_REGS_NOSPEC
>> +    xorq %r15, %r15
>> +    xorq %r14, %r14
>> +    xorq %r13, %r13
>> +    xorq %r12, %r12
>> +    xorl %ebx, %ebx
>> +#ifndef CONFIG_FRAME_POINTER
>> +    xorl %ebp, %ebp
>> +#endif
>> +    .endm
> 
> Yeah, so this series look pretty good to me, but there's one small detail: I think 
> RBP should be cleared unconditionally here, even in the CONFIG_FRAME_POINTERS=y 
> case, because:

ENCODE_FRAME_POINTER should take care of rbp, though.
