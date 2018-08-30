Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC69C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB82520658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB82520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeH3MEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:04:06 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:59202 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeH3MEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:04:06 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 1D3C3CA7767842600E87;
        Thu, 30 Aug 2018 16:03:10 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w7U834lQ016014;
        Thu, 30 Aug 2018 16:03:04 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018083016031230-6559975 ;
          Thu, 30 Aug 2018 16:03:12 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, wanpeng.li@hotmail.com,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V4 0/2] introduce coalesced pio support
Date:   Fri, 31 Aug 2018 00:17:19 +0800
Message-Id: <1535645841-111837-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-30 16:03:12,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-30 16:02:53,
        Serialize complete at 2018-08-30 16:02:53
X-MAIL: mse01.zte.com.cn w7U834lQ016014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coalesced pio is base on coalesced mmio and can be used for some port
like rtc port, pci-host config port, virtio-pci config port and so on.

Specially in case of rtc as coalesced pio, some versions of windows guest
access rtc frequently because of rtc as system tick. guest access rtc like
this: write register index to 0x70, then write or read data from 0x71.
writing 0x70 port is just as index and do nothing else. So we can use
coalesced pio to handle this scene to reduce VM-EXIT time.

When it starts and closes the virtual machine, it will access pci-host config
port or virtio-pci config port frequently. So setting these port as
coalesced pio can reduce startup and shutdown time. In qemu I just realize
piixfx's pci-host, it is convenient for other pci-host type implementations.

without my patch, get the vm-exit time of accessing rtc 0x70 and piix 0xcf8
using perf tools: (guest OS : windows 7 64bit)
IO Port Access  Samples Samples%  Time%  Min Time  Max Time  Avg time
0x70:POUT        86     30.99%    74.59%   9us      29us    10.75us (+- 3.41%)
0xcf8:POUT     1119     2.60%     2.12%   2.79us    56.83us 3.41us (+- 2.23%)

with my patch
IO Port Access  Samples Samples%  Time%   Min Time  Max Time   Avg time
0x70:POUT       106    32.02%    29.47%    0us      10us     1.57us (+- 7.38%)
0xcf8:POUT      1065    1.67%     0.28%   0.41us    65.44us   0.66us (+- 10.55%)


Peng Hao (2):
  kvm/x86 : add coalesced pio support
  kvm/x86 : add document for coalesced pio

 Documentation/virtual/kvm/00-INDEX          |  2 ++
 Documentation/virtual/kvm/coalesced-pio.txt | 15 ++++++++++++++
 include/uapi/linux/kvm.h                    | 11 +++++++++--
 virt/kvm/coalesced_mmio.c                   | 12 +++++++++---
 virt/kvm/kvm_main.c                         |  2 ++
 5 files changed, 37 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/virtual/kvm/coalesced-pio.txt

-- 
1.8.3.1

