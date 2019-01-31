Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8785AC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CBA20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfAaBka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:40:30 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:59558 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfAaBka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 20:40:30 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from sneezy.aussec.com (sneezy.aussec.com [172.16.0.4])
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTP id x0V1eDLw014110;
        Thu, 31 Jan 2019 12:40:18 +1100
Received: from 1.132.106.237 ([1.132.106.237]) by www.aussec.com (Horde
 Framework) with HTTP; Thu, 31 Jan 2019 12:40:08 +1100
Message-ID: <20190131124008.64023l78rw406lfc@www.aussec.com>
Date:   Thu, 31 Jan 2019 12:40:08 +1100
From:   tom burkart <tom@aussec.com>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [PATCH v14 0/3] PPS: pps-gpio PPS ECHO implementation
References: <20190129124357.17396k708szaibbx@www.aussec.com>
 <7abdee30-91fb-4d11-52e1-1778e418c7b8@enneenne.com>
In-Reply-To: <7abdee30-91fb-4d11-52e1-1778e418c7b8@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.3.9)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rodolfo Giometti <giometti@enneenne.com>:

> I answered to your message, see here:
Whoops.  I missed it because I am not on the list, sorry.

> https://lkml.org/lkml/2019/1/4/399
------
Subject	Re: [PATCH v14 3/3] pps: pps-gpio pps-echo implementation

> +static void pps_gpio_echo(struct pps_device *pps, int event, void *data)
> +{
> +	/* add_timer() needs to write into info->echo_timer */
> +	struct pps_gpio_device_data *info;
> +
> +	info = data;

Maybe you can write as below and saving two lines and having better  
readability:

struct pps_gpio_device_data *info = data;

-----
Done.  Easy fix.
------

> +	/* fire the timer */
> +	if (info->pps->params.mode & (PPS_ECHOASSERT | PPS_ECHOCLEAR)) {
> +		info->echo_timer.expires = jiffies + info->echo_timeout;
> +		add_timer(&info->echo_timer);
> +	}
> +}

I think is better firing the timer if and only if we set the echo GPIO  
otherwise
it's useless...
------
Later in the patch:
@@ -152,6 +219,11 @@ static int pps_gpio_probe(struct platform_device *pdev)
         data->info.owner = THIS_MODULE;
         snprintf(data->info.name, PPS_MAX_NAME_LEN - 1, "%s.%d",
                  pdev->name, pdev->id);
+       if (data->echo_pin) {
+               data->info.echo = pps_gpio_echo;
+               data->echo_timeout = msecs_to_jiffies(data->echo_active_ms);
+               timer_setup(&data->echo_timer,  
pps_gpio_echo_timer_callback, 0);
+       }

         /* register PPS source */
         pps_default_params = PPS_CAPTUREASSERT | PPS_OFFSETASSERT;

The pps-gpio-echo function only becomes callable when the echo GPIO is  
set hence I felt that the additional check here was superfluous.  Does  
my reasoning make sense?

> and here:
> https://lkml.org/lkml/2019/1/4/398
--------
Subject	Re: [PATCH v14 2/3] dt-bindings: pps: pps-gpio PPS ECHO implementation

I think this patch it's OK but I'm asking to myself if it should be  
merged with
next one... logically it describes what patch 3/3 does so why do we keep them
separated?
-------
I have separated it because scripts/checkpatch.pl insists it needs to  
be separated.

Tom

