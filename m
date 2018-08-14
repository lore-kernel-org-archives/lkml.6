Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0F1C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B07521527
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B07521527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbeHNHTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 03:19:31 -0400
Received: from regular1.263xmail.com ([211.150.99.136]:42686 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731097AbeHNHTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 03:19:31 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Aug 2018 03:19:30 EDT
Received: from jeffy.chen?rock-chips.com (unknown [192.168.167.175])
        by regular1.263xmail.com (Postfix) with ESMTP id CF717275;
        Tue, 14 Aug 2018 12:27:15 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.22.162] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 1F26137E;
        Tue, 14 Aug 2018 12:27:01 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: computersforpeace@gmail.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <92b4427c30b83f061eef1f88b18aa029>
X-ATTACHMENT-NUM: 0
X-SENDER: cjf@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.22.162] (unknown [103.29.142.67])
        by smtp.263.net (Postfix) whith ESMTP id 24444F5H6AP;
        Tue, 14 Aug 2018 12:27:15 +0800 (CST)
Message-ID: <5B725A12.8050409@rock-chips.com>
Date:   Tue, 14 Aug 2018 12:26:58 +0800
From:   JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To:     Brian Norris <computersforpeace@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        AL Yu-Chen Cho <acho@suse.com>
Subject: Re: [Question] bluetooth/{bnep,cmtp,hidp}: memory barriers
References: <20180730031030.GA9430@andrea> <20180813231854.GA173912@ban.mtv.corp.google.com>
In-Reply-To: <20180813231854.GA173912@ban.mtv.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Thanks for your mails, and sorry for the late response..

On 08/14/2018 07:18 AM, Brian Norris wrote:
>
> commit 5da8e47d849d3d37b14129f038782a095b9ad049
> Author: Jeffy Chen<jeffy.chen@rock-chips.com>
> Date:   Tue Jun 27 17:34:44 2017 +0800
>
>      Bluetooth: hidp: fix possible might sleep error in hidp_session_thread
>
> that*some*  kind of barrier was stuck in there simply as a response to
> comments like this, that were going away:
>
> -                *
> -                * Note: set_current_state() performs any necessary
> -                * memory-barriers for us.
>                   */
> -               set_current_state(TASK_INTERRUPTIBLE);
>
> +               /* Ensure session->terminate is updated */
> +               smp_mb__before_atomic();
>
>
> It was probably an attempt to fill in the gap for the
> set_current_state() (and comment) which was being removed. I believe
> Jeffy originally added more barriers in other places, but I convinced
> him not to.

right, i was trying to avoid losing memory-barriers when removing 
set_current_state and changing wake_up_process to wake_up_interruptible.

and checking these code again, it's true the smp_mb__before_atomic 
before atomic_read is not needed, the smp_mb after 
atomic_inc(&session->terminate) should be enough.

and as Brian point out, there's already an smp_store_mb at the end of 
wait_woken, i agree we can remove all the 
smp_mb__{before,after}_atomic() i wrongly added :)

>
> I have to say, I'm not really up-to-speed on the use of manual barriers
> in Linux (it's much preferable when they're wrapped into higher-level
> data structures already), but I believe the main intention here is to
> ensure that any change to 'terminate' that happened during the previous
> "wait_woken()" would be visible to our atomic_read().
>
> Looking into wait_woken(), I'm feeling like none of these additional
> barriers are necessary at all. I believe wait_woken() handles the
> visibility issues we care about (that if we were woken for termination,
> we'll see the terminating condition).


