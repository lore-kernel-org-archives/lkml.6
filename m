Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CD2C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DE62098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DE62098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeJEQrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:47:05 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50008 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeJEQrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:47:04 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id f735022c6936a5c4; Fri, 5 Oct 2018 11:49:04 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rajneesh.bhardwaj@intel.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPIT: Register attributes based on FADT
Date:   Fri, 05 Oct 2018 11:46:01 +0200
Message-ID: <2363635.PV2ruU7bBX@aspire.rjw.lan>
In-Reply-To: <20180928085402.9108-1-rajneesh.bhardwaj@linux.intel.com>
References: <20180928085402.9108-1-rajneesh.bhardwaj@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 28, 2018 10:54:02 AM CEST Rajneesh Bhardwaj wrote:
> ACPI Low Power S0 Idle capabilities are announced via FADT table and can
> be used to inform the kernel about the presence of one or more Low Power
> Idle (LPI) entries as descried in LPIT table. LPIT table can exist
> independently even if the FADT S0 Idle flag is not set and thus it could
> confuse user since the following cpuidle attributes are created.
> 
> /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
> 
> Presence or absence of above attributes could mean that the given
> platform supports S0ix state or not.
> 
> This change allows to create the above cpuidle attributes only if
> FADT table supports Low Power S0 Idle.
> 
> Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpit.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
> index cf4fc0161164..e43cb71b6972 100644
> --- a/drivers/acpi/acpi_lpit.c
> +++ b/drivers/acpi/acpi_lpit.c
> @@ -117,11 +117,17 @@ static void lpit_update_residency(struct lpit_residency_info *info,
>  		if (!info->iomem_addr)
>  			return;
>  
> +		if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> +			return;
> +
>  		/* Silently fail, if cpuidle attribute group is not present */
>  		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
>  					&dev_attr_low_power_idle_system_residency_us.attr,
>  					"cpuidle");
>  	} else if (info->gaddr.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
> +		if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> +			return;
> +
>  		/* Silently fail, if cpuidle attribute group is not present */
>  		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
>  					&dev_attr_low_power_idle_cpu_residency_us.attr,
> 

Applied, thanks!


