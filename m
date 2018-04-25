Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbeDYJBN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:01:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34949 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeDYJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:01:10 -0400
Date: Wed, 25 Apr 2018 02:00:55 -0700
From: "tip-bot for jacek.tomaka@poczta.fm" <tipbot@zytor.com>
Message-ID: <tip-88ba3829dfd83219bb2b1954acb0c206a602ce83@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, jacek.tomaka@poczta.fm
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jacek.tomaka@poczta.fm, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20180423161425.24366-1-jacekt@dugeo.com>
References: <20180423161425.24366-1-jacekt@dugeo.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpu/intel: Add missing TLB cpuid values
Git-Commit-ID: 88ba3829dfd83219bb2b1954acb0c206a602ce83
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  88ba3829dfd83219bb2b1954acb0c206a602ce83
Gitweb:     https://git.kernel.org/tip/88ba3829dfd83219bb2b1954acb0c206a602ce83
Author:     jacek.tomaka@poczta.fm <jacek.tomaka@poczta.fm>
AuthorDate: Tue, 24 Apr 2018 00:14:25 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 25 Apr 2018 10:56:23 +0200

x86/cpu/intel: Add missing TLB cpuid values

Make kernel print the correct number of TLB entries on Intel Xeon Phi 7210
(and others)

Before:
[ 0.320005] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
After:
[ 0.320005] Last level dTLB entries: 4KB 256, 2MB 128, 4MB 128, 1GB 16

The entries do exist in the official Intel SMD but the type column there is
incorrect (states "Cache" where it should read "TLB"), but the entries for
the values 0x6B, 0x6C and 0x6D are correctly described as 'Data TLB'.

Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180423161425.24366-1-jacekt@dugeo.com

---
 arch/x86/kernel/cpu/intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index b9693b80fc21..55b646c43ef6 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -835,6 +835,9 @@ static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x5d, TLB_DATA_4K_4M,		256,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x61, TLB_INST_4K,		48,	" TLB_INST 4 KByte pages, full associative" },
 	{ 0x63, TLB_DATA_1G,		4,	" TLB_DATA 1 GByte pages, 4-way set associative" },
+	{ 0x6b, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 8-way associative" },
+	{ 0x6c, TLB_DATA_2M_4M,		128	" TLB_DATA 2 MByte or 4 MByte pages, 8-way associative" },
+	{ 0x6d, TLB_DATA_1G,		16,	" TLB_DATA 1 GByte pages, fully associative" },
 	{ 0x76, TLB_INST_2M_4M,		8,	" TLB_INST 2-MByte or 4-MByte pages, fully associative" },
 	{ 0xb0, TLB_INST_4K,		128,	" TLB_INST 4 KByte pages, 4-way set associative" },
 	{ 0xb1, TLB_INST_2M_4M,		4,	" TLB_INST 2M pages, 4-way, 8 entries or 4M pages, 4-way entries" },
