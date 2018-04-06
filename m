Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/JbY7T95W0TiXrKjrVmZ93vu/s7AtsOR9fq1phNQT7JJgjX/EYVy7g4Wl1u3BwWEvSZ1MC
ARC-Seal: i=1; a=rsa-sha256; t=1523021865; cv=none;
        d=google.com; s=arc-20160816;
        b=QBwJprQsEvMLq/YFtsB6UOwPVJa58ha+BKwXbhWywkaVJlfxFNx8x8JmwqwSifm18C
         Qo4hLZo276Bv1p9uREHQuMHZHxFerTqNCSa6IG8uXaId8BxCJJvDDkqj4u3lmJ1QmcTy
         zcM9aoaUHGptOLTRY9fLgDYY5ZrABGqgWBTOhm+mu45594HPLyy0eESsb2ze2qqiJrUD
         hsQM+gt0w+3Fq4JaGSRhhZ+9C6zj8pc026nS9p6BE0JppnwD4s4t/Mc7K6OkHnWpU92Z
         xbZ0qT6T/RaBoMQROiEnUcEIcI3rk/RmU3R0HERdkAyw5y7X5/F/CNGe+qgyr2ANBGXn
         LfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=12UodKDCVl5J0MGmsevoAOTi+rmGPm2Dg127a7tau2w=;
        b=VzyoAu7Gfe21a3Fe7cBPVmPz8TGhy/gm8JLmdik3mn9/405gz5Kw6ZO6lpYWCfQ6am
         BH2nFsGGS9M0Xpy/wU6gtIOehs1jpJFC7FB6Y8Tywc1gKuUEVLJv3ENmD/OzTu6iwlW7
         zAtsj4ito1SjStmNXf5PJ+wbXW/jb5BCaYPuuR2lBqHQtiqbMm2HRBEgh7IX0PMK1Rz7
         hm2anwUsVKZYfO3uPtYOwoKIN97l9BX85X4yVhbOJob8PE54NO/8x5IHEQZ9HUazJIja
         rUA+nFVWM2zuDKVFFo7rPBHHnFBTo97+5chRx5cXYlyVdmh3meHKMYPtZxp/GhXay0PQ
         yvDg==
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
Subject: [PATCH 4.14 16/67] powerpc/64s: Fix i-side SLB miss bad address handler saving nonvolatile GPRs
Date: Fri,  6 Apr 2018 15:23:46 +0200
Message-Id: <20180406084343.451696008@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003860218571411?=
X-GMAIL-MSGID: =?utf-8?q?1597004175681554122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -704,7 +704,7 @@ EXC_COMMON_BEGIN(bad_addr_slb)
 	ld	r3, PACA_EXSLB+EX_DAR(r13)
 	std	r3, _DAR(r1)
 	beq	cr6, 2f
-	li	r10, 0x480		/* fix trap number for I-SLB miss */
+	li	r10, 0x481		/* fix trap number for I-SLB miss */
 	std	r10, _TRAP(r1)
 2:	bl	save_nvgprs
 	addi	r3, r1, STACK_FRAME_OVERHEAD
