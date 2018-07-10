Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B6FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AB920854
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbjTv3Ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AB920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934444AbeGJQIt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:08:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51677 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934339AbeGJQIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:08:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so25254065wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9QnRfKa1nYBmy/xNm4RXIbYUvdUGreEmVbcza66JLUI=;
        b=WbjTv3Iej2/ay4QUzYDcUYj+8QyT+EnQgm/9DDSoIQ+Z5urZQR02H8J7IYloe8Z+/T
         yJhg3ZcK5k1+7FVJ1SaKUeor2PCLVQYp3DdWstn/htcRCgmTHw/YACWAEP6JDFI9/Q2Q
         jDrxZNtcR1wJeDrDYwqKxktQHO80gZAgfku9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9QnRfKa1nYBmy/xNm4RXIbYUvdUGreEmVbcza66JLUI=;
        b=gvHei97v76vexV56fMkKyI1GLy43z8WiLdj3sP2yU+VXM/OAL+qsdCTrDGzn0X/p2a
         ihId1NMFiweRYOBbrVEBYJZrCD5E6vfdadG1TqV5xBtOGqjgMRBBjtlU44iN8PYPDqYF
         9YCl0MOdaqVmNBMn0K9WMYylTbQhsAXl5n+Q6f380up4YHnXotecCbMV7FcJkLJ4pl6g
         vRXHzqOlb0iha0TCBzABHjWuuVxK2NT25/nNG4GjZN3cvcgeiQyaoGKHZKF3vwsQZVTN
         Ixd7NLNJZQHnaVKfbPPb7q67BQX+kOGPoRjGgm9VVOKlpHMhDuw29Q3re7/S8zloGdg1
         h56g==
X-Gm-Message-State: APt69E0uEIkHo6oyM2IKcbYIXe7HidJEdZlayKj1j2tCB9VXqfRCyrj2
        Z+Ha0MW+GoV2mp+ANOLKQzrH/RFXz0c=
X-Google-Smtp-Source: AAOMgpfwPKE7WJ3TsGBEFyUlb3IsLesderFscasg0kVlnDBUnNzWeDjg0dfVoGXNmijWXIwO6LP7fg==
X-Received: by 2002:a1c:3743:: with SMTP id e64-v6mr14983569wma.63.1531238927537;
        Tue, 10 Jul 2018 09:08:47 -0700 (PDT)
Received: from [192.168.8.101] ([37.173.49.80])
        by smtp.googlemail.com with ESMTPSA id m17-v6sm27165801wrg.65.2018.07.10.09.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 09:08:46 -0700 (PDT)
Subject: Re: [PATCH] sched/core: Remove useless hrtimer_active check
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
References: <1529416963-20271-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <de66301c-8c03-6dba-1ab9-c9a9f556c66a@linaro.org>
Date:   Tue, 10 Jul 2018 18:08:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529416963-20271-1-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2018 16:02, Daniel Lezcano wrote:
> The function tick_clear() checks if the timer is active and in this case
> cancels the timer. However, hrtimer_cancel does the same check.
> 
> Perhaps, this test is made on purpose to skip some function calls for
> efficiency reasons but if it is not the case we can safely remove it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  kernel/sched/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d155518..aa46aa6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -218,8 +218,7 @@ void update_rq_clock(struct rq *rq)
>  
>  static void hrtick_clear(struct rq *rq)
>  {
> -	if (hrtimer_active(&rq->hrtick_timer))
> -		hrtimer_cancel(&rq->hrtick_timer);
> +	hrtimer_cancel(&rq->hrtick_timer);
>  }
>  
>  /*

May be not the patch of the century but just a gentle bump if it was
lost by more important patchset review.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

