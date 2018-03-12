Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvdPv7A9H3J/SikROrPNFpS3wgaT9YuTohdu+hLdGQf6uIjsMFchB35twPSMIIjRwavhRV3
ARC-Seal: i=1; a=rsa-sha256; t=1520824064; cv=none;
        d=google.com; s=arc-20160816;
        b=FyPbdNMd8L2kp9mRpv+Hc2vuBciHnaLEJirFTwiXZC7hmSDLMPyu4Ey59LSQW6KJN1
         xdICTKYNPD4a1Gce16aPiucKWxLoSiZlpckUOYPdtPCY3jvMbuysbIXxMwpeSXuTcVRm
         hMxpnrQTAwLDAAJk23ps/8XyxM8+iK9vbF9Bavmta7Zto+ILcFE3wNXs85CqzyRebZXC
         cM3r6oEQ4Bjv+eAVe09dVirSeTv7zNpl2d3Q8IvAICEd7TeAsZ4Zf05/0S80jUQ6Ta7K
         /sdGA+vZPgR209xDEXSt+sWKiO2n0iMT6k5c8eLrSRMN3WocZDEwy3nf7pbweD7L/ehq
         EsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=27py0YGfvXGjVC+vyMSr0GxwLHhc6BpHL+YwLznuqao=;
        b=MWTMb8/wrhl0CJIXlOzLWvuOHXHSyHDpV40ILiR9sNkncXwGrf1Vr0NTEfSBQygYn6
         Hx73vQoQRHeoqOAaYmzCCTjYhCEplRBSXjuu9V5gR9uLYLswRkJhZZSkgGZsI16dGP6Y
         lU+g77RLT2tyuPjYbM6ECDfrAO1uJsiPd0j7j3EvUVoIg79087uK/hbw552CKUkGMzV2
         mYMKJus1n1EWUWPJcyQ0hLxbMT+WVzTVPexVuBY6aIL8wO1XYdWW2cX5ympyoA0uY/bR
         pujGPBmg1DLpv9frZoP8rBTdhqz1hq7iLMGZp9PTPUvaYvB0oErEel2K1GV8ewEA7t4Z
         KKqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, arjan@linux.intel.com,
 gregkh@linuxfoundation.org, dave.hansen@intel.com,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Andi Kleen" <ak@linux.intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 torvalds@linux-foundation.org
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.585469391@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 073/104] x86/retpoline: Optimize inline assembler for
 vmexit_fill_RSB
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699614394357125?=
X-GMAIL-MSGID: =?utf-8?q?1594699614394357125?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit 3f7d875566d8e79c5e0b2c9a413e91b2c29e0854 upstream.

The generated assembler for the C fill RSB inline asm operations has
several issues:

- The C code sets up the loop register, which is then immediately
  overwritten in __FILL_RETURN_BUFFER with the same value again.

- The C code also passes in the iteration count in another register, which
  is not used at all.

Remove these two unnecessary operations. Just rely on the single constant
passed to the macro for the iterations.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: dave.hansen@intel.com
Cc: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org
Cc: arjan@linux.intel.com
Link: https://lkml.kernel.org/r/20180117225328.15414-1-andi@firstfloor.org
[bwh: Backported to 3.2: adjust contex]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/nospec-branch.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -183,15 +183,16 @@ extern char __indirect_thunk_end[];
 static inline void vmexit_fill_RSB(void)
 {
 #ifdef CONFIG_RETPOLINE
-	unsigned long loops = RSB_CLEAR_LOOPS / 2;
+	unsigned long loops;
 
 	asm volatile (ALTERNATIVE("jmp 910f",
 				  __stringify(__FILL_RETURN_BUFFER(%0, RSB_CLEAR_LOOPS, %1)),
 				  X86_FEATURE_RETPOLINE)
 		      "910:"
-		      : "=&r" (loops), ASM_CALL_CONSTRAINT
-		      : "r" (loops) : "memory" );
+		      : "=r" (loops), ASM_CALL_CONSTRAINT
+		      : : "memory" );
 #endif
 }
+
 #endif /* __ASSEMBLY__ */
 #endif /* __NOSPEC_BRANCH_H__ */
