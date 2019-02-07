Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EAEC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8960320863
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfBGQVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:21:41 -0500
Received: from foss.arm.com ([217.140.101.70]:39770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfBGQVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:21:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3543A78;
        Thu,  7 Feb 2019 08:21:40 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A3233F675;
        Thu,  7 Feb 2019 08:21:40 -0800 (PST)
Subject: Re: [PATCH] ACPI/PPTT: Add acpi_pptt_warn_missing() to consolidate
 logs
To:     John Garry <john.garry@huawei.com>, rjw@rjwysocki.net,
        lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1549556061-107418-1-git-send-email-john.garry@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <05990286-4b66-2879-f066-b4ab558f7385@arm.com>
Date:   Thu, 7 Feb 2019 10:21:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549556061-107418-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/7/19 10:14 AM, John Garry wrote:
> For a system using ACPI-based FW without a PPTT, we may get many warnings
> about the lack of a PPTT, as shown:
> 
> root@(none)$ dmesg | grep -i pptt
> [    0.010125] ACPI PPTT: No PPTT table found, cpu topology may be inaccurate
> [    7.138339] ACPI PPTT: No PPTT table found, cache topology may be inaccurate
> [    7.145368] ACPI PPTT: No PPTT table found, cache topology may be inaccurate
> 
> These logs are generated with pr_warn_once(), so the intention was for a
> single log, but the logs overlap, so consolidate them.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index da031b1df6f5..ad31c50de3be 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -451,6 +451,11 @@ static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_ta
>   	return cpu;
>   }
>   
> +static void acpi_pptt_warn_missing(void)
> +{
> +	pr_warn_once("No PPTT table found, cpu and cache topology may be inaccurate\n");
> +}
> +
>   /**
>    * topology_get_acpi_cpu_tag() - Find a unique topology value for a feature
>    * @table: Pointer to the head of the PPTT table
> @@ -498,7 +503,7 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
>   
>   	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
>   	if (ACPI_FAILURE(status)) {
> -		pr_warn_once("No PPTT table found, cpu topology may be inaccurate\n");
> +		acpi_pptt_warn_missing();
>   		return -ENOENT;
>   	}
>   	retval = topology_get_acpi_cpu_tag(table, cpu, level, flag);
> @@ -531,7 +536,7 @@ int acpi_find_last_cache_level(unsigned int cpu)
>   	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>   	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
>   	if (ACPI_FAILURE(status)) {
> -		pr_warn_once("No PPTT table found, cache topology may be inaccurate\n");
> +		acpi_pptt_warn_missing();
>   	} else {
>   		number_of_levels = acpi_find_cache_levels(table, acpi_cpu_id);
>   		acpi_put_table(table);
> @@ -563,7 +568,7 @@ int cache_setup_acpi(unsigned int cpu)
>   
>   	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
>   	if (ACPI_FAILURE(status)) {
> -		pr_warn_once("No PPTT table found, cache topology may be inaccurate\n");
> +		acpi_pptt_warn_missing();
>   		return -ENOENT;
>   	}
>   
> @@ -617,7 +622,7 @@ int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
>   
>   	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
>   	if (ACPI_FAILURE(status)) {
> -		pr_warn_once("No PPTT table found, topology may be inaccurate\n");
> +		acpi_pptt_warn_missing();
>   		return -ENOENT;
>   	}
>   
> 

This all looks fine to me,

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks!
