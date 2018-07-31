Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6128EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1609E20862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XD5jaAp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1609E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbeGaH5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:57:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34292 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbeGaH5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:57:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id h1-v6so4959449eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 23:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXeY0Mmh3+PtCfD7WNr35JUQOyRpdBQizgin6njUTaw=;
        b=XD5jaAp2KkadGl6ZE/oCAHZi433z3eDPSfynz4+TvcO6GVOMXzJUS685krfvjhKaFZ
         sIpvxJq86TYRIftUkxKIh8jEId3wq8fhzFzrOpUjI3uJGEh1e6PF0+MA4XGwf49TgRw4
         8qZFmXB6F+MsifK6xE3Z/5BKkP7qaiw2bBp1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXeY0Mmh3+PtCfD7WNr35JUQOyRpdBQizgin6njUTaw=;
        b=iRIYu+PIkmCfmc05MHJ1kBk5LgFz8pK+YsqF7sfE2OeYwBwHYm91+x2sZNJx1ILdzj
         JKYgbQLpNnfQBbTBiz+sUOgD68jarECVj9FxgCJb0bwARNnY+GA8lw/aDAmhiO/d0HIZ
         KuUJz5PK8VBtpbXm+kj/FPBnz1n6G4LQrzHrPGZbzFgfErkaENewttjljq6Hdjnffd0L
         CIzOnKCj2C7U4ZoIfgrxdJP4VMLpBnkHs+1cH2VjSO5pzRFFqY6Kv4ipv+mvlTfgj+DE
         WbioK/eXV4wDntubaZ6Z/fu7+nqFFyI/rnPZOqiZsJ/BQKH7badI6dtGAe9xctSy+cAh
         rDVw==
X-Gm-Message-State: AOUpUlGwu0RnMoMSGZIlBG8ThMbIchQMXUsfiU2tu+34O+NZUlhaEwcA
        g0y31OzyYaOir90YgnPxsdSx7kHcCqw=
X-Google-Smtp-Source: AAOMgpccw34o0jd3wDhqCYCBIoY6TZ/xlFNpGw8sPYfEe5yk3dL4KAT+BG4uTWi0k5YdGhIRACjROg==
X-Received: by 2002:a50:e146:: with SMTP id i6-v6mr11014929edl.204.1533017944183;
        Mon, 30 Jul 2018 23:19:04 -0700 (PDT)
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com. [74.125.82.51])
        by smtp.gmail.com with ESMTPSA id m20-v6sm2992921eds.5.2018.07.30.23.19.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 23:19:03 -0700 (PDT)
Received: by mail-wm0-f51.google.com with SMTP id w24-v6so306306wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 23:19:02 -0700 (PDT)
X-Received: by 2002:a1c:c7c1:: with SMTP id x184-v6mr1281665wmf.134.1533017942141;
 Mon, 30 Jul 2018 23:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180729193646.201721-1-toddpoynor@gmail.com> <20180729193646.201721-2-toddpoynor@gmail.com>
In-Reply-To: <20180729193646.201721-2-toddpoynor@gmail.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Mon, 30 Jul 2018 23:18:49 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ-VmW=X-HEFj4PouxUcH6jKqHR_XXhXfrQmx_-CPE_tWQ@mail.gmail.com>
Message-ID: <CAE_wzQ-VmW=X-HEFj4PouxUcH6jKqHR_XXhXfrQmx_-CPE_tWQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] staging: gasket: core: hold reference to pci_dev
 while used
To:     toddpoynor@gmail.com
Cc:     rspringer@google.com, jnjoseph@google.com, benchan@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        toddpoynor@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 12:37 PM Todd Poynor <toddpoynor@gmail.com> wrote:
>
> From: Todd Poynor <toddpoynor@google.com>
>
> Hold a reference on the struct pci_dev while a pointer to it is held in
> the gasket data structures.
>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index 2b484d067c38a..b832a4f529f27 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -488,6 +488,7 @@ static void gasket_free_dev(struct gasket_dev *gasket_dev)
>         internal_desc->devs[gasket_dev->dev_idx] = NULL;
>         mutex_unlock(&internal_desc->mutex);
>         put_device(gasket_dev->dev);
> +       pci_dev_put(gasket_dev->pci_dev);

gasket_free_dev() is called only from driver PCI probe and remove
function. I can assure you that that pci_dev structure is not going
anywhere, there is no need to take this additional reference.

Thanks,
Dmitry
