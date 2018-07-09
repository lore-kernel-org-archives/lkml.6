Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB45EC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7546E20854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7546E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbeGIJrz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:47:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61708 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932225AbeGIJry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:47:54 -0400
Received: from 79.184.255.246.ipv4.supernova.orange.pl (79.184.255.246) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id d373c44df46e5a45; Mon, 9 Jul 2018 11:47:52 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: save NVS memory for ASUS 1025C laptop
Date:   Mon, 09 Jul 2018 11:46:23 +0200
Message-ID: <3003662.PMZt7LD2T1@aspire.rjw.lan>
In-Reply-To: <1531059617-19681-1-git-send-email-w@1wt.eu>
References: <1531059617-19681-1-git-send-email-w@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, July 8, 2018 4:20:17 PM CEST Willy Tarreau wrote:
> Every time I tried to upgrade my laptop from 3.10.x to 4.x I faced an
> issue by which the fan would run at full speed upon resume. Bisecting
> it showed me the issue was introduced in 3.17 by commit 821d6f0359b0
> (ACPI / sleep: Do not save NVS for new machines to accelerate S3). This
> code only affects machines built starting as of 2012, but this Asus
> 1025C laptop was made in 2012 and apparently needs the NVS data to be
> saved, otherwise the CPU's thermal state is not properly reported on
> resume and the fan runs at full speed upon resume.
> 
> Here's a very simple way to check if such a machine is affected :
> 
>   # cat /sys/class/thermal/thermal_zone0/temp
>   55000
> 
>   ( now suspend, wait one second and resume )
> 
>   # cat /sys/class/thermal/thermal_zone0/temp
>   0
> 
>   (and after ~15 seconds the fan starts to spin)
> 
> Let's apply the same quirk as commit cbc00c13 (ACPI: save NVS memory
> for Lenovo G50-45) and reuse the function it provides. Note that this
> commit was already backported to 4.9.x but not 4.4.x.
> 
> Cc: <stable@vger.kernel.org> # 3.17+: requires cbc00c13
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Please resend this one with a CC to linux-acpi@vger.kernel.org

> ---
>  drivers/acpi/sleep.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 974e584..af54d7b 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -338,6 +338,14 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "K54HR"),
>  		},
>  	},
> +	{
> +	.callback = init_nvs_save_s3,
> +	.ident = "Asus 1025C",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "1025C"),
> +		},
> +	},
>  	/*
>  	 * https://bugzilla.kernel.org/show_bug.cgi?id=189431
>  	 * Lenovo G50-45 is a platform later than 2012, but needs nvs memory
> 


