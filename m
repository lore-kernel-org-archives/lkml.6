Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 58CE8C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03291208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qi4r3BNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03291208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933508AbeFLNCT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:02:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53722 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932749AbeFLNCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:02:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id x6-v6so20392465wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 06:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=52WAdnCJ1IaWGogfFZUG5pG29t8xwcOkLRROgjO5rHE=;
        b=Qi4r3BNy7xTTYrx+k0QouvcPBsWUYCJE3VSAYS0s8qjCtOD3NYtPIbvp/IhBzrUjQN
         kbzHDXzLsGpSgjmwAKjuh3HPz5QWSzQIpwy6b4gwKcC/jfwYw9LSggR2xvByzCZTl2FW
         pw8M+MXMol3zenFQNmd96uOLgeA6uYf9W+z8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=52WAdnCJ1IaWGogfFZUG5pG29t8xwcOkLRROgjO5rHE=;
        b=H2OgIGhj8y89WUStzEfzLkw9OczdsjvqGf/fZSvFAJNpdDHh5yS5KhAbh3YIPw/19y
         zznftSw/OyQNsTYqnxglMI2r1o309VG0HrUeGyRQDYdTKslxKxnd6pyGXaIUfc6q9wYe
         AX1GDy6cK7xoONAPdwaKKLtnF0JkxCk4RfPMShSd3fw02tsVZukLqzbXaRn9OntndCGI
         /SMylUUcvpZFfesW7n8mmdqrdQYLkM2eCQLxl61Za6bP6To/GU807GZddFNIHAbWrCUO
         oQIozABRTNe3mjzAEkq+VQrdMObIGS+4ibBntYTUit5NT2tV4nsVsHcEguZo4Y3I6NLl
         nJVw==
X-Gm-Message-State: APt69E3BaKLk6nmy0z2Cq5j0spWAVSur8C9F2JA7DSeqElpxeEzd+cRy
        HMIN0L9H2XnLoQKe05HXx9fTLw==
X-Google-Smtp-Source: ADUXVKKLRyXEtcvbwzv7Qgvs0dsaD4AT3tSZZLsz7dC6sRs9UmWRWvxRLdGDTmUfyYlwa/gB9OuYxA==
X-Received: by 2002:a1c:ae8b:: with SMTP id x133-v6mr195300wme.125.1528808535910;
        Tue, 12 Jun 2018 06:02:15 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:6506:4f49:e430:ddb9? ([2001:41d0:fe90:b800:6506:4f49:e430:ddb9])
        by smtp.googlemail.com with ESMTPSA id p38-v6sm250379wrc.11.2018.06.12.06.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 06:02:15 -0700 (PDT)
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle injection
 framework
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <20180612123036.GJ12180@hirez.programming.kicks-ass.net>
 <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
 <20180612125247.GO12217@hirez.programming.kicks-ass.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <16770447-afe3-0fd7-19f9-1bd52c4c8ced@linaro.org>
Date:   Tue, 12 Jun 2018 15:02:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612125247.GO12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 14:52, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 02:44:29PM +0200, Daniel Lezcano wrote:
>> On 12/06/2018 14:30, Peter Zijlstra wrote:
>>> On Tue, Jun 12, 2018 at 02:00:11PM +0200, Daniel Lezcano wrote:
>>>> +static void __idle_injection_wakeup(struct idle_injection_device *ii_dev)
>>>> +{
>>>> +	struct idle_injection_thread *iit;
>>>> +	struct cpumask tmp;
>>>> +	unsigned int cpu;
>>>> +
>>>> +	cpumask_and(&tmp, ii_dev->cpumask, cpu_online_mask);
>>>
>>> You should not be having a cpumask on the stack. Those things can be
>>> ginormous.
>>
>> Ok, the kernel code uses of cpumask_t on the stack when dealing with
>> cpumask_and. I assume it is also not recommended.
> 
> Yes, that should all get fixed. It's mostly legacy code I suppose. It's
> been at least 10 years I think since we merged the whole
> CPUMASK_OFFSTACK stuff.
> 
>> What would be the best practice ? Allocate a per cpumask at init time as
>> a temporary mask to work with ?
> 
> In this case, you can do:

That is what we had before but we change the code to set the count
before waking up the task, so compute the cpumask_weight of the
resulting AND right before this loop.

> +       for_each_cpu_and(cpu, &ii_dev->cpumask, cpu_online_mask) {
> +               iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +               iit->should_run = 1;
> +               wake_up_process(iit->tsk);
> +       }
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

