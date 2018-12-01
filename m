Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52558C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0996B21479
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQHZXmfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0996B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeLBBiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 20:38:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41498 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeLBBiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 20:38:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so4225292plm.8;
        Sat, 01 Dec 2018 06:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gR/8eeDfCw7cpSGlr6uedUsOon5Qs7dhIv3KwdQlB0Q=;
        b=IQHZXmfFP5PryvnE2BN8PTG3UvSiulGtvPuplzYgIXrW2nZ4GFinWSFZuTfuvn3pKT
         oDu+q/vwPJ9d/9OpqesvV/VLcb/R3l+bd8rzOYHkMfdn+eSysSLc17o3puUsm7u95pqY
         U93Uu5ibkxDNGdg87Ol7XcxeceouDiab1L/shYZVO0ly6lx2Day0nMTcb34Gf6VqlnDo
         9gMQVurt647z+ki1ZNOiwvweFSq1pFzjMcdiGEG2U2F+3wB3IeufW1A5/VrDR+1v3D9j
         J2/WaL/RFr13Tuj4hgQZeW61gGaWaQM7lhnB228bRpQ959imJw5UF4gBUxM0v3yI9fa8
         S1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gR/8eeDfCw7cpSGlr6uedUsOon5Qs7dhIv3KwdQlB0Q=;
        b=V4240zO8dfCJv6gzeT0rxI+Ed5kWZ+AI2By4kZ4o5Z+4KBjs+nvpN89KNh9zN6R/U5
         k4fxfwCCSNqbkMa/4xZvoWJA8LTi2CdXeY76zPXzuKpRiGjvaH9QOQaKx3+yZfbHxcN/
         N5F4BR88neXdBzMnieK3eXET0ODSY7OAtvpSJeSktnkR+4TPlslchKc0n3PQm+wjUQLc
         XhkMPe/2dd8/5h9Qy7tjW+kJ0Cgp69lq9iwxvga8Jn8LZalDTA8+3KCiZAHbOA98NF7H
         1XiT0Hcb0yCFQnF7TxUHfxYZQk/29iYB81wYfKsfuYsWavgDyMaApwwNnC0iPtiN4yDW
         E2hw==
X-Gm-Message-State: AA+aEWZ99K1IeSXwIHLA8+eSTpTrHUg7etih/Vh8fvwtV4qpU4XuHgFe
        63lDFTolBHsgIbm1yfR3bxNgRmNS
X-Google-Smtp-Source: AFSGD/W9X2GW2r1TI6SDoSdVofC+Ej8B3YJk1HMwNmV27CwTVPlF3V3vpUuilBMAO8E/EF3xgCU9Wg==
X-Received: by 2002:a17:902:c5:: with SMTP id a63mr9653022pla.267.1543674346956;
        Sat, 01 Dec 2018 06:25:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q187sm41061621pfq.128.2018.12.01.06.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 06:25:45 -0800 (PST)
Subject: Re: [PATCH] watchdog: convert to DEFINE_SHOW_ATTRIBUTE
To:     Yangtao Li <tiny.windzz@gmail.com>, wim@linux-watchdog.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181201101417.6368-1-tiny.windzz@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2b188937-e297-acb4-8c40-bb93ff5bbb76@roeck-us.net>
Date:   Sat, 1 Dec 2018 06:25:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181201101417.6368-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/18 2:14 AM, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

One patch per file, please.

Guenter

> ---
>   drivers/watchdog/bcm_kona_wdt.c | 16 +++-------------
>   drivers/watchdog/ie6xx_wdt.c    | 16 +++-------------
>   2 files changed, 6 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
> index 1462be9e6fc5..4249b47902bd 100644
> --- a/drivers/watchdog/bcm_kona_wdt.c
> +++ b/drivers/watchdog/bcm_kona_wdt.c
> @@ -90,7 +90,7 @@ static int secure_register_read(struct bcm_kona_wdt *wdt, uint32_t offset)
>   
>   #ifdef CONFIG_BCM_KONA_WDT_DEBUG
>   
> -static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
> +static int bcm_kona_show(struct seq_file *s, void *data)
>   {
>   	int ctl_val, cur_val;
>   	unsigned long flags;
> @@ -130,17 +130,7 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
>   	return 0;
>   }
>   
> -static int bcm_kona_dbg_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, bcm_kona_wdt_dbg_show, inode->i_private);
> -}
> -
> -static const struct file_operations bcm_kona_dbg_operations = {
> -	.open		= bcm_kona_dbg_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(bcm_kona);
>   
>   static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
>   {
> @@ -157,7 +147,7 @@ static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
>   		return;
>   
>   	if (debugfs_create_file("info", S_IFREG | S_IRUGO, dir, wdt,
> -				&bcm_kona_dbg_operations))
> +				&bcm_kona_fops))
>   		wdt->debugfs = dir;
>   	else
>   		debugfs_remove_recursive(dir);
> diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
> index 78c2541f5d52..8de9fb1ed371 100644
> --- a/drivers/watchdog/ie6xx_wdt.c
> +++ b/drivers/watchdog/ie6xx_wdt.c
> @@ -193,7 +193,7 @@ static struct watchdog_device ie6xx_wdt_dev = {
>   
>   #ifdef CONFIG_DEBUG_FS
>   
> -static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
> +static int ie6xx_wdt_show(struct seq_file *s, void *unused)
>   {
>   	seq_printf(s, "PV1   = 0x%08x\n",
>   		inl(ie6xx_wdt_data.sch_wdtba + PV1));
> @@ -212,23 +212,13 @@ static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
>   	return 0;
>   }
>   
> -static int ie6xx_wdt_dbg_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ie6xx_wdt_dbg_show, NULL);
> -}
> -
> -static const struct file_operations ie6xx_wdt_dbg_operations = {
> -	.open		= ie6xx_wdt_dbg_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ie6xx_wdt);
>   
>   static void ie6xx_wdt_debugfs_init(void)
>   {
>   	/* /sys/kernel/debug/ie6xx_wdt */
>   	ie6xx_wdt_data.debugfs = debugfs_create_file("ie6xx_wdt",
> -		S_IFREG | S_IRUGO, NULL, NULL, &ie6xx_wdt_dbg_operations);
> +		S_IFREG | S_IRUGO, NULL, NULL, &ie6xx_wdt_fops);
>   }
>   
>   static void ie6xx_wdt_debugfs_exit(void)
> 

