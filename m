Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECC1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE3D20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfAVFo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:44:28 -0500
Received: from foss.arm.com ([217.140.101.70]:46498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVFo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:44:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1683AA78;
        Mon, 21 Jan 2019 21:44:27 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 662EA3F6A8;
        Mon, 21 Jan 2019 21:44:24 -0800 (PST)
Date:   Tue, 22 Jan 2019 05:44:19 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        James Morse <james.morse@arm.com>,
        SRINIVAS <srinivas.eeda@oracle.com>
Subject: Re: [PATCH 1/5] locking/qspinlock: Safely handle > 4 nesting levels
Message-ID: <20190122054417.GC6445@brain-police>
References: <1548038994-30073-1-git-send-email-longman@redhat.com>
 <1548038994-30073-2-git-send-email-longman@redhat.com>
 <20190121091234.GG27931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121091234.GG27931@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:12:34AM +0100, Peter Zijlstra wrote:
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 8a8c3c208c5e..983b49a75826 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -412,6 +412,12 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	idx = node->count++;
>  	tail = encode_tail(smp_processor_id(), idx);
>  
> +	if (idx >= MAX_NODES) {
> +		while (!queued_spin_trylock(lock))
> +			cpu_relax();
> +		goto release;
> +	}
> +
>  	node = grab_mcs_node(node, idx);

With an unlikely() and a comment, I /much/ prefer this approach!

Will
