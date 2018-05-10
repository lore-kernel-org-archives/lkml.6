Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966781AbeEJR6W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:58:22 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46291 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEJR6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:58:20 -0400
X-Google-Smtp-Source: AB8JxZr67yodgA0+ypkF7+AG2bvpZzdWq+F6dLIQuioDH/vRwnXUy2lOSYwGwHVfaP3A1dkx8/61ccaY+e7QvfbvB5Y=
MIME-Version: 1.0
References: <20180504033119.2130788-1-yhs@fb.com> <20180510100634.GZ12217@hirez.programming.kicks-ass.net>
 <20180510155240.5s2fpgm2fwal3jlj@ast-mbp.dhcp.thefacebook.com> <20180510162028.GB16130@pd.tnic>
In-Reply-To: <20180510162028.GB16130@pd.tnic>
From: Gianluca Borello <g.borello@gmail.com>
Date: Thu, 10 May 2018 17:57:43 +0000
Message-ID: <CAJWsiu=6gNzepWSvySZvmLsRckLE0kpYEFAave0HUJdDSjf9FQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3] x86/cpufeature: bpf hack for clang not supporting
 asm goto
To: bp@alien8.de
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        peterz@infradead.org, Yonghong Song <yhs@fb.com>, mingo@kernel.org,
        torvalds@linux-foundation.org, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org,
        x86@kernel.org,
        Linux Networking Development Mailing List
        <netdev@vger.kernel.org>,
        kernel-team@fb.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 9:28 AM Borislav Petkov <bp@alien8.de> wrote:

> As someone already pointed out on IRC, arch/x86/include/asm/cpufeature.h
> is solely a kernel header so nothing but kernel should include it. So
> forget the userspace breakage "argument".


For what is worth, I have the same exact problem in a relatively popular
open source system call tracer, and my attempt to fix the issue from user
space has been:
https://github.com/draios/sysdig/commit/2958eb1d52e047f4b93d1238be803e7c405bdec2

While I can definitely live with that (and I'd be happy to submit a patch
to samples/ following the same approach) and absolutely respect the
technical authority of the reviewers here, it would be nice to recognize
that these changes actually affect users to a certain degree, even if from
a technical point of view they don't break userspace.

 From a practical point of view, BPF is widely used from userspace programs
to access some kernel data structures to gather visibility information, and
even the simplest use case, such as including linux/sched.h to access some
task_struct members, ends up pulling in arch/x86/include/asm/cpufeature.h,
thus (ab)using that file. Adding these quirks definitely increases the
complexity a developer needs to keep in mind in order to take advantage of
a BPF based instrumentation.

Thanks
