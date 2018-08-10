Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58075C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA17223BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA17223BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeHKAHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:07:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45178 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeHKAHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:07:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id f12-v6so9386885wrv.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZDkSp3LHI32pBKHfkVPGStUp6D5cxqxrXe2b0Y6x95A=;
        b=NUe6Um9/csqvYV1ubc5DLs2IOEJNQylm8IwUjhqH7yKED2+tiu1oS/uKv88ji/NDOV
         N/bgyZlq1P1xzx1X0FDlIMdrPz14STfIy9nIRJLTMLGE21ENsrReYzM/DVyH0aSs4rqB
         iB9z78OlSEGevg2T+8Tg81DEar3PR84/hIw+EFxaP3k8VWJufKXWqPzTnDYz0WK7r7eR
         DlgRodHxX0CxVl5ph6RX13qrfsFUWhuNsP4opftM9SZl4sgnVA/OwX3cFQo4MAsMJPd9
         tfKN8w9IcTgr+df7GD7nWN+oawj/p2P847RjTgoUm7WCkIXOf4RyWLO+8lqQ9ChlfF1e
         Uovw==
X-Gm-Message-State: AOUpUlF0IQ2MY9j4qa34DA17CgwiM7YiB2syzHL6X4XvbN+rqtyajPVR
        Uk966U188OCaPrkc3YKSK9w1b827disRoWqH7NXbkg==
X-Google-Smtp-Source: AA+uWPwgBiyKbX3TpZazuw7NqYxbhoZ4/0whx+C5KWMDXpL0B89imXzX5K7ft4+vEEi2LcmS939jSydkqC45SCt7lq4=
X-Received: by 2002:a5d:4e92:: with SMTP id e18-v6mr5467109wru.32.1533936931070;
 Fri, 10 Aug 2018 14:35:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c2:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 14:35:30
 -0700 (PDT)
In-Reply-To: <20180807203914.2192-7-lyude@redhat.com>
References: <20180807203914.2192-1-lyude@redhat.com> <20180807203914.2192-7-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 10 Aug 2018 23:35:30 +0200
Message-ID: <CACO55tskxMiK9PhA8kE04Z=7bZb04rCv6YPGgq-9QUPBpnqW6A@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v5 06/13] drm/nouveau: Call optimus_dsm
 functions after nouveau_do_suspend()
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Tue, Aug 7, 2018 at 10:39 PM, Lyude Paul <lyude@redhat.com> wrote:
> It's not necessary to call these before we call nouveau_do_suspend().
> Ideally; we shouldn't have to call this at all here, but getting that to
> work will take a bit more effort. So for the time being, just move this
> call after nouveau_do_suspend() to allow us to easily be able to abort
> the runtime suspend process in nouveau_do_suspend()
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Karol Herbst <karolherbst@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 04f704b77a3c..5ea8fe992484 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -833,8 +833,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>                 return -EBUSY;
>         }
>
> -       nouveau_switcheroo_optimus_dsm();
>         ret = nouveau_do_suspend(drm_dev, true);
> +       nouveau_switcheroo_optimus_dsm();
>         pci_save_state(pdev);
>         pci_disable_device(pdev);
>         pci_ignore_hotplug(pdev);
> --
> 2.17.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
