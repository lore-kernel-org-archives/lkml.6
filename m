Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4D8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5782084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aFvc7R2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfAKWRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:17:06 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38327 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfAKWRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:17:05 -0500
Received: by mail-vs1-f65.google.com with SMTP id x64so10190594vsa.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 14:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GishjVQ2mxLj2cSdtiUM4T1jKgDQ8n++tTF09GQ2OIk=;
        b=aFvc7R2rvsKJnzOi7+km9xiBhJnXE9FotjFSoTawhV7BENWZWSPKst7YGyW4PPepZn
         diWOvFvy4SneTSHh46IQk5pzdR7FNFepokI8328qC9xQpbdluhtsGSLCKex+Mzbv4Gei
         iaxx7E8pD1YvOCBTVF3jXOXlMbaAAbdV30KA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GishjVQ2mxLj2cSdtiUM4T1jKgDQ8n++tTF09GQ2OIk=;
        b=qLh2pYTdv/T88JcJFCPUP22efgKvHgfMA067we0Id0Wx1dI9ypyk8T5XBGYr2Mo+45
         e47cHz3yFYmPj9yuflzRtTaKsyoxtFgCzvBCcSmVn6ggwx8bE3URr3IcxR4C1kv9+Vf0
         ovb4srujNK2wf3jEiz4+FMgUK+xtGg49NlQm2w3NwyNcYp5LE2I1e/K2jIla3Vhq40IM
         oFprduFJSfnE8ThDIaaf7emiBXyL82emBDYdM13Yx5lpewiiE+Vvc6AgGZDQtqHN17rt
         showRAqe9YzN9H3xbdQIDxDU7Ew4cyk9Pq3QjqPHGrNkSzjA8TiYeX3ZGLfDSwJ2PFWJ
         nSJA==
X-Gm-Message-State: AJcUukcAbXosEzoLRBLje9dCdY2ohcLIHtTB2p1jD+K9zrk729s4DRuV
        k7x4QatN3j9SQV7IGXce+QREF7t/MkY=
X-Google-Smtp-Source: ALg8bN7RPHWqn5oYoHcn5WSC5Oj3TvYKEiw8PQPrvEk9yrbV/XnRtrCydtmlMZu3suTnph5mxejVNw==
X-Received: by 2002:a67:41c2:: with SMTP id x63mr7459382vsf.185.1547245024609;
        Fri, 11 Jan 2019 14:17:04 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id n206sm39425273vkn.36.2019.01.11.14.17.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 14:17:02 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id y27so10230165vsi.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 14:17:02 -0800 (PST)
X-Received: by 2002:a67:f598:: with SMTP id i24mr6635729vso.87.1547245022117;
 Fri, 11 Jan 2019 14:17:02 -0800 (PST)
MIME-Version: 1.0
References: <20190110040209.6028-1-rnayak@codeaurora.org> <20190110040209.6028-2-rnayak@codeaurora.org>
In-Reply-To: <20190110040209.6028-2-rnayak@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 11 Jan 2019 14:16:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U-1bJC9D3UV6E4FRK7L-cbEbwAg8dGG=HWAtaKvNuTFw@mail.gmail.com>
Message-ID: <CAD=FV=U-1bJC9D3UV6E4FRK7L-cbEbwAg8dGG=HWAtaKvNuTFw@mail.gmail.com>
Subject: Re: [PATCH v11 1/9] dt-bindings: opp: Introduce opp-level bindings
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Herring <robh@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, henryc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 9, 2019 at 8:03 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Add opp-level as an additional property in the OPP node to describe
> the performance level of the device.
>
> On some SoCs (especially from Qualcomm and MediaTek) this value
> is communicated to a remote microprocessor by the CPU, which
> then takes some actions (like adjusting voltage values across various
> rails) based on the value passed.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index c396c4c0af92..76b6c79604a5 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -129,6 +129,9 @@ Optional properties:
>  - opp-microamp-<name>: Named opp-microamp property. Similar to
>    opp-microvolt-<name> property, but for microamp instead.
>
> +- opp-level: A value representing the performance level of the device,
> +  expressed as a 32-bit integer.
> +

I like how this ended up!  :-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...are we just waiting for Rob to weigh back in about whether he's OK
w/ this solution?

Thanks!


-Doug
