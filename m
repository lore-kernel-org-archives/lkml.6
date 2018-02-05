Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeBEEPw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 23:15:52 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:51384 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbeBEEPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 23:15:44 -0500
X-Google-Smtp-Source: AH8x2265V55e03b5Cjdvt0aNigB0aT8m3H2vTIsYOp325bGFKccv7/v1y57pL7ii/Ar6zU/aNndIBlN1pLHipMpNtL4=
MIME-Version: 1.0
In-Reply-To: <80377ECBC5453840BA8C7155328B5377D3410B5D@RTITMBSV06.realtek.com.tw>
References: <CAB4CAweXip+hDprJc6biwR=UtGF1xu-06HdB4ddzg9UZGL+Ngw@mail.gmail.com>
 <CAB4CAwf8zFc8DtzjceATaZbrHJakioPHp7MPb+h7Sa1ySB-_RQ@mail.gmail.com>
 <CAB4CAwfXF3RSiAMsjOe5RkAT8dh__A3677XuDwxwrarxdrZpZQ@mail.gmail.com>
 <80377ECBC5453840BA8C7155328B5377D340AC54@RTITMBSV06.realtek.com.tw>
 <CAB4CAwdRgjT+rk9WJbZzu7Ltw8CL3oAM1VeWvNz_uWYvY1Pmrg@mail.gmail.com>
 <CAB4CAwd=_J42gLoet1EQBws6ztCidqtdQrKGQ0hmx3BGzhZijg@mail.gmail.com> <80377ECBC5453840BA8C7155328B5377D3410B5D@RTITMBSV06.realtek.com.tw>
From: Chris Chiu <chiu@endlessm.com>
Date: Mon, 5 Feb 2018 12:15:42 +0800
Message-ID: <CAB4CAwftpXnue4-4N3SjcuTUNFCs527Rb7uLWtvnE=zk5c4ezg@mail.gmail.com>
Subject: Re: r8169 take too long to complete driver initialization
To: Hau <hau@realtek.com>
Cc: nic_swsd <nic_swsd@realtek.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 7:49 PM, Hau <hau@realtek.com> wrote:
>
>> -----Original Message-----
>> From: Chris Chiu [mailto:chiu@endlessm.com]
>> Sent: Friday, February 2, 2018 10:03 AM
>> To: Hau <hau@realtek.com>
>> Cc: nic_swsd <nic_swsd@realtek.com>; netdev@vger.kernel.org; Linux
>> Kernel <linux-kernel@vger.kernel.org>; Linux Upstreaming Team
>> <linux@endlessm.com>
>> Subject: Re: r8169 take too long to complete driver initialization
>>
>> On Tue, Jan 30, 2018 at 8:07 PM, Chris Chiu <chiu@endlessm.com> wrote:
>> > On Mon, Jan 29, 2018 at 11:24 PM, Hau <hau@realtek.com> wrote:
>> >> Hi Chris,
>> >>
>> >> Could you test following patch?
>> >>
>> >>  DECLARE_RTL_COND(rtl_ocp_tx_cond)
>> >>  {
>> >>         void __iomem *ioaddr = tp->mmio_addr;
>> >>
>> >> -       return RTL_R8(IBISR0) & 0x02;
>> >> +       return RTL_R8(IBISR0) & 0x20;
>> >>  }
>> >>
>> >>  static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)  {
>> >>         void __iomem *ioaddr = tp->mmio_addr;
>> >>
>> >>         RTL_W8(IBCR2, RTL_R8(IBCR2) & ~0x01);
>> >> -       rtl_msleep_loop_wait_low(tp, &rtl_ocp_tx_cond, 50, 2000);
>> >> +       rtl_msleep_loop_wait_high(tp, &rtl_ocp_tx_cond, 50, 2000);
>> >>         RTL_W8(IBISR0, RTL_R8(IBISR0) | 0x20);
>> >>         RTL_W8(IBCR0, RTL_R8(IBCR0) & ~0x01);  }
>> >>
>> >> Thanks.
>> >>
>> >
>> > Yes. It completes the initialization in 70 ms. So it means the
>> > rtl_ocp_tx_cond are waiting for incorrect register bit? Can you help work
>> out a patch for this?
>> >
>> > Chris
>> >
>> >
>>
>> Gentle ping,
>> cheers.
>>
>> Chris
>>
>
> I have submitted the patch to kernel team.
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=086ca23d03c0d2f4088f472386778d293e15c5f6
>
>

Cool. Thanks for this.

Chris

> ------Please consider the environment before printing this e-mail.
>
>> >>> -----Original Message-----
>> >>> From: Chris Chiu [mailto:chiu@endlessm.com]
>> >>> Sent: Monday, January 29, 2018 6:12 PM
>> >>> To: nic_swsd <nic_swsd@realtek.com>; netdev@vger.kernel.org; Linux
>> >>> Kernel <linux-kernel@vger.kernel.org>; Linux Upstreaming Team
>> >>> <linux@endlessm.com>
>> >>> Subject: Re: r8169 take too long to complete driver initialization
>> >>>
>> >>> On Fri, Jan 5, 2018 at 10:17 AM, Chris Chiu <chiu@endlessm.com> wrote:
>> >>> > On Wed, Dec 20, 2017 at 4:41 PM, Chris Chiu <chiu@endlessm.com>
>> wrote:
>> >>> >> Hi,
>> >>> >>     We've hit a suspend/resume issue on a Acer desktop caused by
>> >>> >> r8169 driver. The dmseg
>> >>> >>
>> https://gist.github.com/mschiu77/b741849b5070281daaead8dfee312d1a
>> >>> >> shows it's still in msleep() within a mutex lock.
>> >>> >>     After looking into the code, it's caused by the
>> >>> >> rtl8168ep_stop_cmac() which is waiting 100 seconds for
>> >>> >> rtl_ocp_tx_cond. The following dmesg states that the r8169 driver
>> >>> >> is loaded.
>> >>> >>
>> >>> >> [   20.270526] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
>> >>> >>
>> >>> >> But it takes > 100 seconds to get the following messages
>> >>> >>
>> >>> >> [  140.400223] r8169 0000:02:00.0 (unnamed net_device)
>> >>> >> (uninitialized): rtl_ocp_tx_cond == 1 (loop: 2000, delay: 50).
>> >>> >> [  140.413294] r8169 0000:02:00.0 eth0: RTL8168ep/8111ep at
>> >>> >> 0xffffb16c80db1000, f8:0f:41:ea:74:0d, XID 10200800 IRQ 46 [
>> >>> >> 140.413297] r8169 0000:02:00.0 eth0: jumbo features [frames: 9200
>> >>> >> bytes, tx checksumming: ko]
>> >>> >>
>> >>> >> So any trial to suspend the machine during this period would
>> >>> >> always get device/resource busy message then abort. Is this
>> >>> >> rtl_ocp_tx_cond necessary? Because the ethernet is still working
>> >>> >> and I don't see any problem. I don't know it should be considered
>> >>> >> normal or not. Please let me know if any more information
>> >>> >> required. Thanks
>> >>> >>
>> >>> >> Chris
>> >>> >
>> >>> > gentle ping,
>> >>> >
>> >>> > cheers.
>> >>>
>> >>> Hi,
>> >>>     Just found a r8168 driver which seems to be authrized by realtek
>> >>> for cross comparison. I tried applying the patch to latest 4.15
>> >>> kernel and the driver done it's initialization in faily short time. The patch
>> file is here
>> >>>     https://gist.github.com/mschiu77/fcf406e64a1a437f46cf2be643f1057d.
>> >>>
>> >>>     In mainline r8169.c, the IBISR0 register need to be polled in
>> >>> the rtl8168ep_stop_cmac().
>> >>> In the patch file, there's also the same IBISR0 polling code in
>> >>> Dash2DisableTx(), but it's been bypassed since the chipset maches
>> >>> HW_DASH_SUPPORT_TYPE_2.
>> >>> Per the rtl_chip_info[] in r8168_n.c, CFG_METHOD_23/27/28 are
>> >>> HW_DASH_SUPPORT_TYPE_2, and they happens to be the only 3 named
>> >>> RTL8168EP/8111EP in the rtl_chip_info[].
>> >>>
>> >>>     To find the same matches in r8169.c, RTL_GIGA_MAC_VER_49/50/51
>> >>> seems share the same config. Can anyone clarify if the
>> >>> rtl_ocp_tx_cond() really necessary for 8168EP/8111EP?
>> >>> Or we can just ignore the condition check for
>> RTL_GIGA_MAC_VER_49/50/51?
>> >>>
>> >>> Chris
>> >>>
>> >>> ------Please consider the environment before printing this e-mail.
