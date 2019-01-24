Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E76C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B095B21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UA7xzbCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfAXRdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:33:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39895 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfAXRdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:33:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so2950816pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 09:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LA99GYjCAxlAjylW9nCkBm63LjgUr2vYqlu2+B4w9Rc=;
        b=UA7xzbCiVYMmz6b1jceub6vFwlcP0sUxCXnPx3YjyrlknatM/hRagT5qkktDnzt6uX
         A+w9yob+jAMIQOdb5OB+fPEtm2iNQDgHeCRFyFQxffIuo/8wSVSXMr6EobBvAXppT3xV
         dTCypCHyHsi7x27wm4GQ/TEMsF+Fzf7aFCvFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LA99GYjCAxlAjylW9nCkBm63LjgUr2vYqlu2+B4w9Rc=;
        b=Xchll1P1quce4P3bnMa5jwURe3Zs8UlpIRdabpBP/pg/1BdQOQhsBQG6pW/4S9ddY1
         WwEf25pTUxkF+QwUxyOP0p0oOyFwOTMcxuVg/oohotl66tXhwkjHaZBzxOYwLBZp5jlZ
         WXnL6LoU418t6HYvuZNr8bK6mlDR4u4nGtZThcuUVU4WWgMkXSsZ+AcQXP9UieQyP4BB
         evRnhOwDR2qTZ/QLq+yFGtV8AYp849/odEsthv/FMMAtU2NeEGLAtl4o51tU6ppMPXBk
         UuoDmE8oRg94Y1SUKo/c8KOGFNBceUUx6i+1EQ2x6/4eV62Q2kbkfvfJ/MjeS/JC07Zp
         IWew==
X-Gm-Message-State: AJcUukePhrkS+6Qtf6M1xRwAsHEHvCE6uIQIBEAcwkZb/DdRIUdHQtAJ
        QcGCfZpuFch4zUPEjRtQsDhEHLL9++HdM5reHvcot8mI
X-Google-Smtp-Source: ALg8bN5rl99eNhdsJI9B08UORI4E/zijmK5X3HHJouHeTQsu2oKAxxE+0DC6f0BauK7RDbGBD5TYG9qYRrfs5x0KD4c=
X-Received: by 2002:a63:77ce:: with SMTP id s197mr6706532pgc.89.1548351195596;
 Thu, 24 Jan 2019 09:33:15 -0800 (PST)
MIME-Version: 1.0
References: <1548335501-7868-1-git-send-email-igor.opaniuk@linaro.org> <CAHUa44Gar3JTzSNroJe2Ws_ZAHUC0bewubd8X2uKyssmghKd4A@mail.gmail.com>
In-Reply-To: <CAHUa44Gar3JTzSNroJe2Ws_ZAHUC0bewubd8X2uKyssmghKd4A@mail.gmail.com>
From:   Igor Opaniuk <igor.opaniuk@linaro.org>
Date:   Thu, 24 Jan 2019 19:32:39 +0200
Message-ID: <CAModR+Wi6V3G_CgY8MwfZMwtbV5PZti84i1off8sAo794Fcpvg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tee: add cancellation support to client interface
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

right, missed that. Thanks!
Addressed this issue + also fixed the description and sent v2.

On Thu, 24 Jan 2019 at 18:19, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Thu, Jan 24, 2019 at 2:11 PM Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
> >
> > Add support of cancellation request to the TEE kernel internal
> > client interface. Can be used by software TPM drivers, that leverage
> > TEE under the hood (for instance in TPM2.0 mobile profile), for requesting
> > cancellation of time-consuming operations (RSA key-pair generation etc.).
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
> > ---
> >  drivers/tee/tee_core.c  | 12 ++++++++++++
> >  include/linux/tee_drv.h | 14 ++++++++++++++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 7b2bb4c..aba71a8 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -1027,6 +1027,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
> >  }
> >  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
> >
> > +int tee_client_cancel_req(struct tee_context *ctx,
> > +                         u32 cancel_id,
> > +                         u32 session)
> > +{
> > +
> > +       if (!ctx->teedev->desc->ops->cancel_req)
> > +               return -EINVAL;
> > +       return ctx->teedev->desc->ops->cancel_req(ctx, cancel_id,
> > +                                                 session);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_client_cancel_req);
> > +
> >  static int __init tee_init(void)
> >  {
> >         int rc;
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 6cfe058..62a0b56 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -526,6 +526,20 @@ int tee_client_invoke_func(struct tee_context *ctx,
> >                            struct tee_ioctl_invoke_arg *arg,
> >                            struct tee_param *param);
> >
> > +/**
> > + * tee_client_cancel_req() - Request cancellation of the previous open-session
> > + * or invoke-command operations in a Trusted Application
> > + * @ctx:       TEE Context
> > + * @arg:       Unique cancel request id
> > + * @param:     Session id
>
> These need to be updated, see struct tee_ioctl_cancel_arg in
> include/uapi/linux/tee.h
>
> Thanks,
> Jens
>
> > + *
> > + * Returns < 0 on error else see @arg->ret for result.
> > + */
> > +int tee_client_cancel_req(struct tee_context *ctx,
> > +                         u32 cancel_id,
> > +                         u32 session);
> > +
> > +
> >  static inline bool tee_param_is_memref(struct tee_param *param)
> >  {
> >         switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
> > --
> > 2.7.4
> >



--
Regards,
Igor Opaniuk
