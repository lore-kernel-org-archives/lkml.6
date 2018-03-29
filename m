Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeC2NmM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:42:12 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32945 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbeC2NmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:42:10 -0400
X-Google-Smtp-Source: AIpwx489/A4BX+iQlGWrPuKqh/zV+z82yLBWCq8JV5p6zjlEQ3sKNBlMtlrlv87abt9qxSE/H1Dlkw==
Subject: Re: [PATCH v1] hwmon, via-cputem: support new centaur CPUs
To: David Wang <davidwang@zhaoxin.com>, jdelvare@suse.com,
        tglx@linutronix.de, mingo@redhat.com, rjw@rjwysocki.net,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: brucechang@via-alliance.com, cooperyan@zhaoxin.com,
        qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, lukelin@viacpu.com,
        timguo@zhaoxin.com
References: <1522305403-21009-1-git-send-email-davidwang@zhaoxin.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7fd20afd-ef30-5a25-7fd2-b5f7f60b5a1f@roeck-us.net>
Date: Thu, 29 Mar 2018 06:42:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522305403-21009-1-git-send-email-davidwang@zhaoxin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/2018 11:36 PM, David Wang wrote:
> Newer centaur CPUs(Family == 7) also support this cpu temperature sensor.
> 
> Signed-off-by: David Wang <davidwang@zhaoxin.com>
> ---

FWIW, this would be v2, not v1, and a changelog would be appreciated.

>   drivers/hwmon/via-cputemp.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
> index 07a0cb0..2f5bd50 100644
> --- a/drivers/hwmon/via-cputemp.c
> +++ b/drivers/hwmon/via-cputemp.c
> @@ -136,6 +136,11 @@ static int via_cputemp_probe(struct platform_device *pdev)
>   	data->id = pdev->id;
>   	data->name = "via_cputemp";
>   
> +	if (c->x86 == 7) {
> +		data->msr_temp = 0x1423;
> +		goto test_access;
> +	}

Please rework to not require a goto. Something like

	if (c->x86 == 7) {
		data->msr_temp = 0x1423;
	} else switch (c->x86_model) {
		...
	}

should do.

Thanks,
Guenter

> +
>   	switch (c->x86_model) {
>   	case 0xA:
>   		/* C7 A */
> @@ -152,6 +157,7 @@ static int via_cputemp_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   
> +test_access:
>   	/* test if we can access the TEMPERATURE MSR */
>   	err = rdmsr_safe_on_cpu(data->id, data->msr_temp, &eax, &edx);
>   	if (err) {
> @@ -283,6 +289,7 @@ static int via_cputemp_down_prep(unsigned int cpu)
>   	{ X86_VENDOR_CENTAUR, 6, 0xa, }, /* C7 A */
>   	{ X86_VENDOR_CENTAUR, 6, 0xd, }, /* C7 D */
>   	{ X86_VENDOR_CENTAUR, 6, 0xf, }, /* Nano */
> +	{ X86_VENDOR_CENTAUR, 7, X86_MODEL_ANY, },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(x86cpu, cputemp_ids);
> 
