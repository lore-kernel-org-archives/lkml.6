Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776F7C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3628D20645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3628D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbeLCGin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:38:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:40006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbeLCGin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:38:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 00E02AD02;
        Mon,  3 Dec 2018 06:38:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 02 Dec 2018 22:38:38 -0800
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org
Subject: Re: [PATCH] percpu_rwsem: fix missed wakeup due to reordering of load
Organization: SUSE Labs
In-Reply-To: <1543590656-7157-1-git-send-email-prsood@codeaurora.org>
References: <1543590656-7157-1-git-send-email-prsood@codeaurora.org>
Message-ID: <734eb2ec2c3aeba1c4d054c1fceacef1@suse.de>
X-Sender: dbueso@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-30 07:10, Prateek Sood wrote:
> In a scenario where cpu_hotplug_lock percpu_rw_semaphore is already
> acquired for read operation by P1 using percpu_down_read().
> 
> Now we have P1 in the path of releaseing the cpu_hotplug_lock and P2
> is in the process of acquiring cpu_hotplug_lock.
> 
> P1                                               P2
> percpu_up_read() path                      percpu_down_write() path
> 
>                                           rcu_sync_enter() 
> //gp_state=GP_PASSED
> 
> rcu_sync_is_idle() //returns false        down_write(rw_sem)
> 
> __percpu_up_read()
> 
> [L] task = rcu_dereference(w->task) //NULL
> 
> smp_rmb()                                  [S] w->task = current
> 
>                                             smp_mb()
> 
>                                            [L] readers_active_check() 
> //fails
> 					     schedule()
> 
> [S] __this_cpu_dec(read_count)
> 
> Since load of task can result in NULL. This can lead to missed wakeup
> in rcuwait_wake_up(). Above sequence violated the following constraint
> in rcuwait_wake_up():
> 
> 	 WAIT                WAKE
> [S] tsk = current	  [S] cond = true
> MB (A)	                    MB (B)
> [L] cond		  [L] tsk
> 

Hmm yeah we don't want rcu_wake_up() to get hoisted over the 
__this_cpu_dec(read_count). The smp_rmb() does not make sense to me here 
in the first place. Did you run into this scenario by code inspection or 
you actually it the issue?

Thanks,
Davidlohr
