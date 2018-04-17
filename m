Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeDQJ5F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:57:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57719 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbeDQJ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:57:04 -0400
Date: Tue, 17 Apr 2018 02:56:30 -0700
From: tip-bot for Xiaoming Gao <tipbot@zytor.com>
Message-ID: <tip-d3878e164dcd3925a237a20e879432400e369172@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, gxm.linux.kernel@gmail.com,
        linux-kernel@vger.kernel.org, newtongao@tencent.com, mingo@kernel.org
Reply-To: gxm.linux.kernel@gmail.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, newtongao@tencent.com, linux-kernel@vger.kernel.org
In-Reply-To: <38894564-4fc9-b8ec-353f-de702839e44e@gmail.com>
References: <38894564-4fc9-b8ec-353f-de702839e44e@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/tsc: Prevent 32bit truncation in
 calc_hpet_ref()
Git-Commit-ID: d3878e164dcd3925a237a20e879432400e369172
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

Commit-ID:  d3878e164dcd3925a237a20e879432400e369172
Gitweb:     https://git.kernel.org/tip/d3878e164dcd3925a237a20e879432400e369172
Author:     Xiaoming Gao <gxm.linux.kernel@gmail.com>
AuthorDate: Fri, 13 Apr 2018 17:48:08 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 17 Apr 2018 11:50:42 +0200

x86/tsc: Prevent 32bit truncation in calc_hpet_ref()

The TSC calibration code uses HPET as reference. The conversion normalizes
the delta of two HPET timestamps:

    hpetref = ((tshpet1 - tshpet2) * HPET_PERIOD) / 1e6

and then divides the normalized delta of the corresponding TSC timestamps
by the result to calulate the TSC frequency.

    tscfreq = ((tstsc1 - tstsc2 ) * 1e6) / hpetref

This uses do_div() which takes an u32 as the divisor, which worked so far
because the HPET frequency was low enough that 'hpetref' never exceeded
32bit.

On Skylake machines the HPET frequency increased so 'hpetref' can exceed
32bit. do_div() truncates the divisor, which causes the calibration to
fail.

Use div64_u64() to avoid the problem.

[ tglx: Fixes whitespace mangled patch and rewrote changelog ]

Signed-off-by: Xiaoming Gao <newtongao@tencent.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: peterz@infradead.org
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/38894564-4fc9-b8ec-353f-de702839e44e@gmail.com
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index ef32297ff17e..91e6da48cbb6 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -317,7 +317,7 @@ static unsigned long calc_hpet_ref(u64 deltatsc, u64 hpet1, u64 hpet2)
 	hpet2 -= hpet1;
 	tmp = ((u64)hpet2 * hpet_readl(HPET_PERIOD));
 	do_div(tmp, 1000000);
-	do_div(deltatsc, tmp);
+	deltatsc = div64_u64(deltatsc, tmp);
 
 	return (unsigned long) deltatsc;
 }
