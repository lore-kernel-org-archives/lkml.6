Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9722C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923F32080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c64Usldu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923F32080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeJ3Xr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:47:28 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35964 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJ3Xr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:47:27 -0400
Received: by mail-it1-f196.google.com with SMTP id t4-v6so5678333itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 07:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YGuRL4iSgxQCelHylHdRKjUZPIS29SDCvYcth+nshyk=;
        b=c64UslduNG90Wc5jW7k9PVnxYDloNmU2/6i8KITi4bX6j4W6Sh1JHIhY3p8ON0sct+
         jahBX/mLSP/5iEwpEP3fmU6MqXH+tnXdE8nS8bdpdDHRUqPnVe+OW83ZCFSQQj8UxbmC
         S8y+aNwe0K3MnWzWUipqRh6bPsrgF/0aY7vQ/3zlIu93eo26WF9baFtFtwUyEIqvVH6z
         2huLgPAepwehEoX7yM4DeqxB5VMHy3vWGACbEXQkwdZdDNurVabR3tCt4igiFI+vJuHm
         fHBmJ86a7zx1Z7+3ISnv/pjUV6yiT6gkWO4gFIZ/WF7pP3l6RyhdVpnPVQadmHcox+SS
         7/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YGuRL4iSgxQCelHylHdRKjUZPIS29SDCvYcth+nshyk=;
        b=LzqgkQ0ldgz/uFBcxX9pOuM23sGQ062IhPafxc9uY3lPBALTVreMixAt9uZoE5JFwV
         kAeVNLELRvXmZTBmZY/0axl6PDZ2gMifhXX2UakFFqiMyAHEv4Gs4HsrvDsa25VU7/Ge
         S209VABDbGOXmz+BXhkss9JnZ8FHoMt0uUPusgXP/7JPlR5zOhDTVCKNLTjTkeHOwDPy
         Ix866zKMGeVN9SUfm04Ipebrr6ZJRgCo6HNQkL/MK3Uxl+YvV1MopCkwZbvZtFzjRycs
         UnhcPNiD8LqcyjhDP9E8S+JlFNH1nbEGwcmcK4brF+ugpVqkjV6oKoHN9ADcB7EVvjaF
         3P1A==
X-Gm-Message-State: AGRZ1gJ0WwIrETOS6XRgWYKNbpIksynyJEAns4quRVFO2gU9M2TlekqD
        FQ6OoYY21iNowHaLKfRO8duKxjbxVb0=
X-Google-Smtp-Source: AJdET5f3mTEFv7cWDj5tQx07ILRosUfLdtZlbx40q/94ChZm7gV92uyC31eXlBWFW2gWYR1wUhBXYw==
X-Received: by 2002:a05:660c:247:: with SMTP id t7mr1722892itk.107.1540911219706;
        Tue, 30 Oct 2018 07:53:39 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w124-v6sm8869881ita.0.2018.10.30.07.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 07:53:38 -0700 (PDT)
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-12-axboe@kernel.dk>
 <20181030142601.GA18906@localhost.localdomain>
 <c11c95ae-5e10-38bd-d2c2-e2407634f52a@kernel.dk>
 <20181030144527.GB18906@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <46dbcbcd-799f-9970-a68f-de7e96b1a6bb@kernel.dk>
Date:   Tue, 30 Oct 2018 08:53:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030144527.GB18906@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 8:45 AM, Keith Busch wrote:
> On Tue, Oct 30, 2018 at 08:36:35AM -0600, Jens Axboe wrote:
>> On 10/30/18 8:26 AM, Keith Busch wrote:
>>> On Mon, Oct 29, 2018 at 10:37:35AM -0600, Jens Axboe wrote:
>>>> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
>>>> index f4f29b9d90ee..2046a0f0f0f1 100644
>>>> --- a/kernel/irq/affinity.c
>>>> +++ b/kernel/irq/affinity.c
>>>> @@ -180,6 +180,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>>>>  	int curvec, usedvecs;
>>>>  	cpumask_var_t nmsk, npresmsk, *node_to_cpumask;
>>>>  	struct cpumask *masks = NULL;
>>>> +	int i, nr_sets;
>>>>  
>>>>  	/*
>>>>  	 * If there aren't any vectors left after applying the pre/post
>>>> @@ -210,10 +211,23 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>>>>  	get_online_cpus();
>>>>  	build_node_to_cpumask(node_to_cpumask);
>>>>  
>>>> -	/* Spread on present CPUs starting from affd->pre_vectors */
>>>> -	usedvecs = irq_build_affinity_masks(affd, curvec, affvecs,
>>>> -					    node_to_cpumask, cpu_present_mask,
>>>> -					    nmsk, masks);
>>>> +	/*
>>>> +	 * Spread on present CPUs starting from affd->pre_vectors. If we
>>>> +	 * have multiple sets, build each sets affinity mask separately.
>>>> +	 */
>>>> +	nr_sets = affd->nr_sets;
>>>> +	if (!nr_sets)
>>>> +		nr_sets = 1;
>>>> +
>>>> +	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
>>>> +		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
>>>> +		int nr;
>>>> +
>>>> +		nr = irq_build_affinity_masks(affd, curvec, this_vecs,
>>>> +					      node_to_cpumask, cpu_present_mask,
>>>> +					      nmsk, masks + usedvecs);
>>>> +		usedvecs += nr;
>>>> +	}
>>>
>>>
>>> While the code below returns the appropriate number of possible vectors
>>> when a set requested too many, the above code is still using the value
>>> from the set, which may exceed 'nvecs' used to kcalloc 'masks', so
>>> 'masks + usedvecs' may go out of bounds.
>>
>> How so? nvecs must the max number of vecs, the sum of the sets can't
>> exceed that value.
> 
> 'nvecs' is what irq_calc_affinity_vectors() returns, which is the min
> of either the requested max or the sum of the set, and the sum of the set
> isn't guaranteed to be the smaller value.

The sum of the set can't exceed the nvecs passed in, the nvecs passed in
should be the less than or equal to nvecs. Granted this isn't enforced,
and perhaps that should be the case.

-- 
Jens Axboe

