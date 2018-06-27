Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990EBC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4072B265D2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4072B265D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbeF0HPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:15:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51498 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeF0HPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:15:35 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fY4fo-00007x-IV; Wed, 27 Jun 2018 09:15:28 +0200
Date:   Wed, 27 Jun 2018 09:15:28 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     peterz@infradead.org, matt@codeblueprint.co.uk, mingo@kernel.org,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org
Subject: Re: [PATCH] stop_machine: Remove cpu swap from stop_two_cpus
Message-ID: <20180627071527.hvrndkz436yeqwpq@linutronix.de>
References: <1530048506-21393-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1530048506-21393-1-git-send-email-isaacm@codeaurora.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-26 14:28:26 [-0700], Isaac J. Manjarres wrote:
> Remove CPU ID swapping in stop_two_cpus() so that the
> source CPU's stopper thread is added to the wake queue last,
> so that the source CPU's stopper thread is woken up last,
> ensuring that all other threads that it depends on are woken
> up before it runs.

You can't do that because you could deadlock while locking the stoper
lock.
Couldn't you swap cpu1+cpu2 and work1+work2?

> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index f89014a..d10d633 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -307,8 +307,6 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
>  	cpu_stop_init_done(&done, 2);
>  	set_state(&msdata, MULTI_STOP_PREPARE);
>  
> -	if (cpu1 > cpu2)
> -		swap(cpu1, cpu2);
>  	if (cpu_stop_queue_two_works(cpu1, &work1, cpu2, &work2))
>  		return -ENOENT;
>  

Sebastian
