Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbeDDX7Y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 19:59:24 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35844 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeDDX7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 19:59:20 -0400
X-Google-Smtp-Source: AIpwx49vcMnT0Ys/dn4VrKpjILTjvTU0zeSZ+pbyJXHRQMDGbVLBI5CQ1GJVO/e3NVMM80++G95GvixV6RRn1k8RxWo=
MIME-Version: 1.0
In-Reply-To: <CAJWu+op5-sr=2xWDYcd7FDBeMtrM9Zm96BgGzb4Q31UGBiU3ew@mail.gmail.com>
References: <20180404115310.6c69e7b9@gandalf.local.home> <20180404120002.6561a5bc@gandalf.local.home>
 <CAJWu+orC-1JDYHDTQU+DFckGq5ZnXBCCq9wLG-gNK0Nc4-vo7w@mail.gmail.com>
 <20180404121326.6eca4fa3@gandalf.local.home> <CAJWu+op5-sr=2xWDYcd7FDBeMtrM9Zm96BgGzb4Q31UGBiU3ew@mail.gmail.com>
From: Joel Fernandes <joelaf@google.com>
Date: Wed, 4 Apr 2018 16:59:18 -0700
Message-ID: <CAJWu+opM6RjK-Z1dr35XvQ5cLKaV=cLG5uMu-rLkoO=X03c+FA@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Add set/clear_current_oom_origin() during allocations
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, Apr 4, 2018 at 9:18 AM, Joel Fernandes <joelaf@google.com> wrote:
> On Wed, Apr 4, 2018 at 9:13 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> [..]
>>>
>>> Also, I agree with the new patch and its nice idea to do that.
>>
>> Thanks, want to give it a test too?

With the latest tree and the below diff, I can still OOM-kill a victim
process doing a large buffer_size_kb write:

I pulled your ftrace/core and added this:
+       /*
        i = si_mem_available();
        if (i < nr_pages)
                return -ENOMEM;
+       */

Here's a run in Qemu with 4-cores 1GB total memory:

bash-4.3# ./m -m 1M &
[1] 1056
bash-4.3#
bash-4.3#
bash-4.3#
bash-4.3# echo 10000000 > /d/tracing/buffer_size_kb
[   33.213988] Out of memory: Kill process 1042 (bash) score
1712050900 or sacrifice child
[   33.215349] Killed process 1056 (m) total-vm:9220kB,
anon-rss:7564kB, file-rss:4kB, shmem-rss:640kB
bash: echo: write error: Cannot allocate memory
[1]+  Killed                  ./m -m 1M
bash-4.3#
--

As you can see, OOM killer triggers and kills "m" which is my busy
memory allocator (it allocates and frees lots of memory and does that
in a loop)

Here's the m program, sorry if it looks too ugly:
https://pastebin.com/raw/aG6Qw37Z

Happy to try anything else, BTW when the si_mem_available check
enabled, this doesn't happen and the buffer_size_kb write fails
normally without hurting anything else.

- Joel
