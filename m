Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A70C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B19A206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfBWSQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 13:16:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60389 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfBWSQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 13:16:35 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gxbqT-0003bZ-Nb; Sat, 23 Feb 2019 19:16:17 +0100
Date:   Sat, 23 Feb 2019 19:16:17 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Aubrey Li <aubrey.li@linux.intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 3/3] Documentation/filesystems/proc.txt: add
 AVX512_elapsed_ms
In-Reply-To: <20190221011741.97070-3-aubrey.li@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1902231849400.1666@nanos.tec.linutronix.de>
References: <20190221011741.97070-1-aubrey.li@linux.intel.com> <20190221011741.97070-3-aubrey.li@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019, Aubrey Li wrote:
> @@ -45,6 +45,7 @@ Table of Contents
>    3.9   /proc/<pid>/map_files - Information about memory mapped files
>    3.10  /proc/<pid>/timerslack_ns - Task timerslack value
>    3.11	/proc/<pid>/patch_state - Livepatch patch operation state
> +  3.12	/proc/<pid>/AVX512_elapsed_ms - time elapsed since last AVX512 use

So is this a separate file now?
  
> +3.12	/proc/<pid>/AVX512_elapsed_ms - time elapsed since last AVX512 use
> +--------------------------------------------------------------------------
> +If AVX512 is supported on the machine, this file displays time elapsed since

This is not a file and this documentation wants to be where the status file
is described.

> +last AVX512 usage of the task in millisecond.

Since last usage is misleading. What you want to say is:

  The entry shows the milliseconds elapsed since the last time AVX512 usage
  was recorded.

> +The per-task AVX512 usage tracking mechanism is added during context switch.
> +When the task is scheduled out, the AVX512 timestamp of the task is tagged
> +by jiffies if AVX512 usage is detected.
> +
> +When this interface is queried, AVX512_elapsed_ms is calculated as follows:
> +
> +	delta = (long)(jiffies_now - AVX512_timestamp);
> +	AVX512_elpased_ms = jiffies_to_msecs(delta);

This information is not really helpful for someone who wants to use that
field.

> +
> +Because this tracking mechanism depends on context switch, the number of
> +AVX512_elapsed_ms could be inaccurate if the AVX512 using task runs alone on
> +a CPU and not scheduled out for a long time. An extreme experiment shows a
> +task is spinning on the AVX512 ops on an isolated CPU, but the longest elapsed
> +time is close to 4 seconds(HZ = 250).
> +
> +So 5s or even longer is an appropriate threshold for the job scheduler to poll
> +and decide if the task should be classifed as an AVX512 task and migrated
> +away from the core on which a Non-AVX512 task is running.

5 seconds or long is appropriate? No. It really depends on the workload and
the scheduling scenarios. What the documentation has to provide is the
information that this value is a crystal ball estimate and what the reasons
are why its inaccurate.

Something like this instead of this conglomorate of useful, irrelevant and
misleading information:

  The AVX512_elapsed_ms entry shows the milliseconds elapsed since the last
  time AVX512 usage was recorded. The recording happens on a best effort
  basis when a task is scheduled out. This means that the value depends on
  two factors:

    1) The time which the task spent on the CPU without being scheduled
       out. With CPU isolation and a single runnable task this can take
       several seconds.

    2) The time since the task was scheduled out last. Depending on the
       reason for being scheduled out (time slice exhausted, syscall ...)
       this can be arbitrary long time.

  As a consequence the value cannot be considered precise and authoritive
  information. The application which uses this information has to be aware
  of the overall scenario on the system in order to determine whether a
  task is a real AVX512 user or not.

See? No jiffies, no code snippets, no absolute numbers and no magic
recommendation which might be correct for your test scenario, but
completely bogus for some other scenario.

Instead it contains the things which a application programmer who wants to
use that value needs to know. He then has to map it to his scenario and
build the crystal ball logic which makes it perhaps useful.

Thanks,

	tglx


