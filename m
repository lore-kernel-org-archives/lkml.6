Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1643BC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B292082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLiznEMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B292082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeLHP4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:56:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45769 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeLHP4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:56:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so3332587pfd.12;
        Sat, 08 Dec 2018 07:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I4ypepzJm6LWBy4LTt3QSU3bjCCgIwOoGIbEnoULCFU=;
        b=ZLiznEMtzxTUB2HFx1mhDTQVR1UkIMcZV00GPLFEp4XnhVxlzSgzyZpRFd8WUDoEjD
         AXmde5P8ukipy573kVH6sjyPdIGFIiUFHcgiL0FSjLhtnTezKWqWfIH99Wx2kkKEZe/W
         Iv9NduPuZNwK36YdAc0ggUp+zB4+1dZ0TzvwQvLp/935niXRW5LpAZsKenWhE9Qxhhpc
         L6OEgv824Zro3ge5Dq3QvLMHPD6yS+DXbhNPsG5QDdrMC6tprJbg82AuhDhHaIa84nIL
         F7k4xbDAG46clDeaQaJ/VBAXKi/ivAm+1fIs9gMGFll6Pf1w1WuZUonYpcz0K0gyyQ0C
         xiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I4ypepzJm6LWBy4LTt3QSU3bjCCgIwOoGIbEnoULCFU=;
        b=Sm3SKuQz+ct4jOpjKOT9SKIV4k0DAOW6jRSr9uHmfHU1eOGfCTH2AAs2fmWbxWh5T6
         87P2N5um6oEYmZFQmW2K5O3q4dc1wAzIdStIqSqSZsZyrV4gpssBdnd3GIIv6DCmy22/
         Tqer/IXOKyhdGqoQoniwiJ2AWXZFkmCLWJST4mkyaG00JRI4mHZvSYl46/02eMu8a30o
         EAkuqei1ET1+54lKxavY1Qrks0OxtfLzMKzJRcwlCNtDlUkxCCZEaSf0yAzJ9KTlnVLv
         vvNic88ScsJ+ziQtOzVWHFG6+RCaiOVUBDzsyJ0cqpQ27zeVJE0wbQTt4dDc9iGuZMCt
         1sog==
X-Gm-Message-State: AA+aEWZDvLLuUJC69qMZRAeEiWjqBe8HTMnhwXWoH/idNsM1NvSUPU+h
        oOsnZubQ17GfI5h+lTfNcXS/nRrJ
X-Google-Smtp-Source: AFSGD/VYh/WNiXEyQmgxxwBsXX4Tz2EuKKJjhCxOT2F5hPsX880VSBOv/fXEAbi5GRGW3wRH/fNEfQ==
X-Received: by 2002:a62:ed0f:: with SMTP id u15mr6126538pfh.188.1544284561212;
        Sat, 08 Dec 2018 07:56:01 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w88sm15191455pfk.11.2018.12.08.07.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 07:56:00 -0800 (PST)
Date:   Sat, 8 Dec 2018 07:55:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Pu Wen <puwen@hygon.cn>
Cc:     clemens@ladisch.de, jdelvare@suse.com, bp@alien8.de,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] hwmon/k10temp: Add Hygon Dhyana support
Message-ID: <20181208155559.GA27489@roeck-us.net>
References: <1544250808-20462-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544250808-20462-1-git-send-email-puwen@hygon.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 02:33:28PM +0800, Pu Wen wrote:
> Add support for Hygon Dhyana family 18h processor for k10temp to get the
> temperature. As Hygon Dhyana shares the same function interface with AMD
> family 17h, so add Hygon PCI Vendor ID and reuse the code path of AMD.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> Acked-by: Borislav Petkov <bp@suse.de>

Applied to hwmon-next.

If the Hygon CPUs have Tctl/Tdie temperature offsets similar to some
of the AMD CPUs, please submit follow-up patches as necessary to add
support for it.

Thanks,
Guenter

> ---
>  drivers/hwmon/k10temp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 2cef0c3..e24ba10 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -330,7 +330,7 @@ static int k10temp_probe(struct pci_dev *pdev,
>  	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {
>  		data->read_htcreg = read_htcreg_nb_f15;
>  		data->read_tempreg = read_tempreg_nb_f15;
> -	} else if (boot_cpu_data.x86 == 0x17) {
> +	} else if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
>  		data->temp_adjust_mask = 0x80000;
>  		data->read_tempreg = read_tempreg_nb_f17;
>  		data->show_tdie = true;
> @@ -367,6 +367,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
> +	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, k10temp_id_table);
