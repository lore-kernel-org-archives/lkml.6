Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88CCC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8282F208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8282F208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeJBCCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeJBCCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:02:44 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C672084C;
        Mon,  1 Oct 2018 19:23:25 +0000 (UTC)
Date:   Mon, 1 Oct 2018 15:23:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Wang <wonderfly@google.com>
Cc:     stable@vger.kernel.org, pmladek@suse.com,
        Alexander.Levin@microsoft.com, akpm@linux-foundation.org,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mathieu.desnoyers@efficios.com, mgorman@suse.de, mhocko@kernel.org,
        pavel@ucw.cz, penguin-kernel@I-love.SAKURA.ne.jp,
        peterz@infradead.org, tj@kernel.org, torvalds@linux-foundation.org,
        vbabka@suse.cz, xiyou.wangcong@gmail.com, pfeiner@google.com
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181001152324.72a20bea@gandalf.local.home>
In-Reply-To: <20180927194601.207765-1-wonderfly@google.com>
References: <20180927194601.207765-1-wonderfly@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 12:46:01 -0700
Daniel Wang <wonderfly@google.com> wrote:

> Prior to this change, the combination of `softlockup_panic=1` and
> `softlockup_all_cpu_stacktrace=1` may result in a deadlock when the reboot path
> is trying to grab the console lock that is held by the stack trace printing
> path. What seems to be happening is that while there are multiple CPUs, only one
> of them is tasked to print the back trace of all CPUs. On a machine with many
> CPUs and a slow serial console (on Google Compute Engine for example), the stack
> trace printing routine hits a timeout and the reboot path kicks in. The latter
> then tries to print something else, but can't get the lock because it's still
> held by earlier printing path. This is easily reproducible on a VM with 16+
> vCPUs on Google Compute Engine - which is a very common scenario.
> 
> A quick repro is available at
> https://github.com/wonderfly/printk-deadlock-repro. The system hangs 3 seconds
> into executing repro.sh. Both deadlock analysis and repro are credits to Peter
> Feiner.
> 
> Note that I have read previous discussions on backporting this to stable [1].
> The argument for objecting the backport was that this is a non-trivial fix and
> is supported to prevent hypothetical soft lockups. What we are hitting is a real
> deadlock, in production, however. Hence this request.
> 
> [1] https://lore.kernel.org/lkml/20180409081535.dq7p5bfnpvd3xk3t@pathway.suse.cz/T/#u
> 
> Serial console logs leading up to the deadlock. As can be seen the stack trace
> was incomplete because the printing path hit a timeout.

I'm fine with having this backported.

-- Steve
