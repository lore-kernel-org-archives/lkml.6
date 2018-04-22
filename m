Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49RSkBAgR/x0FLNdycFesZpgfv3j+gbo643Xuxi8dK5xGa8IW6fdQkBHNRfbeJULrZwRIgV
ARC-Seal: i=1; a=rsa-sha256; t=1524405427; cv=none;
        d=google.com; s=arc-20160816;
        b=TCQ0F8+NFtbCKtLBi0IfxNmIz2qWmQmyjM/ojV0l/vKSRG6Cp473yei1XgX7fypAUx
         I5C6od1VDilvBBaqtPWnIWfDGlbjHNN5XZ6ujgKSQmiWiYRpa2aBY27GGP8J4RINaPMN
         qHZKr1Oq0rQ0LPKHE+FOwkKAMrZ6G9L5yi5S5q0xcjJVmcfSL+i0HjKLqSdYxZriFVks
         4wtyEdTxt3NwLQUjOW4D/8xzJN+kYFOaFgspfjuus71GwpStHc6s02JlCTTQM3+mAThL
         rKOEryypIcTuJaXOnLJBStMwD0UJYM3xYToEeTbMXzBsICUXcdKFtk/kzMX+awWkkea5
         963Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+1tHIaja6UMpqTXQ610ftGF9Bqt7/cMWgvBh15BW6N0=;
        b=OIq+IwtL4klO5AfvO8Dz+t4UP5h7d1V3EMyPFqmPDwpP8NB+7GP2AZCdyiH0VZpFUe
         fL1tDw1Z3+SOvxEDRi7AsH+yuynYR7XfLfCa+awlK28DfxeIwvFTzcWyJJQHvqkRipdG
         MFg/9qtbIvD7t0AfpKYxctfwbRT0MHpdvlhBC/ZG+sKiGZnJWyUUzJUuemePgtPl0ChY
         CHzB9mS2kk1vJBQ8VX4LBs+h1242Pnx4aNDv1pkrvUUle5UJftbU+mCfcztc3kEvgcDK
         0oPcSg7IV3lcNwU+WjndsAx2taPStryomvJyDuPICxDGj1gPEOSLYUMB9KatDpZLmP/z
         s+Rg==
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
Subject: [PATCH 4.16 062/196] powerpc/64s: Fix dt_cpu_ftrs to have restore_cpu clear unwanted LPCR bits
Date: Sun, 22 Apr 2018 15:51:22 +0200
Message-Id: <20180422135107.452591280@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454945020240029?=
X-GMAIL-MSGID: =?utf-8?q?1598454945020240029?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -84,6 +84,7 @@ static int hv_mode;
 
 static struct {
 	u64	lpcr;
+	u64	lpcr_clear;
 	u64	hfscr;
 	u64	fscr;
 } system_registers;
@@ -92,6 +93,8 @@ static void (*init_pmu_registers)(void);
 
 static void __restore_cpu_cpufeatures(void)
 {
+	u64 lpcr;
+
 	/*
 	 * LPCR is restored by the power on engine already. It can be changed
 	 * after early init e.g., by radix enable, and we have no unified API
@@ -104,8 +107,10 @@ static void __restore_cpu_cpufeatures(vo
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
@@ -325,8 +330,9 @@ static int __init feat_enable_mmu_hash_v
 {
 	u64 lpcr;
 
+	system_registers.lpcr_clear |= (LPCR_ISL | LPCR_UPRT | LPCR_HR);
 	lpcr = mfspr(SPRN_LPCR);
-	lpcr &= ~LPCR_ISL;
+	lpcr &= ~(LPCR_ISL | LPCR_UPRT | LPCR_HR);
 	mtspr(SPRN_LPCR, lpcr);
 
 	cur_cpu_spec->mmu_features |= MMU_FTRS_HASH_BASE;
