Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9991C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769A5208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FSxNsW9L";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FSxNsW9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769A5208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbeLCTgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:36:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49316 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeLCTgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:36:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E18186130A; Mon,  3 Dec 2018 19:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543865779;
        bh=C429LUGU4RujiL0uhFxLkb9tu7GRexYLkN5vub8F8tk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FSxNsW9L3i/Kx5HHEq63o8x6QO6TBzPeNvdtZf6XK7rYQPhE7j+nk0nUMbBhOb7x+
         4Li9AgSrPTylbbsDELfN9P+lk4+4QiVVz88GfLiQ6PbMG431W64lkTGmdich+2eZ7p
         q2G2p5FibWsaBOD8FDAES8xVqof1JyUJ1DbLvQ08=
Received: from [10.204.79.19] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88E55602F4;
        Mon,  3 Dec 2018 19:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543865779;
        bh=C429LUGU4RujiL0uhFxLkb9tu7GRexYLkN5vub8F8tk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FSxNsW9L3i/Kx5HHEq63o8x6QO6TBzPeNvdtZf6XK7rYQPhE7j+nk0nUMbBhOb7x+
         4Li9AgSrPTylbbsDELfN9P+lk4+4QiVVz88GfLiQ6PbMG431W64lkTGmdich+2eZ7p
         q2G2p5FibWsaBOD8FDAES8xVqof1JyUJ1DbLvQ08=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88E55602F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
Subject: Re: [PATCH] percpu_rwsem: fix missed wakeup due to reordering of load
To:     Davidlohr Bueso <dbueso@suse.de>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org
References: <1543590656-7157-1-git-send-email-prsood@codeaurora.org>
 <734eb2ec2c3aeba1c4d054c1fceacef1@suse.de>
From:   Prateek Sood <prsood@codeaurora.org>
Message-ID: <7803e498-5fc8-9b72-3e1b-76005f7673a3@codeaurora.org>
Date:   Tue, 4 Dec 2018 01:06:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <734eb2ec2c3aeba1c4d054c1fceacef1@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2018 12:08 PM, Davidlohr Bueso wrote:
> On 2018-11-30 07:10, Prateek Sood wrote:
>> In a scenario where cpu_hotplug_lock percpu_rw_semaphore is already
>> acquired for read operation by P1 using percpu_down_read().
>>
>> Now we have P1 in the path of releaseing the cpu_hotplug_lock and P2
>> is in the process of acquiring cpu_hotplug_lock.
>>
>> P1                                               P2
>> percpu_up_read() path                      percpu_down_write() path
>>
>>                                           rcu_sync_enter() //gp_state=GP_PASSED
>>
>> rcu_sync_is_idle() //returns false        down_write(rw_sem)
>>
>> __percpu_up_read()
>>
>> [L] task = rcu_dereference(w->task) //NULL
>>
>> smp_rmb()                                  [S] w->task = current
>>
>>                                             smp_mb()
>>
>>                                            [L] readers_active_check() //fails
>>                          schedule()
>>
>> [S] __this_cpu_dec(read_count)
>>
>> Since load of task can result in NULL. This can lead to missed wakeup
>> in rcuwait_wake_up(). Above sequence violated the following constraint
>> in rcuwait_wake_up():
>>
>>      WAIT                WAKE
>> [S] tsk = current      [S] cond = true
>> MB (A)                        MB (B)
>> [L] cond          [L] tsk
>>
> 
> Hmm yeah we don't want rcu_wake_up() to get hoisted over the __this_cpu_dec(read_count). The smp_rmb() does not make sense to me here in the first place. Did you run into this scenario by code inspection or you actually it the issue?
> 
> Thanks,
> Davidlohr

I have checked one issue where it seems that cpu hotplug code
path is not able to get cpu_hotplug_lock in write mode and there
is a reader pending for cpu hotplug path to release
percpu_rw_semaphore->rwsem to acquire cpu_hotplug_lock.
This caused a deadlock.

From code inspection also it seems to be not adhering to arm64
smp_rmb() constraint of load/load-store ordering guarantee.


Thanks,
Prateek

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
