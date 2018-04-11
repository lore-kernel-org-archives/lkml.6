Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeDKOJR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:09:17 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39296 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbeDKOJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:09:16 -0400
X-Google-Smtp-Source: AIpwx48NSwx8MStMAHlSzLBKFFAoH3PoJ1j585bKC5MA1xcIZEDXjv82/Sp6kKcpXIcpj3vGqXmaQw==
Date: Wed, 11 Apr 2018 07:09:13 -0700
From: Tejun Heo <htejun@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        "Steven J . Hill" <steven.hill@cavium.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] Revert mm/vmstat.c: fix vmstat_update() preemption BUG
Message-ID: <20180411140913.GE793541@devbig577.frc2.facebook.com>
References: <20180411095757.28585-1-bigeasy@linutronix.de>
 <ef663b6d-9e9f-65c6-25ec-ffa88347c58d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef663b6d-9e9f-65c6-25ec-ffa88347c58d@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 11, 2018 at 03:56:43PM +0200, Vlastimil Babka wrote:
> > vmstat_update() is invoked by a kworker on a specific CPU. This worker
> > it bound to this CPU. The name of the worker was "kworker/1:1" so it
> > should have been a worker which was bound to CPU1. A worker which can
> > run on any CPU would have a `u' before the first digit.
> 
> Oh my, and I have just been assured by Tejun that his cannot happen :)
> And yet, in the original report [1] I see:
> 
> CPU: 0 PID: 269 Comm: kworker/1:1 Not tainted
> 
> So is this perhaps related to the cpu hotplug that [1] mentions? e.g. is
> the cpu being hotplugged cpu 1, the worker started too early before
> stuff can be scheduled on the CPU, so it has to run on different than
> designated CPU?
> 
> [1] https://marc.info/?l=linux-mm&m=152088260625433&w=2

The report says that it happens when hotplug is attempted.  Per-cpu
doesn't pin the cpu alive, so if the cpu goes down while a work item
is in flight or a work item is queued while a cpu is offline it'll end
up executing on some other cpu.  So, if a piece of code doesn't want
that happening, it gotta interlock itself - ie. start queueing when
the cpu comes online and flush and prevent further queueing when its
cpu goes down.

Thanks.

-- 
tejun
