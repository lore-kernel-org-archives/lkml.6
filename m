Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeDSSY2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:24:28 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36712 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbeDSSY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 14:24:26 -0400
X-Google-Smtp-Source: AIpwx497YDWWgnIiyRck1XvTeRdMErTX40K96cHYB1DALNelKDIzuZuOLcYsKo56uqPDYdKtA+iwhzX49y8bao+TRWw=
MIME-Version: 1.0
In-Reply-To: <1524154267.17017.15.camel@nxp.com>
References: <20180411183622.305902791@linuxfoundation.org> <20180411183630.390575424@linuxfoundation.org>
 <CA+G9fYtR_3AXKvhrkE3WEZhVOX6XwJ1r38PLav1XKkz4L4eQZQ@mail.gmail.com> <1524154267.17017.15.camel@nxp.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 19 Apr 2018 23:54:24 +0530
Message-ID: <CA+G9fYs00cOVxuWYkfUxkdYZX5NGeTgBpwimCJ7tJbANbZwGEA@mail.gmail.com>
Subject: Re: [PATCH 4.9 181/310] net: phy: micrel: Restore led_mode and
 clk_sel on resume
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 April 2018 at 21:41, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> On Thu, 2018-04-19 at 17:02 +0530, Naresh Kamboju wrote:
>> On 12 April 2018 at 00:05, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> >
>> > 4.9-stable review patch.  If anyone has any objections, please let me know.
>> >
>> > ------------------
>> >
>> > From: Leonard Crestez <leonard.crestez@nxp.com>
>> >
>> > [ Upstream commit 79e498a9c7da0737829ff864aae44df434105676 ]
>> >
>> > These bits seem to be lost after a suspend/resume cycle so just set them
>> > again. Do this by splitting the handling of these bits into a function
>> > that is also called on resume.
>> >
>> > This patch fixes ethernet suspend/resume on imx6ul-14x14-evk boards.
>> >
>> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>> > Signed-off-by: David S. Miller <davem@davemloft.net>
>> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > ---
>> >  drivers/net/phy/micrel.c |   42 ++++++++++++++++++++++++++++--------------
>> >  1 file changed, 28 insertions(+), 14 deletions(-)
>
>> arm32 x15 device booting 4.9 kernel shows kernel warning and
>> the network is not working on the device.
>>
>> Linux version 4.9.95-rc1 (buildslave@lkft-01) (gcc version 6.2.1 20161016
>>  (Linaro GCC 6.2-2016.11) ) #1 SMP Tue Apr 17 19:12:22 UTC 2018
>>
>> Boot log kernel crash log:
>> --------------------------
>> [   13.766589] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>> [   13.805441] net eth0: initializing cpsw version 1.15 (0)
>> [   13.930334] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000008
>> [   13.982009] PC is at kszphy_config_reset+0x1c/0x150
>> [   13.986909] LR is at kszphy_resume+0x24/0x64
>> LAVA job id: https://lkft.validation.linaro.org/scheduler/job/187429#L3341
>
> Looking at this dump I'm guessing that phydev->priv is NULL at the
> start of kszphy_config_reset and this really shouldn't be happening.
>
> The phydev->priv field is initialized by kszphy_probe but your
> particular phy (KSZ9031) in linux-4.9.y does not seem to have .probe =
> kszphy_probe assigned in the struct phy_driver ksphy_driver array.
>
> In upstream this was added by commit bfe72442578b ("net: phy: micrel:
> fix crash when statistic requested for KSZ9031 phy"). The message for
> that patch claims to fix a kernel crash on this command:
>
>     ethtool --phy-statistics eth0
>
> Looking at the code this issue should affect linux-4.9.y on your board.
> Naresh: can you please check?

After reverting the patch i have run this command and kernel oops showed up.
ethtool --phy-statistics eth0

PC is at kszphy_get_stats+0x74/0xa8

ethtool --phy-statistics eth0 crashed on x15
https://pastebin.com/8cGBMuxC

- Naresh
