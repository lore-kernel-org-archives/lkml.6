Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB27ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E513220C07
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNR1RtPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E513220C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeGPQji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbeGPQji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:39:38 -0400
Received: from localhost (LFbn-NCY-1-193-82.w83-194.abo.wanadoo.fr [83.194.41.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF2220BED;
        Mon, 16 Jul 2018 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531757492;
        bh=3N3+SkOOc+ri+94ElzY6wVP/Zt4vbW3G/ZQdXabVu8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pNR1RtPlVkPc8GYvNQ5VfAjBBxX08X2Vxv/g8Hvvab1CoDDdQygNm4RKHT9MTtHqJ
         4JmlsUoWcSmtQz6wMq3IryFeTeudrZmPx4EyXDteafTqSNxcV/R1F8uaQiFDLyytpO
         fjHwqXioTSqwcy4NIpgyczJy5hQgk5qHqNjoyBdw=
Date:   Mon, 16 Jul 2018 18:11:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     xlpang@linux.alibaba.com, tglx@linutronix.de,
        lcapitulino@redhat.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tj@kernel.org,
        mingo@kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/cputime: Ensure accurate utime and stime
 ratio in cputime_adjust()
Message-ID: <20180716161127.GB29270@lerouge>
References: <20180709145843.126583-1-xlpang@linux.alibaba.com>
 <tip-8d4c00dc38a8aa30dae8402955e55e7b34e74bc8@git.kernel.org>
 <20180716133751.GC2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716133751.GC2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 03:37:51PM +0200, Peter Zijlstra wrote:
> On Sun, Jul 15, 2018 at 04:36:17PM -0700, tip-bot for Xunlei Pang wrote:
> > Commit-ID:  8d4c00dc38a8aa30dae8402955e55e7b34e74bc8
> > Gitweb:     https://git.kernel.org/tip/8d4c00dc38a8aa30dae8402955e55e7b34e74bc8
> > Author:     Xunlei Pang <xlpang@linux.alibaba.com>
> > AuthorDate: Mon, 9 Jul 2018 22:58:43 +0800
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Mon, 16 Jul 2018 00:28:31 +0200
> > 
> > sched/cputime: Ensure accurate utime and stime ratio in cputime_adjust()
> > 
> > If users access "/proc/pid/stat", the utime and stime ratio in the
> > current SAMPLE period are excepted, but currently cputime_adjust()
> > always calculates with the ratio of the WHOLE lifetime of the process.
> > 
> > This results in inaccurate utime and stime in "/proc/pid/stat". For
> > example,  a process runs for a while with "50% usr, 0% sys", then
> > followed by "100% sys". For later while, the following is excepted:
> > 
> >   0.0 usr,  100.0 sys
> > 
> > but we get:
> > 
> >   10.0 usr,  90.0 sys
> > 
> > This patch uses the accurate ratio in cputime_adjust() to address the
> > issue. A new 'task_cputime' type field is added in prev_cputime to record
> > previous 'task_cputime' so that we can get the elapsed times as the accurate
> > ratio.
> 
> Ingo, please make this one go away. I still have no idae what the
> problem is and I've not had time to reverse engineer the patch.
> 
> The previous (v1) Changelog was a pile of incoherent rambling and the
> above doesn't explain anything much.
> 
> I want a clear description of the problem and a coherent explanation of
> the proposed solution without having to reverse engineer the actual
> patch.

I must confess I'm having trouble to understand what the real problem is.
