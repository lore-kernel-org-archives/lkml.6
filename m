Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB587C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBF023D3D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBF023D3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeGDKke (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:40:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50489 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932399AbeGDKkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:40:33 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id ad63a7152df4bc8e; Wed, 4 Jul 2018 12:40:31 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     lenb@kernel.org, ravisadineni@google.com,
        dmitry.torokhov@gmail.com, tbroch@google.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rajatja@google.com, bleung@google.com, furquan@chromium.org
Subject: Re: [PATCH V3] ACPI LID: increment wakeup count only when notified.
Date:   Wed, 04 Jul 2018 12:39:08 +0200
Message-ID: <1749498.FF42dzjKYz@aspire.rjw.lan>
In-Reply-To: <20180627175502.178725-1-ravisadineni@chromium.org>
References: <2352530.ePvj7nqZEq@aspire.rjw.lan> <20180627175502.178725-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 27, 2018 7:55:02 PM CEST Ravi Chandra Sadineni wrote:
> Because acpi_lid_initialize_state() is called on every system
> resume and it triggers acpi_lid_notify_state() which invokes
> acpi_pm_wakeup_event() for the lid device, the lid's wakeup count is
> incremented even if the lid was not the source of the event that woke up
> the system. That behavior confuses user space deamons using
> wakeup_count to identify the potential system wakeup source. To avoid
> the confusion, only trigger acpi_pm_wakeup_event() in the
> acpi_button_notify() path and don't do that in the
> acpi_lid_initialize_state() path.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
>  v3:  Change is_notification to signal_wakeup
>  V2: Increment the wakeup count only when the lid is open.
> 
>  drivers/acpi/button.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 2345a5ee2dbbc..40ed3ec9fc94c 100644
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
> +				 bool signal_wakeup)
>  {
>  	int state;
>  
> @@ -374,6 +372,9 @@ static int acpi_lid_update_state(struct acpi_device *device)
>  	if (state < 0)
>  		return state;
>  
> +	if (state && signal_wakeup)
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

Applied, thanks!


