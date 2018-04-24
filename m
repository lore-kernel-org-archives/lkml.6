Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeDXSJF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:09:05 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:38337 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeDXSJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:09:03 -0400
X-Google-Smtp-Source: AIpwx4/PsEU7pq/5TzVT01K7x5wjI5zTWaFSjP4vg/hbHGTHMvf2bqoa2N9sQ9kx51sCrBBCTaljv+T4sHoJZa8W+I8=
MIME-Version: 1.0
In-Reply-To: <87h8o0ocul.fsf@gmail.com>
References: <87h8o0ocul.fsf@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 24 Apr 2018 11:09:02 -0700
Message-ID: <CAKgT0Udj+d7yzPN4Jph8uk7Z6fz0oyWrO+6W6CfygSYTkGJ0Xw@mail.gmail.com>
Subject: Re: [BUG] igb: reconnecting of cable not always detected
To: Holger Schurig <holgerschurig@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 8:14 AM, Holger Schurig <holgerschurig@gmail.com> wrote:
> Hi all,
>
> I'm on kernel 4.16.4 and have an issue with eth0, driver is igb. When I
> remove the ethernet cable, this is always detected:
>
> [    2.772360] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
> [    2.772363] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    3.023707] igb 0000:02:00.0: added PHC on eth0
> [    3.023710] igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
> [    3.023713] igb 0000:02:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 00:13:95:1a:54:33
> [    3.023758] igb 0000:02:00.0: eth0: PBA No: 000300-000
> [    3.023762] igb 0000:02:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
> [    7.984921] igb 0000:02:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
> [   11.184593] igb 0000:02:00.0 eth0: igb: eth0 NIC Link is Down
>
> Sometimes, plugging the cable back in is detected ...
>
> [   43.736922] igb 0000:02:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
>
> ... but sometimes this is *NOT* detected. I can put the cable in and
> even after two minutes nothing has been detected.
>
> But when I run "rmmod igb" followed by "modpobe igb", the link is
> detected again:
>
> [  100.528609] igb 0000:02:00.0 eth0: igb: eth0 NIC Link is Down
> [ 2336.583244] igb 0000:02:00.0: removed PHC on eth0
> [ 2339.693521] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
> [ 2339.693524] igb: Copyright (c) 2007-2014 Intel Corporation.
> [ 2339.990553] pps pps0: new PPS source ptp0
> [ 2339.990561] igb 0000:02:00.0: added PHC on eth0
> [ 2339.990565] igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
> [ 2339.990569] igb 0000:02:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 00:13:95:1a:54:33
> [ 2339.990611] igb 0000:02:00.0: eth0: PBA No: 000300-000
> [ 2339.990615] igb 0000:02:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
> [ 2343.001114] igb 0000:02:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
>
> (In above dmesg snippet the ethernet cable was the whole time inserted).
>
>
> Any tips on how I can debug this further?
>
> PS: I already tried a different switch and also a direct connection from
> device-to-device, without a switch.

Sounds like the link is failing to re-establish. You might double
check a few things. One is to verify if the link partner is
recognizing the link as coming up or not. That would help to tell us
if this is a problem of the driver detecting the link, or if the link
itself is not being re-established.

Another thing you could look at doing is running "ethtool -r eth0"
after plugging the cable in to see if that re-establishes the link or
not. It should be easier anyway than having to unload and reload the
driver.

If you could also provide an "lspci -vvv" and "ethtool -i" for the
device it would help us in the debugging process as it would provide
us with information on what NIC it is you are using and what firmware
is in use on it.

Thanks.

- Alex
