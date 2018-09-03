Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8881DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E2C2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E2C2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ladisch.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbeICWI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:08:29 -0400
Received: from webclient5.webclient5.de ([136.243.32.184]:46422 "EHLO
        webclient5.webclient5.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeICWI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:08:28 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Sep 2018 18:08:27 EDT
Received: from olorin.ladisch.de (x2f7f94d.dyn.telefonica.de [2.247.249.77])
        by webclient5.webclient5.de (Postfix) with ESMTPSA id AE65655837FE;
        Mon,  3 Sep 2018 19:39:30 +0200 (CEST)
Subject: Re: [PATCH] hwmon: (k10temp) Support all Family 15h Model 6xh and
 Model 7xh processors
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Guglielmo Fanini <g.fanini@gmail.com>
References: <1535933820-23767-1-git-send-email-linux@roeck-us.net>
From:   Clemens Ladisch <clemens@ladisch.de>
Message-ID: <2b23f0d3-25cb-3bc2-949f-fdf1633d5245@ladisch.de>
Date:   Mon, 3 Sep 2018 19:38:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1535933820-23767-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.4 at webclient5
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck wrote:
> BIOS developer guides refer to Family 15h Models 60h-6fh and Family 15h
> Models 70h-7fh. So far the driver only checked for Modela 60h and 70h.
> However, there are now processors with other model numbers in the same
> family. Example is A10-9620P family 15h model 65h. Follow the developer
> guides and mask the lower 4 bit of the model number to determine the
> registers to use for reading temperatures and temperature limits.
>
> Reported-by: Guglielmo Fanini <g.fanini@gmail.com>
> Cc: Guglielmo Fanini <g.fanini@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  drivers/hwmon/k10temp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index bb15d7816a29..2cef0c37ff6f 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -325,8 +325,9 @@ static int k10temp_probe(struct pci_dev *pdev,
>
>  	data->pdev = pdev;
>
> -	if (boot_cpu_data.x86 == 0x15 && (boot_cpu_data.x86_model == 0x60 ||
> -					  boot_cpu_data.x86_model == 0x70)) {
> +	if (boot_cpu_data.x86 == 0x15 &&
> +	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
> +	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {
>  		data->read_htcreg = read_htcreg_nb_f15;
>  		data->read_tempreg = read_tempreg_nb_f15;
>  	} else if (boot_cpu_data.x86 == 0x17) {
