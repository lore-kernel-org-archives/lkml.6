Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165158AbeE1NG5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:06:57 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:53603 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164069AbeE1NGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:06:47 -0400
X-Google-Smtp-Source: AB8JxZoSKDvJqnayjvdZD9csL5gk664QTR7uYpCs0kb9GQU+Wx6HFgpeBhqD3cT9whK36ZCFveUCiYsTVR06sEihfg0=
MIME-Version: 1.0
In-Reply-To: <1526544259-27891-1-git-send-email-samarth.parikh@arm.com>
References: <1526544259-27891-1-git-send-email-samarth.parikh@arm.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 28 May 2018 18:36:45 +0530
Message-ID: <CABb+yY03QuwktEAOk6Qzr+-h8Z9iJJQAYo_tgdt9iiD3Ud9GYA@mail.gmail.com>
Subject: Re: [PATCH v2] mailbox: arm_mhu: add support for mhuv2
To: Samarth Parikh <samarth.parikh@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudipto.Paul@arm.com, Arvind Chauhan <Arvind.Chauhan@arm.com>,
        Deepak.Pandey@arm.com, samarthp@ymail.com,
        Sudeep Holla <Sudeep.Holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 1:34 PM, Samarth Parikh <samarth.parikh@arm.com> wrote:
> ARM has launched a next version of MHU i.e. MHUv2 with its latest
> subsystems. The main change is that the MHUv2 is now a distributed IP
> with different peripheral views (registers) for the sender and receiver.
>
> Another main difference is that MHUv1 duplex channels are now split into
> simplex/half duplex in MHUv2.
>
Not sure what you mean. v1 too had separate rx, tx channels.
Is the MHUv2 spec available somewhere for me to have a look? If not,
please share the register map.

 MHUv2 has a configurable number of
> communication channels. There is a capability register (MSG_NO_CAP) to
> find out how many channels are available in a system.
>
> The register offsets have also changed for STAT, SET & CLEAR registers
> from 0x0, 0x8 & 0x10 in MHUv1 to 0x0, 0xC & 0x8 in MHUv2 respectively.
>
> 0x0    0x4  0x8  0xC             0x1F
> ------------------------....-----
> | STAT |    |    | SET |    |   |
> ------------------------....-----
>       Transmit Channel
>
> 0x0    0x4  0x8   0xC            0x1F
> ------------------------....-----
> | STAT |    | CLR |    |    |   |
> ------------------------....-----
>         Receive Channel
>
> The MHU controller can request the receiver to wake-up and once the
> request is removed, the receiver may go back to sleep, but the MHU
> itself does not actively puts a receiver to sleep.
>
> So, in order to wake-up the receiver when the sender wants to send data,
> the sender has to set ACCESS_REQUEST register first in order to wake-up
> receiver, state of which can be detected using ACCESS_READY register.
> ACCESS_REQUEST has an offset of 0xF88 & ACCESS_READY has an offset
> of 0xF8C and are accessible only on any sender channel.
>

> This patch adds necessary changes in a new file required to support the
> latest MHUv2 controller. This patch also need an update in DT binding for
> ARM MHUv2 as we need a second register base (tx base) which would be used
> as the send channel base.
>
Please submit the dt-bindings as well.

......

> +
> +#define MHU_V2_REG_STAT_OFS            0x0
> +#define MHU_V2_REG_CLR_OFS             0x8
> +#define MHU_V2_REG_SET_OFS             0xC
> +#define MHU_V2_REG_MSG_NO_CAP_OFS      0xF80
> +#define MHU_V2_REG_ACC_REQ_OFS         0xF88
> +#define MHU_V2_REG_ACC_RDY_OFS         0xF8C
> +
> +#define MHU_V2_LP_OFFSET               0x20
> +#define MHU_V2_HP_OFFSET               0x0
> +
 and the third channel please.

> +#define MHU_V2_CHANS                   3
> +
> +#define mbox_to_mhuv2_drv_data(c) container_of(c, struct mhuv2_drv_data, mbox)
> +
> +enum mhuv2_regs {
> +       MHU_V2_REG_STAT,
> +       MHU_V2_REG_SET,
> +       MHU_V2_REG_CLR,
> +       MHU_V2_REG_END
> +};
> +
> +enum mhuv2_access_regs {
> +       MHU_V2_REG_MSG_NO_CAP,
> +       MHU_V2_REG_ACC_REQ,
> +       MHU_V2_REG_ACC_RDY,
> +       MHU_V2_REG_ACC_END
> +};
> +
> +enum mhuv2_channels {
> +       MHU_V2_CHAN_LOW,
> +       MHU_V2_CHAN_HIGH,
> +       MHU_V2_CHAN_SEC,
> +       MHU_V2_CHAN_END
> +};
> +
These three are unused.


> +struct mhuv2_dev_data {
> +       int regs[MHU_V2_REG_END]; /* STAT, SET, CLEAR */
> +       int chans[MHU_V2_CHAN_END]; /* LP, HP, Sec */
> +       int acc_regs[MHU_V2_REG_ACC_END];
> +};
> +
This looks ugly and was the main reason I suggested separating out the
mhu-v2 from v1.
Please use MHU_V2_REG_xxx directly.

Thanks
