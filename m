Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86A4C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865A420874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MFvMF/1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBJQfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 11:35:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33400 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfBJQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 11:35:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so3851913pgu.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 08:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SvTeScHsprZoo4g2v8VaFvECABnXvmrSL4jUYtPiRqo=;
        b=MFvMF/1qdfQUmA37fL1NIzl57aLKO4JEzCzBRXQvTyl8eq6Jg7MahgGkE//KMIO4/5
         puUNTGreOLYCAF0+9m6bV9DOi9s9J58HFaucytf4DbheVzvF6OiJ28v5wXFCk9ruWukH
         j13esro2S0fSfzEHdIfZSDpWjA+w+zgYRKmRLzeB/Gw1HJjIYS8Ibtnrewj8PJbXZwDo
         MOYNv/kD8FXWje+vmndC+qw/icfoTQPV4rViB6IL7qnHCyakSj0Q4re/HdZihJNlduC3
         jxKZBLx2sCm7KdJfCXCMyZgZiKbVRhsnQeVBwm8tQIOE4l5IZLpztavOawIkbxtDPoiH
         fuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SvTeScHsprZoo4g2v8VaFvECABnXvmrSL4jUYtPiRqo=;
        b=S1SY/KzukobC6Qd2x2Jt5t1NaGekG1Pv7IZbEJumZ/rLFoI92MXXWEEl1q9la9b6cK
         +lQKfVCS6fDYEGij8FwlAP0aIfL/46WMZ4550rJtbeWbRM+iGH042w4df+iapJFRJNWE
         ka7QMHy6C51aNL55zQ28QUAN+8MHrQdIBwwvapzufBJnfHlQ7YbkPBA5fH5J2yJIAv8o
         LaYjJO9mTITyCyDkgDQ2nCMiD9/yFe1Zp/X5wI4TA6Fc46GaD6mrBA3Tck9BbeEboAcC
         LImtiQIlsixQL2msafRed1b7kdJodk2jPhRTzHcG5mcUNM6R+L4e2SAqGvEuWqPvgLpu
         ARbA==
X-Gm-Message-State: AHQUAubJxQmpeimaBLRXI8WojfEjMiaF4u2xHgO+ASK32QD+zdpuCcog
        DDdfTydWLoISE3JMG9qisQoZR53B82LoKQ==
X-Google-Smtp-Source: AHgI3Ia/R3ekxfDbZvgAipEBE9NfMcUXDntYJ/+PMMDly8tV/BlLbD+pRHU20gAk3Vzh5B33WUg8SA==
X-Received: by 2002:a63:ce45:: with SMTP id r5mr30292290pgi.112.1549816521349;
        Sun, 10 Feb 2019 08:35:21 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id w185sm11262261pfb.135.2019.02.10.08.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 08:35:20 -0800 (PST)
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes 5
 minute delay during boot on Sun Blade 2500
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
 <1549736341.2971.7.camel@HansenPartnership.com>
 <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
 <1549813472.4142.3.camel@HansenPartnership.com>
 <3380ed8e-ae02-96f2-142b-7cce09459df8@kernel.dk>
 <1549815924.4142.8.camel@HansenPartnership.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e6e5d67-d305-dd00-2e42-e2299166c8b2@kernel.dk>
Date:   Sun, 10 Feb 2019 09:35:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549815924.4142.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/19 9:25 AM, James Bottomley wrote:
> On Sun, 2019-02-10 at 09:05 -0700, Jens Axboe wrote:
>> On 2/10/19 8:44 AM, James Bottomley wrote:
>>> On Sun, 2019-02-10 at 10:17 +0100, Mikael Pettersson wrote:
>>>> On Sat, Feb 9, 2019 at 7:19 PM James Bottomley
>>>> <James.Bottomley@hansenpartnership.com> wrote:
>>>
>>> [...]
>>>>> I think the reason for this is that the block mq path doesn't
>>>>> feed
>>>>> the kernel entropy pool correctly, hence the need to install an
>>>>> entropy gatherer for systems that don't have other good random
>>>>> number sources.
>>>>
>>>> That does sound plausible, I admit I didn't even consider the
>>>> possibility that the old block I/O path also was an entropy
>>>> source.
>>>
>>> In theory, the new one should be as well since the rotational
>>> entropy
>>> collector is on the SCSI completion path.   I'd seen the same
>>> problem
>>> but had assumed it was something someone had done to our internal
>>> entropy pool and thus hadn't bisected it.
>>
>> The difference is that the old stack included ADD_RANDOM by default,
>> so this check:
>>
>> 	if (blk_queue_add_random(q))
>> 		add_disk_randomness(req->rq_disk);
>>
>> in scsi_end_request() would be true, and we'd add the randomness. For
>> sd, it seems to set it just fine for non-rotational drives. Could
>> this be because other devices don't? Maybe the below makes a
>> difference.
> 
> No, in both we set it per the rotational parameters of the disk in 
> 
> sd.c:sd_read_block_characteristics()
> 
> 	rot = get_unaligned_be16(&buffer[4]);
> 
> 	if (rot == 1) {
> 	
> 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
> 	
> 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
> 	} else {
> 	
> 	blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
> 	
> 	blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
> 	}
> 
> 
> That check wasn't changed by the code removal.

As I said above, for sd. This isn't true for non-disks.

> Although I suspect it should be unconditional: even SSDs have what
> would appear as seek latencies at least during writes depending on the
> time taken to find an erased block or even trigger garbage collection. 
> The entropy collector is good at taking something completely regular
> and spotting the inconsistencies, so it won't matter that loads of
> "seeks" are deterministic.

The reason it isn't is that it's of limited use for SSDs where it's a
lot more predictable. And they are also a lot faster, which means the
adding randomness is more problematic from an efficiency pov.

-- 
Jens Axboe

