Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF9AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013AB206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBRaxsB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013AB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632794AbeKXCtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:49:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39920 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632780AbeKXCtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:49:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so4861587wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lqnu5Frd50dYQ31+ZaN+a9DUcihrXq8ePCw8ZaQxYCI=;
        b=QBRaxsB1Cbw3nPbm5eHsbSDTXQ4anQkIGlYw/M1IH8nD+CBM9wG5FQsBvQMSwQh4yk
         4DbCcK7q+niM4bHRxL3TgJTtC2Znb2jeXz3WB/otF23vvbumGoDsNz4+ZPyRuMnL9UDP
         4OXolBt/Qx4SJnJV+P3SA4/nK/S6mqhz9m/pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lqnu5Frd50dYQ31+ZaN+a9DUcihrXq8ePCw8ZaQxYCI=;
        b=k0nrFj+0IIcdyS7YNvw28vO/zEgo4His9ZRqFPZYxjU8ki8y0T/a9xip7P4j3YXPqN
         MUtsbsiDA/yaVL4+9neeY3iv6Q22BVx6az8hwr0WdDkSWJatPoJfJDypCg9T9oQHS0vG
         I50y+EZaYTh7RYkieVIwtHuTsBi6w3m9MfL5U5+Cic/AYOrB7mRS3Cn2xvjs4i/elLWi
         zUG/oU6tVRBtwkTK0LJTALAzQtNIDPagU00FQp82lUV7P5JYxUOF/gRPdG+j1rd2wveo
         EA672LwHyVX9RnV11fcApgpl6GTFhLymOxKMSMfit+KhJa+u0PnU9qTXnSWFTYPSqVmE
         VuQA==
X-Gm-Message-State: AA+aEWbZZGxJck8yxTNBAXXsz8wU+IY2WTCm29ocGjq4aIAUKl89Dj7g
        fIg0Ztte4dAsffb1jygbV+6g0PwcjSg=
X-Google-Smtp-Source: AFSGD/W215yRUoS/lZ3FyemPJz47l/9Ny/yJ0y6ChhW8W9YIMMEiELymCCXHvZ55ifWVzvZ4RLgWTQ==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr15790672wrn.185.1542989061847;
        Fri, 23 Nov 2018 08:04:21 -0800 (PST)
Received: from [192.168.0.40] (33.181.88.92.rev.sfr.net. [92.88.181.33])
        by smtp.googlemail.com with ESMTPSA id e190sm10638546wmf.0.2018.11.23.08.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 08:04:20 -0800 (PST)
Subject: Re: [PATCH 2/4] base/drivers/arch_topology: Replace mutex with
 READ_ONCE / WRITE_ONCE
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     rjw@rjwysocki.net, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <1540830201-2947-2-git-send-email-daniel.lezcano@linaro.org>
 <20181123135807.GA14964@e107155-lin>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9cea4556-15f8-9377-305a-b629ba7e811f@linaro.org>
Date:   Fri, 23 Nov 2018 17:04:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181123135807.GA14964@e107155-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2018 14:58, Sudeep Holla wrote:
> On Mon, Oct 29, 2018 at 05:23:18PM +0100, Daniel Lezcano wrote:
>> The mutex protects a per_cpu variable access. The potential race can
>> happen only when the cpufreq governor module is loaded and at the same
>> time the cpu capacity is changed in the sysfs.
>>
> 
> I wonder if we really need that sysfs entry to be writable. For some
> reason, I had assumed it's read only, obviously it's not. I prefer to
> make it RO if there's no strong reason other than debug purposes.

Are you suggesting to remove the READ_ONCE/WRITE_ONCE patch and set the
sysfs file read-only ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

