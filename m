Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A552ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E56420C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E56420C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeIRQ1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:27:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbeIRQ1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:27:38 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9F2D308AA15;
        Tue, 18 Sep 2018 10:55:35 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B197F86BBA;
        Tue, 18 Sep 2018 10:55:35 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w8IAtZKb030098;
        Tue, 18 Sep 2018 06:55:35 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w8IAtYpW030094;
        Tue, 18 Sep 2018 06:55:34 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 18 Sep 2018 06:55:34 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Sasha Levin <Alexander.Levin@microsoft.com>
cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH AUTOSEL 4.18 032/136] arm64: fix infinite stacktrace
In-Reply-To: <20180917030006.245495-32-alexander.levin@microsoft.com>
Message-ID: <alpine.LRH.2.02.1809180654220.17180@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com> <20180917030006.245495-32-alexander.levin@microsoft.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 18 Sep 2018 10:55:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is not correct, because the stacktrace is supposed to work 
around discontiguous interrupt stacks.

You should replace 'frame->fp <= fp' with 'frame->fp == fp'.

Mikulas



On Mon, 17 Sep 2018, Sasha Levin wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> [ Upstream commit 7e7df71fd57ff2894d96abb0080922bf39460a79 ]
> 
> I've got this infinite stacktrace when debugging another problem:
> [  908.795225] INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  908.796176]  1-...!: (1 GPs behind) idle=952/1/4611686018427387904 softirq=1462/1462 fqs=355
> [  908.797692]  2-...!: (1 GPs behind) idle=f42/1/4611686018427387904 softirq=1550/1551 fqs=355
> [  908.799189]  (detected by 0, t=2109 jiffies, g=130, c=129, q=235)
> [  908.800284] Task dump for CPU 1:
> [  908.800871] kworker/1:1     R  running task        0    32      2 0x00000022
> [  908.802127] Workqueue: writecache-writeabck writecache_writeback [dm_writecache]
> [  908.820285] Call trace:
> [  908.824785]  __switch_to+0x68/0x90
> [  908.837661]  0xfffffe00603afd90
> [  908.844119]  0xfffffe00603afd90
> [  908.850091]  0xfffffe00603afd90
> [  908.854285]  0xfffffe00603afd90
> [  908.863538]  0xfffffe00603afd90
> [  908.865523]  0xfffffe00603afd90
> 
> The machine just locked up and kept on printing the same line over and
> over again. This patch fixes it.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  arch/arm64/kernel/stacktrace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index d5718a060672..e160ca123da3 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -56,6 +56,9 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>  	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
>  	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
>  
> +	if (frame->fp <= fp)
> +		return -EINVAL;
> +
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	if (tsk->ret_stack &&
>  			(frame->pc == (unsigned long)return_to_handler)) {
> -- 
> 2.17.1
> 
