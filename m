Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4DFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6A0219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6A0219E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeHFLO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:14:29 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45145 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeHFLO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:14:29 -0400
Received: by mail-qk0-f193.google.com with SMTP id c192-v6so8337495qkg.12;
        Mon, 06 Aug 2018 02:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aAhR4STXYqjO/+LcRVC1qw/9Qh6e3/smxsttZkYecX0=;
        b=n3TBCbW3dPV8MquVZBJgIn0RN4Q3CjeCFnHOivp79qk/yQyhj+mP6MmZzGKYzevvwf
         W9fjBn1oP4QuxtWAT7gidK1whDYRO8YhVF8abVGRveologTGsKLfCFplpo0jsk8aW8rP
         E9v5c6gCWgAxHbmW9cFIwZt89forJd9Zky0Nkb32es2Wc20iRj4wEr8hK2cEchOYK4Bb
         pBLs+1yTF/eNmMgp+2gPhzDacECIfWZY5fd9vfZ7ZihxIg3KXNxhJir+R0EzQrQjIQBO
         TdW1iZxhoQ8yAklvhHEcJcRslUaahaYYfnRV66tV3Z5q5YX4Xvy3YMVq55HfyHXTd6Qc
         oIfg==
X-Gm-Message-State: AOUpUlGQXAm+0ftWtoN7EvtypNUePTyFZYK5/i4nWZuz67jlx8FsKsSu
        tzpBoYrZ/rsIt3+z18oQnw3NsQQySfY2f/OPkDS5lA==
X-Google-Smtp-Source: AAOMgpe6jiaX4FNWO4JOzxckIsL93Y+671MXpaFG8cxStqrPJTJKol431HRXZre+XAHvya6xkj0vzyovqdXtq89dlkM=
X-Received: by 2002:a37:2a65:: with SMTP id q98-v6mr12427702qkh.174.1533546383025;
 Mon, 06 Aug 2018 02:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com> <20180726134056.18273-9-alexandre.belloni@bootlin.com>
In-Reply-To: <20180726134056.18273-9-alexandre.belloni@bootlin.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Aug 2018 11:06:07 +0200
Message-ID: <CAK8P3a121CrinzrXPZ86f=KkK9yfnVHF70MQQYt2VVr-6jCnGQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] rtc: remove struct rtc_task
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 3:42 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Include rtc_task members directly in rtc_timer member.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/interface.c | 8 ++++----
>  include/linux/rtc.h     | 9 ++-------
>  2 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index d0983ed6c842..a962540faf2e 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -912,8 +912,8 @@ void rtc_timer_do_work(struct work_struct *work)
>                 timerqueue_del(&rtc->timerqueue, &timer->node);
>                 trace_rtc_timer_dequeue(timer);
>                 timer->enabled = 0;
> -               if (timer->task.func)
> -                       timer->task.func(timer->task.private_data);
> +               if (timer->func)
> +                       timer->func(timer->private_data);
>
>                 trace_rtc_timer_fired(timer);
>                 /* Re-add/fwd periodic timers */
> @@ -968,8 +968,8 @@ void rtc_timer_init(struct rtc_timer *timer, void (*f)(void *p), void *data)
>  {
>         timerqueue_init(&timer->node);
>         timer->enabled = 0;
> -       timer->task.func = f;
> -       timer->task.private_data = data;
> +       timer->func = f;
> +       timer->private_data = data;
>  }

From what I can see, all remaining users pass the rtc_device pointer as
'private_data', so maybe make that explicit now instead of the void pointer?

      Arnd
