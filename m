Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89BEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7505D20866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XhRdvmJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfAVXRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:17:04 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36986 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfAVXRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:17:04 -0500
Received: by mail-ua1-f65.google.com with SMTP id u19so101934uae.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vym9ti5IvtTy9rGh/Wfs+WReAQFpLSv6EidbIz9M1Mk=;
        b=XhRdvmJk1N5ruy09z1DpLImu/iZXhCrGpTNu/9qjUfK5Bym7IUPXmGfEpHBVS6+T6+
         PTXKfHtY/1fhrAnsw5HYNw4deUEdO3wsQH1GpK5F5pzxz8GeMNOp8M4m68h7yYJtxuDO
         fisdib6RxVIpDl6uRc5ooB9S5qkl6iy2ILGyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vym9ti5IvtTy9rGh/Wfs+WReAQFpLSv6EidbIz9M1Mk=;
        b=m+KH5KOXe7QDFoivC3uGD/kxdiFladcN3b1gvK08bD/fTfPe3llICy/jVFLbIZ/8W0
         tCkgh4d2IPz9Wgv1mVmmf3LkitIAB0sf+wtLbCdyLHh62HXp1qoUGNKMPzeNDGy2Dynx
         VNDhgUztYi9CPXUb0jfirRZN2MXbiy0YcgtXBuGR640W4KDaqFOG6/uVspHonTLU5WuA
         a0R+X4dELlf1XPcrYCCYtEIeWcMasoNzj3rH61BHhMzVKGa7fmCI5DS9rdNud4wYqgN/
         yzX+54iFzIyfUIdtgxr5CIWOHDA0laLwobrdPG0CKzfm39OnIlB67miqGFq8/oY+N9dZ
         fxew==
X-Gm-Message-State: AJcUukd8Oliik9Ca3g8Y51MnCFD4ahyMnislujIMzUeqzgOb139SYauS
        +iHVpk/M4RTQKXihMSMtXjXfm9Qv4YA=
X-Google-Smtp-Source: ALg8bN4slC0jWhMZMK4Ds6kilx51d/00LO/Y9Dm7uyyrkpNGVvRGe0ZupZF3i7ay/kbISBb6NgDqYA==
X-Received: by 2002:ab0:1393:: with SMTP id m19mr14098574uae.75.1548199022360;
        Tue, 22 Jan 2019 15:17:02 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id y195sm56457654vkd.0.2019.01.22.15.17.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 15:17:01 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id p9so100074uaa.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:17:01 -0800 (PST)
X-Received: by 2002:ab0:60a3:: with SMTP id f3mr14425945uam.9.1548199021098;
 Tue, 22 Jan 2019 15:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20190122055112.30943-1-bjorn.andersson@linaro.org> <20190122055112.30943-2-bjorn.andersson@linaro.org>
In-Reply-To: <20190122055112.30943-2-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jan 2019 15:16:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ubg2D+1w8AxwYMwFfBZt3ZFf6auPJGDr8+2wE7=DV6Yw@mail.gmail.com>
Message-ID: <CAD=FV=Ubg2D+1w8AxwYMwFfBZt3ZFf6auPJGDr8+2wE7=DV6Yw@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] arm64: dts: qcom: sdm845: Update PIL region
 memory map
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 21, 2019 at 9:52 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Update existing and add all missing PIL regions to the reserved memory
> map, as described in version 10.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v2:
> - New patch
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 61 ++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0ec827394e92..cdcac3704c13 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -89,12 +89,47 @@
>                 };
>
>                 memory@86200000 {
> -                       reg = <0 0x86200000 0 0x2d00000>;
> +                       reg = <0 0x86200000 0 0x100000>;
>                         no-map;
>                 };
>
> -               wlan_msa_mem: memory@96700000 {
> -                       reg = <0 0x96700000 0 0x100000>;
> +               memory@86300000 {
> +                       reg = <0 0x86300000 0 0x4800000>;
> +                       no-map;
> +               };

I know it's not a problem upstream (yet), but downstream this collides
with a memory region in the cheza board.  We have:

rmtfs@88f00000 {
  compatible = "qcom,rmtfs-mem";
  reg = <0x0 0x88f00000 0x0 0x800000>;
  no-map;

  qcom,client-id = <1>;
};

...and the above region overlays it since it goes till 0x8ab00000


> +
> +               memory@8ab00000 {
> +                       reg = <0 0x8ab00000 0 0x1400000>;
> +                       no-map;
> +               };
> +
> +               memory@8bf00000 {
> +                       reg = <0 0x8bf00000 0 0x500000>;
> +                       no-map;
> +               };
> +
> +               ipa_fw_mem: memory@8c400000 {
> +                       reg = <0 0x8c400000 0 0x10000>;
> +                       no-map;
> +               };
> +
> +               ipa_gsi_mem: memory@8c410000 {
> +                       reg = <0 0x8c410000 0 0x5000>;
> +                       no-map;
> +               };
> +
> +               memory@8c415000 {
> +                       reg = <0 0x8c415000 0 0x2000>;
> +                       no-map;
> +               };
> +
> +               adsp_mem: memory@8c500000 {
> +                       reg = <0 0x8c500000 0 0x1a00000>;
> +                       no-map;
> +               };
> +
> +               wlan_msa_mem: memory@8df00000 {

Your patch moves 'wlan_msa_mem' from 0x96700000 to 0x8df00000.  Is
that OK?  I haven't been involved in all of the previous discussions
but if everything is all OK w/ the device tree just moving this chunk
around (without any other coordination w/ firmware) it seems really
weird that we even need to specify it in the device tree.  ...but
maybe I shouldn't open this can of worms.  You can pretend I didn't
say anything.

-Doug
