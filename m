Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbeEBMEU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:04:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37685 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeEBMET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:04:19 -0400
X-Google-Smtp-Source: AB8JxZqLSnQmNdZFdzwjk9Ujl62z0hhFp6mulBDoGX8J1+/rUmEi8iFE6QPi6UABFIiPCalz17PYdyQLJDJioPJ87V0=
MIME-Version: 1.0
In-Reply-To: <1525245244-15336-1-git-send-email-samarth.parikh@arm.com>
References: <1525245244-15336-1-git-send-email-samarth.parikh@arm.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 2 May 2018 17:34:17 +0530
Message-ID: <CABb+yY00AJ3ZBAU3R-=eaLJfBooY23JAiPaYxi=8MdCczKmZHw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: arm_mhu: add support for mhuv2
To: Samarth Parikh <samarth.parikh@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudipto.Paul@arm.com, Arvind.Chauhan@arm.com, samarthp@ymail.com,
        Deepak.Pandey@arm.com, Sudeep Holla <Sudeep.Holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 12:44 PM, Samarth Parikh <samarth.parikh@arm.com> wrote:
> Hi Jassi,
>
> I am resending the patch for review, in case you have missed my previous
> patch. Can you please go through it and let me know your thoughts on
> the same?
>
You don't want this to go into git log :)
If your patch isn't looked into for more than 2weeks (or longer if
merge window is not near), please just ping as a reply to original
submission.
Anyways....

> ARM has launched a next version of MHU i.e. MHUv2 with its latest
> subsystems. The main change is that the MHUv2 is now a distributed IP
> with different peripheral views (registers) for the sender and receiver.
>
> Another main difference is that MHUv1 duplex channels are now split into
> simplex/half duplex in MHUv2. MHUv2 has a configurable number of
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
> This patch adds necessary changes required to support the older
> version of MHU & the latest MHUv2 controller. This patch also need an
> update in DT binding for ARM MHU as we need a second register base
> (tx base) which would be used as the send channel base.
>
> Signed-off-by: Samarth Parikh <samarth.parikh@arm.com>
> ---
>  drivers/mailbox/arm_mhu.c | 163 ++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 151 insertions(+), 12 deletions(-)
>
The original driver is 195 loc, this patch makes it almost double the size.
Also there have been controllers (resembling closer to MHU than this
one) with separate drivers. So I think we should simply create another
arm_mhu_v2.c ?

Cheers!
