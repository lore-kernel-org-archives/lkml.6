Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53B9C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D19120868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NUHb0k3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D19120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeLHLNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 06:13:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45078 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeLHLNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 06:13:30 -0500
Received: from zn.tnic (p200300EC2BDEA700C0511CCA78411630.dip0.t-ipconnect.de [IPv6:2003:ec:2bde:a700:c051:1cca:7841:1630])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20D1B1EC08EA;
        Sat,  8 Dec 2018 12:13:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544267608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nc348Quwlk+7q7Hfpg+sF30DWIgUcjXoRtz52k2hQcs=;
        b=NUHb0k3u3c6Tq2HRGBQZMhvTQccl/AWCaKDcUFQ7qJzwl9XjtA+XsaFOUW9eD5HH3VI/1x
        tP7DVV33HudRBsebTIfBOKUEJiR3S9Fr1OIPFYnxxqyytJEUcodEzM8fPtyfdgPsAeSTtJ
        EUeKsOE8MLxvWGpokbHLrqUaGPVmIcs=
Date:   Sat, 8 Dec 2018 12:13:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     clemens@ladisch.de, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] hwmon/k10temp: Add Hygon Dhyana support
Message-ID: <20181208111325.GC30399@zn.tnic>
References: <1544250808-20462-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1544250808-20462-1-git-send-email-puwen@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> -- 

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
