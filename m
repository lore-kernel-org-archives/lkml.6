Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1B195C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4638208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Idb9V47N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4638208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934232AbeFLOpf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:45:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34879 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932803AbeFLOpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:45:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id j15-v6so23958622wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 07:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ihhcLs49Fg1+LM1WLziwwTZG8g9BRCEgMpJRdrOPRZg=;
        b=Idb9V47NYukxhmrfVXsNWr+BHx2lS3FtB0qcVG3CUBPr3JqToP1OS78tGpur7OywMh
         mMNn7opViSGuAJ6gmsdpuLopOQB3FKJFdiOhgOu3SP+vlkv9LL9XlsIXxhltlhrshI60
         tr//4lLgQcerXa0kOPvvJ2lHnrzK72qPRBMqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ihhcLs49Fg1+LM1WLziwwTZG8g9BRCEgMpJRdrOPRZg=;
        b=p9Vz7N4PsMcBQWexzyP/OtGw4S3HYxd5s19jExF89BahJxcXysQ7h169vF/4SX630Y
         O4klpnsAO6/ZT0+cBy1L04ujjjeUWI8WuUEjs2E+YNChmgK/jbtMRoaGhYdjf748FVuz
         u6zZ3F1Aby92ITN/8Kx2shAjjav5xjlEe+koZpulv6fBIs/GddA39h6s0p4jEL4D8Z6D
         yXBSvqHnjO6gAdQqyyTJZr6wj9XdFOni6sCs82Zv291WrZ9JAzI2vWFhyCHDB7qcO3qJ
         tSKGR84JPuLPsoZKo2JhHjcFZBw2fB+gx9VRtU0PjpXSoOSFNAsG0U+h7TTISOSZNOZo
         ND1g==
X-Gm-Message-State: APt69E3/7JqniYP/KkDF80Udd7SidPh+8xzz5k+R/7J92VTFMJwmE3dV
        9pgJdGC9a+Xhqb2QL8yav4UVcA==
X-Google-Smtp-Source: ADUXVKJ0qWBkBc5IbtTtngdZ9oAvVrS3QdjXTZquqG/91BQucEKy9oKq5QGY7b4nGUzkL+j4t0xNyw==
X-Received: by 2002:a1c:9e95:: with SMTP id h143-v6mr425762wme.105.1528814732565;
        Tue, 12 Jun 2018 07:45:32 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:6506:4f49:e430:ddb9? ([2001:41d0:fe90:b800:6506:4f49:e430:ddb9])
        by smtp.googlemail.com with ESMTPSA id l69-v6sm1176261wma.45.2018.06.12.07.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 07:45:31 -0700 (PDT)
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
 <20180612142301.GR12217@hirez.programming.kicks-ass.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4e0eb5c6-adff-37d9-c58e-f526d51720e5@linaro.org>
Date:   Tue, 12 Jun 2018 16:45:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612142301.GR12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 16:23, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 02:00:11PM +0200, Daniel Lezcano wrote:
>> +static void idle_injection_last_man(struct idle_injection_device *ii_dev)
>> +{
>> +	unsigned int run_duration_ms;
>> +
>> +	run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
>> +	if (run_duration_ms) {
>> +		hrtimer_start(&ii_dev->timer, ms_to_ktime(run_duration_ms),
>> +			      HRTIMER_MODE_REL_PINNED);
> 
> What's the point of PINNED here? AFAICT this gets called from a
> different CPU every time.

Right, I will remove it.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

