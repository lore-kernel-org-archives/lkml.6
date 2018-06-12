Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 70357C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255F9208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2mKIIij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255F9208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933740AbeFLMof (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:44:35 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40187 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933685AbeFLMoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:44:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id l41-v6so23931445wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 05:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=upRjlozCSreFuipSMgeL8a5cZbLpnSpNjs2Rx/+fwq4=;
        b=F2mKIIijp2WT/nbdZZ6fJbsKlb4S2bQemf1Xw+I+Ydsb2pcQ+VSWXPcsu2w/FF6ugP
         TbuZd89rlDp7EBxMLAN1gFhh29EOBl0EF5cT4hUZDDMm6iY0ixsZ+9tunMTGjNu7k7e6
         Posj1j6uOqGc9XWGRKw/F5GAcXu4AonqCuCgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upRjlozCSreFuipSMgeL8a5cZbLpnSpNjs2Rx/+fwq4=;
        b=faah0JU3amnDnkDxzF+RpIj0LTS2bIfM4xJv6bwkYJ68axooey7InA/MpbGE652Grt
         ccEjglYi0DrQgqubkSnbnEVegDynp12B6eWEW4CI5a6tLFSH+lB/lBhlO9WXHcwVr+wc
         v11PUsZbPt+gAowVDTQy/90UU+p4O+cUltm0/xj7XsORyFaZsT1x27m5dRekwpfyWQiO
         rIQE4wGOz+e4uUMeJ50C+E99MuRV9+5GFhuc8m6ur19UoW2yOaYRBPHQVzfAHDGyXHym
         KdJuPUImabdaP5h+9Sjnoix7T+9wRyTqkLj0LDQRK945tedx5Uj6DsFIU87go3eGdDN4
         afAQ==
X-Gm-Message-State: APt69E1WLh5v/aC0hBe15tTTm7N0MCgULXSv9+S0lApeyZDOExq+HX5Q
        Il+G73PDijONgAC8/wS2Vd3R01Lq2Ns=
X-Google-Smtp-Source: ADUXVKLsAsKoGHb9XlSqYZath9gxxXdSvsyWwEXEhwzkyUagvqNqMK/qqV77HPoXFVycDAkG2P1UFA==
X-Received: by 2002:adf:8023:: with SMTP id 32-v6mr170509wrk.243.1528807470870;
        Tue, 12 Jun 2018 05:44:30 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:6506:4f49:e430:ddb9? ([2001:41d0:fe90:b800:6506:4f49:e430:ddb9])
        by smtp.googlemail.com with ESMTPSA id l69-v6sm731762wma.45.2018.06.12.05.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 05:44:29 -0700 (PDT)
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
Date:   Tue, 12 Jun 2018 14:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612123036.GJ12180@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 14:30, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 02:00:11PM +0200, Daniel Lezcano wrote:
>> +static void __idle_injection_wakeup(struct idle_injection_device *ii_dev)
>> +{
>> +	struct idle_injection_thread *iit;
>> +	struct cpumask tmp;
>> +	unsigned int cpu;
>> +
>> +	cpumask_and(&tmp, ii_dev->cpumask, cpu_online_mask);
> 
> You should not be having a cpumask on the stack. Those things can be
> ginormous.

Ok, the kernel code uses of cpumask_t on the stack when dealing with
cpumask_and. I assume it is also not recommended.

What would be the best practice ? Allocate a per cpumask at init time as
a temporary mask to work with ?




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

