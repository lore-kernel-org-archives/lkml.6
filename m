Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7026EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F256217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y4AKbig5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F256217A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbeHDBGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 21:06:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41521 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731741AbeHDBGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 21:06:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id v22-v6so5175466lfe.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OTBrKBS2FOaR8amPaVJWlIwCoGnTHmp4d6+RN9CaMWI=;
        b=Y4AKbig5ReBzVeZLX3XYF5Bc9kiocOOA9gX9bpg3hyxeXzKtVTpMlYWwU6FIEcoJFu
         BR2L1F0sFVO5O8JHVv9Ly4+Rz0ntQKZKazswaqVyUsv0FPJfQcgr7cHOxmM/qtGsoVTr
         9V8LZPbKlKcVUMKS+UZ5c7ZiM0uKa/Cp4+P7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OTBrKBS2FOaR8amPaVJWlIwCoGnTHmp4d6+RN9CaMWI=;
        b=ug9eeBZxPoy3AJec+wRjNpRapn8MaEtvEcKo3BGNNByuol1KCiVH6JoS56bGkZbEKk
         +9w81i56e3OhEk+o7vJGGZOlrq2jH5ZFg53hkaLosNMqXZ8lGTYGN15v+JiGgd3eQfDi
         obu+pWMXvHz2WJkWL4kSP8ljXQuRWNJzKHzed1gN35MIit/huupZbISyLUKaIQOCDPGr
         EUpDLE1KvIV9qlvxgN7jdDrk7faJ3+5GMbBG23qPGIeb8azXdyto0zpXJOhBWBhik9zU
         hBg8za4J+MYPXw5trsMtLRiLnPYIR6gtRa1aI09Qt+AN51wilrrMZ+qEwckm/RVck6JD
         6r2A==
X-Gm-Message-State: AOUpUlHd3lG8cNIHgKYfpSkEN2w5uQIgw+l3f4fhCZ2JEoV7pou2ybpa
        bQAGPXxeiFSMmTAO0nFDcibBlP7o9Qg=
X-Google-Smtp-Source: AAOMgpesrIut53g0auJrnvS37XO+OBvw9Oud0TXYlZ0kyUU30uocRsKiMoXPgGPc8+x+ycmnLbPHkw==
X-Received: by 2002:a19:5309:: with SMTP id h9-v6mr6044210lfb.86.1533337694759;
        Fri, 03 Aug 2018 16:08:14 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id z12-v6sm904475lfj.26.2018.08.03.16.08.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 16:08:14 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id y200-v6so5177636lfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 16:08:14 -0700 (PDT)
X-Received: by 2002:a19:c742:: with SMTP id x63-v6mr5616208lff.9.1533337205139;
 Fri, 03 Aug 2018 16:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180731161340.13000-1-georgi.djakov@linaro.org> <20180731161340.13000-5-georgi.djakov@linaro.org>
In-Reply-To: <20180731161340.13000-5-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 3 Aug 2018 15:59:28 -0700
X-Gmail-Original-Message-ID: <CAE=gft5VyY5_44df3G2x4gLtogTNq9tqe=nYz5N0MBz42zF+Bg@mail.gmail.com>
Message-ID: <CAE=gft5VyY5_44df3G2x4gLtogTNq9tqe=nYz5N0MBz42zF+Bg@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] interconnect: qcom: Add RPM communication
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
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle communication
> with this remote processor.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom-smd.txt        | 32 +++++++
>  drivers/interconnect/qcom/Kconfig             | 14 +++
>  drivers/interconnect/qcom/Makefile            |  2 +
>  drivers/interconnect/qcom/smd-rpm.c           | 91 +++++++++++++++++++
>  drivers/interconnect/qcom/smd-rpm.h           | 16 ++++
>  5 files changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-smd.txt
>  create mode 100644 drivers/interconnect/qcom/Kconfig
>  create mode 100644 drivers/interconnect/qcom/Makefile
>  create mode 100644 drivers/interconnect/qcom/smd-rpm.c
>  create mode 100644 drivers/interconnect/qcom/smd-rpm.h
>
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom-smd.txt b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
> new file mode 100644
> index 000000000000..88a5aeb50935
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
> @@ -0,0 +1,32 @@
> +Qualcomm SMD-RPM interconnect driver binding
> +------------------------------------------------
> +The RPM (Resource Power Manager) is a dedicated hardware engine
> +for managing the shared SoC resources in order to keep the lowest
> +power profile. It communicates with other hardware subsystems via
> +the shared memory driver (SMD) back-end and accepts requests for
> +various resources.
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +                       "qcom,interconnect-smd-rpm"
> +
> +Example:
> +       smd {
> +               compatible = "qcom,smd";
> +
> +               rpm {
> +                       interrupts = <0 168 1>;

It would be nice if this interrupt example were more proper, somethine
like <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>. Other than that:

Reviewed-by: Evan Green <evgreen@chromium.org>
