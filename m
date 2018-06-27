Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEB4C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD24265C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kq5Wtxd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD24265C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934535AbeF0Az1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:55:27 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46424 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754527AbeF0AzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:55:25 -0400
Received: by mail-pg0-f67.google.com with SMTP id q14-v6so141409pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 17:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u5kez1ICBgVFskUH7rpNljRRmwb32FDQ7wdF2fHPdX8=;
        b=kq5Wtxd+0452FFQagKGT47b5LQ7cswTdQfbr3Ev669jhwWzJpASeYTEGulc4J5tk0B
         0ZX/GZqwEF9YlcEO6mji9DBgk/rXEu74jqd5EaYRFFlv6N8S17daXVmFttwSebSYnyml
         xQjHJVxoRpcq1ZM5VZXmHxWfCys5ZialMPb2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u5kez1ICBgVFskUH7rpNljRRmwb32FDQ7wdF2fHPdX8=;
        b=dBOT5KVABkpum6wde045eU7TFmA6WKWyLiDkPWtHCWSYx7TZzm7kFwOd5e8sco5I7W
         h1XqR+gFdIKKcjtL4ra8ZvddNR5em4/qXxM6ySoCgorKvvBL5aaSIQRpgjYG90d2ilHF
         fczLBsF0LvzoUwUSVRd6bBHWDuubPZ/jimdrWKKKY2Zr89o9HbhZjB16NPAVGsaQgeIN
         CBckxw0fE+SXQ/8quXyj7YPY/Dvka9jOZ1q1nQJv+EbeNtN2JCs1+gdHFqBF0JU/sBvs
         jwV58mrbFThbjAdoLe8SddRCvGlPZsW1LhW/ETJnbkxMrJIixJ2j56YTi9QpfQBfnBtf
         rJuA==
X-Gm-Message-State: APt69E0U6JcaJGYGJUVAjcC+3R/C9blSmSPfeHvB973ggPo1mcrqQDVA
        9VNDh5k4h1cswYQwWFBS08qyng==
X-Google-Smtp-Source: AAOMgpeuZjnvIJQztQIrsN1WjDKcXHu2qYm86r6u9gyDmRGlz6h0mvQ7AIZ4bP3EvsFH4JqHeqgCRw==
X-Received: by 2002:a62:3783:: with SMTP id e125-v6mr3652910pfa.232.1530060925156;
        Tue, 26 Jun 2018 17:55:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l11-v6sm4531190pff.50.2018.06.26.17.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 17:55:24 -0700 (PDT)
Date:   Tue, 26 Jun 2018 17:55:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 4/8] interconnect: qcom: Add RPM communication
Message-ID: <20180627005523.GS129942@google.com>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-5-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180620121141.15403-5-georgi.djakov@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 03:11:37PM +0300, Georgi Djakov wrote:
> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle comminication

s/comminication/communication/

> with this remote processor.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom-smd.txt        | 32 +++++++
>  drivers/interconnect/qcom/Makefile            |  2 +
>  drivers/interconnect/qcom/smd-rpm.c           | 90 +++++++++++++++++++
>  drivers/interconnect/qcom/smd-rpm.h           | 15 ++++
>  4 files changed, 139 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-smd.txt
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
> +			"qcom,interconnect-smd-rpm"
> +
> +Example:
> +	smd {
> +		compatible = "qcom,smd";
> +
> +		rpm {
> +			interrupts = <0 168 1>;
> +			qcom,ipc = <&apcs 8 0>;
> +			qcom,smd-edge = <15>;
> +
> +			rpm_requests {
> +				compatible = "qcom,rpm-msm8916";
> +				qcom,smd-channels = "rpm_requests";
> +
> +				interconnect-smd-rpm {
> +					compatible = "qcom,interconnect-smd-rpm";
> +				};
> +
> +			};
> +		};
> +	};
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> new file mode 100644
> index 000000000000..2a0c41db91c4
> --- /dev/null
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-y += smd-rpm.o
> diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
> new file mode 100644
> index 000000000000..0cf772f51642
> --- /dev/null
> +++ b/drivers/interconnect/qcom/smd-rpm.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RPM over SMD communication wrapper for interconects

s/interconects/interconnects/
