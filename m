Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF050C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C12326C74
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GcejPAU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C12326C74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934125AbeFZUzE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:55:04 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44841 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933810AbeFZUzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:55:00 -0400
Received: by mail-ot0-f195.google.com with SMTP id w13-v6so20542894ote.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZM+bJQWF7l/EjU3i3mcRHRPbKph38WHpiFKd1YMHhBo=;
        b=GcejPAU4js1eCabY8h9ISXWW/bAyCfGotUspL+sQlkSTdr1x/njS6YqFbesENrWbKW
         0bz0gxxn28ZXI6KUp4podPv09EJKLSWGYCx2qL6sSYKbOCjSmotgwsf3irL90k2NTQA2
         /BuC8ExWGwhLlgceJk91TOnjdn5CetuxPhOhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZM+bJQWF7l/EjU3i3mcRHRPbKph38WHpiFKd1YMHhBo=;
        b=fCxmpB9ycqaNyBlUP94UQmpDHNr8Mnh+j9ONdM/hfENy7M1ZypDSZviKuYJQV5uMFk
         rGYH9oIXBmZYViLhSMvOEGxaE4tEzIJ5r6GycoT7+g+XZ8YO1qYyuBlAM+ahHHOg9CLe
         xe9RVdE/YqzeRVsBsKWsNOHdHnGHr0TXP1nTEw+WZAN1wTQjn5mG6V5aLDYcmhJFaJJk
         TcX0I0B7iHJNqdpQoACQJXTaLNqBkZP7cV84pGyTVogkbD2P+3Yf8H2R9CSupAArgClb
         Zpb2O+autB7f9Gq/aVuZ0iYWxO89KxdYoscYysyNfytMZAYfTYS1eKs9ZVZ3nlE4Nvg1
         mWjw==
X-Gm-Message-State: APt69E3uCbtaz+CUDILu3ilLJG+NyJCyl9EKrlHAnIofv54Bdo5+ZiMW
        eM00LscIAO7yDgqHU0cNyuLkM54dggc=
X-Google-Smtp-Source: AAOMgpemOE9rRvhXVOWulP3+xMdb4Nn7y7d99vrRw8uqg+abgUWDMqKRtEqJt8RTchzgq/IPJOQulA==
X-Received: by 2002:a9d:4905:: with SMTP id e5-v6mr1927633otf.101.1530046499368;
        Tue, 26 Jun 2018 13:54:59 -0700 (PDT)
Received: from mail-ot0-f182.google.com (mail-ot0-f182.google.com. [74.125.82.182])
        by smtp.gmail.com with ESMTPSA id b26-v6sm1156836otl.41.2018.06.26.13.54.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 13:54:59 -0700 (PDT)
Received: by mail-ot0-f182.google.com with SMTP id l15-v6so20560691oth.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:54:58 -0700 (PDT)
X-Received: by 2002:a9d:350a:: with SMTP id o10-v6mr1700137otc.247.1530046109535;
 Tue, 26 Jun 2018 13:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180620121141.15403-1-georgi.djakov@linaro.org> <20180620121141.15403-5-georgi.djakov@linaro.org>
In-Reply-To: <20180620121141.15403-5-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 26 Jun 2018 13:47:52 -0700
X-Gmail-Original-Message-ID: <CAE=gft7+S7MJHB2jw8SNewNcr2OvK+1a-PdJdcaonTphJX7c8A@mail.gmail.com>
Message-ID: <CAE=gft7+S7MJHB2jw8SNewNcr2OvK+1a-PdJdcaonTphJX7c8A@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] interconnect: qcom: Add RPM communication
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

On Wed, Jun 20, 2018 at 5:11 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle comminication
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
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> new file mode 100644
> index 000000000000..2a0c41db91c4
> --- /dev/null
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-y += smd-rpm.o

This new file has an unexpressed dependency on CONFIG_QCOM_SMD_RPM due
to qcom_rpm_smd_write. RPMh-based systems won't need this file, right?
Maybe this file should live behind some config?

> diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
> new file mode 100644
> index 000000000000..0cf772f51642
> --- /dev/null
> +++ b/drivers/interconnect/qcom/smd-rpm.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RPM over SMD communication wrapper for interconects
> + *
> + * Copyright (C) 2018 Linaro Ltd
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/qcom/smd-rpm.h>
> +#include "smd-rpm.h"
> +
> +#define        RPM_KEY_BW      0x00007762
> +
> +static struct qcom_icc_rpm {
> +       struct qcom_smd_rpm *rpm;
> +} icc_rpm_smd;
> +
> +struct icc_rpm_smd_req {
> +       __le32 key;
> +       __le32 nbytes;
> +       __le32 value;
> +};
> +
> +bool qcom_icc_rpm_smd_available(void)
> +{
> +       if (!icc_rpm_smd.rpm)
> +               return false;
> +
> +       return true;
> +}
> +
> +int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
> +{
> +       struct icc_rpm_smd_req req = {
> +               .key = cpu_to_le32(RPM_KEY_BW),
> +               .nbytes = cpu_to_le32(sizeof(u32)),
> +               .value = cpu_to_le32(val),
> +       };
> +
> +       return qcom_rpm_smd_write(icc_rpm_smd.rpm, ctx, rsc_type, id, &req,
> +                                 sizeof(req));
> +}
> +EXPORT_SYMBOL(qcom_icc_rpm_smd_send);
> +
> +static int qcom_icc_rpm_smd_probe(struct platform_device *pdev)
> +{
> +       icc_rpm_smd.rpm = dev_get_drvdata(pdev->dev.parent);
> +       if (!icc_rpm_smd.rpm) {
> +               dev_err(&pdev->dev, "unable to retrieve handle to RPM\n");
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id qcom_icc_rpm_smd_dt_match[] = {
> +       { .compatible = "qcom,interconnect-smd-rpm", },
> +       { },
> +};
> +
> +MODULE_DEVICE_TABLE(of, qcom_interconnect_rpm_smd_dt_match);
> +
> +static struct platform_driver qcom_interconnect_rpm_smd_driver = {
> +       .driver = {
> +               .name           = "qcom-interconnect-smd-rpm",
> +               .of_match_table = qcom_icc_rpm_smd_dt_match,
> +       },
> +       .probe = qcom_icc_rpm_smd_probe,
> +};
> +
> +static int __init rpm_smd_interconnect_init(void)
> +{
> +       return platform_driver_register(&qcom_interconnect_rpm_smd_driver);
> +}
> +subsys_initcall(rpm_smd_interconnect_init);
> +
> +static void __exit rpm_smd_interconnect_exit(void)
> +{
> +       platform_driver_unregister(&qcom_interconnect_rpm_smd_driver);
> +}
> +module_exit(rpm_smd_interconnect_exit)
> +
> +MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
> +MODULE_DESCRIPTION("Qualcomm SMD RPM interconnect driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
> new file mode 100644
> index 000000000000..0f4a3da31cf6
> --- /dev/null
> +++ b/drivers/interconnect/qcom/smd-rpm.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018, Linaro Ltd.
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#ifndef __LINUX_INTERCONNECT_QCOM_RPM_H
> +#define __LINUX_INTERCONNECT_QCOM_RPM_H

This doesn't really reflect the path, should this be something different?

> +
> +#include <linux/soc/qcom/smd-rpm.h>
> +
> +bool qcom_icc_rpm_smd_available(void);
> +int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
> +
> +#endif
