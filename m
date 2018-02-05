Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbeBEPPk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:15:40 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:42539 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753037AbeBEPPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:15:32 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@linux.intel.com>
Cc: nico@linaro.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 2/2] x86: make __ibp_barrier visible
Date: Mon,  5 Feb 2018 16:12:53 +0100
Message-Id: <20180205151300.539874-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180205151300.539874-1-arnd@arndb.de>
References: <20180205151300.539874-1-arnd@arndb.de>
X-Provags-ID: V03:K0:KZQT0FH1nAaojQPCyTPQCi7eKXrIHLjOGE0cGSR1vz8606thuJw
 nUYsffLfXxVy4qlwS3vmWWhY4SYp2F2fRtVoVSh6lgeEIEH7me+bhpyiXyZEuZKVakEKUIb
 +GbJDur/wmX4Cxuke3gIUa77jE0xflavd2TqByDE7KUeYCgWz9r/xMs4csfKDxj8p3L9Pu5
 Ebry4maUxFkJNIWZN6sXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QnD3WMQzmSk=:Fh6bD7+Db7SB6d3eqHrF3J
 j0qlyeWxUeFYxsjThT5wTLa6RjWV3BqyhXVDFWIBvOksDJyV3SxrM5YRjEmE85nUn3PFRZi1y
 Ny/QRh/qM7cP8LeTxpN7iiP6wg+KJDnYPqkdnLqFzcGQrbOA4GPkqpxY7ZNvpWtEslAdGF3nu
 opgzEG1U8ZDwKRVgucTR2K59YzU/0/ITE5A6ndGDb5E/ShEMkICHIHF7Y8OO4Z9ZWoG/5gAIY
 v9tWLLqPteiu/C3fpYEyBukeIpCZmU++I41K4jSGLAtUjnXAr8rZRSoHhEv04Z6WT0FPh1+dB
 5AuTrBM1U6UQfEbit7nIiNcwmAwx+B+/GsWLyD3v3l6LCT+PitX4Qo1EEyhkYMW/Vg+HaLwO5
 OfKPFC0AjGu5ymH1dfC0FyNL7lL6i2E9IS4HLIddWx8OWaDEuvOGhLsSqYRZgeefZJpORtwqt
 datS3vPxEw6kXW72b/LByyc2fLUBy1knfZ6VmvQ1IRpP0xDAzktUHGc7YYl8Kotyh4287idE/
 /bSmrEQ9M1ctrjl2RKJqYY6mNRiigxS9qDAtNauC/2kY4iQApEYJriOtDvNJlyNW1MRxeLtxE
 pf9qNCZKqohlVS84YaCCw6sv2jc2UFXAxFvXWAGUrlNM13r5h9bexrbRmcER5kMICtOC3aP0d
 D8SUP4Qht92OL2290g5iJKIEx/Sn0jlyJjohjhfVZyjBJTQ2WC8ZA8XCTQiKiJ/lo5mZonjcj
 UVYg+jqx/J+y9X0EiibwVtpQNCVIKYkubtXiCQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTO linking was broken by the addition of __ibp_barrier, which only
has relocations from assembler code, and not from C, so the linker
decides to drop it:

./ccfzUJ1l.ltrans0.ltrans.o:(.altinstr_replacement+0x42): undefined reference to `__ibp_barrier'

Fixes: 64e16720ea08 ("x86/speculation: Simplify indirect_branch_prediction_barrier()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 71949bf2de5a..c3f5fe1c6e83 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -338,7 +338,7 @@ ssize_t cpu_show_spectre_v2(struct device *dev,
 }
 #endif
 
-void __ibp_barrier(void)
+void __visible __ibp_barrier(void)
 {
 	__wrmsr(MSR_IA32_PRED_CMD, PRED_CMD_IBPB, 0);
 }
-- 
2.9.0
