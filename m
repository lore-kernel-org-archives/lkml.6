Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D9AC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739102075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CG+2vd4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739102075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeJYAT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:19:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39729 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbeJYATZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:19:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id p1-v6so5254194ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prdvgaD3Efp/A4t6iK6tEVlDOLQznWC6F6kezvMzyuQ=;
        b=CG+2vd4Xbdfwh64rYVgJnhx2d/SGfjJ+sJDl82kkV8dg9APT4MVjHR+93gkAhupzeD
         FkSA6uD8GDEORooaIwMwQUJpzIItRBPBRI39AOjX7H6/1tRi9uM9Wo1aafKckWI9gV7R
         CkWHexa2AkYJ3FsiF0CvyLEVVlg0YGEGPMqLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prdvgaD3Efp/A4t6iK6tEVlDOLQznWC6F6kezvMzyuQ=;
        b=SnJey+J80epK6ec5gV0hs1yGrIDM05eEADan7w4yqD33vvCtaEEeM5+kfUUAfzBLpm
         tII2SwjcWQH7NnDgcRETo1osjN7kEryJ3lgmvsm6d59g/a/pfzJsKmeeRHn05LcwIa7J
         RLMMOl40uq0tUGOVm9Lk0GUR/NjAaU4T52g8BTFLlvd/v3Arh92LZDOkxHcISptX6/af
         G2Wb7XgEa0OAXbgqrNVn3RDTpFAxm2OxdXgJFiOOEzfgtGe07svQUznCPM2H2nSz8f42
         D7PG88RVp95qvCL3tYeLRZTMhPopQWIpEs51velbc09SkDTd2+mwtTuxbE/TlheBOiX/
         XUfA==
X-Gm-Message-State: AGRZ1gIvsqA3vDg/7vFBE++FZ+xXr+gBn8CDeDO8h0iY5Iaj4DY2J1hl
        0QlE8oY5g70fJT1OfxdEq+v6cXxpscE=
X-Google-Smtp-Source: AJdET5cSDTKhhuHPwq2/hp5mzRIHgsyrWVtLFLuWEUeufEUgqnCyeDXQvHDSQQ1h2tUAD7lq1OX/gQ==
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr2199549ljh.118.1540396247565;
        Wed, 24 Oct 2018 08:50:47 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id q5-v6sm741261lfj.85.2018.10.24.08.50.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 08:50:46 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id v6-v6so5241428ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 08:50:46 -0700 (PDT)
X-Received: by 2002:a2e:6c0c:: with SMTP id h12-v6mr2124622ljc.112.1540396245978;
 Wed, 24 Oct 2018 08:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <1540315748-29158-1-git-send-email-rplsssn@codeaurora.org>
In-Reply-To: <1540315748-29158-1-git-send-email-rplsssn@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 24 Oct 2018 08:50:09 -0700
X-Gmail-Original-Message-ID: <CAE=gft6o8c4abTxa3JDeUTk_xkuZmtFXCx7+Ach1E-vv-cYzMw@mail.gmail.com>
Message-ID: <CAE=gft6o8c4abTxa3JDeUTk_xkuZmtFXCx7+Ach1E-vv-cYzMw@mail.gmail.com>
Subject: Re: [PATCH RESEND] drivers: qcom: rpmh: avoid sending sleep/wake sets immediately
To:     rplsssn@codeaurora.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, Doug Anderson <dianders@chromium.org>,
        mka@chromium.org, Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:29 AM Raju P.L.S.S.S.N
<rplsssn@codeaurora.org> wrote:
>
> Fix the redundant call being made to send the sleep and wake requests
> immediately to the controller.
>
> As per the patch[1], the sleep and wake request votes are cached in rpmh
> controller and sent during rpmh_flush(). These requests needs to be sent
> only during entry of deeper system low power modes or suspend.
>
> [1]https://patchwork.kernel.org/patch/10477533/
>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> Reviewed-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index e6e98d4..877fe78 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -228,9 +228,8 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
>                 WARN_ON(irqs_disabled());
>                 ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
>         } else {
> -               ret = rpmh_rsc_write_ctrl_data(ctrlr_to_drv(ctrlr),
> -                               &rpm_msg->msg);
>                 /* Clean up our call by spoofing tx_done */
> +               ret = 0;
>                 rpmh_tx_done(&rpm_msg->msg, ret);
>         }
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of the Code Aurora Forum, hosted by The Linux Foundation.
>

I think this makes sense to me, though the paths through here can be a
little winding.

Reviewed-by: Evan Green <evgreen@chromium.org>
