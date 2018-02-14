Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030716AbeBNOXr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:23:47 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41505 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030419AbeBNOXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:23:45 -0500
X-Google-Smtp-Source: AH8x227bK7Q7CcexG1my6iytUI0M7y/0kknpqjgYR6akSi9Od3HLi08ZqVm1TKJfqVxW9jzwMlqAKcnmWVGF45QlN40=
MIME-Version: 1.0
In-Reply-To: <20180213170018.9780-19-mika.westerberg@linux.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com> <20180213170018.9780-19-mika.westerberg@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2018 16:23:44 +0200
Message-ID: <CAHp75VcwWDTFnBcLotrABvWhT7a=-Z-vue8nB6hko1BaSqKQPQ@mail.gmail.com>
Subject: Re: [PATCH 18/18] thunderbolt: Add support for Intel Titan Ridge
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 7:00 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> Intel Titan Ridge is the next Thunderbolt 3 controller. The ICM firmware
> message format in Titan Ridge differs from Falcon Ridge and Alpine Ridge
> somewhat because it is using route strings addressing devices. In
> addition to that the DMA port of 4-channel (two port) controller is in
> different port number than the previous controllers. There are some
> other minor differences as well.
>
> This patch add support for Intel Titan Ridge and the new ICM firmware
> message format.

>  static int dma_find_port(struct tb_switch *sw)
>  {
> +       static const int ports[] = { 7, 5, 3 };

Is it anything special in ordering? Otherwise I would keep it the same
as in comment below.

> +       int i;
>
>         /*
> +        * The DMA (NHI) port is either 3, 5 or 7 depending on the
> +        * controller. Try all of them.
>          */
> +       for (i = 0; i < ARRAY_SIZE(ports); i++) {
> +               u32 type;
> +               int ret;
> +
> +               ret = dma_port_read(sw->tb->ctl, &type, tb_route(sw), ports[i],
> +                                   2, 1, DMA_PORT_TIMEOUT);
> +               if (!ret && (type & 0xffffff) == TB_TYPE_NHI)
> +                       return ports[i];
> +       }

> +static inline u64 get_parent_route(u64 route)
> +{
> +       int depth = tb_route_length(route);
> +       return depth ? route & ~((u64)0xff << (depth - 1) * TB_ROUTE_SHIFT) : 0;

0xffULL ?

> +}

> +       const struct icm_tr_event_device_connected *pkg =
> +               (const struct icm_tr_event_device_connected *)hdr;

> +       const struct icm_tr_event_device_disconnected *pkg =
> +               (const struct icm_tr_event_device_disconnected *)hdr;

> +       const struct icm_tr_event_xdomain_connected *pkg =
> +               (const struct icm_tr_event_xdomain_connected *)hdr;

> +       const struct icm_tr_event_xdomain_disconnected *pkg =
> +               (const struct icm_tr_event_xdomain_disconnected *)hdr;


>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_USBONLY_NHI        0x15dc
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_USBONLY_NHI   0x15dd
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_USBONLY_NHI 0x15de

> +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI         0x15e8
> +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_BRIDGE      0x15e7
> +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI         0x15eb
> +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE      0x15ea
> +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE      0x15ef

Can we keep it sorted?

> +#define ICM_TR_INFO_SLEVEL_MASK                0x7

GENMASK() ?

> +#define ICM_TR_INFO_BOOT_ACL_SHIFT     7
> +#define ICM_TR_INFO_BOOT_ACL_MASK      GENMASK(12, 7)

-- 
With Best Regards,
Andy Shevchenko
