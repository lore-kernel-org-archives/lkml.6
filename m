Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A97DECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EFC20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EFC20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbeGSLj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:39:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64794 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbeGSLjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:39:25 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 5ea6e0ac09da68a2; Thu, 19 Jul 2018 12:56:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Lucas Magasweran <lucas.magasweran@ieee.org>
Cc:     linux-acpi@vger.kernel.org,
        Vladimir Lebedev <vladimir.p.lebedev@intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: battery: use cache_time as cache "enabled"
Date:   Thu, 19 Jul 2018 12:55:08 +0200
Message-ID: <10585866.b9VflrVt2K@aspire.rjw.lan>
In-Reply-To: <1531607910-4975-1-git-send-email-lucas.magasweran@ieee.org>
References: <1531607910-4975-1-git-send-email-lucas.magasweran@ieee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, July 15, 2018 12:38:29 AM CEST Lucas Magasweran wrote:
> From: Lucas Rangit Magasweran <lucas.magasweran@ieee.org>
> 
> When battery state is not cached the module parameter cache_time is 0
> and battery->update_time starts at 0. However, it set to jiffies in
> each call to acpi_battery_get_state() and should not be used to
> determine if a cache time is used.
> 
> Using battery->update_time causes the evaluation of time_before()
> even though cache_time is 0.
> 
> This is a minor issue as the behavior is still as expected.
> Even if kernel HZ was very slow and jiffies remained equal, the
> expected branch (false) would be taken because time_before() is
> used instead of time_before_eq().
> 
> Signed-off-by: Lucas Rangit Magasweran <lucas.magasweran@ieee.org>
> ---
>  drivers/acpi/battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index d79ad84..f88bc9f 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -549,7 +549,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
>  	if (!acpi_battery_present(battery))
>  		return 0;
>  
> -	if (battery->update_time &&
> +	if (cache_time &&
>  	    time_before(jiffies, battery->update_time +
>  			msecs_to_jiffies(cache_time)))
>  		return 0;
> 

Applied, thanks!


