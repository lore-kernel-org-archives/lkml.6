Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC23ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC9C208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rcdgBy7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC9C208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbeGPOF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:05:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeGPOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a/LkpbTSvRl0CKVLCHZG/tv5yJb6S8MQs6B24MnniV4=; b=rcdgBy7D5Vuua5D26SytolwOf
        beOJwD602VhkzuOxY33zXi51vhxwPtjWHAHRoet5hM4hjtowPY9JZDr2kUBsSJmCOGgfPGv9W5Kg8
        gdUCbySDQpzdNzwwUqhENXvL+WCy8iEpAo0OqTQhuq2Y2zl4OMiGhCzUsxxca4TntbS2tx4yAb1MG
        HTmEt1PSlhQ7NsyCsus7E5MdB4M2u8P8sApWHgo9zRHmgDy7QeaZQJKeOZ5BkIAAinIKSJ0omyAF/
        ItnOv+H7AEr9GSEO2W79SQjk/+tQZSfgchNBcQNLa7Rm/+Pc1E5U/D6Z4Lr6LGIi0/6AH7QISa6vz
        mBq/gdYsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ff3hJ-0008DH-RI; Mon, 16 Jul 2018 13:37:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC9F220289332; Mon, 16 Jul 2018 15:37:51 +0200 (CEST)
Date:   Mon, 16 Jul 2018 15:37:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     xlpang@linux.alibaba.com, tglx@linutronix.de, frederic@kernel.org,
        lcapitulino@redhat.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tj@kernel.org,
        mingo@kernel.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/cputime: Ensure accurate utime and stime
 ratio in cputime_adjust()
Message-ID: <20180716133751.GC2494@hirez.programming.kicks-ass.net>
References: <20180709145843.126583-1-xlpang@linux.alibaba.com>
 <tip-8d4c00dc38a8aa30dae8402955e55e7b34e74bc8@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-8d4c00dc38a8aa30dae8402955e55e7b34e74bc8@git.kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 04:36:17PM -0700, tip-bot for Xunlei Pang wrote:
> Commit-ID:  8d4c00dc38a8aa30dae8402955e55e7b34e74bc8
> Gitweb:     https://git.kernel.org/tip/8d4c00dc38a8aa30dae8402955e55e7b34e74bc8
> Author:     Xunlei Pang <xlpang@linux.alibaba.com>
> AuthorDate: Mon, 9 Jul 2018 22:58:43 +0800
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Mon, 16 Jul 2018 00:28:31 +0200
> 
> sched/cputime: Ensure accurate utime and stime ratio in cputime_adjust()
> 
> If users access "/proc/pid/stat", the utime and stime ratio in the
> current SAMPLE period are excepted, but currently cputime_adjust()
> always calculates with the ratio of the WHOLE lifetime of the process.
> 
> This results in inaccurate utime and stime in "/proc/pid/stat". For
> example,  a process runs for a while with "50% usr, 0% sys", then
> followed by "100% sys". For later while, the following is excepted:
> 
>   0.0 usr,  100.0 sys
> 
> but we get:
> 
>   10.0 usr,  90.0 sys
> 
> This patch uses the accurate ratio in cputime_adjust() to address the
> issue. A new 'task_cputime' type field is added in prev_cputime to record
> previous 'task_cputime' so that we can get the elapsed times as the accurate
> ratio.

Ingo, please make this one go away. I still have no idae what the
problem is and I've not had time to reverse engineer the patch.

The previous (v1) Changelog was a pile of incoherent rambling and the
above doesn't explain anything much.

I want a clear description of the problem and a coherent explanation of
the proposed solution without having to reverse engineer the actual
patch.
