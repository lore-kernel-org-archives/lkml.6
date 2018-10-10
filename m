Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABA1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CDB21526
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJNKEPVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CDB21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeJJVor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:44:47 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35495 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeJJVor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:44:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id v68-v6so3250222qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tAWmy0gMuXOcZJtdhH+ZjiZQiAbEcdaue2riVUXB+F4=;
        b=jJNKEPVRgfBzcs2nBwrv2OUecLJcaH3b1Z1zd5yTBX6h4uiEwddWG8yq0kGQ5TsdUM
         UEXxlgcmaeaunw2T3BuFwqX0GJdTFLeA39oZq4tqKB3zYqq79vvd2xCa55/MaPkElZvI
         wQjdx99EjI+v4yGawJQhylGyvXsgkTVS1D5Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tAWmy0gMuXOcZJtdhH+ZjiZQiAbEcdaue2riVUXB+F4=;
        b=jqCdsL0ndqAXfJNKjbO4xrlZhJLOfwQbMC/idY+UX/YVTsUteUAj4njlK8TSK2fX1y
         TzRxBZRcgxb8WWS4H9CjI0C7B2M4zY9beyj6E8A4wuCFR9rsOZtKdckwiJ2GrMepDw/e
         VY1eItnAtWdx5PQ9pCsJaSCTiGZbhDEcGwFktNJ9iKg6cgZmTnVBA8bp4vD5KKfAJG18
         sumlq5GsbhP8uTr7Z00pOXchwGO3z7JGmXlNZTJ99vhVaHtoMmQ8x06QtCQztiws8d/h
         QQgyvLLjiOcdxY+1kkvopqVuFr4eLxGRHbVYrTQUahewabhbqORjk0GWaYKc6HrOIGHr
         T75w==
X-Gm-Message-State: ABuFfojusjgbsgWMtKHZ9SvYvlKclt2Mfq3vUonLRTgrHvnveFRZ+WGf
        yyaCByByrBP7Rb+lgJJYVxzuAA==
X-Google-Smtp-Source: ACcGV602sd0oeMTcLiFF3lfvqjH+m0R9SjDW3BsBUKsOI3bOJiF/fqEDKrh7TVB3WnsrQ7aAUoGbyA==
X-Received: by 2002:a37:4f53:: with SMTP id d80-v6mr27047020qkb.323.1539181342691;
        Wed, 10 Oct 2018 07:22:22 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id b10-v6sm13495008qkj.25.2018.10.10.07.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 07:22:21 -0700 (PDT)
Subject: Re: [RFC PATCH 6/7] sched/fair: update cpu_capcity to reflect thermal
 pressure
To:     Javi Merino <javi.merino@kernel.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <1539102302-9057-7-git-send-email-thara.gopinath@linaro.org>
 <20181010055722.GA5038@tesla>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, quentin.perret@arm.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5BBE0B1C.4060508@linaro.org>
Date:   Wed, 10 Oct 2018 10:22:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20181010055722.GA5038@tesla>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2018 01:57 AM, Javi Merino wrote:
> On Tue, Oct 09, 2018 at 12:25:01PM -0400, Thara Gopinath wrote:
>> cpu_capacity relflects the maximum available capacity of a cpu. Thermal
>> pressure on a cpu means this maximum available capacity is reduced. This
>> patch reduces the average thermal pressure for a cpu from its maximum
>> available capacity so that cpu_capacity reflects the actual
>> available capacity.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  kernel/sched/fair.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 7deb1d0..8651e55 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7497,6 +7497,7 @@ static unsigned long scale_rt_capacity(int cpu)
>>  
>>  	used = READ_ONCE(rq->avg_rt.util_avg);
>>  	used += READ_ONCE(rq->avg_dl.util_avg);
>> +	used += READ_ONCE(rq->avg_thermal.load_avg);
> 
> IIUIC, you are treating thermal pressure as an artificial load on the
> cpu.  If so, this sounds like a hard to maintain hack.  Thermal
> pressure have different characteristics to utilization.  What happens
> if thermal sets the cpu cooling state back to 0 because there is
> thermal headroom again?  Do we keep adding this artificial load to the
> cpu just because there was thermal pressure in the past and let it
> decay as if it was cpu load?

Setting cpu cooling state back to 0 will decay the thermal pressure back
to 0 ? Yes, cpu will not register an instantaneous drop in the cap, it
will be decayed down following the PELT signals.

> 
> Cheers,
> Javi
> 


-- 
Regards
Thara
