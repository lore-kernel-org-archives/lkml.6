Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A4EC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BB82084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BB82084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeLLQA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:00:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16561 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726468AbeLLQA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:00:26 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7C6414DBDB44A;
        Thu, 13 Dec 2018 00:00:20 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Thu, 13 Dec 2018
 00:00:13 +0800
From:   John Garry <john.garry@huawei.com>
Subject: arm64 board boot pauses on linux-next
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Message-ID: <568651c2-da2f-b0bc-777b-5a669cfb642d@huawei.com>
Date:   Wed, 12 Dec 2018 16:00:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am finding our arm64 D05 board particularly slow to boot from 
linux-next, specifically a 30+ second pause when setting up CPU features.

I tried to bisect, but I am finding bisect holes (board does not boot at 
all).

Snippet good, like v4.20-rc6:
[    5.482756] smp: Brought up 4 nodes, 64 CPUs
[    7.423242] SMP: Total of 64 processors activated.
[    7.428087] CPU features: detected: GIC system register CPU interface
[    7.434620] CPU features: detected: 32-bit EL0 Support
[    7.439813] CPU features: detected: CRC32 instructions
[    7.530336] CPU: All CPU(s) started at EL2
[    7.534599] alternatives: patching kernel code
[    7.556042] devtmpfs: initialized
[    7.559982] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[    7.569991] futex hash table entries: 16384 (order: 8, 1048576 bytes)
[    7.577262] pinctrl core: initialized pinctrl subsystem
[    7.582947] SMBIOS 3.0.0 present.
[    7.586293] DMI: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT17 
Nemo 2.0 RC0 10/05/2018
[    7.594812] NET: Registered protocol family 16
[    7.600073] audit: initializing netlink subsys (disabled)
[    7.605593] audit: type=2000 audit(5.072:1): state=initialized 
audit_enabled=0 res=1


Snippet next-20181211:
[    5.483420] GICv3: CPU63: found redistributor 70303 region 
63:0x000004006d4c0000
[    5.483438] GICv3: CPU63: using allocated LPI pending table 
@0x0000001fb8dd0000
[    5.483578] arch_timer: CPU63: Trapping CNTVCT access
[    5.483582] CPU63: Booted secondary processor 0x0000070303 [0x410fd082]
[    5.483666] smp: Brought up 4 nodes, 64 CPUs
[    7.424162] SMP: Total of 64 processors activated.
[    7.429006] CPU features: detected: GIC system register CPU interface
[    7.435538] CPU features: detected: 32-bit EL0 Support
[    7.440731] CPU features: detected: CRC32 instructions
[   40.107984] CPU: All CPU(s) started at EL2
[   40.112264] alternatives: patching kernel code
[   40.134299] devtmpfs: initialized
[   40.138196] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[   40.148209] futex hash table entries: 16384 (order: 8, 1048576 bytes)
[   40.155486] pinctrl core: initialized pinctrl subsystem
[   40.161109] SMBIOS 3.0.0 present.
[   40.164456] DMI: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT17 
Nemo 2.0 RC0 10/05/2018
[   40.172985] NET: Registered protocol family 16
[   40.178236] audit: initializing netlink subsys (disabled)
[   40.183748] audit: type=2000 audit(5.072:1): state=initialized 
audit_enabled=0 res=1

Anyone else notice a similar issue?

Our nextgen D06 board does not seem to have this issue.

Thanks,
John

