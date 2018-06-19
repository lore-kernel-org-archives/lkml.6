Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2541C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FF420874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FF420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937324AbeFSG23 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:28:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56345 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755731AbeFSG21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:28:27 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1fVA7g-0000c1-Uu; Tue, 19 Jun 2018 08:28:13 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     adrian.hunter@intel.com
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kurt@linutronix.de
Subject: [PATCH 0/1] eMMC controller issue on Intel Baytrail SoC
Date:   Tue, 19 Jun 2018 08:31:18 +0200
Message-Id: <20180619063119.3955-1-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've encountered a problem on an Intel Atom E3825. When performing lots of
reboots (10, 50, 100, ...) the eMMC controller stops working. The reset commands
won't work anymore and you get error messages such as:

|mmc1: Reset 0x1 never completed.
|sdhci: =========== REGISTER DUMP (mmc1)===========
|sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
|sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
|sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
|sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
|sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
|sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
|sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
|sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
|sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
|sdhci: Caps:     0xffffffff | Caps_1:   0xffffffff
|sdhci: Cmd:      0x0000ffff | Max curr: 0xffffffff
|sdhci: Host ctl2: 0x0000ffff
|sdhci: ADMA Err: 0xffffffff | ADMA Ptr: 0xffffffff

After using ftrace, I've discovered that this issue happens when runtime power
management is utilized. So after searching a bit, I've found the errata list for
the E3825:

https://www.intel.ca/content/dam/www/public/us/en/documents/specification-updates/atom-e3800-family-spec-update.pdf

Erratum VLI10 basically states, that suspend/resume shouldn't be used. Otherwise
wrong data between memory the device may be transferred. Therefore, I've
disabled runtime power management and the issue disappeared. That's what the
following patch does.

This patch is tested against v4.17 and v4.9.

Any suggestions?

Kurt Kanzenbach (1):
  mmc: sdhci-pci: fix eMMC controller issue on Intel Baytrail SoCs

 drivers/mmc/host/sdhci-pci-core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--
2.11.0
