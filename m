Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELshB4T+cIiD2MUXiRSrDgWwDC6ZtZFvFPBv/UkuukbGixBSFldvDbW0qC2+BlQioic25lrj
ARC-Seal: i=1; a=rsa-sha256; t=1520824077; cv=none;
        d=google.com; s=arc-20160816;
        b=URSZ8p0C9JHKSWSKl3XOZIsq0l5h3yoDvkHQk41ivgc/R6BpyxwkI8SxWb2IWc0NPc
         QnQiR+rvR63Pd/MPN3ugTiFSHyjg5KMO2C/aYXRxtaWTIExQa6vSjfDzzhhVkklZLv9y
         iBih8qFBJvOzRXdeMOKo9atzB8u/iHowK60PwcDVIE8qNve0awPtDL20WW7AbLAe0Gdm
         GajBpyJH195WLeyzF5opYLPej/H3wzyOW38Ji7G5mwm1ujaK/uW6SReYNTJJYtBu7XeJ
         PW1xZeEXTx5d9dftht3Pl7wyLB5AIaTcdA+PIdyioxEdG2MpJ8+yU927NeujGDTEaM2s
         ZdYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=cW/qvv9CzD1LElM41rNOk+fmPoZ48T6VOiXw/n6DmOU=;
        b=W1Evo+5nkxcIQn3BGxm4CP1KRKHnUNfEpJVC4FbCPKfMwyxuJGX/gRSMWorXRpXq0N
         3YQynZ/jk2c09I2c04F2CPbkr4mM58FpF2FF3L8Ggwc7xv94nqpdDvfsP0YcTnfzJiDr
         Bf7/pmUqfkgEgXmjDDZEX4cnMmmvzuOytqMVmn350wk4G3CeWU/mOG+dvfXwa1cZlvx+
         EYrIu0gDJ2nQ5KZr3joM7eOOxEt40O05gJ6lpHHv5Srgm/wqb6O0LlXgLGiIWUqt2kk7
         l9ypHegTJ2yayST6thW5l9gL5ghrpWloXvqus9oZQ6gLTlYuF+sjXhq5ELMHevWlmdKW
         HRNg==
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
 dave.hansen@intel.com,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 gregkh@linuxfoundation.org,
 "Andi Kleen" <ak@linux.intel.com>,
 torvalds@linux-foundation.org
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.548637965@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 39/76] x86/retpoline: Optimize inline assembler for
 vmexit_fill_RSB
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699614394357125?=
X-GMAIL-MSGID: =?utf-8?q?1594699627569933987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust contex]
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
