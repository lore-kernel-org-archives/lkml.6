Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755987AbeDWQP4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:15:56 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44857 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932219AbeDWQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:15:03 -0400
X-Google-Smtp-Source: AIpwx4/smDoLZpLvD0cOvHHr8EO1obRG/aEYnvuaweEAFB4igrEOgBy0pjjx2dpnOvCQJTRev2Mq0w==
From: Jacek Tomaka <jacekt@dugeo.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: jacek.tomaka@poczta.fm
Subject: [PATCH] x86/cpuid: Add missing TLB cpuid values
Date: Tue, 24 Apr 2018 00:14:25 +0800
Message-Id: <20180423161425.24366-1-jacekt@dugeo.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jacek.tomaka@poczta.fm

Make kernel print correct message upon boot on Intel Xeon Phi 7210 (and others).

Before:
[ 0.320005] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
After:
[ 0.320005] Last level dTLB entries: 4KB 256, 2MB 128, 4MB 128, 1GB 16

The entries do exist in the official Intel's documentation but the type column there is incorrect (states "Cache" where it should read "TLB")
https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-vol-2a-manual.html

Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>
---
 arch/x86/kernel/cpu/intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index b9693b80fc21..21e6cc52d56f 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -835,6 +835,9 @@ static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x5d, TLB_DATA_4K_4M,		256,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x61, TLB_INST_4K,		48,	" TLB_INST 4 KByte pages, full associative" },
 	{ 0x63, TLB_DATA_1G,		4,	" TLB_DATA 1 GByte pages, 4-way set associative" },
+	{ 0x6b, TLB_DATA_4K, 		256, 	" TLB_DATA 4 KByte pages, 8-way associative" },
+	{ 0x6c, TLB_DATA_2M_4M, 	128, 	" TLB_DATA 2 MByte or 4 MByte pages, 8-way associative" },
+	{ 0x6d, TLB_DATA_1G, 		16, 	" TLB_DATA 1 GByte pages, fully associative" },
 	{ 0x76, TLB_INST_2M_4M,		8,	" TLB_INST 2-MByte or 4-MByte pages, fully associative" },
 	{ 0xb0, TLB_INST_4K,		128,	" TLB_INST 4 KByte pages, 4-way set associative" },
 	{ 0xb1, TLB_INST_2M_4M,		4,	" TLB_INST 2M pages, 4-way, 8 entries or 4M pages, 4-way entries" },
-- 
2.17.0
