Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF17FC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8054C2145D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A7LzCfW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8054C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeLALuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:50:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44566 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbeLALuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:50:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so6511396lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUwgOG2FwKn73vdyjMJ9x8UdUTas2QjkWsYuqenQdmk=;
        b=A7LzCfW8fURMHCJvh+eCrnoMDst+w2MVobrY/ZRoPlxnsGPWMEUvJXYP77/Y0ZJnSA
         2Vhypd2U8MDqCiOJmmUADxU5zMOS6bPMoXSseYHpjLXLLJJ8sq/v2roeVEOBMODAFJle
         Znz3Vp4EV3lEU+OabVzWSKhiwqKwKnRyH1oUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUwgOG2FwKn73vdyjMJ9x8UdUTas2QjkWsYuqenQdmk=;
        b=fJJYZRIGFC647e8RwjAyQ0K8LKrrhdfqzVWCAKgZiUTHKbh+zlh0FQyVapGmU36Eu3
         IiFKuo6OVKG2Nsz3PxCI6c2dKywmGMLL7mMZd4HtRVjDxVPL3e5gIfk4jHM+eS2oxlfc
         XbLRzfQpKTf9Hh7CShODRpcByTG2ra30lJGrYSdEjrIRpI1wRsWE7/x7MA6FwbwepPzw
         fyCfCToY19uP5GDbcRtdFVpHNltapsjg++XxmoT/3Ey8Xyj2uHrsBKYqZ4nP20G3d8I3
         4OHPsF+a155nIhkBMO6xnaJjekk9/BBD8hCfVkC6+xlKUjj0wWE8bzeMekweMduiynFs
         BWhA==
X-Gm-Message-State: AA+aEWbZL5XUGpXZ+eke6SNvazGfSQh7rxJAhw177y8G7LBLIe8rToWg
        uLuV0DKD/JKGQDaNmPKra/z06Hl/9vg=
X-Google-Smtp-Source: AFSGD/VHBazuWa7/M6P69egaGi/fqGdFYvO5f8zZ0ne0OC67aKbh2Ymgzr0pUeW1Sj2VbA4nnIWTmg==
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr5083046lji.30.1543624750735;
        Fri, 30 Nov 2018 16:39:10 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id j12-v6sm1057962ljh.66.2018.11.30.16.39.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:39:09 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id s5-v6so6516096ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:39:08 -0800 (PST)
X-Received: by 2002:a2e:501:: with SMTP id 1-v6mr5641242ljf.74.1543624747961;
 Fri, 30 Nov 2018 16:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org> <20181127180349.29997-3-georgi.djakov@linaro.org>
In-Reply-To: <20181127180349.29997-3-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 30 Nov 2018 16:38:31 -0800
X-Gmail-Original-Message-ID: <CAE=gft5z0=Rp_+jj2JTKF4Kn-RB6AK0Ke1ByUuRwrZHwvNDcCg@mail.gmail.com>
Message-ID: <CAE=gft5z0=Rp_+jj2JTKF4Kn-RB6AK0Ke1ByUuRwrZHwvNDcCg@mail.gmail.com>
Subject: Re: [PATCH v10 2/7] dt-bindings: Introduce interconnect binding
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>,
        maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>,
        thierry.reding@gmail.com, ksitaraman@nvidia.com,
        sanjayc@nvidia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> This binding is intended to represent the relations between the interconnect
> controllers (providers) and consumer device nodes. It will allow creating links
> between consumers and interconnect paths (exposed by interconnect providers).
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt    | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
>
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> new file mode 100644
> index 000000000000..6775c07e1574
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -0,0 +1,60 @@
> +Interconnect Provider Device Tree Bindings
> +=========================================
> +
> +The purpose of this document is to define a common set of generic interconnect
> +providers/consumers properties.
> +
> +
> += interconnect providers =
> +
> +The interconnect provider binding is intended to represent the interconnect
> +controllers in the system. Each provider registers a set of interconnect
> +nodes, which expose the interconnect related capabilities of the interconnect
> +to consumer drivers. These capabilities can be throughput, latency, priority
> +etc. The consumer drivers set constraints on interconnect path (or endpoints)
> +depending on the use case. Interconnect providers can also be interconnect
> +consumers, such as in the case where two network-on-chip fabrics interface
> +directly.
> +
> +Required properties:
> +- compatible : contains the interconnect provider compatible string
> +- #interconnect-cells : number of cells in a interconnect specifier needed to
> +                       encode the interconnect node id
> +
> +Example:
> +
> +               snoc: interconnect@580000 {
> +                       compatible = "qcom,msm8916-snoc";
> +                       #interconnect-cells = <1>;
> +                       reg = <0x580000 0x14000>;
> +                       clock-names = "bus_clk", "bus_a_clk";
> +                       clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +                                <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +               };
> +
> +
> += interconnect consumers =
> +
> +The interconnect consumers are device nodes which dynamically express their
> +bandwidth requirements along interconnect paths they are connected to. There
> +can be multiple interconnect providers on a SoC and the consumer may consume
> +multiple paths from different providers depending on use case and the
> +components it has to interact with.
> +
> +Required properties:
> +interconnects : Pairs of phandles and interconnect provider specifier to denote
> +               the edge source and destination ports of the interconnect path.
> +
> +Optional properties:
> +interconnect-names : List of interconnect path name strings sorted in the same
> +                    order as the interconnects property. Consumers drivers will use
> +                    interconnect-names to match interconnect paths with interconnect
> +                    specifier pairs.
> +
> +Example:
> +
> +       sdhci@7864000 {
> +               ...
> +               interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
> +               interconnect-names = "sdhc-ddr";
> +       };

Reviewed-by: Evan Green <evgreen@chromium.org>
