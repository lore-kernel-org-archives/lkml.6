Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517F3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4A82086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbeLODqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 22:46:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbeLODqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 22:46:52 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 062662086D;
        Sat, 15 Dec 2018 03:46:50 +0000 (UTC)
Date:   Fri, 14 Dec 2018 22:46:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: Tracing to console
Message-ID: <20181214224649.04d53b9e@vmware.local.home>
In-Reply-To: <08fe327a686f590008de3d6f43c880c655c648c2.camel@wdc.com>
References: <08fe327a686f590008de3d6f43c880c655c648c2.camel@wdc.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018 21:01:53 +0000
Bart Van Assche <Bart.VanAssche@wdc.com> wrote:

> Hello Steven,

Sorry about the 6 month old reply. I just noticed this email buried in
my INBOX (I triage my INBOX to find emails like this that got missed).
And yes I missed your reply as well :-/


> 
> If I run the following commands as root:
> 
> cd /sys/kernel/debug/tracing
> grep pm_ available_events > set_event
> echo function >current_tracer
> grep scsi_ available_filter_functions | while read a b; do echo $a; done >set_ftrace_filter
> echo 1 >events/printk/enable
> echo 1 >tracing_on
> echo 1 >/proc/sys/kernel/tracepoint_printk

Just for some closure. The tracepoint_printk is a special command that
only gets enabled if you pass "tp_printk" on the kernel command line.

> echo - - - >/sys/class/scsi_host/host0/scan
> 
> then the following appears on the console:
> 
> console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: console: console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [ ... ]
> 
> I assume that the repeated "console: " prefix is a bug and also that the same
> line repeats over and over again is also a bug? I ran into this with commit
> 017b3f8a10ca ("scsi: snic: fix a couple of spelling mistakes: "COMPLETE"").
>

The above behavior is actually expected and not a bug. It's a "Doctor
it hurts me when I do this" issue. Don't do that ;-)

The tracepoint_printk is for cases where the system crashes before you
ever get to a command prompt, and you want to see trace events that you
can enable from the kernel command line. What you did above was like
running "ls -lR / > /dev/mem" in old kernels. It's doomed to fail.

You just told the kernel that you want all trace events to go over
printk, and you also told the kernel, you want all printk to become a
trace event. Thus you created a recursive loop. You're lucky it didn't
crash.

I hope this explains things for you.

Again, sorry that it took 6 months to reply. I believe June was a busy
time for me (vacation and work travel).

-- Steve
