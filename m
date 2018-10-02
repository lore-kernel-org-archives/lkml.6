Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605CCC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C672064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iQtM/gi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C672064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeJCCAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:00:00 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61573 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJCCAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538507709; x=1570043709;
  h=from:to:cc:subject:date:message-id;
  bh=rMPk8dxyx5CybRX2rxrSyOX33/pWDxcvGzCyMW0+dcU=;
  b=iQtM/gi7doI1bPmITP2IjGACOFUOe5GrqZBua/FAXRndQmuqmKOw9YcT
   AK+u5jU84mHiI/RptByZrNpogj+AKKvtv4eaTtJuGJker6IMrSqmDUAho
   37/YGi2xrk8MfTXIlTi/au7f96PfRnfyEK7CvOgyqEIeH7UT76LAus+3O
   wd9cLKITFkjNkCPvk9Z+w3/CKawIo+zQU8ji5/Kf9c9U1qCd1oRRrbF0y
   zgGsb8hucyG1qCO6Ww7ITQ/MtqlsMsrH56pvM6q/xB6olkKc0URD8g7iV
   XCaNmCjymMspSR3LurvOtYgf3ieutUcR61lZNZ9b0dsPdpT9NoP5+ugpB
   w==;
X-IronPort-AV: E=Sophos;i="5.54,332,1534780800"; 
   d="scan'208";a="91076735"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2018 03:15:08 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Oct 2018 12:00:49 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2018 12:15:09 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org, palmer@sifive.com
Cc:     anup@brainfault.org, hch@infradead.org,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com
Subject: [PATCH v6 00/14] SMP cleanup and new features
Date:   Tue,  2 Oct 2018 12:14:53 -0700
Message-Id: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series now has evolved to contain several related changes.

1. Updated the assorted cleanup series by palmer.
The original cleanup patch series can be found here.
http://lists.infradead.org/pipermail/linux-riscv/2018-August/001232.html

2. Implemented decoupling linux logical CPU ids from hart id.
Some of the work has been inspired from ARM64.
Tested on QEMU & HighFive Unleashed board with/without SMP enabled.

3. Included Anup's cleanup and IPI stat patch.

All the patch series have been combined to avoid conflicts as a lot
of common code is changed different patch sets. I have mostly addressed
review comments and fixed checkpatch errors from palmer's and anup's series.

v1->v2:

1. Dropped cpu_ops patch.
2. Moved back IRQ cause definitions to irq.h
3. Keep boot CPU hart id and assign zero as the CPU id for boot CPU.
4. Renamed CPU id and hart id correctly.

v2-v3:

1. Added cleanup patches from palmer.
2. Moved the hotplug related functions to it's own file.
3. Updated stub functions as per coding guidelines.
4. Renamed __cpu_logical_map to a more coherent name.

v3-v4:

1. Addressed minor typos in commit text and code.
2. Included Anup's do_IRQ patch.
3. Dropped CPU hotplug patch. As there are some concerns
   about approach, I will submit it separately.

v4->v5:

1. Minor typo fixes in commit text.

v5->v6:
1. Included Anup's IPI stat and cpuinfo patch.
2. Fixed a typo cpuid_to_hardid_map->cpuid_to_hartid_map 


Anup Patel (3):
  RISC-V: No need to pass scause as arg to do_IRQ()
  RISC-V: Show CPU ID and Hart ID separately in /proc/cpuinfo
  RISC-V: Show IPI stats

Atish Patra (4):
  RISC-V: Disable preemption before enabling interrupts
  RISC-V: Use WRITE_ONCE instead of direct access
  RISC-V: Add logical CPU indexing for RISC-V
  RISC-V: Use Linux logical CPU number instead of hartid

Palmer Dabbelt (7):
  RISC-V: Don't set cacheinfo.{physical_line_partition,attributes}
  RISC-V: Filter ISA and MMU values in cpuinfo
  RISC-V: Comment on the TLB flush in smp_callin()
  RISC-V: Provide a cleaner raw_smp_processor_id()
  RISC-V: Rename riscv_of_processor_hart to riscv_of_processor_hartid
  RISC-V: Rename im_okay_therefore_i_am to found_boot_cpu
  RISC-V: Use mmgrab()

 arch/riscv/include/asm/processor.h |  2 +-
 arch/riscv/include/asm/smp.h       | 47 +++++++++++++++-----
 arch/riscv/include/asm/tlbflush.h  | 16 +++++--
 arch/riscv/kernel/cacheinfo.c      |  7 ---
 arch/riscv/kernel/cpu.c            | 87 ++++++++++++++++++++++++++++++++------
 arch/riscv/kernel/entry.S          |  1 -
 arch/riscv/kernel/head.S           |  4 +-
 arch/riscv/kernel/irq.c            | 12 +++++-
 arch/riscv/kernel/setup.c          | 10 +++++
 arch/riscv/kernel/smp.c            | 82 ++++++++++++++++++++++++++++-------
 arch/riscv/kernel/smpboot.c        | 46 ++++++++++++++------
 drivers/clocksource/riscv_timer.c  | 12 ++++--
 drivers/irqchip/irq-sifive-plic.c  | 10 +++--
 13 files changed, 259 insertions(+), 77 deletions(-)

-- 
2.7.4

