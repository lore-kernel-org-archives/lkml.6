Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C2FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0112170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0112170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeI1IyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:54:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:36570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726271AbeI1IyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:54:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A131AE12;
        Fri, 28 Sep 2018 02:32:57 +0000 (UTC)
Subject: Re: [PATCH] bcache: add separate workqueue for journal_write to avoid
 deadlock
To:     Eddie Chapman <eddie@ehuk.net>
Cc:     guoju <fangguoju@gmail.com>, kent.overstreet@gmail.com,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1538055919-5757-1-git-send-email-fangguoju@gmail.com>
 <bda92f58-d321-d4db-c73f-0ceecbfd9c38@suse.de>
 <9b1abe65-c6f5-77b4-290e-e6af21723cfc@ehuk.net>
From:   Coly Li <colyli@suse.de>
Message-ID: <ef36fbef-9f2e-0208-aa00-bd9ba656de31@suse.de>
Date:   Fri, 28 Sep 2018 10:32:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <9b1abe65-c6f5-77b4-290e-e6af21723cfc@ehuk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/27/18 11:53 PM, Eddie Chapman wrote:
> On 27/09/18 16:23, Coly Li wrote:
>>
>> On 9/27/18 9:45 PM, guoju wrote:
>>> After write SSD completed, bcache schedule journal_write work to
>>> system_wq, that is a public workqueue in system, without WQ_MEM_RECLAIM
>>> flag. system_wq is also a bound wq, and there may be no idle kworker on
>>> current processor. Creating a new kworker may unfortunately need to
>>> reclaim memory first, by shrinking cache and slab used by vfs, which
>>> depends on bcache device. That's a deadlock.
>>>
>>> This patch create a new workqueue for journal_write with WQ_MEM_RECLAIM
>>> flag. It's rescuer thread will work to avoid the deadlock.
>>>
>>> Signed-off-by: guoju <fangguoju@gmail.com>
>>
>> Nice catch, this fix is quite important. I will try to submit to Jens 
>> ASAP.
>>
>> Thanks.
>>
>> Coly Li
>
> Once this goes into 4.19, would this be a candidate for backporting to 
> any stable kernels, or does it only fix something introduced in this 
> cycle?
>
This bug exists in upstream for quite long time, it should be applied to 
all stable kernels which it can be applied. And it is Cced to 
stable@vger.kernel.org already.

Coly Li

