Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6745FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F00A20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNXzP5XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F00A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeJCTxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:53:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34622 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeJCTxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:53:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id z4-v6so6061007wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 06:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yzWhglJwDwDoF4dy32MfWIQEKiw1LR/riwsf0+Snlv4=;
        b=bNXzP5XDuBFiafdtYXdCzePTVNkxY7LWU8bZFXOzzW8shMqtqO5YVid7E7MKyzbhIX
         d9bBxN3ponzQENK6v/RQHj3c3tCUGdxN2x8dj81msBKeDhVRQHQ+TXDtBs7ow96xCW+n
         cxlG0AEEMtPGTjDv3YrlqPowp1pUJ1H590eF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yzWhglJwDwDoF4dy32MfWIQEKiw1LR/riwsf0+Snlv4=;
        b=EEXlkfukXJKpATvLe8qR5lOsun+dDDe1vbQc7heL42u9HJfz7LBS/1JOKgLhQwE2jp
         ovHQTwokHW9rIdoGT/mdxk++bHynlSKO1evuQvJQ8t9sYkSgS9tDE+jz9bf2Sibnr3E3
         X1lsao0FetyhizEWvr/UL8aC9ncBH9USv8//Sx6QV5NzErAALDfodgouKkuZgvk6yBOZ
         g0oddGcC2opLx15qipbYCXLlDcia3vu9zA1aZyZRhC415sxPAsWJNOJBRJsG03lImN0+
         5tyt2tUCANPkSD8qDDFUOBU/HKbZMce23w7FGW3WSA6ecSHCRMfZQhObeH4eC0pQJkF9
         MsVQ==
X-Gm-Message-State: ABuFfojSKQ1Pmm5ZFAA5PpZnGYriBJJsgr++JRp3eUg1t8dQSXp7HVSu
        dGx5nUOuFDfeJG2BuGvkLDfrbQ==
X-Google-Smtp-Source: ACcGV60TY4IGpL3S6VKDUlqetRnXqMybpr2+UTz+uydNm6m+Ubk9uKWGHQDYCInlourYA3TXU0WGyg==
X-Received: by 2002:adf:e48e:: with SMTP id i14-v6mr1252303wrm.145.1538571917084;
        Wed, 03 Oct 2018 06:05:17 -0700 (PDT)
Received: from [192.168.0.41] (84.152.136.77.rev.sfr.net. [77.136.152.84])
        by smtp.googlemail.com with ESMTPSA id v16-v6sm2094070wrw.12.2018.10.03.06.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:05:16 -0700 (PDT)
Subject: Re: [PATCH RFC] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@android.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>
References: <1537868328-13405-1-git-send-email-daniel.lezcano@linaro.org>
 <4200780.ZjVhNjpZ67@aspire.rjw.lan>
 <ab561a7d-9425-7b04-8d11-ed3e85afe971@linaro.org>
 <CAJZ5v0iRMvhZ1rW40syPRJfYBZ4=zE2-f4HcKaRQsvg18pnTcw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ba6c1dfe-d4ce-c697-3b44-992946cd5c4a@linaro.org>
Date:   Wed, 3 Oct 2018 15:05:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iRMvhZ1rW40syPRJfYBZ4=zE2-f4HcKaRQsvg18pnTcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2018 13:09, Rafael J. Wysocki wrote:
> On Wed, Oct 3, 2018 at 12:25 PM Daniel Lezcano

[ ... ]

> If you send a non-RFC patch to drop get_loadavg() (but you can drop it
> altogether then, there are no other callers of it AFAICS), I'll queue
> it up after the 4.20 (or whatever it turns out to be in the end) merge
> window so all of the CIs out there have a chance to report issues (if
> any).

Sure, I can do that. There were some changes in this file, shall I base
the patch on v4.19-rc6 or linux-pm/linux-next ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

