Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeDLHwZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:52:25 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:37360 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeDLHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:52:24 -0400
X-Google-Smtp-Source: AIpwx4+NAJxE4i1+MatIWO9HJkRKXOX1wldMAvwGnBsLoSYehaJsgagfjaqhx7lGZkSMZSZ3SShgAQ==
Date: Thu, 12 Apr 2018 09:52:20 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Song Liu <songliubraving@fb.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf: fuzzer leads to trace_kprobe: Could not insert message
 flood
Message-ID: <20180412075220.l7lqhk3qn4sobfz7@gmail.com>
References: <alpine.DEB.2.21.1804101043490.6068@macbook-air>
 <A3B3905F-3364-462A-BE02-B01D52482791@fb.com>
 <20180411120447.2gzrwijrtayjv3eg@gmail.com>
 <C0B2EFB5-C403-4BDB-9046-C14B3EE66999@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C0B2EFB5-C403-4BDB-9046-C14B3EE66999@fb.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Song Liu <songliubraving@fb.com> wrote:

> > spamming the kernel log ...
> 
> Yeah, the new API allows non-root user to trigger this message. We should only 
> allow root to create kprobe with perf_event_open(). 
> 
> On the other hand, do we need to fix this for root? In fact, a simple bash loop 
> can create something similar through the text interface (with root):
> 
> root@virt-test:~# for x in {0..5} ; do echo p:xx xx+$x >> /sys/kernel/debug/tracing/kprobe_events ; done
> -bash: echo: write error: No such file or directory
> -bash: echo: write error: No such file or directory
> -bash: echo: write error: No such file or directory
> -bash: echo: write error: No such file or directory
> -bash: echo: write error: No such file or directory
> -bash: echo: write error: No such file or directory
> root@virt-test:~# dmesg | tail -n 5
> [  664.208374] trace_kprobe: Could not insert probe at xx+1: -2
> [  664.237882] trace_kprobe: Could not insert probe at xx+2: -2
> [  664.268067] trace_kprobe: Could not insert probe at xx+3: -2
> [  664.297395] trace_kprobe: Could not insert probe at xx+4: -2
> [  664.327614] trace_kprobe: Could not insert probe at xx+5: -2
> 
> This happens before the new API is introduced. 
> 
> The following patch does capable(CAP_SYS_ADMIN) for perf_kprobe and 
> perf_uprobe at an earlier stage, so non-root user cannot trigger 
> this error message. Please let me know whether we need to fix this 
> for root. 

That's two bugs then, and yes, I think we should fix the log spamming: what's the 
point? We already get an error code from the write.

I'll apply your CAP_SYS_ADMIN fix.

Thanks,

	Ingo
