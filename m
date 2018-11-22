Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8054EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4346B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DW9xtphq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4346B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393495AbeKVULR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:11:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37090 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387669AbeKVULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Uroc4STou8Rt8PF72AReZCmVPgM2zJxM5RyxZsLix1I=; b=DW9xtphq0zZPwWwIYgpWFPG9Z
        HODM3TFnANT7jZHZR9487YM73Cd/e5W58xuLp1IO3gHUzZxPT8Xdzcub/drERJZWlcfiV4Biq7uFj
        rFgqf6aJ/rDvggm4rCGGnSfVO85Q8ZkzOsWFqH20uKuYUAgBzApf1BVBVLYGvaFSbqGxCpWuNC/96
        SKAvF80YWD9JzwNcjPhaPBvxV0TxZKuV6sHZmylda6Mt8yHWzrKP5F1xiZ6VT6/k3G8TFNi00btaB
        JU0Dq8W3FGvJ80myViZEW+GqX8t3BP6T/B5jdGt4n1tY/F5SR2Qz2l7JcGMk3qzzp+x8m8VDLFdye
        J8wvX2T1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPlLb-0008Mc-0m; Thu, 22 Nov 2018 09:32:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B81832029FD58; Thu, 22 Nov 2018 10:32:19 +0100 (CET)
Date:   Thu, 22 Nov 2018 10:32:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, acme@kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH perf,bpf 0/5] reveal invisible bpf programs
Message-ID: <20181122093219.GK2131@hirez.programming.kicks-ass.net>
References: <20181121195502.3259930-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121195502.3259930-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:54:57AM -0800, Song Liu wrote:
> Changes RFC -> PATCH v1:
> 
> 1. In perf-record, poll vip events in a separate thread;
> 2. Add tag to bpf prog name;
> 3. Small refactorings.
> 
> Original cover letter (with minor revisions):
> 
> This is to follow up Alexei's early effort to show bpf programs
> 
>    https://www.spinics.net/lists/netdev/msg524232.html
> 
> In this version, PERF_RECORD_BPF_EVENT is introduced to send real time BPF
> load/unload events to user space. In user space, perf-record is modified
> to listen to these events (through a dedicated ring buffer) and generate
> detailed information about the program (struct bpf_prog_info_event). Then,
> perf-report translates these events into proper symbols.
> 
> With this set, perf-report will show bpf program as:
> 
>    18.49%     0.16%  test  [kernel.vmlinux]    [k] ksys_write
>    18.01%     0.47%  test  [kernel.vmlinux]    [k] vfs_write
>    17.02%     0.40%  test  bpf_prog            [k] bpf_prog_07367f7ba80df72b_
>    16.97%     0.10%  test  [kernel.vmlinux]    [k] __vfs_write
>    16.86%     0.12%  test  [kernel.vmlinux]    [k] comm_write
>    16.67%     0.39%  test  [kernel.vmlinux]    [k] bpf_probe_read
> 
> Note that, the program name is still work in progress, it will be cleaner
> with function types in BTF.
> 
> Please share your comments on this.

So I see:

  kernel/bpf/core.c:void bpf_prog_kallsyms_add(struct bpf_prog *fp)

which should already provide basic symbol information for extant eBPF
programs, right?

And (AFAIK) perf uses /proc/kcore for annotate on the current running
kernel (if not, it really should, given alternatives, jump_labels and
all other other self-modifying code).

So this fancy new stuff is only for the case where your profile spans
eBPF load/unload events (which should be relatively rare in the normal
case, right), or when you want source annotated asm output (I normally
don't bother with that).

That is; I would really like this fancy stuff to be an optional extra
that is typically not needed.

Does that make sense?

