Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EE8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6680214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l5WauJmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfAHXe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:34:27 -0500
Received: from mail-vs1-f47.google.com ([209.85.217.47]:41685 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAHXe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:34:27 -0500
Received: by mail-vs1-f47.google.com with SMTP id t17so3617178vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRx1RhxbFePmxF8jGRhippvFmr/2UK33Auq8vyV3bpk=;
        b=l5WauJmtOGndUGTPr0rIPOwpJhDgqrt+4/McNfMiBV5YJbBHTUj//NpPazxYtnqAkI
         N283Uv41JLe6N3pP9oIeg38Nd02Fr63P8K+8Uw/Q5aId+xmCFCrMfRSY5rTZaKpz7bQr
         xcT8gUBDWjkX5KUWNJNFsE/bj6PyIMvXO5EaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRx1RhxbFePmxF8jGRhippvFmr/2UK33Auq8vyV3bpk=;
        b=E8TeOdI318PnQBl3JCnV8VfeyI4FtuhWQxfN2obGU+TzjJBDUymqqUV4hjD6YLNP38
         RQ2I3sSBumpNQC6K9OX5j2UwyOFhXKzoGlCRKvz4U+WJeNaCogIQy/DL7dbFicuR8FlL
         Y0hVt04VXbeGGbFW1XxKH7727GW3tAVLlqYAuRnRe24pvayJptsV/bevZHmHzxMKmC+c
         aBVRPy0FqKyALd4eg+PVUqwthOLzTm1VL/RWROiTpndKJFgcjz7thrOVNGy90THTRVRx
         3zRmTTn9o7wnVcInGy/THGsyqo/6kwxj/No442lL8vHd8Cls7UGbEhmTcDjKm260Qm+Q
         Q7yQ==
X-Gm-Message-State: AJcUukekIQ4NcqkXrFSqvUP8nLe0iGFaKWGUA9YDI4+eqtrjjjXeHCUv
        /zw+YcbiJr1k26RXIH8kdju80igKEOI=
X-Google-Smtp-Source: ALg8bN6cRoScgDvLNuUfryvbW7Nk6Yf6yxBo1wfliUEgdx6/bi8KWo3jdlzhAwS0+Ua4YQYc0D5u+g==
X-Received: by 2002:a67:6204:: with SMTP id w4mr1616481vsb.68.1546990465695;
        Tue, 08 Jan 2019 15:34:25 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id l10sm33227360vkl.54.2019.01.08.15.34.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:34:24 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id h78so3629315vsi.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:34:24 -0800 (PST)
X-Received: by 2002:a67:208:: with SMTP id 8mr1592718vsc.48.1546990464127;
 Tue, 08 Jan 2019 15:34:24 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jKUP9o-ZgW5Wa5-9DHeQNZ5VA3cLBCJ0P7AVkTQ5tqHtQ@mail.gmail.com>
 <CAPcyv4iZZEM3D8vta_sge7a4iMgPZ5a1AnunXa4DKUaWauZk1g@mail.gmail.com>
In-Reply-To: <CAPcyv4iZZEM3D8vta_sge7a4iMgPZ5a1AnunXa4DKUaWauZk1g@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 15:34:12 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+z_yRPgE0HO=Sjo_VwwDDPJ+VLxbxwKgbb2cUAB5jmwg@mail.gmail.com>
Message-ID: <CAGXu5j+z_yRPgE0HO=Sjo_VwwDDPJ+VLxbxwKgbb2cUAB5jmwg@mail.gmail.com>
Subject: Re: nvdimm crash at boot
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 3:28 PM Dan Williams <dan.j.williams@intel.com> wrote:
> Ah, thanks for the report! The key difference is that you don't define
> a "label area", so the driver bails out early and never initializes
> the security state.
>
> This should fix it up.
>
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index 4890310df874..636cdb06ee17 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -514,7 +514,7 @@ static umode_t nvdimm_visible(struct kobject
> *kobj, struct attribute *a, int n)
>
>         if (a != &dev_attr_security.attr)
>                 return a->mode;
> -       if (nvdimm->sec.state < 0)
> +       if (!nvdimm->sec.ops || nvdimm->sec.state < 0)
>                 return 0;
>         /* Are there any state mutation ops? */
>         if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable

Okay, cool. I wasn't sure if that test needed a deeper check. :)

Fixes: 37833fb7989a9 ("acpi/nfit, libnvdimm: Add freeze security
support to Intel nvdimm")
Tested-by: Kees Cook <keescook@chromium.org>

Thanks!

-- 
Kees Cook
