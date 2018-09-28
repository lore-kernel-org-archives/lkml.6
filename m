Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2DFC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F832170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F832170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbeI1IxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:53:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:36188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727361AbeI1IxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:53:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6CEFEAE12;
        Fri, 28 Sep 2018 02:31:35 +0000 (UTC)
Subject: Re: [PATCH] bcache: add separate workqueue for journal_write to avoid
 deadlock
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     Eddie Chapman <eddie@ehuk.net>, guoju <fangguoju@gmail.com>,
        kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1538055919-5757-1-git-send-email-fangguoju@gmail.com>
 <bda92f58-d321-d4db-c73f-0ceecbfd9c38@suse.de>
 <9b1abe65-c6f5-77b4-290e-e6af21723cfc@ehuk.net>
 <2C0DE6F7-624B-49B6-9788-BA0A8E7DA25C@profihost.ag>
From:   Coly Li <colyli@suse.de>
Message-ID: <b4d23257-1912-30c8-85f4-5a7b0d69115c@suse.de>
Date:   Fri, 28 Sep 2018 10:31:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <2C0DE6F7-624B-49B6-9788-BA0A8E7DA25C@profihost.ag>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

This bug was triggered by following condition:

1, few system memory available to allocate

2, journal delayed its operations to system_wq, which needs to allocate 
memory to execute.

3, Due to lack of memory, kernel starts to reclaim system memory, and 
trigger writeback to file system on top of bcache device

4, the memory writeback I/O hitting bcache device via upper layer file 
system, requiring more bcache journal operations

5, a loop-blocking issue happens in bcache journal

If your system is under heavy memory pressure, this deadlock may also 
happens in your environment. Anyway, this is a patch I suggest to apply 
because it fix a real deadlock which is probably happens when system 
memory is exhausted.


Thanks.


Coly Li

On 9/28/18 1:16 AM, Stefan Priebe - Profihost AG wrote:
> Hi Coly,
>
> is this the deadlock I reported some weeks ago?
>
> Greets,
> Stefan
>
> Excuse my typo sent from my mobile phone.
>
> Am 27.09.2018 um 17:53 schrieb Eddie Chapman <eddie@ehuk.net 
> <mailto:eddie@ehuk.net>>:
>
>> On 27/09/18 16:23, Coly Li wrote:
>>> On 9/27/18 9:45 PM, guoju wrote:
>>>> After write SSD completed, bcache schedule journal_write work to
>>>> system_wq, that is a public workqueue in system, without WQ_MEM_RECLAIM
>>>> flag. system_wq is also a bound wq, and there may be no idle kworker on
>>>> current processor. Creating a new kworker may unfortunately need to
>>>> reclaim memory first, by shrinking cache and slab used by vfs, which
>>>> depends on bcache device. That's a deadlock.
>>>>
>>>> This patch create a new workqueue for journal_write with WQ_MEM_RECLAIM
>>>> flag. It's rescuer thread will work to avoid the deadlock.
>>>>
>>>> Signed-off-by: guoju <fangguoju@gmail.com <mailto:fangguoju@gmail.com>>
>>> Nice catch, this fix is quite important. I will try to submit to 
>>> Jens ASAP.
>>> Thanks.
>>> Coly Li
>>
>> Once this goes into 4.19, would this be a candidate for backporting 
>> to any stable kernels, or does it only fix something introduced in 
>> this cycle?
>>
>> thanks,
>> Eddie
