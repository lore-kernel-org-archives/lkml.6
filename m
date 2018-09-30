Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8900FC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 14:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E35A20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 14:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORZhCYbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E35A20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeI3UdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 16:33:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33229 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbeI3UdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 16:33:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so7645584pge.0;
        Sun, 30 Sep 2018 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tEBO+YrSeyX2qSr6vKlEud5u/pB0SW0zhbCxDnJWAUI=;
        b=ORZhCYbM+YJLpUNb47AieWj73RXPmjFnOMbHSPWLEnB+Ia+CVtTP+6dcNdU4qM504e
         r7CsI4snY1gQuO6DwpiaCFY09CGDM961XfVMnFtpoGR1qjvN83hCY/NE+5OJ7dtlArqZ
         D5XHw9gW8W5na3ya6p4RgUZSFVGgehOEA/M0Gn6fpcUmh9prQ5zW1/Wbv1cHzkiA6neZ
         fCzI7gicCJI+P4k8qPUCbafIAn+lbTOhVGNxYnXwnOFjyH7lY2YvaRx7FC3sIEej/n2O
         iJNEGT2YcDpzQJDTH7xg/N6G9utvQrUePJiM8zDZET1RZ8lfN/eD3l3PigFLTpqOFjU/
         iF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tEBO+YrSeyX2qSr6vKlEud5u/pB0SW0zhbCxDnJWAUI=;
        b=jSB9P71RM74ZD3qyEc24a6GSpObXZdJrpxcVXtYoZqbEiGtoClN67HRWQZ1/VylwTl
         0XLVUsPOKvvZ/dn5jFXqVKWrlfWSGGFv8LufuSq4kNeq7U1Hhwb1nLTa7JD5MTpDWC1Y
         WprXheuZEwnh4lWxo5JCaHpzq7Qbkywuv6JBrvArOegD8Ih9k17jLspTpTs9nsuMvwbO
         x0N/lqVTiBu7ApBcxi9cGu63rNWlATS5RlaGGyWj6iew8I9MOJNVzv+1d8POmZr8f51f
         QrCAA5hunWFe4HTG0prsmlxHdip639U2z8ArReRKGWRStkXSN29ptAtV5UsyehqdeK4J
         5SPQ==
X-Gm-Message-State: ABuFfohHOrp4R0vIvUhor08FVwywbCTjv8GJHjrojTRFzEBGlqXdw5iK
        JMzvsisSkEajeqwancvJPkXQZ+fR
X-Google-Smtp-Source: ACcGV61/U00ix0WDwY7fAkL8vagHpuo2AbjR8cdpZuZdQIYOgVFNs0+bN7EGfflAx2b+7xt+j6TgkA==
X-Received: by 2002:a17:902:2:: with SMTP id 2-v6mr7614379pla.178.1538316004101;
        Sun, 30 Sep 2018 07:00:04 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r65-v6sm5098301pfj.5.2018.09.30.07.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 07:00:03 -0700 (PDT)
Subject: Re: [PATCH RT 2/2] watchdog, rt: prevent deferral of watchdogd wakeup
To:     Julia Cartwright <julia@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>
References: <cover.1538089179.git.julia@ni.com>
 <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <51edd05c-a5a2-062f-bbc6-1ca7af81e4d8@roeck-us.net>
Date:   Sun, 30 Sep 2018 07:00:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 02:03 PM, Julia Cartwright wrote:
> When PREEMPT_RT_FULL is enabled, all hrtimer expiry functions are
> deferred for execution into the context of ktimersoftd unless otherwise
> annotated.
> 
> Deferring the expiry of the hrtimer used by the watchdog core, however,
> is a waste, as the callback does nothing but queue a kthread work item
> and wakeup watchdogd.
> 
> It's worst then that, too: the deferral through ktimersoftd also means
> that for correct behavior a user must adjust the scheduling parameters
> of both watchdogd _and_ ktimersoftd, which is unnecessary and has other
> side effects (like causing unrelated expiry functions to execute at
> potentially elevated priority).
> 
> Instead, mark the hrtimer used by the watchdog core as being _HARD to
> allow it's execution directly from hardirq context.  The work done in
> this expiry function is well-bounded and minimal.
> 
> A user still must adjust the scheduling parameters of the watchdogd
> to be correct w.r.t. their application needs.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reported-and-tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Reported-by: Tim Sander <tim@krieglstein.org>
> Signed-off-by: Julia Cartwright <julia@ni.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/watchdog_dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index ffbdc4642ea5..9c2b3e5cebdc 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -945,7 +945,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>   		return -ENODEV;
>   
>   	kthread_init_work(&wd_data->work, watchdog_ping_work);
> -	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
>   	wd_data->timer.function = watchdog_timer_expired;
>   
>   	if (wdd->id == 0) {
> 

