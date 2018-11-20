Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88C4C32788
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC4A2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC4A2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeKUI41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:56:27 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:39693 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbeKUI41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:56:27 -0500
Received: from [192.168.0.4] (ip5f5bf248.dynamic.kabel-deutschland.de [95.91.242.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 51D0E2012BAC06;
        Tue, 20 Nov 2018 23:25:01 +0100 (CET)
Subject: Re: Realtek NIC uses over 1 Watt with no traffic
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <081beaeb-be22-55b3-2927-fec04e9f714a@molgen.mpg.de>
 <20181120144556.GC18335@lunn.ch>
 <c3ff00a1-ac51-7f27-8e90-b753f316866d@gmail.com>
 <524e54fa-c7b2-7cf5-7bd1-7b9ad7a64a46@molgen.mpg.de>
 <25b108c7-342e-e123-eb35-d1e6823102ea@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <f75d832e-4b5b-8c7c-d5d9-013f9d5cacef@molgen.mpg.de>
Date:   Tue, 20 Nov 2018 23:25:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <25b108c7-342e-e123-eb35-d1e6823102ea@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Heiner,


Am 20.11.18 um 22:06 schrieb Heiner Kallweit:
> On 20.11.2018 21:31, Paul Menzel wrote:

[…]

>> Am 20.11.18 um 21:14 schrieb Heiner Kallweit:
>>> On 20.11.2018 15:45, Andrew Lunn wrote:
>>>> On Tue, Nov 20, 2018 at 09:40:25AM +0100, Paul Menzel wrote:
>>
>>>>> Using Ubuntu 18.10, Linux 4.18.0-11-generic, PowerTOP 2.9 shows, the NIC
>>>>> uses 1.77 Watts. A network cable is plugged in, but there is no real traffic
>>>>> according to `iftop`. Only an email program is running.
>>>>>
>>>>>       $ lspci -nn -s 3:00.1
>>>>>       03:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
>>>>> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev
>>>>> 12)
>>>>>
>>>>> Is that a measurement error, or does the NIC really need that much power?
>>
>>>> This sounds like Energy Efficient Ethernet, EEE, is not enabled.
>>>>
>>>> What does ethtool --show-eee ethX say?
>>
>>      $ sudo ethtool --show-eee enp3s0f1
>>      Cannot get EEE settings: Operation not supported
>>
>>> The r8169 driver doesn't support the get_eee ethtool_ops callback.
>>> For certain chip versions EEE gets enabled in the PHY init, for others
>>> not and some don't seem to support EEE at all.
>>>
>>> Apart from EEE one important factor affecting power consumption is ASPM.
>>> This was recently enabled for certain chip versions.
>>>
>>> Information that would help:
>>>
>>> whether Wake-on-LAN is enabled ("Wake-on:" line from ethtool output)
>>
>> ```
>> $ sudo ethtool enp3s0f1
>> Settings for enp3s0f1:
>>      Supported ports: [ TP AUI BNC MII FIBRE ]
>>      Supported link modes:   10baseT/Half 10baseT/Full
>>                              100baseT/Half 100baseT/Full
>>                              1000baseT/Full
>>      Supported pause frame use: Symmetric Receive-only
>>      Supports auto-negotiation: Yes
>>      Supported FEC modes: Not reported
>>      Advertised link modes:  10baseT/Half 10baseT/Full
>>                              100baseT/Half 100baseT/Full
>>                              1000baseT/Full
>>      Advertised pause frame use: Symmetric Receive-only
>>      Advertised auto-negotiation: Yes
>>      Advertised FEC modes: Not reported
>>      Link partner advertised link modes:  10baseT/Half 10baseT/Full
>>                                           100baseT/Half 100baseT/Full
>>                                           1000baseT/Full
>>      Link partner advertised pause frame use: Symmetric
>>      Link partner advertised auto-negotiation: Yes
>>      Link partner advertised FEC modes: Not reported
>>      Speed: 1000Mb/s
>>      Duplex: Full
>>      Port: MII
>>      PHYAD: 0
>>      Transceiver: internal
>>      Auto-negotiation: on
>>      Supports Wake-on: pumbg
>>      Wake-on: g
>>      Current message level: 0x00000033 (51)
>>                     drv probe ifdown ifup
>>      Link detected: yes
>> ```
>>
>> So, it’s enabled (g  Wake on MagicPacket(tm)).
>>
>> Running `sudo ethtool -s enp3s0f1 wol d;` doesn’t change anything though.
>>
>>> lspci -vv output for the Realtek NIC
>>
>> Here is the output (quoted, so that Thunderbird does not wrap the line).
>>
>>> $ sudo lspci -vv -s 3:00.1
>>> 03:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)
>>>      Subsystem: CLEVO/KAPOK Computer RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
>>>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0, Cache Line Size: 64 bytes
>>>      Interrupt: pin A routed to IRQ 19
>>>      Region 0: I/O ports at e000 [size=256]
>>>      Region 2: Memory at df114000 (64-bit, non-prefetchable) [size=4K]
>>>      Region 4: Memory at df110000 (64-bit, non-prefetchable) [size=16K]
>>>      Capabilities: [40] Power Management version 3
>>>          Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>>          Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>>      Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>>>          Address: 0000000000000000  Data: 0000
>>>      Capabilities: [70] Express (v2) Endpoint, MSI 01
>>>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
>>>              ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10.000W
>>>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>>              RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>              MaxPayload 128 bytes, MaxReadReq 4096 bytes
>>>          DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>>>          LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
>>>              ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>>>          LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
> 
> L0s is missing here, no idea why.

Indeed. I’ll forward that to TUXEDO.

>>>              ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>>>          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>>          DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via message/WAKE#
>>>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>>>          LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>>>               EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>>>      Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
>>>          Vector table: BAR=4 offset=00000000
>>>          PBA: BAR=4 offset=00000800
>>>      Capabilities: [d0] Vital Product Data
>>> pcilib: sysfs_read_vpd: read failed: Input/output error
>>>          Not readable
>>>      Capabilities: [100 v2] Advanced Error Reporting
>>>          UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>          UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>          UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>>          CESta:    RxErr+ BadTLP+ BadDLLP+ Rollover- Timeout+ NonFatalErr+
>>>          CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>>>          AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>>>      Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
>>>      Capabilities: [170 v1] Latency Tolerance Reporting
>>>          Max snoop latency: 3145728ns
>>>          Max no snoop latency: 3145728ns
>>>      Capabilities: [178 v1] L1 PM Substates
>>>          L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>>>                PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
>>>          L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>>                 T_CommonMode=0us LTR1.2_Threshold=0ns
>>>          L1SubCtl2: T_PwrOn=10us
>>>      Kernel driver in use: r8169
>>>      Kernel modules: r8169
>>
>> Some Active State Power Management levels seem to be enabled.
>>
>>> Info from powertop about package C states. With ASPM my system reaches
>>> 50% PC7 + 50% PC10.
>>
>> That seems to be the case on my TUXEDO Book BU1406 too.
>>
>>>            Paket     |             Kern    |            CPU 0       CPU 2
>>>                      |                     | C0 aktiv    1,7%        1,1%
>>>                      |                     | POLL        0,0%    0,0 ms  0,0%    0,0 ms
>>>                      |                     | C1E         0,2%    0,8 ms  0,1%    0,2 ms
>>> C2 (pc2)    5,2%    |                     |
>>> C3 (pc3)   82,1%    | C3 (cc3)    0,0%    | C3          0,0%    0,2 ms  0,1%    0,2 ms
> 
> Relevant are the package states and your system reaches pc3 only. The "Tunables" section
> in powertop may provide hints how to save more power.

Thank you for the hint. As it’s unrelated, I’ll just paste the tunables 
below, but will try to forward it to the correct people.

     Schlecht      Audiocodec-Energieverwaltung einschalten 

     Schlecht      VM-Rückschreibezeitlimit

>>> C6 (pc6)    0,0%    | C6 (cc6)    1,3%    | C6          0,8%    0,5 ms  1,4%    0,6 ms
>>> C7 (pc7)    0,0%    | C7 (cc7)   90,8%    | C7s         0,0%    1,6 ms  0,0%    0,0 ms
>>> C8 (pc8)    0,0%    |                     | C8          6,0%    1,8 ms 10,1%    2,0 ms
>>> C9 (pc9)    0,0%    |                     | C9          0,2%    2,8 ms  0,2%    2,9 ms
>>> C10 (pc10)  0,0%    |                     | C10        88,7%   12,7 ms 84,4%   14,9 ms
>>>
>>>                      |             Kern    |            CPU 1       CPU 3
>>>                      |                     | C0 aktiv    1,0%        0,8%
>>>                      |                     | POLL        0,0%    0,0 ms  0,0%    0,0 ms
>>>                      |                     | C1E         0,1%    0,3 ms  0,1%    0,3 ms
>>>                      |                     |
>>>                      | C3 (cc3)    0,0%    | C3          0,0%    0,2 ms  0,0%    0,2 ms
>>>                      | C6 (cc6)    1,1%    | C6          0,9%    0,6 ms  0,8%    0,5 ms
>>>                      | C7 (cc7)   92,2%    | C7s         0,0%    1,7 ms  0,0%    0,0 ms
>>>                      |                     | C8          6,2%    1,7 ms  5,4%    1,7 ms
>>>                      |                     | C9          0,3%    1,7 ms  0,1%    1,9 ms
>>>                      |                     | C10        88,8%   12,1 ms 90,7%   14,8 ms
>>>
>>>                      |             GPU     |
>>>                      |                     |
>>>                      | Powered On  2,2%    |
>>>                      | RC6        97,8%    |
>>>                      | RC6p        0,0%    |
>>>                      | RC6pp       0,0%    |
>>
>>> dmesg output filtered for "r8169". Primarily relevant is the line with
>>> the chip name and XID.
>>
>> Please find them below.
>>
>>> $ sudo dmesg | grep r8169
>>> [    5.318442] calling  rtl8169_pci_driver_init+0x0/0x1000 [r8169] @ 418
>>> [    5.318470] r8169 0000:03:00.1: enabling device (0000 -> 0003)
>>> [    5.340324] libphy: r8169: probed
>>> [    5.340630] r8169 0000:03:00.1 eth0: RTL8411, 80:fa:5b:3b:dd:f0, XID 5c800800, IRQ 136
> 
> Good to know. For this chip version rtl8168g_2_hw_phy_config() is used to configure the PHY,
> but this function just loads the firmware. So we don't know whether EEE is enabled.
> 
> What you could do to test further is limiting the speed to 100MBit or 10MBit via ethtool.
> If this reduces power consumption significantly it's a hint that indeed the PHY seems
> to be the one to be blamed.

With `sudo ethtool -s enp3s0f1 speed 10 duplex full` the power usage 
drops to 800 mW and even to 0, so it’s much less as with 1 Gbit/s.

>>> [    5.340632] r8169 0000:03:00.1 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
>>> [    5.340673] initcall rtl8169_pci_driver_init+0x0/0x1000 [r8169] returned 0 after 9217 usecs
>>> [    5.799967] r8169 0000:03:00.1 enp3s0f1: renamed from eth0
>>> [   10.036968] Generic PHY r8169-301:00: attached PHY driver [Generic PHY] (mii_bus:phy_addr=r8169-301:00, irq=IGNORE)
>>> [  676.940934] calling  rtl8169_pci_driver_init+0x0/0x1000 [r8169] @ 22235
>>> [  676.952411] libphy: r8169: probed
>>> [  676.952701] r8169 0000:03:00.1 eth0: RTL8411, 80:fa:5b:3b:dd:f0, XID 5c800800, IRQ 139
>>> [  676.952702] r8169 0000:03:00.1 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
>>> [  676.952736] initcall rtl8169_pci_driver_init+0x0/0x1000 [r8169] returned 0 after 11518 usecs
>>> [  676.954420] r8169 0000:03:00.1 enp3s0f1: renamed from eth0
>>> [  676.975161] Generic PHY r8169-301:00: attached PHY driver [Generic PHY] (mii_bus:phy_addr=r8169-301:00, irq=IGNORE)
>>> [  680.518923] r8169 0000:03:00.1 enp3s0f1: Link is Up - 1Gbps/Full - flow control rx/tx
>>> [ 1751.285899] r8169 0000:03:00.1: invalid short VPD tag 00 at offset 1


Kind regards,

Paul
