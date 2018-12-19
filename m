Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1875C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2D221871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOqDD1Ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeLSFov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 00:44:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45406 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLSFou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 00:44:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so8948316plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 21:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gbA93Ti3Kq/BfEmCryXdmghZPymeM+aE195+KRbYLXk=;
        b=fOqDD1Ps2KzdnzpIVbR69qz7SLevWdN/AG+HCwzuswgYidlx/46aPPqQLJm0INk/t2
         yAE/4a0oq+WLAq8AGhwFP4k64dXEH/FlzbHNIq0DfPhT8RxfyiCKEMbgp5daO4skEAqZ
         PpNng121zXNwypAnSJArQr+hZK0cQT045oSYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gbA93Ti3Kq/BfEmCryXdmghZPymeM+aE195+KRbYLXk=;
        b=D2dq3t71WQSpQD3VC/cYHMXv4UXjaxuyc1dxcdhmsTWw0ba6+NdHlRtFqbqjEEwHcD
         tm1HX1aDxuW/NZb/v/aOnt0RT1hOgZXgFwf4GqnwMycpBFVUVI9pydgxhfnx0x2m5Q2d
         dtzIEUIF/s0aky7JEMN49gmr3uuV9WkjqqXrsn8bMO1ECC+I9m8XyqeYFuo3Rok+AuMH
         vCJ/opl+5cLnDUZC5dTuJ7usi+r37poYD5w5wHr4JYa/WSmJ9z/inThWq3wX7/f1qMJu
         tfeLEAkw84bIgsk7gkmDrBXVwx5z11RQ6GFw49QUYEcCRvPNVX8ds6ryBvjk9+WA0EMf
         JiIA==
X-Gm-Message-State: AA+aEWYOjlaPbn4WnGMW0/ZPfWdrnZp4jDVZh8HFmkxW6fmZrBsqSYJM
        KVDnqANsX+q1iNYlk0yZnIMJVg==
X-Google-Smtp-Source: AFSGD/XQOcUzRGd6gMFl0Z9P4/as1CKcRff2UaOlXJ5ooS5RgbuQXGLWfDRYpDLUi72P5Ip0y9/IMw==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr19356961plb.312.1545198290001;
        Tue, 18 Dec 2018 21:44:50 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id q1sm24291143pfb.96.2018.12.18.21.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 21:44:48 -0800 (PST)
Date:   Wed, 19 Dec 2018 11:14:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181219054442.ffkyv6bcmrlkgcga@vireshk-i7>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-3-git-send-email-tdas@codeaurora.org>
 <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
 <20181213100506.sy3haqjbxtmkthvt@vireshk-i7>
 <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com>
 <20181218054545.k77jh5lxvmj2zott@vireshk-i7>
 <154516038159.238328.2917665370794230521@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154516038159.238328.2917665370794230521@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-12-18, 11:13, Stephen Boyd wrote:
> I don't see any failure returned from cpufreq_dt's cpufreq_init()
> function. Maybe put a static int counter = 0 and then fail
> cpufreq_init() the second time that it's called for the same policy
> pointer? I have a system with two policies, so I made it fail and return
> -EINVAL when the counter == 2 and I see the lockdep splat.

Yuck. You were so clear on this earlier, how can I forget it. :(

Here is the additional diff. And I do get this print message on my screen while
I try to online CPU4.

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 639feca22d27..b836e93fd87d 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -151,6 +151,11 @@ static int cpufreq_init(struct cpufreq_policy *policy)
        const char *name;
        int ret;
 
+       if (policy->count++) {
+               pr_info("%s: %d\n", __func__, __LINE__);
+               return -EINVAL;
+       }
+
        cpu_dev = get_cpu_device(policy->cpu);
        if (!cpu_dev) {
                pr_err("failed to get cpu%d device\n", policy->cpu);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 882a9b9e34bc..643141a2013f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -151,6 +151,7 @@ struct cpufreq_policy {
 
        /* For cpufreq driver's internal use */
        void                    *driver_data;
+       int                     count;
 };

> I did the following:
> 
>   grep . /sys/devices/system/cpu/cpufreq/*/* >/dev/null
>   echo 0 > /sys/devices/system/cpu/cpu4/online 
>   echo 0 > /sys/devices/system/cpu/cpu5/online 
>   echo 0 > /sys/devices/system/cpu/cpu6/online 
>   echo 0 > /sys/devices/system/cpu/cpu7/online 
>   echo 1 > /sys/devices/system/cpu/cpu4/online 
>   dmesg
> 
> And boom, lockdep splat.

  502  grep . /sys/devices/system/cpu/cpufreq/*/*
  503  echo 0 > /sys/devices/system/cpu/cpu4/online
  504  echo 0 > /sys/devices/system/cpu/cpu5/online
  505  echo 0 > /sys/devices/system/cpu/cpu6/online
  506  echo 0 > /sys/devices/system/cpu/cpu7/online
  507  grep . /sys/devices/system/cpu/cpufreq/*/*
  508  echo 1 > /sys/devices/system/cpu/cpu4/online
  509  dmesg 


But still no lockdep :(

Can you try that on mainline as well ?

-- 
viresh
