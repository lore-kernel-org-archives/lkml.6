Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B84C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABB22054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIkuTH3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABB22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJXPtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:49:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40213 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbeJXPtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:49:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id o14-v6so1906776pgv.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uacBp3cTQRRb5S23HlKTPfDPWxUxX/RyN5zqK/Bv4mU=;
        b=LIkuTH3Czu+8ofiFb510e64p2ZluQ5murrJbB4Ri/YDfEoJlKMOAreW5dVS6ogCAZM
         0QwCdrBqQsKPO3N4xVmTo1aBhl0MooBgE38ZneqVaeTZKBjS64XpsLYEi01dBhwrQLME
         0zAE2X6OGDvXU2MPEm0XTmgS7tUTgEUTKmsHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uacBp3cTQRRb5S23HlKTPfDPWxUxX/RyN5zqK/Bv4mU=;
        b=GnRRT0XHNjlouKOAvwjF5JNzQ7gzZRhqb2o+2WxB5PGWm/sH8pUb/f+SNvsiZXVe04
         Jgojw65R7LsU9e/bEzuwy1LFeVvwn3iMd0bwEqK4EXwZo8T+4oyRqM0NSgZinYMTEEC1
         QOocKPRsGIAQYc2wv+E2mypXoCqVqR5w9AX14nGUPXF+PDtptE+wi6fwvuzBB6CG3UYS
         EjAUO9AzRH+tR15N7rWY7n2zaCycIZbX16yToP0KMMiVrbADhFGvx2H/bWBdohPTcnq+
         D2bDWd1OJIsk0WXnGcogl8ZepvVz0r2cZNACq5r+JB5nNF8bs1EgL9P0xXsVVvsidJwz
         Hh6w==
X-Gm-Message-State: AGRZ1gJiYJvyBi/p1xrkqBTeH6sbr7xukjj8Oixbv0PbLUtbNezu236w
        0KTkmre2aIcVW9VxTqJnb0OkEA==
X-Google-Smtp-Source: AJdET5eHxPxBfXAj4IkDnnMgeyxvdID9BNuCoY1tGFSBtvzYURoDyh39YwPLgj7/OR8wUFJ3Hb8NZw==
X-Received: by 2002:a62:52cc:: with SMTP id g195-v6mr1566812pfb.241.1540365751905;
        Wed, 24 Oct 2018 00:22:31 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id f10-v6sm3911229pgp.72.2018.10.24.00.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 00:22:30 -0700 (PDT)
Date:   Wed, 24 Oct 2018 12:52:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ross Zwisler <zwisler@google.com>
Cc:     linux-kernel@vger.kernel.org, Ricky Liang <jcliang@chromium.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Stephen Barber <smbarber@chromium.org>
Subject: Re: [PATCH] thermal: add ratelimited thermal and power logging
Message-ID: <20181024072227.achkbix2ndef2ule@vireshk-i7>
References: <20181022202901.1654-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022202901.1654-1-zwisler@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-18, 14:29, Ross Zwisler wrote:
> From: Ricky Liang <jcliang@chromium.org>
> 
> Add thermal logs in devfreq_cooling and cpu_cooling.

Why should we add them ?

> Also add logging to
> power_allocator when it starts to control power.
> 
> These changes can lead to excessive log spam when running up against
> thermal limits, so have this logging ratelimited to allow only 1 log each
> 30 seconds from each of those subsystems.

What's the use of these logs when we are going to print them only once every 30
seconds ?

I recently extended thermal sysfs support to share more stats.

commit 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")

Will that be helpful in your case ?

Otherwise we should probably add trace points instead.

-- 
viresh
