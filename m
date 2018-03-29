Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeC2O0q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbeC2O0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:26:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9807121777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 29 Mar 2018 10:26:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wang Yu <yuwang@linux.alibaba.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: fix task's invalid comm of <...> when big pid
Message-ID: <20180329102642.23fa246a@gandalf.local.home>
In-Reply-To: <5ABC4C76.3090202@linux.alibaba.com>
References: <1522240347-24465-1-git-send-email-yuwang@linux.alibaba.com>
        <20180328113522.21b4298b@gandalf.local.home>
        <20180328114434.3a05d3bc@gandalf.local.home>
        <5ABC4C76.3090202@linux.alibaba.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018 10:16:22 +0800
Wang Yu <yuwang@linux.alibaba.com> wrote:

> > What you can do is make that map_pid_to_cmdline array bigger.
> >
> > -- Steve  
> 
> I am sorry about it, and as the number of cpu cores increases, the current
> 
> PID_MAX_DEFAULT is too small, our online machines set the pid_max 65536 as default, so the task
> pid number bigger than PID_MAX_DEFAULT can't show the real comm (only <...>), so i want to
> ajust the PID_MAX_DEFAULT upto 4x, and what do you think?
> 
>    * This controls the default maximum pid allocated to a process
>    */
> -#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
> +#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x20000)

What I was thinking is to make the map_pid_to_cmdline array dynamic
(not static), and be set to pid_max (after pid_max is determined).

Now, pid_max can be changed at run time. Thus, the tracing code will
need to keep a separate variable for that array to store the length. It
can not rely on pid_max. But if a pid that is greater than pid_max is
found, we could kick off a work thread to increase the array.

-- Steve
