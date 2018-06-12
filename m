Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 43C3FC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE9E208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xq0rOqKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE9E208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934005AbeFLOqd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:46:33 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36252 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932919AbeFLOqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:46:31 -0400
Received: by mail-wr0-f194.google.com with SMTP id f16-v6so24404892wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q8KufmPCcckCzGDMMYcnlvuCXG038JVgN80xASDUSfQ=;
        b=Xq0rOqKWyfVXQxOKyskHiHUs4KwPqI7Uow7RG/tAatZ04Q5xmD+Cq08Rk3z48JLhOD
         m8j1/DzFZ3wHZkZrvq3Y/t2qK6RmG/kqJt92m5pqmIcjHlNNeS0H6Aowq8YbZPLds+5W
         Qry532SzqAC6inkjFwbi+Gz7Gf6186vyJA9+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q8KufmPCcckCzGDMMYcnlvuCXG038JVgN80xASDUSfQ=;
        b=Q5HxknKcVA/ASX302htLYboTyRyR5rvl4lgLzkgcZS1KvEtXMxN4IpRA9AfxvmSjhl
         T2xxgh3mmdA7nqCO20tUnRk4DRmuaiQPQ6Hdhtcc35wPqJLZqGAAC7gE0yv9JfNv4ByH
         /iEtycU3w4eDRexlBnc7mIvf6Ja35L9ucIbGULOeVDxVU1xASqW7WG6O9J4CaJdwMwlt
         s1isWfcuDMYmoyuYTMpQC5sexM9WJbXUEuptw2t/do6QEzDu/T/b6L0IhZLz5iZ18OUb
         aruqqa0sDpRS5K3RUbOgPAKuGSn7RmEY+LgwKkDYcIe4suiU0nHzwZK1osbg5wgjusin
         LaqQ==
X-Gm-Message-State: APt69E38jagv1a4EC5era7z7HxGLvzecefaI8uv7phZczgMbK/n5cnQD
        IzObbfOoIAaBcB6+KG7ngvqF4A==
X-Google-Smtp-Source: ADUXVKKY3a9gftIH90Fju6sniHSa/60Gf/CFoBcvRAY4hvcNrYOOGYKIsE0ejob6w24GYNnM7gk3xA==
X-Received: by 2002:adf:87d0:: with SMTP id c16-v6mr542392wrc.246.1528814790673;
        Tue, 12 Jun 2018 07:46:30 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:6506:4f49:e430:ddb9? ([2001:41d0:fe90:b800:6506:4f49:e430:ddb9])
        by smtp.googlemail.com with ESMTPSA id l69-v6sm1179795wma.45.2018.06.12.07.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 07:46:29 -0700 (PDT)
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
 <20180612142647.GS12217@hirez.programming.kicks-ass.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7bfb88b6-166b-ef4f-9a2f-03d122faba6b@linaro.org>
Date:   Tue, 12 Jun 2018 16:46:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612142647.GS12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 16:26, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 02:00:11PM +0200, Daniel Lezcano wrote:
>> +void idle_injection_stop(struct idle_injection_device *ii_dev)
>> +{
>> +	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
>> +		 cpumask_pr_args(ii_dev->cpumask));
>> +
>> +	idle_injection_set_duration(ii_dev, 0, 0);
>> +
>> +	wait_for_completion_interruptible(&ii_dev->stop_complete);
>> +}
> 
> interruptible?

Right, can be removed.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

