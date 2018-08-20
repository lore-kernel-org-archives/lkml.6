Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1DDC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6A92174D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFvK58h1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6A92174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeHUCYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 22:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbeHUCYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 22:24:00 -0400
Received: from localhost (20.sub-174-234-143.myvzw.com [174.234.143.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C975C2174A;
        Mon, 20 Aug 2018 23:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534806386;
        bh=Q+e7o6PNxh8z5t85+pa7ge3Q8TOhHXoS2vSUCBPDnsA=;
        h=Date:From:To:Cc:Subject:From;
        b=FFvK58h1ptDo9HUsctx6wCCig0iuSuR5xqtwgovFeWZx5OougmB/8yRIhDXOV5YCN
         Cx14nHSAHjNd5RdOT269ebrEjDMkr+mHmRGzFLgQQtQru8pUSV/5x6OUs3dpZGgYU7
         4yg5nR1hS++JZh37mkNDCeq++3utSRc9toX6sVtU=
Date:   Mon, 20 Aug 2018 18:06:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
        mmyangfl@gmail.com
Subject: Enumeration issue with QCA9005 AR9462
Message-ID: <20180820230624.GB154536@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmyangfl@gmail.com reported a problem [1]: on v4.17, a QCA9005 AR9462
wifi device was present at boot, but disappeared after suspend/resume.

He/she also tested a recent kernel (5c60a7389d79, from Thu Aug 16),
where the suspend/resume problem doesn't seem to happen, but the wifi
device isn't enumerated correctly at boot-time.

  pci 0000:00:1c.3: PCIe Root Port to [bus 03-07]
  pci 0000:03:00.0: [1ae9:0101] PCIe Switch Upstream Port to [bus 04-07]
  pci 0000:04:00.0: [1ae9:0200] PCIe Switch Downstream Port to [bus 05]
  pci 0000:05:00.0: [168c:0034] QCA9005 AR9462 wifi NIC

These messages are extracted from [2]:

[    0.928714] pciehp 0000:04:00.0:pcie204: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    0.928752] pciehp 0000:04:00.0:pcie204: Slot(0-1): Card not present
[    0.928811] pciehp 0000:04:00.0:pcie204: Slot(0-1): Link Up
[    0.928815] pciehp 0000:04:00.0:pcie204: Slot(0-1): No adapter

After manually executing:

  echo 1 > /sys/devices/pci0000\:00/0000\:00\:1c.3/0000\:03\:00.0/0000\:04\:00.0/rescan

the wifi NIC is discovered correctly:

[  114.649896] pci 0000:05:00.0: [168c:0034] type 00 class 0x028000
[  114.649977] pci 0000:05:00.0: reg 0x10: [mem 0xf7400000-0xf747ffff 64bit]
[  114.650090] pci 0000:05:00.0: reg 0x30: [mem 0xf7480000-0xf748ffff pref]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=200839
[2] https://bugzilla.kernel.org/attachment.cgi?id=277923
