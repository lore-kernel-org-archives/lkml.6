Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx497H9iAfA+f7i9HjcyyuU65PPJXmOZtEmx0v8nkqUFyfZLi3LkdLrBztpw8rsTbooxRXWU7
ARC-Seal: i=1; a=rsa-sha256; t=1523021564; cv=none;
        d=google.com; s=arc-20160816;
        b=GouKNbnkw3AeD5ksWQjs/rzKhkm/lZiCS7xDxUMCp75M5BDR48NYZXalfwoPmZwsAJ
         c+YIg8pwNpHL7seOllnQqRPERapHzrFYWcbo2Nzv3q/9X9yNi9P6WdGdfDkh7CbGnwtN
         zwdiqJqEB3dnr1wuMgroanjqEGIT61gGWuYo105j/hrI8VLFLcqjsDce+RsDzIGoEFpD
         DK+rNO/nNMNOEGg3CGwM/1ZQpIKH7YXEw0gl/hmwpzPMwYL2d0hb7eFgWvRV+hxTu29q
         mNFLMVrggb8tUbXnpsjc/P29bjQsEMC0NigKXt0d1bHdCIf8hfIl+T57ov2puCLu0WqB
         e8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=asmBrGXG2eqg88KpLp5A0y9objq4BhSg+pltcHW+lFs=;
        b=cF5yyeFAipAGTeHVxf2UT3T1RdTemC3/s4Nqy+CV6DVO/Bd3AV930gMoG+NL8oZSpt
         Fw0pt8NLZOnvCclCVEJhi4l9z6DA/6QkHc6seGeNoBjCZVcx6TQ2boOOJr8a9ZNSjgp3
         yQ3yJOa+QxPwgyNTvgF2DAfEXzdpgaVy2tltrzNNhgA80ZUAglMRGXSPSp11+AByLmTX
         2/Oa1TBD4aEDgoJ4hN9iqjVAQEJaTSKz0UFapJp7HjjpX16jbZaN/zOfCge2IDkBPgYr
         XoNBlXU7WtAN99u394y6fRZlMW820XXkDEi1pRjSX6hpZ0vEHzSOUr8PIBKasVS7M/3N
         yDgw==
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
Subject: [PATCH 4.9 010/102] powerpc/64s: Fix i-side SLB miss bad address handler saving nonvolatile GPRs
Date: Fri,  6 Apr 2018 15:22:51 +0200
Message-Id: <20180406084333.042021081@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003860218571411?=
X-GMAIL-MSGID: =?utf-8?q?1597003860218571411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -723,7 +723,7 @@ EXC_COMMON_BEGIN(bad_addr_slb)
 	ld	r3, PACA_EXSLB+EX_DAR(r13)
 	std	r3, _DAR(r1)
 	beq	cr6, 2f
-	li	r10, 0x480		/* fix trap number for I-SLB miss */
+	li	r10, 0x481		/* fix trap number for I-SLB miss */
 	std	r10, _TRAP(r1)
 2:	bl	save_nvgprs
 	addi	r3, r1, STACK_FRAME_OVERHEAD
