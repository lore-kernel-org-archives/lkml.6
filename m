Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7279CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D1C20645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SRtJnMAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D1C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeILBGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:06:33 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52878 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeILBGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536696340; x=1568232340;
  h=from:to:cc:subject:date:message-id;
  bh=ZLogkIlkfLLZrpZWANuoPB7Me8QHxPVvVo+WbqnGtis=;
  b=SRtJnMAySDRLTHNPGSQl2VbfNxnEZFloVKucka42fEpwazLek5bKOirc
   +R0EpEJiuYzdhDAkoBuN4s2H9WmTNExn5cJty3Bxl/UX375V3Dpeb2Oyb
   9QfQ5ggI7lvd9yctDnI7lZW9HFn/XsFfIcTDHLE0GP8sLe77e9wSdEuD7
   Izvj+vPUM1bTOmVPfXRNiFZ4SRe4fLt5PCZ9+D78qCYUpNWNPBahWUpDf
   Mpz5HBwbLiHrYpBkON9pgMX1CVXS3iFdHz5XyesgNQUZqc+q0G6+NuvR4
   IVwbZGtzmxgXACTamuoOTCjrfWYfAM8TQKWCTh5F0QFblBWmYOb33N+56
   g==;
X-IronPort-AV: E=Sophos;i="5.53,361,1531756800"; 
   d="scan'208";a="193728817"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2018 04:05:40 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Sep 2018 12:52:14 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2018 13:05:40 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org
Cc:     mark.rutland@arm.com, hch@infradead.org, anup@brainfault.org,
        atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: [PATCH v4 00/12] SMP cleanup and new features
Date:   Tue, 11 Sep 2018 13:05:27 -0700
Message-Id: <1536696339-15204-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series has updated the assorted cleanup series by palmer.
The original cleanup patch series can be found here.
http://lists.infradead.org/pipermail/linux-riscv/2018-August/001232.html

It also implemented decoupling linux logical cpu ids from hardware cpu id.
Some of the work has been inspired from ARM64.
Tested on QEMU & HighFive Unleashed board with/without SMP enabled.

Both the patch series have been combined to avoid conflicts as a lot
of common code is changed in both the series. I have mostly addressed
review comments and fixed checkpatch errors from palmer's series.

v1->v2:

1. Dropped cpu_ops patch.
2. Moved back IRQ cause definitions to irq.h
3. Keep boot cpu hart id and assign zero as the cpu id for boot cpu.
4. Renamed cpu id and hart id correctly.

v2-v3:

1. Added cleanup patches from palmer.
2. Moved the hotplug related functions to it's own file.
3. Updated stub functions as per coding guidelines.
4. Renamed __cpu_logical_map to a more coherent name.

v3-v4:

1. Addressed minor typos in commit text and code.
2. Included Anup's do_IRQ patch.
3. Dropped cpu hotplug patch. As there are some concerns
   about approach, I will submit it separately.

Anup Patel (1):
  RISC-V: No need to pass scause as arg to do_IRQ()

Atish Patra (4):
  RISC-V: Disable preemption before enabling interrupts
  RISC-V: User WRITE_ONCE instead of direct access
  RISC-V: Add logical CPU indexing for RISC-V
  RISC-V: Use Linux logical cpu number instead of hartid

Palmer Dabbelt (7):
  RISC-V: Don't set cacheinfo.{physical_line_partition,attributes}
  RISC-V: Filter ISA and MMU values in cpuinfo
  RISC-V: Comment on the TLB flush in smp_callin()
  RISC-V: Provide a cleaner raw_smp_processor_id()
  RISC-V: Rename riscv_of_processor_hart to riscv_of_processor_hartid
  RISC-V: Rename im_okay_therefore_i_am to found_boot_cpu
  RISC-V: Use mmgrab()

 arch/riscv/include/asm/processor.h |  2 +-
 arch/riscv/include/asm/smp.h       | 38 ++++++++++++-----
 arch/riscv/include/asm/tlbflush.h  | 16 ++++++--
 arch/riscv/kernel/cacheinfo.c      |  7 ----
 arch/riscv/kernel/cpu.c            | 83 ++++++++++++++++++++++++++++++++------
 arch/riscv/kernel/entry.S          |  1 -
 arch/riscv/kernel/head.S           |  4 +-
 arch/riscv/kernel/irq.c            |  4 +-
 arch/riscv/kernel/setup.c          | 10 +++++
 arch/riscv/kernel/smp.c            | 43 +++++++++++++++-----
 arch/riscv/kernel/smpboot.c        | 46 ++++++++++++++-------
 drivers/clocksource/riscv_timer.c  | 12 ++++--
 drivers/irqchip/irq-sifive-plic.c  | 10 +++--
 13 files changed, 207 insertions(+), 69 deletions(-)

-- 
2.7.4

