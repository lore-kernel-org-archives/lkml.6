Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B34C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E557218A1
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ee0dwsIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfAGTYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:24:39 -0500
Received: from pb-sasl21.pobox.com ([173.228.157.49]:52438 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfAGTYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:24:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-sasl21.pobox.com (Postfix) with ESMTP id 0D5EA292A0;
        Mon,  7 Jan 2019 14:24:33 -0500 (EST)
        (envelope-from mlord@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=/f+mPDvafzdJ
        3YPEwF4HD1zz92A=; b=Ee0dwsIx5dqaRDsnpuERQp8WeWfnRJIRVWZegKfQdIjs
        011cjeNzr+kRqNDP0ztrfYXCZjvlNSOOyeFxfUi6jRLEJq7O6vlWWpy6idzEiLwG
        cAi3CehplZOZztEAu89Jfw90P/Y22KI6D+30SgReQgf5LZHT0MJ4AU46wjrYtBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VR56dv
        H/2CQi/1t8jupwE7ooftDJbDKrjQ/X6YrOGg4vII92kqfyAwet6eoRYu3G1k/ng1
        pm3BaMPSuOr376V66oKAja8QcUCyyBgX3smP5/LpvYNWcAPQHX2JPXr5RR/bzqxC
        gCXDf31IzXeMMKJdlrKWc8GNm0J0KTvPvwYnI=
Received: from pb-sasl21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-sasl21.pobox.com (Postfix) with ESMTP id EB7E72929F;
        Mon,  7 Jan 2019 14:24:32 -0500 (EST)
        (envelope-from mlord@pobox.com)
Received: from [10.0.0.9] (unknown [24.53.240.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-sasl21.pobox.com (Postfix) with ESMTPSA id 8B4722929E;
        Mon,  7 Jan 2019 14:24:29 -0500 (EST)
        (envelope-from mlord@pobox.com)
Subject: Re: r8152: data corruption in various scenarios
To:     Mario.Limonciello@dell.com, hayeswang@realtek.com,
        kai.heng.feng@canonical.com
Cc:     aatteka@nicira.com, davem@davemloft.net, greg@kroah.com,
        romieu@fr.zoreil.com, netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        ryankao@realtek.com
References: <ed0c9790-57be-8bca-cdd6-3a54ca24f0bd@pobox.com>
 <20161125095350.GA20653@kroah.com>
 <1816ec7e-2733-f4ba-5d30-29dbabd20aad@pobox.com>
 <20161125.115827.2014848246966159357.davem@davemloft.net>
 <0835B3720019904CB8F7AA43166CEEB201057793@RTITMBSV03.realtek.com.tw>
 <CAA=3Oqn5_5w+vrg9_7UtZ-5BEbZ9Pm=qdX3WoVZKaAkxcMXYXA@mail.gmail.com>
 <469a41ea-e97c-23d2-d129-68aad5585fec@pobox.com>
 <3D7273C4-D378-42D5-92FA-4ED72041D820@canonical.com>
 <1726a1ef-cfa7-0f97-4388-bf2ba72cb9a9@pobox.com>
 <31f145b8-4518-122c-eab8-50ed1075ba55@pobox.com>
 <0835B3720019904CB8F7AA43166CEEB2D38781F2@RTITMBSVM03.realtek.com.tw>
 <92e9ddd8a05a493bbb1f5ac4828c2f2a@ausx13mpc120.AMER.DELL.COM>
 <0e7fce67-a88e-4245-ae4e-c218bfbea12f@pobox.com>
 <53c5ebc06e454ed38a8254acbbabaa68@ausx13mpc120.AMER.DELL.COM>
From:   Mark Lord <mlord@pobox.com>
Message-ID: <1321684c-8857-874a-2f92-f39668c19649@pobox.com>
Date:   Mon, 7 Jan 2019 14:24:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <53c5ebc06e454ed38a8254acbbabaa68@ausx13mpc120.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: DB11F96A-12B1-11E9-B760-B0A4589248B8-82205200!pb-sasl21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-07 1:27 p.m., Mario.Limonciello@dell.com wrote:
..
> The xHCI overrun workaround should only be applied on TB16/TB16, correct.
> 
> Can you double check the verbose information from lsusb for the r8153 device
> on your WD15?

Sure, see below for the full output.

> If it's the same information as the TB16 (which it sounds like it is) Kai Heng and I will check
> around internally to find out why they're looking the same.

Thanks.

> My second guess would be maybe newer ethernet NVM in manufacturing.
> My third guess would be a manufacturing issue putting wrong NVM image on your WD15.

It could be one of those two things.
Let us know what you discover.

Thanks

Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         9
  idVendor           0x0bda Realtek Semiconductor Corp.
  idProduct          0x8153
  bcdDevice           30.11
  iManufacturer           1 Realtek
  iProduct                2 USB 10/100/1000 LAN
  iSerial                 6 000002000000
  bNumConfigurations      2
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           57
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower               64mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval               8
        bMaxBurst               0
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           98
    bNumInterfaces          2
    bConfigurationValue     2
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower               64mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2 Communications
      bInterfaceSubClass      6 Ethernet Networking
      bInterfaceProtocol      0
      iInterface              5 CDC Communications Control
      CDC Header:
        bcdCDC               1.10
      CDC Union:
        bMasterInterface        0
        bSlaveInterface         1
      CDC Ethernet:
        iMacAddress                      3 54BF6450FC4F
        bmEthernetStatistics    0x00000000
        wMaxSegmentSize               1514
        wNumberMCFilters            0x0000
        bNumberPowerFilters              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               8
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              4 Ethernet Data
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               3
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength           22
  bNumDeviceCaps          2
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000002
      Link Power Management (LPM) Supported
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x000e
      Device can operate at Full Speed (12Mbps)
      Device can operate at High Speed (480Mbps)
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   2
      Lowest fully-functional device speed is High Speed (480Mbps)
    bU1DevExitLat          10 micro seconds
    bU2DevExitLat        2047 micro seconds
Device Status:     0x000c
  (Bus Powered)
  U1 Enabled
  U2 Enabled

-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
