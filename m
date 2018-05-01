Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbeEAXDD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 19:03:03 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39415 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbeEAXC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 19:02:59 -0400
X-Google-Smtp-Source: AB8JxZqjQ36XNBA01JwBoyWD45GWpH/3+M2Zs8BXyKUclBrFB5gFVsTgAZ2LjshEsJza0t/1f2v1oqw34wW4yuP0lYk=
MIME-Version: 1.0
In-Reply-To: <CA+55aFwoOee_8H-1KRnY1G-Ud4Rez16s8xjVbG8YOPn1jqxxtg@mail.gmail.com>
References: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFwoOee_8H-1KRnY1G-Ud4Rez16s8xjVbG8YOPn1jqxxtg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 1 May 2018 16:02:58 -0700
Message-ID: <CAPcyv4jA98NVNqYFpj29OHE45HVp1DMH9oFO4-neWKA_4WKTwA@mail.gmail.com>
Subject: Re: [PATCH 0/6] use memcpy_mcsafe() for copy_to_iter()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 2:05 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, May 1, 2018 at 1:55 PM Dan Williams <dan.j.williams@intel.com>
> wrote:
>
>> The result of the bypass is that the kernel treats machine checks during
>> read as system fatal (reboot) when they could simply be flagged as an
>> I/O error, similar to performing reads through the pmem driver. Prevent
>> this fatal condition by deploying memcpy_mcsafe() in the fsdax read
>> path.
>
> How about just changing the rules, and go the old "Don't do that then" way?
>
> IOW, get rid of the whole idea that MCS errors should be fatal. It's wrong
> and pointless anyway.
>
> The while approach seems fundamentally buggered, if you ever want to mmap
> one of these things. And don't you want that?
>
> So why continue down a fundamentally broken path?

I'm confused. Are you talking about getting rid of the block-layer
bypass or changing how MCS errors are handled? If it's the former I've
gotten push back in the past trying to remove the bypass, but I feel
better about my chances to slay that beast wielding the +5 Hammer of
Linus. If it's the latter, MCS error handling, I don't see how get
around something like copy_to_iter_mcsafe().

You mention mmap. Yes, we want the predominant access model to be
dax-mmap for Persistent Memory, but there's still the question about
what to do with media errors. To date we are trying to mirror the
error handling model for System Memory, i.e. SIGBUS to the process
that consumed the error. Is that error handling model also problematic
in your view?
