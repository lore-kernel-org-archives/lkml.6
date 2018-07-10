Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E8FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36E220A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KItWB+1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36E220A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbeGJWmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:42:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40667 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732258AbeGJWmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:42:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id a6-v6so17958896ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOVonLEpB15KdDJ4tIVBSy7yFCnJmuqT/9YRwse9dCQ=;
        b=KItWB+1I/Fq9nmEhHNpkX8aV8beqMfDgoVSeBNKTOXH76E0baf4QC1ew4GKUqX1c/g
         hOtQ04LiRDAR1rQH4Pjfb85tlcUN+yHRkjTp1KkXmu3lOWHaebFuxxFUj9RsHLW8nwoc
         fEomqD1UOlLNZ9a/Gl5xh3IqJRrF+C23r8tl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOVonLEpB15KdDJ4tIVBSy7yFCnJmuqT/9YRwse9dCQ=;
        b=Cd8EeEACGu/c7t3BwBJauT8RKUISZypihFa+qm5T1LNuEuMTicqXHCh7fuCBblhr2l
         1L4PU28YS8rBlzW74x0a79MQT1rPkG5JgSXHLYX3SsrBHht+obzxOWrb6GrUZ0aJe+yH
         Vpv9Fpnyoxo7GT6Ru4fEiWZvFq73yCVN27kyajWLCTnoC0lju7cP7cd7z9Kqzr6RNMEU
         RFJGc9k/g1E0IjvVgRtCxEVrgr6nqWRzzINWjNT8dqodo4rIyCRkPQv3EQuRddgt3QTM
         MCF73B2NXGrWMhmHRkP4WvC+CcidXK7QS+K91cHQ02h97rnsD+164cyBMmd0GSfLXZuP
         ydvA==
X-Gm-Message-State: APt69E1tmTXbmcScMohjXaFVCbvz5ihio9dg3+NZHBs5WEfde80taHbD
        9+3VW52QViQGAa9t4xiTXEBzikbrCbQ=
X-Google-Smtp-Source: AAOMgpfr8eNFultoXHCiVxaVgm2mZNAFcMUnUs6s2CQBWmEnhKwsoyN/68+zR9XJsB4cTFw/c5XFjg==
X-Received: by 2002:a2e:205b:: with SMTP id g88-v6mr17225402ljg.39.1531262451145;
        Tue, 10 Jul 2018 15:40:51 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id o62-v6sm4714370lfe.71.2018.07.10.15.40.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 15:40:51 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id v9-v6so7631350ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:40:51 -0700 (PDT)
X-Received: by 2002:a2e:5c07:: with SMTP id q7-v6mr15662949ljb.119.1531262099626;
 Tue, 10 Jul 2018 15:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180709155104.25528-1-georgi.djakov@linaro.org> <20180709155104.25528-5-georgi.djakov@linaro.org>
In-Reply-To: <20180709155104.25528-5-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 10 Jul 2018 15:34:23 -0700
X-Gmail-Original-Message-ID: <CAE=gft6pPcxfYqEcb-yQpf7S6CDTZNavhqYaKi37962U78qO3Q@mail.gmail.com>
Message-ID: <CAE=gft6pPcxfYqEcb-yQpf7S6CDTZNavhqYaKi37962U78qO3Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] interconnect: qcom: Add RPM communication
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
> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle communication
> with this remote processor.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom-smd.txt        | 32 +++++++
>  drivers/interconnect/qcom/Kconfig             | 11 +++
>  drivers/interconnect/qcom/Makefile            |  2 +
>  drivers/interconnect/qcom/smd-rpm.c           | 91 +++++++++++++++++++
>  drivers/interconnect/qcom/smd-rpm.h           | 15 +++
>  5 files changed, 151 insertions(+)
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
> +                       qcom,ipc = <&apcs 8 0>;
> +                       qcom,smd-edge = <15>;
> +
> +                       rpm_requests {
> +                               compatible = "qcom,rpm-msm8916";
> +                               qcom,smd-channels = "rpm_requests";
> +
> +                               interconnect-smd-rpm {
> +                                       compatible = "qcom,interconnect-smd-rpm";
> +                               };
> +
> +                       };
> +               };
> +       };
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> new file mode 100644
> index 000000000000..b0c2ff928d88
> --- /dev/null
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -0,0 +1,11 @@
> +config INTERCONNECT_QCOM
> +       bool "Qualcomm Network-on-Chip interconnect drivers"
> +       depends on INTERCONNECT
> +       depends on ARCH_QCOM || COMPILE_TEST
> +
> +config INTERCONNECT_QCOM_SMD_RPM
> +       tristate "Qualcomm SMD RPM interconnect driver"
> +       depends on INTERCONNECT_QCOM

Should this also depend on CONFIG_QCOM_SMD_RPM, since it uses
qcom_rpm_smd_write?

> +       help
> +         This is a driver for communicating interconnect related configuration
> +         details with a remote processor (RPM) on Qualcomm platforms.
...
> diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
> new file mode 100644
> index 000000000000..c33b91a3dd51
> --- /dev/null
> +++ b/drivers/interconnect/qcom/smd-rpm.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018, Linaro Ltd.
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_RPM_H
> +#define __DRIVERS_INTERCONNECT_QCOM_RPM_H

Nit: this still doesn't quite match, it would need an _SMD like:
__DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H

> +
> +#include <linux/soc/qcom/smd-rpm.h>
> +
> +bool qcom_icc_rpm_smd_available(void);
> +int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
> +
> +#endif
