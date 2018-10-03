Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E74C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E0D20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E0D20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJCQQu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:16:50 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48704 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeJCQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:16:50 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 24c3cb921fe4d6f1; Wed, 3 Oct 2018 11:29:13 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ronald =?ISO-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc:     Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI/sbs: Fix GPE storm on recent MacBookPro's.
Date:   Wed, 03 Oct 2018 11:26:13 +0200
Message-ID: <3586570.iHchT2WdI2@aspire.rjw.lan>
In-Reply-To: <20181001025251.GA9069@innovation.ch>
References: <20181001025251.GA9069@innovation.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 1, 2018 4:52:51 AM CEST Ronald Tschalär wrote:
> On Apple machines, plugging-in or unplugging the power triggers a GPE
> for the EC. Since these machines expose an SBS device, this GPE ends
> up triggering the acpi_sbs_callback(). This in turn tries to get the
> status of the SBS charger. However, on MBP13,* and MBP14,* machines,
> performing the smbus-read operation to get the charger's status triggers
> the EC's GPE again. The result is an endless re-triggering and handling
> of that GPE, consuming significant CPU resources (> 50% in irq).
> 
> In the end this is quite similar to commit 3031cddea633 (ACPI / SBS:
> Don't assume the existence of an SBS charger), except that on the above
> machines a status of all 1's is returned. And like there, we just want
> ignore the charger here.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=198169
> CC: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> ---
>  drivers/acpi/sbs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index 295b59271189..96c5e27967f4 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -441,9 +441,13 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
>  
>  	/*
>  	 * The spec requires that bit 4 always be 1. If it's not set, assume
> -	 * that the implementation doesn't support an SBS charger
> +	 * that the implementation doesn't support an SBS charger.
> +	 *
> +	 * And on some MacBooks a status of 0xffff is always returned, no
> +	 * matter whether the charger is plugged in or not, which is also
> +	 * wrong, so ignore the SBS charger for those too.
>  	 */
> -	if (!((status >> 4) & 0x1))
> +	if (!((status >> 4) & 0x1) || status == 0xffff)
>  		return -ENODEV;
>  
>  	sbs->charger_present = (status >> 15) & 0x1;
> 

Applied, thanks!


