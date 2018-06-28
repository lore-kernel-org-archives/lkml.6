Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEA4C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE733273C7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BlStTvj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE733273C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967213AbeF1Pfm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:35:42 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40639 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966930AbeF1Pfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:35:39 -0400
Received: by mail-it0-f66.google.com with SMTP id 188-v6so13133645ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uUGMPFsNG/dQAI5hqeo64+nXDRsq8B3N+5Op22Ma5Lg=;
        b=BlStTvj5m4ApUKXOMQYe/owePNYb/5zyq+nGM/l5+FWn9zSrCuRpwfZi507xyyIWMz
         JoYBZ63oaAJ2MsCEb3hAK6cWHx63rtSlI+pH+g9o41Lqpk0V8gLU5ifEMHKtBjnjAaW7
         21IlymjZjZVX/4JyGCW6aHDIssrs0XbQqNRqVXFivZ9kDB7IxmcA5lpoC8yva2aF2wZs
         J2Dl1NUfnyn0D4+A8DlzwHUN0cvg+6ITj39H1FJ0ye+euFXkei9SIfL4XY6yKFlk4c5h
         IgJyUsQ7/YzYSJ9W3FVet9etT6We8ChY73aq5+dMdNZqWsBUpRly+lkNan5easbXRPth
         CI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uUGMPFsNG/dQAI5hqeo64+nXDRsq8B3N+5Op22Ma5Lg=;
        b=QL4/UFGnSaFv4NrFpg2VLqLRY55gbIYxUUDaoGpH20vH5YFFdcfK18NNt0LeAzTN7M
         UeWicHPKzHnCfCRvwN6Peo01ScyDNjf0hXUmzwWqVbMcUNCu4q5sdHD53P0YIpQKvEht
         x0xraNr58pKG6pNTQtydXHMOMem96Rv2Ov+zXp1BCrNoIehCwMLYimeVYOvHmsQ6c1y+
         jzEt8b1JX/esJ9rt47O7yeWpT7Qhh5tavcF8sU9dQgmchm7MZpUNJSSZMfqZs8TWntGW
         lKjJnBn4IukWyhfiF5N/7sJx6b834StwFwQfYAKdK+tHXH8FK6vYVKdPxUqgRc+q0Unh
         lUSw==
X-Gm-Message-State: APt69E1ooLqZGGI32dtELt2rucCZ88G5zHT0SQq4rO7qYcYQzKtgZRRX
        9JHRQLDHELpH49TTFt33GBLMvw==
X-Google-Smtp-Source: AAOMgpfxJR8krwuRhI2XwoAQM+zWi7NfzEEsr3KIJxR50h2lKnA6TDpzLIoasM4ntjN0dbICB70M6Q==
X-Received: by 2002:a24:a43:: with SMTP id 64-v6mr8908298itw.140.1530200138569;
        Thu, 28 Jun 2018 08:35:38 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1132::1029? ([2620:10d:c090:180::1:dc82])
        by smtp.gmail.com with ESMTPSA id p201-v6sm3836094itp.35.2018.06.28.08.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 08:35:37 -0700 (PDT)
Subject: Re: [PATCH 12/15] block: introduce blk-iolatency io controller
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, Josef Bacik <jbacik@fb.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
 <20180625151243.2132-13-josef@toxicpanda.com>
 <05a581ed-8f21-9d89-a813-a03d802d3469@kernel.dk>
 <20180627192046.ieqncfl6ioy37mof@destiny>
 <784f0862-0441-5ed2-1beb-3effa82b3438@kernel.dk>
 <20180628132648.wytk67ascubysqun@destiny>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <69aaf06b-ab1a-9982-a547-fcab7daff55f@kernel.dk>
Date:   Thu, 28 Jun 2018 09:35:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180628132648.wytk67ascubysqun@destiny>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/18 7:26 AM, Josef Bacik wrote:
> On Wed, Jun 27, 2018 at 01:24:55PM -0600, Jens Axboe wrote:
>> On 6/27/18 1:20 PM, Josef Bacik wrote:
>>> On Wed, Jun 27, 2018 at 01:06:31PM -0600, Jens Axboe wrote:
>>>> On 6/25/18 9:12 AM, Josef Bacik wrote:
>>>>> +static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
>>>>> +				       struct iolatency_grp *iolat,
>>>>> +				       spinlock_t *lock, bool issue_as_root,
>>>>> +				       bool use_memdelay)
>>>>> +	__releases(lock)
>>>>> +	__acquires(lock)
>>>>> +{
>>>>> +	struct rq_wait *rqw = &iolat->rq_wait;
>>>>> +	unsigned use_delay = atomic_read(&lat_to_blkg(iolat)->use_delay);
>>>>> +	DEFINE_WAIT(wait);
>>>>> +	bool first_block = true;
>>>>> +
>>>>> +	if (use_delay)
>>>>> +		blkcg_schedule_throttle(rqos->q, use_memdelay);
>>>>> +
>>>>> +	/*
>>>>> +	 * To avoid priority inversions we want to just take a slot if we are
>>>>> +	 * issuing as root.  If we're being killed off there's no point in
>>>>> +	 * delaying things, we may have been killed by OOM so throttling may
>>>>> +	 * make recovery take even longer, so just let the IO's through so the
>>>>> +	 * task can go away.
>>>>> +	 */
>>>>> +	if (issue_as_root || fatal_signal_pending(current)) {
>>>>> +		atomic_inc(&rqw->inflight);
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	if (iolatency_may_queue(iolat, &wait, first_block))
>>>>> +		return;
>>>>> +
>>>>> +	do {
>>>>> +		prepare_to_wait_exclusive(&rqw->wait, &wait,
>>>>> +					  TASK_UNINTERRUPTIBLE);
>>>>> +
>>>>> +		iolatency_may_queue(iolat, &wait, first_block);
>>>>> +		first_block = false;
>>>>> +
>>>>> +		if (lock) {
>>>>> +			spin_unlock_irq(lock);
>>>>> +			io_schedule();
>>>>> +			spin_lock_irq(lock);
>>>>> +		} else {
>>>>> +			io_schedule();
>>>>> +		}
>>>>> +	} while (1);
>>>>
>>>> So how does this wait loop ever exit?
>>>>
>>>
>>> Sigh, I cleaned this up from what we're using in production and did it poorly,
>>> I'll fix it up.  Thanks,
>>
>> Also may want to consider NOT using exclusive add if first_block == false, as
>> you'll end up at the tail of the waitqueue after sleeping and being denied.
>> This is similar to the wbt change I posted last week.
>>
> 
> This isn't how it works though.  You aren't removed from the list until you do
> finish_wait(), so you don't lose your spot on the list.  We only get added to
> the end of the list if
> 
>         if (list_empty(&wq_entry->entry))
> 
> otherwise nothing changes.

I missed that you don't do finish_wait() in the loop, I had played with that
to see if it fixes things. But yeah, as it stands, you are right.

>> For may_queue(), your wq_has_sleeper() is also going to be always true
>> inside your loop, since you call it after doing the prepare_to_wait()
>> which adds you to the queue. That's why wbt does the list checks, but
>> it'd be nicer to have a wq_has_other_sleepers() for that. So your
>> first iolatency_may_queue() inside the loop will always be false.
> 
> Ah yeah that's a good point, I'll go back to using what you had to catch that
> case.  Thanks,

Basically we need to do the same thing in wbt and blk-iolatency for this,
so we should sync them up.

-- 
Jens Axboe

