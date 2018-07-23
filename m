Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28034ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5CB20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVvRq0wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5CB20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbeGWMRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:17:51 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39322 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbeGWMRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:17:51 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so415050oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OYCTsxaZF7BmZZ3qXxvJeLp+BVzAQMyegg69+a9vRTU=;
        b=eVvRq0wz/RLE+KAk2Jwp77izoM02LcTmbWkSTA7c4xVYnoIR51lOvwPPMdGb29GMRX
         D6QA0I43ldAq1zsAvXledKc7+tKDNpqM3DsLIeIa4agCgUCi4ZRHlcnYtbKqpFmnBzGX
         Y/IKuSwccDY6O4sXyDC/F+Ly3NktMcSHJEbRPM/IsXUiS4+T5fICXPlOqkPlr3u2ryFT
         xaIxZ32oFhPM9RsFg/aDVtlFPF3dxEPSfBfLeO0qTbmM31Zbb0bBIxrSpq4+qyBq7REp
         dSZKfGBeUXrIPFcygIhcNg4Kvyc31N79jeliq85pkwSndVuEoNJRyRiPudk7K3QeSon6
         D2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OYCTsxaZF7BmZZ3qXxvJeLp+BVzAQMyegg69+a9vRTU=;
        b=NW4LrDKxBrp2uqe/x/crhGnOHLpdw0rz7manMF49iWSfbXofwz398RtDOdwPTvdKyu
         F1t75GTsE/chfb5wfjid6pNAHy3DUJdnS0y+NRRCjhDk6dvdjpRwaaZ3KI4CRDWGYWT+
         j68xN6zEIDmo9zKOVHXJM8yEH2l9b5t5Kjw/SjZyHaY4guiKCVq7lf2CoZsxjv1cgIrq
         ctu0yy/71qvb6bw07yxOeZS4n2sRH+doZLE6xxeLhV2kBOeftanUikfO6UaqS/tStgoC
         Y/3lOjToMqdSAQrVghwAzdJ/ufvaOotLUSARg8wGltzDFiTNm9RcX6Czip66pqxZ1bNA
         qXnQ==
X-Gm-Message-State: AOUpUlHYPaiV6yhTQUH0yaY1PHogkZkr0aeH6ciiRUGnXb79pEouffIH
        P8f/A6DQowHe5Z/EKbu9kPDFGNrnouBvUk/SgQU+yA==
X-Google-Smtp-Source: AAOMgpeeKrAFB3LjEWnskWVSeuxBABDinVhl45olXN7CfaFtflK8QKhUneZM9ulvkHc+5h7pXXmg0n0MGUj9SyusmVs=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr8698046oih.227.1532344627796;
 Mon, 23 Jul 2018 04:17:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 04:17:07
 -0700 (PDT)
In-Reply-To: <1532035440-7860-1-git-send-email-rishabhb@codeaurora.org>
References: <1532035440-7860-1-git-send-email-rishabhb@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Jul 2018 13:17:07 +0200
X-Google-Sender-Auth: KAnAeCKGTu6-z3r_J7Cvr6tsFIQ
Message-ID: <CAJZ5v0gWqx5Op-Bbg7bAYALCyBPsc=-+homAYj2Q1qd3WsqmDw@mail.gmail.com>
Subject: Re: [PATCH] dd: Invoke one probe retry cycle after every initcall level
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        Vikram Mulukutla <markivx@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:24 PM, Rishabh Bhatnagar
<rishabhb@codeaurora.org> wrote:
> Drivers that are registered at an initcall level may have to
> wait until late_init before the probe deferral mechanism can
> retry their probe functions. It is possible that their
> dependencies were resolved much earlier, in some cases even
> before the next initcall level. Invoke one probe retry cycle
> at every _sync initcall level, allowing these drivers to be
> probed earlier.

Can you please say something about the actual use case this is
expected to address?

> Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/base/dd.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 1435d72..e6a6821 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -224,23 +224,44 @@ void device_unblock_probing(void)
>         driver_deferred_probe_trigger();
>  }
>
> +static void enable_trigger_defer_cycle(void)
> +{
> +       driver_deferred_probe_enable = true;
> +       driver_deferred_probe_trigger();
> +       /*
> +        * Sort as many dependencies as possible before the next initcall
> +        * level
> +        */
> +       flush_work(&deferred_probe_work);
> +}
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
>   * We don't want to get in the way when the bulk of drivers are getting probed.
>   * Instead, this initcall makes sure that deferred probing is delayed until
> - * late_initcall time.
> + * all the registered initcall functions at a particular level are completed.
> + * This function is invoked at every *_initcall_sync level.
>   */
>  static int deferred_probe_initcall(void)
>  {
> -       driver_deferred_probe_enable = true;
> -       driver_deferred_probe_trigger();
> -       /* Sort as many dependencies as possible before exiting initcalls */
> -       flush_work(&deferred_probe_work);
> +       enable_trigger_defer_cycle();
> +       driver_deferred_probe_enable = false;
> +       return 0;
> +}
> +arch_initcall_sync(deferred_probe_initcall);
> +subsys_initcall_sync(deferred_probe_initcall);
> +fs_initcall_sync(deferred_probe_initcall);
> +device_initcall_sync(deferred_probe_initcall);
> +
> +static int deferred_probe_enable_fn(void)
> +{
> +       /* Enable deferred probing for all time */
> +       enable_trigger_defer_cycle();
>         initcalls_done = true;
>         return 0;
>  }
> -late_initcall(deferred_probe_initcall);
> +late_initcall(deferred_probe_enable_fn);
>
>  /**
>   * device_is_bound() - Check if device is bound to a driver
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
