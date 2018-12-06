Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B4AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF853208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnsMRR6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF853208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeLFR5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:57:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38929 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeLFR5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:57:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so537178pfc.6;
        Thu, 06 Dec 2018 09:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OJPXWd4FMJJKZlnPByr1v7NeRv267BCMd1VRhn2UWrc=;
        b=pnsMRR6mUkhVrnnLXvnESTxUz57Ty9MzF+CoQ1fPVRFg5I4Ucf/+F46YWGuP8/rHdx
         ng9qaMqyFqudWvxx8WC29TqghlAE1yhUI1D/jnSNUv95eRpF9cUjiTu35jJI1nk30XhP
         qt3u+rM/38KZu9O+jOXLgGZJjVlBj3KDJJZAalqq8EPba6fjfGGOmwRPj/TQ2CyIunxQ
         rZ74k+6lP4hR+xFTZtbcL3/mzXWc85THj/4c5nPQ2bkr/MoPJtEBQr8oIS0eTbS8Zije
         plneFE4oZlaoRTC+YJ9A8g5FtrZphkIyb6S08mwVNdxJ2Hw76MeCjMqYCZMSUAdOT/rL
         rD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OJPXWd4FMJJKZlnPByr1v7NeRv267BCMd1VRhn2UWrc=;
        b=jXe8Zws75gv8Xx0N12v56oOD3aeH3K2Dj+ATRL7BFTJATRhXsoN7Tz8eRfTnT1o3W5
         sL4yKbF7pOhkBbFvWdcUENauE+7IlyLO88U0wR6z2GDD1JIFUdXH0GBa2FotmMeVhlC8
         i3LFYooelilNpUXk8X52anaojb2+nleRZn188O5IalOjDhwAW8hyNv3bHpZ0J8kUWufL
         dfpnnFvfkDYJ3c7mL/cTyQmjURAQ90b3F6B9Ybz+6eNErkYfz7J0y91rLrnOWg/pdWxx
         WJ+yaP7ezQp0+lOS7XZy4EVSta/9jUhnmRrl6jKvp9shMEfiBauC6IWqhCY6Dv1ZN7dM
         3LJA==
X-Gm-Message-State: AA+aEWZ5adQz2e64abdIBHTylYS6jvGqDoqfsv7UXpxs/XLMpUBiYVL4
        JvXdjgmlJXTERU6UOwvkZec=
X-Google-Smtp-Source: AFSGD/VMu3uPXrP1lLDiF6ej5sDB2izwJjrF+xs3tE09nuG6g/Z0TsE0uy2n58P4Erxi+tqtFH8HGw==
X-Received: by 2002:aa7:85d7:: with SMTP id z23mr30618576pfn.205.1544119050713;
        Thu, 06 Dec 2018 09:57:30 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o84sm1270410pfi.172.2018.12.06.09.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 09:57:29 -0800 (PST)
Date:   Thu, 6 Dec 2018 09:57:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] watchdog/hpwdt: Do not claim unsupported hardware
Message-ID: <20181206175724.GC11808@roeck-us.net>
References: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
 <1544056943-79958-3-git-send-email-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544056943-79958-3-git-send-email-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:42:22PM -0700, Jerry Hoemann wrote:
> Do not claim when SSID 0x0289 as the watchdog features
> are not enabled/validated by the firmware.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/hpwdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index eecd014..c8e8055 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -52,6 +52,7 @@
>  
>  static const struct pci_device_id hpwdt_blacklist[] = {
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3306, PCI_VENDOR_ID_HP, 0x1979) }, /* auxilary iLO */
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3306, PCI_VENDOR_ID_HP_3PAR, 0x0289) },  /* CL */
>  	{0},			/* terminate list */
>  };
>  
> -- 
> 1.8.3.1
> 
