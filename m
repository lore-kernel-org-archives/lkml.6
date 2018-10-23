Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9C4C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7184220831
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lb9TuHUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7184220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeJWQbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:31:09 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40640 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbeJWQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:31:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id w67so466050ota.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3GCYP0cLVFLdoRFNixu2nJdzCAav5JSS+H1PqER4cso=;
        b=Lb9TuHUXnkQBi5Ls2RdG8fFZ9+msnOXhqpVcfzv/rgrUDA3qRX1u7l7kBiCCCmQ3nf
         Weao+Y8WgX7UOVXHpfqHdcoK/D7bug6j+hhcBkW2nt6qEiQBEFLoPWwqEII1vZp2J5X6
         JbyBngICE6fxjREKVotOfGTqw7oGfUYixb8oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GCYP0cLVFLdoRFNixu2nJdzCAav5JSS+H1PqER4cso=;
        b=Tq3aAcMzfGt1cGRDHysyerxj2/TPfOSB6APTe+FxFLYljGjHs5EsUT5v27Px0znp2j
         M+SAqA03Bciq8NaA96bcGPEaTnDmW8EtiuBov7nPEOo3jf7Q0TnhCQIGorVKndGT8i3r
         3nzcFP7fVtSf3t/IKNovEBtv8elNb5qOoEAvuko+gGF/1+38jJdkKEYcGhTXkH1pOeBW
         O3SLAsa3TMtkIcZ8SHbkGAk1h+4V0YMOcvDmaCt/Nqtcj7D4MWjalTBRpwyAS7UfQwzw
         BRrkr83T1aXTCAuc1SpA/y1kKijryaU6L9zMWWnuqTr+u7TWyzXoxkqABYRQ778iDavG
         ky4Q==
X-Gm-Message-State: ABuFfohnqgxFVbNW31NJfNi6WdHmdMhwXoR3C4M1k7dys5c0X5frGdPx
        9Mif9gHs/PpnT4IceF+FJGOZMd66xX92eQ==
X-Google-Smtp-Source: ACcGV619z1mUN/SH8Cai164LeBhqpuvVYCPw/1zcBlIp3V6jPay9RpZbOZ+ww3in34Trr/HEPk9llA==
X-Received: by 2002:a9d:56f8:: with SMTP id b53mr32598742otj.365.1540282131950;
        Tue, 23 Oct 2018 01:08:51 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id z53sm168614otz.0.2018.10.23.01.08.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 01:08:50 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id e17-v6so384865oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 01:08:50 -0700 (PDT)
X-Received: by 2002:aca:e385:: with SMTP id a127-v6mr27738877oih.261.1540282130278;
 Tue, 23 Oct 2018 01:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <1540209912-24834-1-git-send-email-mgottam@codeaurora.org>
In-Reply-To: <1540209912-24834-1-git-send-email-mgottam@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 23 Oct 2018 17:08:39 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUB6cOEgN3fnFfPBLMmVJQ4BbjWYeJRY1_v=oQW-vNWyg@mail.gmail.com>
Message-ID: <CAPBb6MUB6cOEgN3fnFfPBLMmVJQ4BbjWYeJRY1_v=oQW-vNWyg@mail.gmail.com>
Subject: Re: [PATCH v2] media: venus: handle peak bitrate set property
To:     mgottam@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

On Mon, Oct 22, 2018 at 9:06 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>
> Max bitrate property is not supported for venus version 4xx.
> Return unsupported from packetization layer. Handle it in
> hfi_venus layer to exit gracefully to venc layer.
>
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>

This seems to work, thanks!

Tested-by: Alexandre Courbot <acourbot@chromium.org>

> ---
>  drivers/media/platform/qcom/venus/hfi_cmds.c  | 2 +-
>  drivers/media/platform/qcom/venus/hfi_venus.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index e8389d8..87a4414 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -1215,7 +1215,7 @@ static int pkt_session_set_property_1x(struct hfi_session_set_property_pkt *pkt,
>         }
>         case HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE:
>                 /* not implemented on Venus 4xx */
> -               break;
> +               return -ENOTSUPP;
>         default:
>                 return pkt_session_set_property_3xx(pkt, cookie, ptype, pdata);
>         }
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index 1240855..9d086b9 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -1355,6 +1355,8 @@ static int venus_session_set_property(struct venus_inst *inst, u32 ptype,
>         pkt = (struct hfi_session_set_property_pkt *)packet;
>
>         ret = pkt_session_set_property(pkt, inst, ptype, pdata);
> +       if (ret == -ENOTSUPP)
> +               return 0;
>         if (ret)
>                 return ret;
>
> --
> 1.9.1
>
