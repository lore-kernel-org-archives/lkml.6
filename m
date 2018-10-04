Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB980C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C922082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ehuk.net header.i=@ehuk.net header.b="emG5t3n5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C922082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehuk.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeJDVBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:01:24 -0400
Received: from schatzi.steelbluetech.co.uk ([92.63.139.240]:24203 "EHLO
        schatzi.steelbluetech.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727394AbeJDVBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:01:24 -0400
Received: from [10.0.5.25] (tv.ehuk.net [10.0.5.25])
        by schatzi.steelbluetech.co.uk (Postfix) with ESMTP id 69019BFD68;
        Thu,  4 Oct 2018 15:07:54 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.10.3 schatzi.steelbluetech.co.uk 69019BFD68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ehuk.net; s=default;
        t=1538662074; bh=/+jd7c8Be2Q66V7cUgTmMjbwu+tWkf/S98vILRYWLys=;
        h=Subject:To:Cc:References:From:Reply-To:Date:In-Reply-To:From;
        b=emG5t3n5yllVTOuwD2O4iQm+lgSvCjnsQV6uGKYRB0igl4TKX4hlxZbtmdGPlGViA
         7BR96qPkXrEQEFtm0MxE9Y/Ky/Ymvpr6dsCehTyiZW7HJjlKXvPV6BA19k807hjAEn
         EsQVY9BjX/zMiZmzKdaBdtuk8ldmMOgQtTfsJ7SM=
Subject: Re: [PATCH] bcache: add separate workqueue for journal_write to avoid
 deadlock
To:     Coly Li <colyli@suse.de>
Cc:     guoju <fangguoju@gmail.com>, kent.overstreet@gmail.com,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
        s.priebe@profihost.ag
References: <1538055919-5757-1-git-send-email-fangguoju@gmail.com>
 <bda92f58-d321-d4db-c73f-0ceecbfd9c38@suse.de>
 <9b1abe65-c6f5-77b4-290e-e6af21723cfc@ehuk.net>
 <ef36fbef-9f2e-0208-aa00-bd9ba656de31@suse.de>
From:   Eddie Chapman <eddie@ehuk.net>
Reply-To: Eddie Chapman <eddie@ehuk.net>
Message-ID: <17ea92fa-a07b-2391-aba3-377382c63d9b@ehuk.net>
Date:   Thu, 4 Oct 2018 15:07:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ef36fbef-9f2e-0208-aa00-bd9ba656de31@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/18 03:32, Coly Li wrote:
> 
> On 9/27/18 11:53 PM, Eddie Chapman wrote:
>> On 27/09/18 16:23, Coly Li wrote:
>>>
>>> On 9/27/18 9:45 PM, guoju wrote:
>>>> After write SSD completed, bcache schedule journal_write work to
>>>> system_wq, that is a public workqueue in system, without WQ_MEM_RECLAIM>>>> flag. system_wq is also a bound wq, and there may be no idle kworker on
>>>> current processor. Creating a new kworker may unfortunately need to
>>>> reclaim memory first, by shrinking cache and slab used by vfs, which
>>>> depends on bcache device. That's a deadlock.
>>>>
>>>> This patch create a new workqueue for journal_write with WQ_MEM_RECLAIM
>>>> flag. It's rescuer thread will work to avoid the deadlock.
>>>>
>>>> Signed-off-by: guoju <fangguoju@gmail.com>
>>>
>>> Nice catch, this fix is quite important. I will try to submit to Jens 
>>> ASAP.
>>>
>>> Thanks.
>>>
>>> Coly Li
>>
>> Once this goes into 4.19, would this be a candidate for backporting to 
>> any stable kernels, or does it only fix something introduced in this 
>> cycle?
>>
> This bug exists in upstream for quite long time, it should be applied to 
> all stable kernels which it can be applied. And it is Cced to 
> stable@vger.kernel.org already.
> 
> Coly Li

Thanks Coly! :-)

Just to let you know, I applied this (and couple of other cherry picks) 
to a couple of 4.14 boxes last night, so far so good, running without 
issues. However, this one needed this recent commit upstream as a 
pre-requisite:

16c1fdf4cfd6c0091e59b93ec2cb7e99973f8244
bcache: do not assign in if condition in bcache_init()

in order to be able to apply it.

This is because the context of the second hunk for 
drivers/md/bcache/super.c (in this journal_write workqueue patch) 
contains code added by that commit 16c1fdf4cfd6c0091e59b93ec2cb7e99973f8244.

So I guess either 16c1fdf4cfd6c0091e59b93ec2cb7e99973f8244 also needs 
tagging for stable, or perhaps a backport of this journal_write 
workqueue will have to be created for earlier kernels, with different 
context for that hunk?

Eddie
