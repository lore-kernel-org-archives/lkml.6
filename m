Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225m4vhu3NpyoQW2x99ydZ93feSEHqx/SJUlIk+LfGdHNbJkmPAjT4RnF2ulpFNwp7fgIgSo
ARC-Seal: i=1; a=rsa-sha256; t=1519218671; cv=none;
        d=google.com; s=arc-20160816;
        b=jS9ROk1TFpjvJtFNdoSGNjBeGOgzhgD/VKJrDNJF207ffxwziE7TB/LxI8fxqxQPzk
         Or+oVq+7uUFBRs0yFAIUKtWiuek07+1p/fM6mrYwCXjbl7Ofl+KFm8Xn8f5u274HKDQX
         9AyVsycbb6j6P60Tyy7ISHT2hVm8hbVIDrQ4P5NBPXTHb1G76Kd3Hda6OI9/bu6VhjJn
         MjuMYhNz+pHvpm6lWaszH0nByYd5bHsoyVdoyuduqZCYHZFfCVdYWCQEQcywN6AbDpKL
         3TWLhFQPIXtooHaFrutGM68Z5k+eLDB1GWBmwdrC4LLkPvpUEaptjdbKc4FAZ1kuol0b
         Mhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZoKpDkj7ggsrolOIKx9hKHEKjecpedhXlg0DNcvelwQ=;
        b=cuWXjVYzfPuJ6063z0UYcNB01bsjJkXOnPwmEswczK4bizRHokRdpi6BOJW6mX34NT
         e9U99b++pzI+KvqWPw/nKMUYu15HlJ0709dypjK31ULJiXkkpdEMdzCRoTw5Rkeh7VES
         PP5edhzVK/pp3yAEdt2QjTgy60XQCY233B29jD+TZCyKGxYQ0yKTpcxkqLZhWgQF+Sm5
         4gho5+dC4dY7XeAIW6vCUUaumoaRNEyolnf6azFTVuRngSzymGii1RIO9z8YEyaxMCO2
         bWBPVTgxHSAlPOBttTpmN4R9K1QPLph+m1UIYzMtWqPzBN17gxHoQOSuPqbV4/SYg0rF
         HtvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Greg Ungerer <gerg@linux-m68k.org>,
	James Hogan <jhogan@kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Paul Burton <paul.burton@mips.com>,
	linux-mips@linux-mips.org
Subject: [PATCH 4.15 113/163] MIPS: CPS: Fix MIPS_ISA_LEVEL_RAW fallout
Date: Wed, 21 Feb 2018 13:49:02 +0100
Message-Id: <20180221124536.407722932@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593016238261572063?=
X-GMAIL-MSGID: =?utf-8?q?1593016238261572063?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit 8dbc1864b74f5dea5a3f7c30ca8fd358a675132f upstream.

Commit 17278a91e04f ("MIPS: CPS: Fix r1 .set mt assembler warning")
added .set MIPS_ISA_LEVEL_RAW to silence warnings about .set mt on r1,
however this can result in a MOVE being encoded as a 64-bit DADDU
instruction on certain version of binutils (e.g. 2.22), and reserved
instruction exceptions at runtime on 32-bit hardware.

Reduce the sizes of the push/pop sections to include only instructions
that are part of the MT ASE or which won't convert to 64-bit
instructions after .set mips64r2/mips64r6.

Reported-by: Greg Ungerer <gerg@linux-m68k.org>
Fixes: 17278a91e04f ("MIPS: CPS: Fix r1 .set mt assembler warning")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.15
Tested-by: Greg Ungerer <gerg@linux-m68k.org>
Patchwork: https://patchwork.linux-mips.org/patch/18578/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/cps-vec.S |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -388,15 +388,16 @@ LEAF(mips_cps_boot_vpes)
 
 #elif defined(CONFIG_MIPS_MT)
 
-	.set	push
-	.set	MIPS_ISA_LEVEL_RAW
-	.set	mt
-
 	/* If the core doesn't support MT then return */
 	has_mt	t0, 5f
 
 	/* Enter VPE configuration state */
+	.set	push
+	.set	MIPS_ISA_LEVEL_RAW
+	.set	mt
 	dvpe
+	.set	pop
+
 	PTR_LA	t1, 1f
 	jr.hb	t1
 	 nop
@@ -422,6 +423,10 @@ LEAF(mips_cps_boot_vpes)
 	mtc0	t0, CP0_VPECONTROL
 	ehb
 
+	.set	push
+	.set	MIPS_ISA_LEVEL_RAW
+	.set	mt
+
 	/* Skip the VPE if its TC is not halted */
 	mftc0	t0, CP0_TCHALT
 	beqz	t0, 2f
@@ -495,6 +500,8 @@ LEAF(mips_cps_boot_vpes)
 	ehb
 	evpe
 
+	.set	pop
+
 	/* Check whether this VPE is meant to be running */
 	li	t0, 1
 	sll	t0, t0, a1
@@ -509,7 +516,7 @@ LEAF(mips_cps_boot_vpes)
 1:	jr.hb	t0
 	 nop
 
-2:	.set	pop
+2:
 
 #endif /* CONFIG_MIPS_MT_SMP */
 
