Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755769AbeDYQCF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:02:05 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:42584 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754954AbeDYQB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:01:58 -0400
X-Google-Smtp-Source: AIpwx49WzMxSkgyi2j4TYohw2Cgj2PGLNMAl0y3CwV7O8l0DYOTUh02ARE9C/hq9WaZtzia/YdtWt3yBh0RYepL7gYk=
MIME-Version: 1.0
In-Reply-To: <877eovobxl.fsf@gmail.com>
References: <87h8o0ocul.fsf@gmail.com> <CAKgT0Udj+d7yzPN4Jph8uk7Z6fz0oyWrO+6W6CfygSYTkGJ0Xw@mail.gmail.com>
 <877eovobxl.fsf@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 25 Apr 2018 09:01:54 -0700
Message-ID: <CAKgT0UdTf5pf53==hB71Ba_N1gJ-TH_3uMajozr1wykLEbK80g@mail.gmail.com>
Subject: Re: [BUG] igb: reconnecting of cable not always detected
To: Holger Schurig <holgerschurig@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 2:47 AM, Holger Schurig <holgerschurig@gmail.com> wrote:
> Hi Alex,
>
> (Sent a 2nd time, this time with "Reply to all" and without HTML, so
> that it hits the kernel archives as well. Sorry for the noise.
>
>
>
>
>> Sounds like the link is failing to re-establish. You might double
>> check a few things. One is to verify if the link partner is
>> recognizing the link as coming up or not.
>
> It turns on differently. Before I remove the cable, the LED on the TP
> LINK "TL SG-108" was green. After removing the cable, the LED went off.
> After reinserting the cable, it became orange after some while.
>
> Green LED means 1000 MB/s, orange LED means 10/100 MB/s.

Was the orange LED on the igb NIC or on the TL SG-108? Based on the
comment below I am assuming it is the switch.

Based on that I am thinking we probably need to work on the PHY configuration.

> I have a different, even older switch: "Allnet ALL8039". Here the same:
> the switch detects a link, but igb not.
>
>
>
>> If you could also provide an "lspci -vvv"
>
> 02:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
> Connection (rev 03)

Okay so we are working with an i210.

>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 19
>         Region 0: Memory at 90600000 (32-bit, non-prefetchable) [size=512K]
>         Region 2: I/O ports at d000 [size=32]
>         Region 3: Memory at 90680000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>                 Address: 0000000000000000  Data: 0000
>                 Masking: 00000000  Pending: 00000000
>         Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
>                 Vector table: BAR=3 offset=00000000
>                 PBA: BAR=3 offset=00002000
>         Capabilities: [a0] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 <64us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> SlotPowerLimit 0.000W
>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
> Unsupported+
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> FLReset-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+
> TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <2us, L1 <16us
>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-,
> OBFF Not Supported
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+,
> LTR-, OBFF Disabled
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
> SpeedDis-
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+
> ChkEn-
>         Capabilities: [140 v1] Device Serial Number 00-13-95-ff-ff-1a-54-33
>         Capabilities: [1a0 v1] Transaction Processing Hints
>                 Device specific mode supported
>                 Steering table in TPH capability structure
>         Kernel driver in use: igb
>         Kernel modules: igb
>
>> and "ethtool -i" for the
>
> driver: igb
> version: 5.4.0-k
> firmware-version: 3.20, 0x80000553
> expansion-rom-version:
> bus-info: 0000:02:00.0
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: yes
> supports-register-dump: yes
> supports-priv-flags: yes
>
>
>
> One thing that is interesting is how igb reacts to ethtool inquiries
> once it goes into the failed state. You inquired for "ethtool -i eth0",
> but in the failed state I only get this:
>
> Cannot restart autonegotiation: No such device

I assume you mean "ethtool -r" since that is what is supposed to be
restarting negotiation. The "ethtool -i" is what you provided above.

The fact that the device disappears is a bit concerning. I'm wondering
if we are somehow triggering the surprise removal code.

> But eth0 is of course still there, "ip -d link show eth0" shows:
>
>
> 2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN
> mode DEFAULT group default qlen 1000
>     link/ether 00:13:95:1a:54:33 brd ff:ff:ff:ff:ff:ff promiscuity 0
>     numtxqueues 8 numrxqueues 8 gso_max_size 65536 gso_max_segs 65535
>
>
>
>
>
> Other ethtool commands also don't report any information once the link
> went bogus. Here one output from "ethtool eth0":
>
> Settings for eth0:
>         Supported ports: [ TP ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Full
>         Supported pause frame use: Symmetric
>         Supports auto-negotiation: Yes
>         Advertised link modes:  10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Full
>         Advertised pause frame use: Symmetric
>         Advertised auto-negotiation: Yes
>         Speed: 1000Mb/s
>         Duplex: Full
>         Port: Twisted Pair
>         PHYAD: 1
>         Transceiver: internal
>         Auto-negotiation: on
>         MDI-X: off (auto)
>         Supports Wake-on: pumbg
>         Wake-on: g
>         Current message level: 0x00000007 (7)
>                                drv probe link
>         Link detected: yes
>
> ... and here another:
>
> Settings for eth0:
> Cannot get device settings: No such device
> Cannot get wake-on-lan settings: No such device
> Cannot get message level: No such device
> Cannot get link status: No such device
> Settings for eth0:
> No data available
>
>
>
> I'm willing to pepper the source with printk, if this helps :-)
>
>
> Greetings,
> Holger

Thanks. I'm suspecting we may need to instrument igb_rd32 at this
point. In order to trigger what you are seeing I am assuming the
device has been detached due to a read failure of some sort.

Another thing you could look at doing is narrowing down the possible
factors involved. You could go through and limit phy settings and look
at possibly dropping features such as EEE if it is enabled on the
device.

Thanks.

- Alex
