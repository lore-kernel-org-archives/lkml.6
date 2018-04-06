Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx485qXjLYn7rqOIWtu5m5KQKCZQ17Bn3EHf1hfvfIN5zr/ghJcX2BVYUX/oZDTosLqchPuYo
ARC-Seal: i=1; a=rsa-sha256; t=1523022150; cv=none;
        d=google.com; s=arc-20160816;
        b=1It7boUoGJUGrP7bJWu47sz5swUdFY/MT0PM8lb6yMidctwnjUPHjBAP66qqTGE+KR
         qL2Xf+0uF3LMJZqCLnEcng7jGx54lFu9eMylGLxHVf5ssZ0Of1J30KM4KEMt7XPLCRIP
         soKTiZY4MJQNoSiD6wm1ZzH6seiyN6ElTbE4IEqW0rmEeTZdOGwdcLM780sicRdP6FS/
         N69iQaOHhP6ibjCmJq/RG03tUY7mLKJGETwUX573SBiRpfm4wHb63mCVWNREYDPwor7A
         Q/VABYDm0udubyycI+eW6lokzJyfiFqxaVtRC/Qf0V7ba3PzTLj213R9rZi3ys7SwLNJ
         eEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ia6k1I8n668hnHD3OTrUNhpku4FwYs4LbWEGE9oNcRA=;
        b=JvVPyj/yC5ECXT30dqvRUu5zi0/HukhH6UCBhoJmZEUO5Fw0RRrfRMREHKotrwNJcb
         q5j/gJUrVolZhyYUu2tgXIlZJndSYSbLUIb3n7DjoqbKPFDKCkeQKolZmMT8BiFwuvm6
         uZwF1LzcEZ3byCR5yWcKyxbjfryG4nu76KP8hUHXFpG0B0LfGTpQnS3Te004W3QPxJTB
         qexNdOnH2pF7UHu9uSGyDA50hWqHbAulUC1A/taqp9OmAa+kxTXb+EiEjuQ4nKqI26LW
         XfpfFFY243phiPgTCBNuPcZ1i8ZGVWeU8XrOrZANfW/3MDyHmcpo4NoP44Qf6zeJeu/1
         x0rA==
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
Subject: [PATCH 4.15 18/72] powerpc/64s: Fix i-side SLB miss bad address handler saving nonvolatile GPRs
Date: Fri,  6 Apr 2018 15:23:53 +0200
Message-Id: <20180406084350.948403208@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003860218571411?=
X-GMAIL-MSGID: =?utf-8?q?1597004475095929178?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 52396500f97c53860164debc7d4f759077853423 upstream.

The SLB bad address handler's trap number fixup does not preserve the
low bit that indicates nonvolatile GPRs have not been saved. This
leads save_nvgprs to skip saving them, and subsequent functions and
return from interrupt will think they are saved.

This causes kernel branch-to-garbage debugging to not have correct
registers, can also cause userspace to have its registers clobbered
after a segfault.

Fixes: f0f558b131db ("powerpc/mm: Preserve CFAR value on SLB miss caused by access to bogus address")
Cc: stable@vger.kernel.org # v4.9+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/exceptions-64s.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -706,7 +706,7 @@ EXC_COMMON_BEGIN(bad_addr_slb)
 	ld	r3, PACA_EXSLB+EX_DAR(r13)
 	std	r3, _DAR(r1)
 	beq	cr6, 2f
-	li	r10, 0x480		/* fix trap number for I-SLB miss */
+	li	r10, 0x481		/* fix trap number for I-SLB miss */
 	std	r10, _TRAP(r1)
 2:	bl	save_nvgprs
 	addi	r3, r1, STACK_FRAME_OVERHEAD
