Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3CAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463012085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463012085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJJSaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:30:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36058 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJSaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:30:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so5258616wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 04:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pSF9EnqH6FMUKODkCMkGIbU9b/BrO4h5WOurFwb5FW8=;
        b=Rw8sbKkK+q/+VXnWJ/Wil8Opt8r/B3A9DD1LCT0QjKkCmfZKg3HQs7qfS6aFcVz4ys
         CYblTCsZCyzS94WGvocB+EJ7JOs+dt8Astbyhf/2+iPYIQ87+IUnNC2gjZwhwVcx2Gsz
         W+WkU415YROsq7UVQ7VV3CTqIXf5Wj2OLJw4HVJ7qBpkrOlL1g4oIybZiAmOoy5ip5U1
         CDfW99EAQYYLE1tDNkdwrh8RMReMBeTANaZJ6yALjq9UCKltTC5Xr/tWPtH8uGv0WLJc
         ICB6nLz0Sa5/S6spUtPXOhualvUD8nJfji2nKOzj15IC485JTouO7sf6in3kODfhtG6R
         k/yQ==
X-Gm-Message-State: ABuFfoiOoKmSrKk+ACc7pw9M5NT7SZpawCGJAh42cklpt8ZkLCvFawll
        stHClNT19ehpMMR68yKn0npcgaNzJBc=
X-Google-Smtp-Source: ACcGV61tgC8F+rUjHEZF3ATDetoeh7S5A0ukqPVgWls48LA5GWD8UTNWQYM+o5dWqiL3ZzAoEWq9Cw==
X-Received: by 2002:a1c:2746:: with SMTP id n67-v6mr496791wmn.116.1539169711942;
        Wed, 10 Oct 2018 04:08:31 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id n11-v6sm28322761wra.26.2018.10.10.04.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 04:08:31 -0700 (PDT)
Subject: Re: [PATCH] usb: roles: intel_xhci: Fix Unbalanced pm_runtime_enable
To:     wan.ahmad.zainie.wan.mohamad@intel.com, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1539060767-12858-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c45ddc5d-a57d-cba5-7239-e1ae736c67ad@redhat.com>
Date:   Wed, 10 Oct 2018 13:08:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1539060767-12858-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09-10-18 06:52, wan.ahmad.zainie.wan.mohamad@intel.com wrote:
> From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> 
> Add missing pm_runtime_disable() to remove(), in order to avoid
> an Unbalanced pm_runtime_enable when the module is removed and
> re-probed.
> 
> Error log:
> root@intel-corei7-64:~# modprobe -r intel_xhci_usb_role_switch
> root@intel-corei7-64:~# modprobe intel_xhci_usb_role_switch
> intel_xhci_usb_sw intel_xhci_usb_sw: Unbalanced pm_runtime_enable!
> 
> Fixes: cb2968468605 (usb: roles: intel_xhci: Enable runtime PM)
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

Thank you for the patch, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/usb/roles/intel-xhci-usb-role-switch.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> index 1fb3dd0f1dfa..277de96181f9 100644
> --- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
> +++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> @@ -161,6 +161,8 @@ static int intel_xhci_usb_remove(struct platform_device *pdev)
>   {
>   	struct intel_xhci_usb_data *data = platform_get_drvdata(pdev);
>   
> +	pm_runtime_disable(&pdev->dev);
> +
>   	usb_role_switch_unregister(data->role_sw);
>   	return 0;
>   }
> 
