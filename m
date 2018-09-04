Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83443C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AC12073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AC12073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeIECWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:22:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58020 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbeIECWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:22:08 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxJHr-00069U-CS; Tue, 04 Sep 2018 23:55:03 +0200
Date:   Tue, 4 Sep 2018 23:54:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dhaval.giani@oracle.com, steven.sistare@oracle.com
Subject: Re: [RFC PATCH 2/2] pipe: use pipe busy wait
In-Reply-To: <20180830202458.32579-3-subhra.mazumdar@oracle.com>
Message-ID: <alpine.DEB.2.21.1809042351220.1416@nanos.tec.linutronix.de>
References: <20180830202458.32579-1-subhra.mazumdar@oracle.com> <20180830202458.32579-3-subhra.mazumdar@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, subhra mazumdar wrote:
>  
> +void pipe_busy_wait(struct pipe_inode_info *pipe)
> +{
> +	unsigned long wait_flag = pipe->pipe_wait_flag;
> +	unsigned long start_time = pipe_busy_loop_current_time();
> +
> +	pipe_unlock(pipe);
> +	preempt_disable();
> +	for (;;) {
> +		if (pipe->pipe_wait_flag > wait_flag) {
> +			preempt_enable();
> +			pipe_lock(pipe);
> +			return;
> +		}
> +		if (pipe_busy_loop_timeout(pipe, start_time))
> +			break;
> +		cpu_relax();
> +	}
> +	preempt_enable();

You are not really serious about busy looping with preemption disabled?

That's just wrong. Why do you want to block others from getting on the CPU
if there is nothing in the pipe?

There is no point in doing so, really. If the wait loop is preempted
because there is more important work to do, then it will come back and
either see new data, or leave due to wait time reached.

Thanks,

	tglx

