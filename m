Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49q8UBXups55T4uzZItqofxEr64vy5f29HsC2kbUO7b3VLANHHHVz7CHVRVqS+iUPW7SDrL
ARC-Seal: i=1; a=rsa-sha256; t=1524405936; cv=none;
        d=google.com; s=arc-20160816;
        b=L0t+/mYJtpBSHPEQ2go3n+Ze9OEMU/0k6ZunO+gJVGgYhW5/jdOy6/9BSdeun6E/3s
         tLU7aUQNDW9/maTzCS4a06+f3uof4fmGBve0j3jkbnQR2Ob++vK28+Aj9CYCXGe1sarf
         +cKc70Ve1KjQUhBv7COD7Va/SeTAfHW6zpbwcn3nyXCA2vv9cri6Uueg8RGPfAZqJTnw
         qQUHfCeRs5a2NWA41ExjBHX7NjyrolOSUh/F5jVJQIzpVyzVp33qs4pkc67VSL4jdY+t
         /X3HJ9vc5qRQKMz4SFpCNJgFAW9bkib1wuxx+fa+dXufvaYMC1Fuk+JfwDajTH/D5/x3
         /u0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ANHME8/GwPnCUj7/Qmn4AFWPKfCAV9wzaiKgoSt45VY=;
        b=eoRyxuMg+xWmG3hfYohYEEdvuWo+gxpOiexsBWp9D5vm9oa3AN/DTK9qko1cEx1g07
         jUxQwPU5na/RZ4JOfVCXDdBPyWefyqyhVCkbgbIwRROaCb9CPI1Wrtca+Gz5LLJSflPJ
         i5ZDWhqM766MOiuHkHpe2IFDz98JtLvWL5NVmI7UVTTC0J2c0pToRJ53ry9giAI1FQqN
         wtP8pj1cMknA2Wl3yfXY6eBTajv2C3UHHIrWPmeCU30bea+fW9RZmGjKEsKKI6AyLyWt
         uTyjzCtZXuEcFy1cVFBliK7L/dF1XNKlJJEcxpCkCUK0a38r/qPEFcIgNtFxDHzMzDWR
         vSEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 052/164] powerpc/64s: Fix dt_cpu_ftrs to have restore_cpu clear unwanted LPCR bits
Date: Sun, 22 Apr 2018 15:51:59 +0200
Message-Id: <20180422135137.540366717@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454945020240029?=
X-GMAIL-MSGID: =?utf-8?q?1598455478587593867?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit a57ac411832384eb93df4bfed2bf644c4089720e upstream.

Presently the dt_cpu_ftrs restore_cpu will only add bits to the LPCR
for secondaries, but some bits must be removed (e.g., UPRT for HPT).
Not clearing these bits on secondaries causes checkstops when booting
with disable_radix.

restore_cpu can not just set LPCR, because it is also called by the
idle wakeup code which relies on opal_slw_set_reg to restore the value
of LPCR, at least on P8 which does not save LPCR to stack in the idle
code.

Fix this by including a mask of bits to clear from LPCR as well, which
is used by restore_cpu.

This is a little messy now, but it's a minimal fix that can be
backported.  Longer term, the idle SPR save/restore code can be
reworked to completely avoid calls to restore_cpu, then restore_cpu
would be able to unconditionally set LPCR to match boot processor
environment.

Fixes: 5a61ef74f269f ("powerpc/64s: Support new device tree binding for discovering CPU features")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/dt_cpu_ftrs.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -86,6 +86,7 @@ static int hv_mode;
 
 static struct {
 	u64	lpcr;
+	u64	lpcr_clear;
 	u64	hfscr;
 	u64	fscr;
 } system_registers;
@@ -115,6 +116,8 @@ static void cpufeatures_flush_tlb(void)
 
 static void __restore_cpu_cpufeatures(void)
 {
+	u64 lpcr;
+
 	/*
 	 * LPCR is restored by the power on engine already. It can be changed
 	 * after early init e.g., by radix enable, and we have no unified API
@@ -127,8 +130,10 @@ static void __restore_cpu_cpufeatures(vo
 	 * The best we can do to accommodate secondary boot and idle restore
 	 * for now is "or" LPCR with existing.
 	 */
-
-	mtspr(SPRN_LPCR, system_registers.lpcr | mfspr(SPRN_LPCR));
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr |= system_registers.lpcr;
+	lpcr &= ~system_registers.lpcr_clear;
+	mtspr(SPRN_LPCR, lpcr);
 	if (hv_mode) {
 		mtspr(SPRN_LPID, 0);
 		mtspr(SPRN_HFSCR, system_registers.hfscr);
@@ -351,8 +356,9 @@ static int __init feat_enable_mmu_hash_v
 {
 	u64 lpcr;
 
+	system_registers.lpcr_clear |= (LPCR_ISL | LPCR_UPRT | LPCR_HR);
 	lpcr = mfspr(SPRN_LPCR);
-	lpcr &= ~LPCR_ISL;
+	lpcr &= ~(LPCR_ISL | LPCR_UPRT | LPCR_HR);
 	mtspr(SPRN_LPCR, lpcr);
 
 	cur_cpu_spec->mmu_features |= MMU_FTRS_HASH_BASE;
