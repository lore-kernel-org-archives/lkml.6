Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5DBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945012133F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c3qptZS7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c3qptZS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfALIyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:54:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56530 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfALIyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:54:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 811AB6053B; Sat, 12 Jan 2019 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547283270;
        bh=jKRDqJ+jd9AfNt0ojqb3Z11Sqon/z/R8vUXI9d1Al7k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c3qptZS7xRmDWxSQKZfvvAj8hro/RRrhCEG8ZRQ1gPK/1DqKXe99a3PKVTPUGEh6b
         SufTmSG1PmH0OMcuZ7IxHXysvaZveHPlF8DcbbGElUWIjprjymE4KsAy+zhPwy9gS5
         N0bucB31U7seHZyeBE92CxRXSW9AQzgiHxhpwz3o=
Received: from [192.168.0.5] (unknown [183.83.164.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 678476053B;
        Sat, 12 Jan 2019 08:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547283270;
        bh=jKRDqJ+jd9AfNt0ojqb3Z11Sqon/z/R8vUXI9d1Al7k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c3qptZS7xRmDWxSQKZfvvAj8hro/RRrhCEG8ZRQ1gPK/1DqKXe99a3PKVTPUGEh6b
         SufTmSG1PmH0OMcuZ7IxHXysvaZveHPlF8DcbbGElUWIjprjymE4KsAy+zhPwy9gS5
         N0bucB31U7seHZyeBE92CxRXSW9AQzgiHxhpwz3o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 678476053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: kernel BUG at kernel/sched/core.c:3490!
To:     Qian Cai <cai@lca.pw>, Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux kernel <linux-kernel@vger.kernel.org>
References: <ba9c5ad8-d78c-904d-0430-a67d8e3ea729@lca.pw>
 <20190107135215.GG14122@hirez.programming.kicks-ass.net>
 <46089f1c-ad72-c96c-2f35-c2f60e726462@lca.pw>
 <20190107175644.GB7636@redhat.com>
 <3a6d8f4c-d7ed-e888-601b-a379efec306a@codeaurora.org>
 <1547223444.6911.19.camel@lca.pw>
From:   "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <5a65a014-9013-cfbd-48a9-67199d33e719@codeaurora.org>
Date:   Sat, 12 Jan 2019 14:24:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547223444.6911.19.camel@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Peter, Oleg,

as per flag and state this seems to be possible only from below code:
XXX: 0 1 0x40844c
PF_NOFREEZE
PF_RANDOMIZE
PF_SIGNALED
PF_FORKNOEXEC
PF_EXITING
PF_EXITPIDONE

above state shows do_exit runs properely and  if somehow after parked 
stated , TASK_WAKEKILL got set and signal_pending_state returns 1 in 
below case:

  switch_count = &prev->nivcsw;
         if (!preempt && prev->state) {
                 if (unlikely(signal_pending_state(prev->state, prev))) {
                         prev->state = TASK_RUNNING;
                 } else {
                         deactivate_task(rq, prev, DEQUEUE_SLEEP | 
DEQUEUE_NOCLOCK);

Regards
Gaurav


On 1/11/2019 9:47 PM, Qian Cai wrote:
> On Fri, 2019-01-11 at 16:07 +0530, Kohli, Gaurav wrote:
>>
>> On 1/7/2019 11:26 PM, Oleg Nesterov wrote:
>>> pr_crit("XXX: %ld %d\n", current->state, current->on_rq);
>>
>> Can we also add flags, this may help to know the path of problem:
>>
>>    pr_crit("XXX: %ld %d 0x%x\n", current->state, current->on_rq, 	
>> current->flags);
>>
> 
> XXX: 0 1 0x40844c
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
