Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65C0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B219E2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tez/Q0XB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfBUOZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:25:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33069 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBUOZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:25:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so898459pfd.0;
        Thu, 21 Feb 2019 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACf3sZZ6JUpwwGnJCICtvZluxz8TE6VNlska+mK+xxg=;
        b=Tez/Q0XB7GLm/fR0cdhhL1SS/QY+qWDbdg7pZpy7j7z6Y+MTcqZXfg4g+JOK3DWh9i
         GKCC6B+NjsUzBROR5vc75ytEa6vBxItoKofX72G2TZxuZ8Bxk411+Ef0YR39aP4WCz6U
         4c/vYxO7excPDlgJkk5Rc8uXsZAy2T1LNvLYgH0/4ZjafdLIoLbscFuGdfWS/wt21IPM
         kCtJLu/DrhHxFlwm25uf17MXSkGu3DvECmWUSnsb0wh0/iMI68iRExFTCa5KW7ODt0c+
         JJv9bKWkPaMCvyve1WudJOIlQROv0oa/pRoNgtMlLzDi7hKx2py5RF0c+sPLp1mnyQIV
         jUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACf3sZZ6JUpwwGnJCICtvZluxz8TE6VNlska+mK+xxg=;
        b=CLtccek+XMgF9ikG0UqFpV+dRFRTMzUQ7o6SdMfsGMXcifPl8327b4GA+h48BrJhUH
         jmDr2GTHprR/aD4nE8WGEwpFHTg7qQIIBgn454ReRlyqq6KjsAknXNUVV5HwzIT8ivsb
         +CSRgwWfaNSwAcsWxFFmsZ35Hwxa2JcTlGfDsjaXKmAPaFzeI0z3N5tjPQphvgS6AYPa
         zHSvn8z2Tfs0IAHuHHBvrgsxSOfXWl6sjBqDeDWU8Y/eykluxxEGCl3Flimk1LZHJfIz
         +zdnhkaklggagkQ+iGqYIMUr7RfgkdtAY2aksaVseWCL354D6vXauOgccYng7FJqY7Ml
         0UTQ==
X-Gm-Message-State: AHQUAuaex8+YNQIdLDbocMFcaJlyHlkjJxVctGMIQ9w/CA76SNxzVpnO
        INS1WmAt/SPorYcK5R+9f4/D32dARLRxRuVnqGU=
X-Google-Smtp-Source: AHgI3Ibo71gn49tOMne7xlvSUSlu+rB2t5KdZeck5UJjIclw5FMPOm6oeu6adnfp+Fr1gAsZP3Hc/H+5KLVlCcdSCNQ=
X-Received: by 2002:a62:864c:: with SMTP id x73mr40782724pfd.49.1550759103168;
 Thu, 21 Feb 2019 06:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20190216001920.178053-1-rajatja@google.com>
In-Reply-To: <20190216001920.178053-1-rajatja@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Feb 2019 16:24:52 +0200
Message-ID: <CAHp75VdHMgfxT-n-4tMqM1pNOH970erGAhajUvg5wUrsf3xH8Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Avoid a u32 overflow
To:     Rajat Jain <rajatja@google.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 2:19 AM Rajat Jain <rajatja@google.com> wrote:
>
> The register (SLP_S0_RES) at offset slp_s0_offset is a 32 bit register.
> The pmc_core_adjust_slp_s0_step() could overflow the u32 value while
> returning it after adjusting the step. Thus change to u64, this is
> already accounted for in debugfs attribute (that wants to output a
> 64 bit value).
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 22dbf115782e..f90f4dd25151 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -328,9 +328,9 @@ static inline void pmc_core_reg_write(struct pmc_dev *pmcdev, int
>         writel(val, pmcdev->regbase + reg_offset);
>  }
>
> -static inline u32 pmc_core_adjust_slp_s0_step(u32 value)
> +static inline u64 pmc_core_adjust_slp_s0_step(u32 value)
>  {
> -       return value * SPT_PMC_SLP_S0_RES_COUNTER_STEP;
> +       return (u64)value * SPT_PMC_SLP_S0_RES_COUNTER_STEP;
>  }
>
>  static int pmc_core_dev_state_get(void *data, u64 *val)
> --
> 2.21.0.rc0.258.g878e2cd30e-goog
>


-- 
With Best Regards,
Andy Shevchenko
