Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5410ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D9A20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D9A20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbeGSLjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:39:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49742 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbeGSLjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:39:39 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id ce2a2a5a777a517c; Thu, 19 Jul 2018 12:57:01 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Lucas Magasweran <lucas.magasweran@ieee.org>
Cc:     linux-acpi@vger.kernel.org,
        Alexey Starikovskiy <astarikovskiy@suse.de>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: battery: remove redundant old_present check on insertion
Date:   Thu, 19 Jul 2018 12:55:21 +0200
Message-ID: <4448104.DkuDPgeVpq@aspire.rjw.lan>
In-Reply-To: <1531608019-5785-1-git-send-email-lucas.magasweran@ieee.org>
References: <1531608019-5785-1-git-send-email-lucas.magasweran@ieee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, July 15, 2018 12:40:18 AM CEST Lucas Magasweran wrote:
> From: Lucas Rangit Magasweran <lucas.magasweran@ieee.org>
> 
> On removal battery_present changes from 1 to 0 after calling
> acpi_battery_get_statu() and battery->update_time is set to 0
> before returning.
> 
> On insertion battery_present changes from 0 to 1 after calling
> acpi_battery_get_status() and acpi_battery_get_info() is called
> because battery->update_time is 0.
> 
> The old_present condition is therefore redundant.
> 
> This was added in the commit below when there was a path without
> sysfs that would skip getting the newly inserted battery info.
> 
> commit 50b178512b7d ("Newly inserted battery might differ from one
> just removed, so update of battery info fields is required.")
> 
> Signed-off-by: Lucas Rangit Magasweran <lucas.magasweran@ieee.org>
> ---
>  drivers/acpi/battery.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index f88bc9f..c280e8e 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -918,10 +918,11 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
>  
>  static int acpi_battery_update(struct acpi_battery *battery, bool resume)
>  {
> -	int result, old_present = acpi_battery_present(battery);
> -	result = acpi_battery_get_status(battery);
> +	int result = acpi_battery_get_status(battery);
> +
>  	if (result)
>  		return result;
> +
>  	if (!acpi_battery_present(battery)) {
>  		sysfs_remove_battery(battery);
>  		battery->update_time = 0;
> @@ -931,8 +932,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
>  	if (resume)
>  		return 0;
>  
> -	if (!battery->update_time ||
> -	    old_present != acpi_battery_present(battery)) {
> +	if (!battery->update_time) {
>  		result = acpi_battery_get_info(battery);
>  		if (result)
>  			return result;
> 

Applied, thanks!


