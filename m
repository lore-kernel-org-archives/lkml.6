Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB6CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F08120B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aviucKNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F08120B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbeGJWoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:44:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37007 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732242AbeGJWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:44:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so7634118ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VArQud8KYfMjVdJrHxkkOvXx4t4xEHTiSs2W4gYn+VA=;
        b=aviucKNn7cgNnDPiFH43MUb9PE/5bOvPOcbAIbP9TG8NPCalydSbbmE4/2aYnc5zRA
         RdgReLNVEeUsb1h7LuQF1+wO2Mo+yRkFuKNY6YbOYEjuL3pK+V+jtXC+ubBzCr48AANf
         XPpryHBgdXU9nOBdeq7EAXrzSmpHjqNpA8Djc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VArQud8KYfMjVdJrHxkkOvXx4t4xEHTiSs2W4gYn+VA=;
        b=PWYzBSb+ss1kkO8tpHL3qPpuiVfhdR95n1W2PGHfs9SKsJYZBwpUMZlxlWPrGAvJ0r
         hjqznI5YK50g4oYJdBluqoFlZKDMYC9Y3PShVR4sYs47nT5XZxyeJmXNoDoNCXmKLqr7
         fvFWf33IrV+mxmqTU6uTKjPccn2PL3OOjvp4IeDo+QDxmPX0jSPB/9m3Hbulgg7lSlMu
         CoAi8m1sUtFgRvYxN9WqzKGdTCprxO5c6AufCbBUXUh1gErY7a9jmWotJiKArJa4XTTx
         y8l8uTJ8YBibdl3vvdC6TWqFr33a881ib2qMUBsBSMuBTzupIkXMSuB8PQ6pseGVwlfl
         KY8g==
X-Gm-Message-State: APt69E1UKk/M6Yiqg5xX2zNWZdPNIUs31Lf67gwk1MVLXAVIets1+l07
        9dSCe/NIZojSi8SYgYGq7P4X45R5IIE=
X-Google-Smtp-Source: AAOMgpfMBnDO7fSqFb95tfy9p8z/58FJ09lbH5xnCOEJG28hcbIBfJHVvgXyfnWk8AKg58zfXKNwVQ==
X-Received: by 2002:a2e:5f5b:: with SMTP id t88-v6mr17047519ljb.140.1531262579100;
        Tue, 10 Jul 2018 15:42:59 -0700 (PDT)
Received: from mail-lf0-f48.google.com (mail-lf0-f48.google.com. [209.85.215.48])
        by smtp.gmail.com with ESMTPSA id g2-v6sm4036434lfb.52.2018.07.10.15.42.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 15:42:59 -0700 (PDT)
Received: by mail-lf0-f48.google.com with SMTP id b22-v6so7246033lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:42:58 -0700 (PDT)
X-Received: by 2002:a19:d405:: with SMTP id l5-v6mr3957382lfg.28.1531262127467;
 Tue, 10 Jul 2018 15:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180709155104.25528-1-georgi.djakov@linaro.org> <20180709155104.25528-8-georgi.djakov@linaro.org>
In-Reply-To: <20180709155104.25528-8-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 10 Jul 2018 15:34:51 -0700
X-Gmail-Original-Message-ID: <CAE=gft7tDYB172LTMuS4JPPaTFasT22zLBx4XjpYne2PNNz+kQ@mail.gmail.com>
Message-ID: <CAE=gft7tDYB172LTMuS4JPPaTFasT22zLBx4XjpYne2PNNz+kQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] dt-bindings: Introduce interconnect consumers bindings
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Alexandre Bailon <abailon@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mka@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, tfiga@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 8:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Add documentation for the interconnect consumer bindings, that will allow
> to link a device node (consumer) to its interconnect controller hardware.
>
> Tha aim is to enable drivers to request a framework API to configure an
> interconnect path by providing their struct device pointer and a name.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt    | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> index 6e2b2971b094..0ad65dccbe8b 100644
> --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -31,3 +31,30 @@ Example:
>                         clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
>                                  <&rpmcc RPM_SMD_SNOC_A_CLK>;
>                 };
> +
> +
> += interconnect consumers =
> +
> +The interconnect consumers are device nodes which consume the interconnect
> +path(s) provided by the interconnect provider. There can be multiple

I wonder if this sentence could be more descriptive. Maybe something like:

The interconnect consumers are device nodes which dynamically express
their bandwidth requirements along interconnect paths they are
connected to.

...or choose a better one if this one's a mouthful.

> +interconnect providers on a SoC and the consumer may consume multiple paths
> +from different providers depending on use case and the components it has to
> +interact with.
> +
> +Required properties:
> +interconnects : Pairs of phandles and interconnect provider specifier to denote
> +               the edge source and destination ports of the interconnect path.
> +
> +Optional properties:
> +interconnect-names : List of interconnect path name strings sorted in the same
> +                    order as the interconnects property. Consumers drivers will use
> +                    interconnect-names to match interconnect paths with interconnect
> +                    specifiers.
> +
> +Example:
> +
> +       sdhci@7864000 {
> +               ...
> +               interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
> +               interconnect-names = "ddr";
> +       };
