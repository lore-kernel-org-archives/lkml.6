Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeECO5c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbeECO52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:57:28 -0400
Date: Thu, 3 May 2018 23:57:21 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: oleg@redhat.com, peterz@infradead.org, srikar@linux.vnet.ibm.com,
        rostedt@goodmis.org, acme@kernel.org, ananth@linux.vnet.ibm.com,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        alexis.berlemont@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
        jolsa@redhat.com, kan.liang@intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, fengguang.wu@intel.com, jglisse@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v3 8/9] trace_uprobe/sdt: Document about reference
 counter
Message-Id: <20180503235721.d1dbc6f5bfdfc97e6200b7de@kernel.org>
In-Reply-To: <20180417043244.7501-9-ravi.bangoria@linux.vnet.ibm.com>
References: <20180417043244.7501-1-ravi.bangoria@linux.vnet.ibm.com>
        <20180417043244.7501-9-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 10:02:43 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> Reference counter gate the invocation of probe. If present,
> by default reference count is 0. Kernel needs to increment
> it before tracing the probe and decrement it when done. This
> is identical to semaphore in Userspace Statically Defined
> Tracepoints (USDT).
> 
> Document usage of reference counter.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> ---
>  Documentation/trace/uprobetracer.txt | 16 +++++++++++++---
>  kernel/trace/trace.c                 |  2 +-
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/trace/uprobetracer.txt b/Documentation/trace/uprobetracer.txt
> index bf526a7c..cb6751d 100644
> --- a/Documentation/trace/uprobetracer.txt
> +++ b/Documentation/trace/uprobetracer.txt
> @@ -19,15 +19,25 @@ user to calculate the offset of the probepoint in the object.
>  
>  Synopsis of uprobe_tracer
>  -------------------------
> -  p[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a uprobe
> -  r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a return uprobe (uretprobe)
> -  -:[GRP/]EVENT                           : Clear uprobe or uretprobe event
> +  p[:[GRP/]EVENT] PATH:OFFSET[(REF_CTR_OFFSET)] [FETCHARGS]
> +  r[:[GRP/]EVENT] PATH:OFFSET[(REF_CTR_OFFSET)] [FETCHARGS]
> +  -:[GRP/]EVENT
> +
> +  p : Set a uprobe
> +  r : Set a return uprobe (uretprobe)
> +  - : Clear uprobe or uretprobe event
>  
>    GRP           : Group name. If omitted, "uprobes" is the default value.
>    EVENT         : Event name. If omitted, the event name is generated based
>                    on PATH+OFFSET.
>    PATH          : Path to an executable or a library.
>    OFFSET        : Offset where the probe is inserted.
> +  REF_CTR_OFFSET: Reference counter offset. Optional field. Reference count
> +		  gate the invocation of probe. If present, by default
> +		  reference count is 0. Kernel needs to increment it before
> +		  tracing the probe and decrement it when done. This is
> +		  identical to semaphore in Userspace Statically Defined
> +		  Tracepoints (USDT).
>  
>    FETCHARGS     : Arguments. Each probe can have up to 128 args.
>     %REG         : Fetch register REG
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 300f4ea..d211937 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4604,7 +4604,7 @@ static int tracing_trace_options_open(struct inode *inode, struct file *file)
>    "place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>\n"
>  #endif
>  #ifdef CONFIG_UPROBE_EVENTS
> -	"\t    place: <path>:<offset>\n"
> +  "   place (uprobe): <path>:<offset>[(ref_ctr_offset)]\n"
>  #endif
>  	"\t     args: <name>=fetcharg[:type]\n"
>  	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
> -- 
> 1.8.3.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
