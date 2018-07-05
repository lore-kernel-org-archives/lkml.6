Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E9FC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2A92242B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2A92242B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeGELfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:35:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56351 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753579AbeGELfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:35:37 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id a8127d02eafb2dbe; Thu, 5 Jul 2018 13:35:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Tristian Celestin <tristiancelestin@fastmail.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Default to s2idle in all machines supporting LP S0.
Date:   Thu, 05 Jul 2018 13:34:11 +0200
Message-ID: <3030490.HWdhQ4YSSa@aspire.rjw.lan>
In-Reply-To: <1529052618-370-1-git-send-email-tristiancelestin@fastmail.com>
References: <1529052618-370-1-git-send-email-tristiancelestin@fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 15, 2018 10:50:18 AM CEST Tristian Celestin wrote:
> The Dell Venue Pro 7140 supports the Low Power S0 Idle state, but does not
> support any of the _DSM functions that the current heuristic checks
> for. Since suspend-to-mem can not be safely performed on this machine,
> and since the bitfield check can't cover this case, it is safer
> to enable s2idle by default by checking for the presence of the _DSM
> alone and removing the bitfield check.
> 
> Signed-off-by: Tristian Celestin <tristiancelestin@fastmail.com>
> ---
>  drivers/acpi/sleep.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 974e584..d0ddd4d 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -718,9 +718,6 @@ static int acpi_suspend_begin_old(suspend_state_t pm_state)
>  #define ACPI_LPS0_ENTRY		5
>  #define ACPI_LPS0_EXIT		6
>  
> -#define ACPI_LPS0_SCREEN_MASK	((1 << ACPI_LPS0_SCREEN_OFF) | (1 << ACPI_LPS0_SCREEN_ON))
> -#define ACPI_LPS0_PLATFORM_MASK	((1 << ACPI_LPS0_ENTRY) | (1 << ACPI_LPS0_EXIT))
> -
>  static acpi_handle lps0_device_handle;
>  static guid_t lps0_dsm_guid;
>  static char lps0_dsm_func_mask;
> @@ -924,17 +921,14 @@ static int lps0_device_attach(struct acpi_device *adev,
>  	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
>  		char bitmask = *(char *)out_obj->buffer.pointer;
>  
> -		if ((bitmask & ACPI_LPS0_PLATFORM_MASK) == ACPI_LPS0_PLATFORM_MASK ||
> -		    (bitmask & ACPI_LPS0_SCREEN_MASK) == ACPI_LPS0_SCREEN_MASK) {
> -			lps0_dsm_func_mask = bitmask;
> -			lps0_device_handle = adev->handle;
> -			/*
> -			 * Use suspend-to-idle by default if the default
> -			 * suspend mode was not set from the command line.
> -			 */
> -			if (mem_sleep_default > PM_SUSPEND_MEM)
> -				mem_sleep_current = PM_SUSPEND_TO_IDLE;
> -		}
> +		lps0_dsm_func_mask = bitmask;
> +		lps0_device_handle = adev->handle;
> +		/*
> +		 * Use suspend-to-idle by default if the default
> +		 * suspend mode was not set from the command line.
> +		 */
> +		if (mem_sleep_default > PM_SUSPEND_MEM)
> +			mem_sleep_current = PM_SUSPEND_TO_IDLE;
>  
>  		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
>  				  bitmask);
> 

Applied, thanks!


