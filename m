Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758782AbeD0Qe1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:34:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53585 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758568AbeD0QeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:34:25 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v1 6/7] Bluetooth: hci_mediatek: Add protocol support for
 MediaTek serial devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1524820468.12322.205.camel@mtkswgap22>
Date: Fri, 27 Apr 2018 18:34:22 +0200
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CB157958-F0F1-4728-9B4C-1799BC60A2C4@holtmann.org>
References: <cover.1522736996.git.sean.wang@mediatek.com>
 <f0e0a0b7f1dc3845dc6eafb4ccd60284d1675f8d.1522736996.git.sean.wang@mediatek.com>
 <A7391E5D-2945-415B-8AB1-8DFBF2E65878@holtmann.org>
 <1524728068.12322.125.camel@mtkswgap22>
 <0DB4E6C1-28AD-41B7-8623-10046809A686@holtmann.org>
 <1524802381.12322.164.camel@mtkswgap22>
 <BBFEF77F-BE5D-4092-BB2B-8844C10CC34E@holtmann.org>
 <1524820468.12322.205.camel@mtkswgap22>
To: Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

>>>>>>> This adds a driver for the MediaTek serial protocol based on H4 protocol,
>>>>>>> which can enable the built-in Bluetooth device inside MT7622 SoC.
>>>>>>> 
>>>>>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>>>>>> ---
>>> 
> 
> [... snip ...]
> 
>>> 
>>> where could I find the newest btuart.c (which seems cannot be found in
>>> 4.17 rc2)? It seems a time to rewrite the driver based on btuart.c
>> 
>> It is not merged yet. I posted RFC patches to the mailing list.
>> 
> 
> got it.
> 
>>> 
>>> the Bluetooth device can't survive in a power/down cycle and
>>> 
>>> * power on should be including
>>> - enable clk and power domain
>>> - download firmware through specific ACL command
>>> - send specific commands to configure bluetooth (Required to note that
>>> the steps should be after downloading firmware because the behavior for
>>> the command might be changed by the firmware)
>> 
>> Then this sounds like you need a quirk that runs setup() after every open() and not just after the first open(). You would be the first hardware that looses their firmware, but that is fine, I almost expect that at some point someone comes along and requires this. So just create a new HCI_QUIRK_NON_PERSISTENT_SETUP.
>> 
> 
> Yes, it should be good to have an option HCI_QUIRK_NON_PERSISTENT_SETUP
> to allow us to run setup() for every open(). 
> 
> When users are feeling unexpected thing happening on its device, they
> always have a habit trying to restart device from UI.
> 
> If close() -> open() can completely power reset a bluetooth device and
> then it can recover from any fatal error to the initial state as at
> boot. It's good for these problems specially hard to be reproduced and
> required to reboot the whole machine to save.
> 
> However, it would take a little longer time on open() since it takes
> extra time to make firmware download and reconfiguration.

if setup() is smart enough to skip the firmware download if it is already active, you can avoid these kind of things. It is up to your hardware. All the devices I have encountered so far only needed setup() once. Maybe some can be more power aggressive via GPIOs to full reset the hardware, but that could also be achieved via RFKILL. We need to see how this shapes up with your hardware. An alternative could be HCI_QUIRK_SETUP_AFTER_RFKILL and that means only the rfkill switch that brings down hciX interfaces will cause the full cycle.

My recommendation is to not worry too much here. You want to get the base logic done and then we deal with the rest. Maybe doing ->post_open() and ->pre_close() is more useful since you want HCI transport to send a HCI command to complete transport activation and shutdown.

> 
>>> * power off should be including
>>> - send specific commands, such as to disable bluetooth
>> 
>> So try to put these in shutdown()
>> 
> 
> got it.
> 
>>> - disable power domain and clk
>> 
>> And do this in close().
>> 
> 
> got it.
> 
> 
>>> 
>>>>> 
>>>>>>> +
>>>>>>> +	return err;
> 
> 
> [ ... snip ....]
> 
>>      .open           = mtk_open,
>>>> 
>> 
>> Go with a brand new btmtkuart.c driver. I really sounds you don’t want the hci_ldisc.c framework in your way. You want direct control over the core callbacks.
>> 
> 
> 1)
> 
> In fact. the device is working via a internal serial bus, rather than
> via uart for mt7622. so could i call it btmtkserial.c ?
> 
> Becasue mediatek indeed also have bluetooth over uart, if i called it
> btmtkserialc, the same code logic I think can be fit to all other
> devices using either uart or internal serial bus.

It is just a name so far. Start with btmtkuart.c for now. We will sort that naming out later. Mind you that as long as this is abstracted via serdev, it doesn’t really matter what it is in detail. It is just that Bluetooth called H:4 UART and H:5 3-Wire UART. These are the two UART protocol we are running. That you have extra serial bus framing is just some other detail. But picking the final driver name is something we worry about after detailed review.

> 
> 2)
> 
> Yes, i don't want hci_ldisc. so far i thought serdev version is enough,
> and i preferred that bluetotoh device don't depend on any utility on
> user space to launch.

serdev is the way to go. I will not accept any now drivers that require btattach.

> 
> 3) 
> 
> last question
> 
> if i have bluetooth over usb, the usb version bluetooth can reuse
> btmtkserial.c code?

We would most likely create a btmtk.c for shared code. Similar to btintel.c, btbcm.c etc. However lets do that in step two since it is harder to review.

Regards

Marcel
