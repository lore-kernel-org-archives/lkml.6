Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeDJUOZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:14:25 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42291 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbeDJUOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:14:23 -0400
X-Google-Smtp-Source: AIpwx4+I1lYlmGpQ+RxX3v1yLOX6dyWj4+gKW3sMP0iC90sP2tUklF442NkHmooTnN1PkXIfbVehvA==
Date: Tue, 10 Apr 2018 13:14:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (scmi) handle absence of few types of sensors
Message-ID: <20180410201419.GA27759@roeck-us.net>
References: <1523028647-21849-1-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523028647-21849-1-git-send-email-sudeep.holla@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 04:30:47PM +0100, Sudeep Holla wrote:
> Currently the loop checks for non-zero count of sensors for each type
> of sensors which is completely wrong. It also results in aborting the
> registration of sensors if one or more types of sensors are completely
> not supported by the platform SCMI firmware.
> 
> This patch fixes the issue by continue to loop and skiping sensor types
> that are not present.
> 
> Fixes: b23688aefb8b ("hwmon: add support for sensors exported via ARM SCMI")
> Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/scmi-hwmon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index 363bf56eb0f2..91976b6ca300 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -170,7 +170,10 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>  	scmi_chip_info.info = ptr_scmi_ci;
>  	chip_info = &scmi_chip_info;
>  
> -	for (type = 0; type < hwmon_max && nr_count[type]; type++) {
> +	for (type = 0; type < hwmon_max; type++) {
> +		if (!nr_count[type])
> +			continue;
> +
>  		scmi_hwmon_add_chan_info(scmi_hwmon_chan, dev, nr_count[type],
>  					 type, hwmon_attributes[type]);
>  		*ptr_scmi_ci++ = scmi_hwmon_chan++;
> -- 
> 2.7.4
> 
