Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5739C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD752146D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jfOza/y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD752146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeKPL5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 06:57:08 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41464 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeKPL5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 06:57:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id 14so9173622eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 17:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1d/Ov0KgkCUrjBDPPbvOaMNElyatVG7XFcjcuFOBZIs=;
        b=jfOza/y1D5gfvP15XyxUAx+CawgByFEb7YLMT20Q7WcHwaJ1myxAChfNA11JN+3AKS
         iouyQqnYi5CaMUtNnp0Gm9SF3vJ3yu/n0R/ncXhvOcGwfuprEGoMBucyxJZEHNWCvZz5
         GoIBea/eHINZQUgUjnnAV/2KZNHoIbuKwGnWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1d/Ov0KgkCUrjBDPPbvOaMNElyatVG7XFcjcuFOBZIs=;
        b=sp62GUJKgspq4S0l26TmlwzK9ANxL6mNhd4nF/Ne9lnW4rR/eFdPj0UGmriSuhN+yu
         nWhhPIXLPQqdQhsEDzUkcwruVY0gSw5BkFVKb15yZfiHh6q8VSrl0Mgza4a3YQPnGdvI
         BQXpckA49KZxslivdWP4MY+au1HKLzXOU23TK8zqckuDl+cZD84ysBJ1GNVYe/VSRTBe
         SYnSGwVoLt960S31GLDP8weEswBAK7zhJxaHdTxDksAbIFnrdMrPjkJlLuwST9ZB0pDx
         pSTqT+mSphzbXrFgrmyTi/EgHm7+k54KNL0MNR50aec3pJ+G7c8QOWSncOzUewBN8qaY
         AwZw==
X-Gm-Message-State: AGRZ1gLnTiCLsgOqF992BfOM9j1Qz93qmyt2AIa5aLKqlutmIBcJwfBH
        IMCXhtIVi/lm/UEjhL7SvkjS/d5MsUI=
X-Google-Smtp-Source: AJdET5cAHLaJqVAKhF6BFSFQ/9cG71Hi9ElzRLs9kJQihjNgwfJZfMxorJxBrb5OJw949ogfiXQtqQ==
X-Received: by 2002:a17:906:5a0a:: with SMTP id p10-v6mr7262246ejq.43.1542332803048;
        Thu, 15 Nov 2018 17:46:43 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id z44-v6sm7480462ede.11.2018.11.15.17.46.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 17:46:42 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id b14so15809661edt.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 17:46:42 -0800 (PST)
X-Received: by 2002:a17:906:6011:: with SMTP id o17-v6mr7151641ejj.237.1542332801870;
 Thu, 15 Nov 2018 17:46:41 -0800 (PST)
MIME-Version: 1.0
References: <20181114122029.16766-1-kraxel@redhat.com>
In-Reply-To: <20181114122029.16766-1-kraxel@redhat.com>
From:   Gurchetan Singh <gurchetansingh@chromium.org>
Date:   Thu, 15 Nov 2018 17:46:30 -0800
X-Gmail-Original-Message-ID: <CAAfnVBmhpMDi8EVUNZxWTU38ZWoO61eyG1-=bRqoe3hoQ08E0A@mail.gmail.com>
Message-ID: <CAAfnVBmhpMDi8EVUNZxWTU38ZWoO61eyG1-=bRqoe3hoQ08E0A@mail.gmail.com>
Subject: Re: [PATCH] udmabuf: set read/write flag when exporting
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>
Tested-by: Gurchetan Singh <gurchetansingh@chromium.org>
On Wed, Nov 14, 2018 at 4:20 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Otherwise, mmap fails when done with PROT_WRITE.
>
> Suggested-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/dma-buf/udmabuf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index e70328ab7e..d9ff246093 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -189,6 +189,7 @@ static long udmabuf_create(const struct udmabuf_create_list *head,
>         exp_info.ops  = &udmabuf_ops;
>         exp_info.size = ubuf->pagecount << PAGE_SHIFT;
>         exp_info.priv = ubuf;
> +       exp_info.flags = O_RDWR;
>
>         buf = dma_buf_export(&exp_info);
>         if (IS_ERR(buf)) {
> --
> 2.9.3
>
