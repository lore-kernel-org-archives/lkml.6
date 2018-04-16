Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeDPUeN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 16:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbeDPUeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 16:34:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E383921838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AIpwx4/EMe0FEVFNOvEdjEOBYyShHcPx4E6XcMQ09SuQmqRcoflV4U+SoKJy5IWgPeqtHtwkBWITTQUh2lWzEzA9Wjk=
MIME-Version: 1.0
In-Reply-To: <20180416172546.32118-1-eric@anholt.net>
References: <20180413175632.oz62n363g6rxdp6z@rob-hp-laptop> <20180416172546.32118-1-eric@anholt.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 16 Apr 2018 15:33:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKJD86tV0jno_cZR=nLoOThT5rjRu3BPpzAwpcHgxSArQ@mail.gmail.com>
Message-ID: <CAL_JsqKJD86tV0jno_cZR=nLoOThT5rjRu3BPpzAwpcHgxSArQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/vc4: Remove the need for the GPU-subsystem DT node.
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 12:25 PM, Eric Anholt <eric@anholt.net> wrote:
> The GPU subsystem node was a workaround to have a central device to
> bind V3D and display to.  Following the lead of 246774d17fc0
> ("drm/etnaviv: remove the need for a gpu-subsystem DT node"), remove
> the subsystem node usage and just create a platform device for the DRM
> device to attach to if any of the subsystem devices are present.
>
> v2: Simplify the DT walking code.

> +static bool
> +driver_of_table_has_a_match(const struct platform_driver *driver)
> +{
> +       struct device_node *node;
> +
> +       node = of_find_matching_node_and_match(NULL,
> +                                              driver->driver.of_match_table,
> +                                              NULL);
> +       if (of_device_is_available(node)) {
> +               of_node_put(node);

You need to put the node regardless.

> +               return true;
> +       }
> +
> +       return false;
> +}
