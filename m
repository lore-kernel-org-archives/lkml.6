Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1990FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C834225857
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvA0EbKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C834225857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932648AbeFYLwL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:52:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52425 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755221AbeFYLwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:52:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id p126-v6so8939895wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 04:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XYAnqL8R4EynwsBFn1hss2DPFRe2/tDpikWJaLOZPOc=;
        b=WvA0EbKAfB1ZF9pSLovHCQ6McTAeZ3K4KpGrQl49o6sCHzVyUOJJey5HkOiI4Jgd6c
         ZjuhXnqKgyjztpNDd7GeP0K9+VXQoPamzfwt40s6s2cejZMkumeEI3lmgmyy/yUGyfZi
         ddDepsFQPlgCKQSmSIgMDq4acbHCBJSa4X3HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XYAnqL8R4EynwsBFn1hss2DPFRe2/tDpikWJaLOZPOc=;
        b=mLLrnL0KTm1VeGtYPKkPAJq5n0gKo6+rbNxCY7Xarot4uBscn6ycILUU0iAv2E5mx8
         3HgxgRgongDRkSy+AGjp5CelSCFZ6sHwzxlC+quua542Ol0d4L4TdjnOtQnky5OfN6++
         aqEw3XAvUyvv20can82dX9iSOrxxuBi5wxu46pfD2mxUGdhsYDSifbmidgfCuUS3qvVg
         G9pviItF8zCLCJmG35HFE21KgXCGGQY7R/vzWRhgjXu4uTkcNya/393hjfSVjR1vHg/M
         BsdddiAGZUHws7ZHX+UE29znyvl5rS+Klzsc3UE+b8WMGiIBJFsB8Jqv6ZqytZvgejXe
         dBXg==
X-Gm-Message-State: APt69E3mztobHKc+RMsECImxooj8fSD2aFjek82HhYwqGyfqBr4iu9wE
        M7Cd9SK6Ei4JqXkA2uq/lyK0wg==
X-Google-Smtp-Source: AAOMgpdHRIvjF4CNnEc4z+my6UeFKzH57fRYHppm8cjVU4D3za1KT/vnBKYxhBc2lu1qpTScjB+EpA==
X-Received: by 2002:a1c:8692:: with SMTP id i140-v6mr778628wmd.11.1529927527852;
        Mon, 25 Jun 2018 04:52:07 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:a134:e815:db69:bcb1? ([2001:41d0:fe90:b800:a134:e815:db69:bcb1])
        by smtp.googlemail.com with ESMTPSA id i193-v6sm8286075wmf.13.2018.06.25.04.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 04:52:06 -0700 (PDT)
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection
 framework
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <98f43bb6-9ab5-2f79-05f2-be68a0f7f88e@linaro.org>
Date:   Mon, 25 Jun 2018 13:52:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2018 10:23, Rafael J. Wysocki wrote:

[ ... ]

>> + * It is up to the user of this framework to provide a lock at an
>> + * upper level to prevent stupid things to happen, like starting while
>> + * we are unregistering.
>> + */
> 
> The English above and elsewhere needs some polishing IMO, but I can
> take care of that. :-)

I can give a try and if you are still unhappy, you change them in a
better way.

[ ... ]

>> +static void idle_injection_setup(unsigned int cpu)
>> +{
>> +       struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
>> +
>> +       set_freezable();
> 
> Why do you need set_freezable() here?

We don't want to continue injecting idle cycles when the system is
suspended.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

