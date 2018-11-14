Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DF2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FF422419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FF422419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeKOHdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:33:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49972 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725756AbeKOHdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:33:46 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xugrSHv967eP; Wed, 14 Nov 2018 22:28:51 +0100 (CET)
Received: from zn.tnic (p200300EC2BD0D200D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:d200:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 118C11EC00EB;
        Wed, 14 Nov 2018 22:28:51 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] x86/CPUID: CPUID parsing rework, p1
Date:   Wed, 14 Nov 2018 22:28:40 +0100
Message-Id: <20181114212843.16954-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

this is the beginning of a long conversion. The final goal is to have
one global, read-only CPUID hierarchy representation in arch/x86/ to
replace all the gazillion places where CPUID is read and thus slim a lot
of code. And improve all that X86_FEATURE* diddling. We'll see...

Anyway, these are the first three patches slimming cpuinfo_x86 by
80 bytes per CPU, by making vendor ID and brand name global and
__ro_after_init.

Comments, reviews, etc are welcome, as always.

Thx.

Borislav Petkov (3):
  x86/cpuid: Make cpuinfo_x86.x86_vendor_id global
  x86/cpuid: Get vendor ID on the BSP
  x86/cpuid: Make cpuinfo_x86.x86_model_id global

 arch/x86/include/asm/processor.h     |  6 +--
 arch/x86/kernel/asm-offsets_32.c     |  1 -
 arch/x86/kernel/cpu/amd.c            |  4 +-
 arch/x86/kernel/cpu/centaur.c        |  2 +-
 arch/x86/kernel/cpu/common.c         | 56 +++++++++++++++-------------
 arch/x86/kernel/cpu/cyrix.c          |  7 ++--
 arch/x86/kernel/cpu/intel.c          |  2 +-
 arch/x86/kernel/cpu/proc.c           |  4 +-
 arch/x86/kernel/head_32.S            |  5 ---
 arch/x86/kernel/setup.c              |  3 ++
 drivers/cpufreq/powernow-k8.c        |  2 +-
 drivers/cpufreq/speedstep-centrino.c |  6 +--
 drivers/cpufreq/speedstep-lib.c      |  2 +-
 drivers/edac/e752x_edac.c            |  3 +-
 drivers/hwmon/coretemp.c             |  2 +-
 drivers/hwmon/k10temp.c              |  2 +-
 drivers/platform/x86/intel_ips.c     |  6 +--
 17 files changed, 57 insertions(+), 56 deletions(-)

-- 
2.19.1

