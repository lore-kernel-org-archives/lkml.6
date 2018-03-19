Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtVNdT4gPK1snR63tQ8e/9PjYjE1F4IrXxkZ7oFj+BoFonKcDqy0667jGZnsY/npSM6KTOk
ARC-Seal: i=1; a=rsa-sha256; t=1521483274; cv=none;
        d=google.com; s=arc-20160816;
        b=0u78pV/eGESE/g7DdTLQD0g7q8x1F/GbX+/23NSBPN7LaDuXu2djfTNjnDGyJx/af5
         U9t1WzHlEE8etFww1XWOi8aH1KEjGM9yDbuQfQhNiozMBkZIY/FueFaIKOuoIKiGtYb4
         qxj5k9Yxedy9GJAZCj0s4mm2H5/H7JmuyBuRCny7kgaaixdt45cgMoeC1nsAduTNwGkl
         T/EeSXH3sezpAhmNHjDqTZo1oJF4DA3BRSuzhaX3lsypw9am7o+c5PklRvFULQdH0e1W
         QH8nkWN8zJdaqCTUuu/D+pZFlDZlcRbz8wmQe5K1BynEniOJO+EsSUdJDBkoP9gk5g0s
         TIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UnB0EA+nVFQO0Y4+Kdazx/CpHsPX7i0mosQ+DCt0gYU=;
        b=ae77X+7n3/kpeBTWAZep06x4So1NXetc+CF8Aom7l/zq4QaxlDsYb/u3c3wbFUTby9
         G7CpDcrQjN8SpTWuRCIcupKlcZCWnmXO0cNjrjY1ssgXO50UR712HEyeCvdI5B7mcyCl
         pcjFtSOGoHyUBe1QN09uQQYEoehdr+qbOKdgDWxpFCGWJx3IkWSeQxTyENJyhtec2zTY
         MZzVjj4ra6s6nMVBRTgQwBLO210ChySWrlWAqrCuwMgWCF0/ZkvBkXpbRTz9Xpa66v+4
         9Ay5tgbpSNX1EEOax810hebbhqr3YbBcXbsTOvq8zmL9EEfa+z9oCWLGPUTAOnJklb9Q
         TWVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Daney <david.daney@cavium.com>,
	James Hogan <james.hogan@imgtec.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"Steven J. Hill" <steven.hill@cavium.com>,
	linux-mips@linux-mips.org,
	netdev@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 063/134] MIPS: BPF: Fix multiple problems in JIT skb access helpers.
Date: Mon, 19 Mar 2018 19:05:46 +0100
Message-Id: <20180319171858.380719820@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390846018808300?=
X-GMAIL-MSGID: =?utf-8?q?1595390846018808300?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Daney <david.daney@cavium.com>


[ Upstream commit a81507c79f4ae9a0f9fb1054b59b62a090620dd9 ]

o Socket data is unsigned, so use unsigned accessors instructions.

 o Fix path result pointer generation arithmetic.

 o Fix half-word byte swapping code for unsigned semantics.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Steven J. Hill <steven.hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15747/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/net/bpf_jit_asm.S |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/arch/mips/net/bpf_jit_asm.S
+++ b/arch/mips/net/bpf_jit_asm.S
@@ -90,18 +90,14 @@ FEXPORT(sk_load_half_positive)
 	is_offset_in_header(2, half)
 	/* Offset within header boundaries */
 	PTR_ADDU t1, $r_skb_data, offset
-	.set	reorder
-	lh	$r_A, 0(t1)
-	.set	noreorder
+	lhu	$r_A, 0(t1)
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 # if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
-	wsbh	t0, $r_A
-	seh	$r_A, t0
+	wsbh	$r_A, $r_A
 # else
-	sll	t0, $r_A, 24
-	andi	t1, $r_A, 0xff00
-	sra	t0, t0, 16
-	srl	t1, t1, 8
+	sll	t0, $r_A, 8
+	srl	t1, $r_A, 8
+	andi	t0, t0, 0xff00
 	or	$r_A, t0, t1
 # endif
 #endif
@@ -115,7 +111,7 @@ FEXPORT(sk_load_byte_positive)
 	is_offset_in_header(1, byte)
 	/* Offset within header boundaries */
 	PTR_ADDU t1, $r_skb_data, offset
-	lb	$r_A, 0(t1)
+	lbu	$r_A, 0(t1)
 	jr	$r_ra
 	 move	$r_ret, zero
 	END(sk_load_byte)
@@ -139,6 +135,11 @@ FEXPORT(sk_load_byte_positive)
  * (void *to) is returned in r_s0
  *
  */
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define DS_OFFSET(SIZE) (4 * SZREG)
+#else
+#define DS_OFFSET(SIZE) ((4 * SZREG) + (4 - SIZE))
+#endif
 #define bpf_slow_path_common(SIZE)				\
 	/* Quick check. Are we within reasonable boundaries? */ \
 	LONG_ADDIU	$r_s1, $r_skb_len, -SIZE;		\
@@ -150,7 +151,7 @@ FEXPORT(sk_load_byte_positive)
 	PTR_LA		t0, skb_copy_bits;			\
 	PTR_S		$r_ra, (5 * SZREG)($r_sp);		\
 	/* Assign low slot to a2 */				\
-	move		a2, $r_sp;				\
+	PTR_ADDIU	a2, $r_sp, DS_OFFSET(SIZE);		\
 	jalr		t0;					\
 	/* Reset our destination slot (DS but it's ok) */	\
 	 INT_S		zero, (4 * SZREG)($r_sp);		\
