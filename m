Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F87C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B671E2684F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B671E2684F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeFZJ4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:56:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55250 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeFZJ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:56:33 -0400
Received: from 79.184.255.183.ipv4.supernova.orange.pl (79.184.255.183) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 95538d121b07fdc1; Tue, 26 Jun 2018 11:56:31 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     lenb@kernel.org, ravisadineni@google.com,
        dmitry.torokhov@gmail.com, tbroch@google.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rajatja@google.com, bleung@google.com, furquan@chromium.org
Subject: Re: [PATCH V2] ACPI LID: increment wakeup count only when notified.
Date:   Tue, 26 Jun 2018 11:55:15 +0200
Message-ID: <2352530.ePvj7nqZEq@aspire.rjw.lan>
In-Reply-To: <20180611175759.181681-1-ravisadineni@chromium.org>
References: <CAJZ5v0gXqyKQ5yTtqFYzv=KW2o+b4vGiUYiWWn+iT=zY-mU9xw@mail.gmail.com> <20180611175759.181681-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 11, 2018 7:57:59 PM CEST Ravi Chandra Sadineni wrote:
> Currently ACPI LID increments wakeup count irrespective of the wake source.

What exactly does the above mean?

> This is because we call acpi_lid_initialize_state on every resume.

I guess "because acpi_lid_initialize_state() is called on every system
resume and it triggers acpi_lid_notify_state() which invokes
acpi_pm_wakeup_event() for the lid device, the lid's wakeup count is
incremented even if the lid was not the source of the event that woke up
the system", right?

> Userland deamons using wakeup_count to identify the potential wake
> source for the last wake will be thrown off by this.

Something like: "That behavior confuses user space deamons using
wakeup_count to identify the potential system wakeup source."

> Instead increment
> the wakeup count only when there is a FIXED_HARDWARE/NOTFIY_STATUS event.

So "to avoid that confusion, only trigger acpi_pm_wakeup_event() in the
acpi_button_notify() path and don't do that in the acpi_lid_initialize_state()
path."

> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
>  V2: Increment the wakeup count only when the lid is open.
> 
>  drivers/acpi/button.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 2345a5ee2dbbc..d2fe03e4faf05 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -235,9 +235,6 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
>  		button->last_time = ktime_get();
>  	}
>  
> -	if (state)
> -		acpi_pm_wakeup_event(&device->dev);
> -
>  	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
>  	if (ret == NOTIFY_DONE)
>  		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
> @@ -366,7 +363,8 @@ int acpi_lid_open(void)
>  }
>  EXPORT_SYMBOL(acpi_lid_open);
>  
> -static int acpi_lid_update_state(struct acpi_device *device)
> +static int acpi_lid_update_state(struct acpi_device *device,
> +				 bool is_notification)

Please rename "is_notification" to "signal_wakeup" or similar.

>  {
>  	int state;
>  
> @@ -374,6 +372,9 @@ static int acpi_lid_update_state(struct acpi_device *device)
>  	if (state < 0)
>  		return state;
>  
> +	if (state && is_notification)
> +		acpi_pm_wakeup_event(&device->dev);
> +
>  	return acpi_lid_notify_state(device, state);
>  }
>  
> @@ -384,7 +385,7 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
>  		(void)acpi_lid_notify_state(device, 1);
>  		break;
>  	case ACPI_BUTTON_LID_INIT_METHOD:
> -		(void)acpi_lid_update_state(device);
> +		(void)acpi_lid_update_state(device, false);
>  		break;
>  	case ACPI_BUTTON_LID_INIT_IGNORE:
>  	default:
> @@ -409,7 +410,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>  			users = button->input->users;
>  			mutex_unlock(&button->input->mutex);
>  			if (users)
> -				acpi_lid_update_state(device);
> +				acpi_lid_update_state(device, true);
>  		} else {
>  			int keycode;
>  
> 


