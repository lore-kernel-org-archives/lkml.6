Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZraK6C6rdFZ4AbZALpWx8TU0zIaQRzznfsLJbdjLBbN2hJDWY/K91S6NKmyNZ+wCxuo0HpQ
ARC-Seal: i=1; a=rsa-sha256; t=1527156144; cv=none;
        d=google.com; s=arc-20160816;
        b=m5Y2h1+4+1QSST+Lhw+Mugw9nCE6MOwsFA03KdR3TKXngiy0c8WRuVa6gDjRhAmmgx
         ml1afygC6cFst8eOJoIAAdEiHA28j5jOtpVtmSTpS8r66M1sENXA6lP5zLAb6yMPmihj
         KZGEy7OMvBVr7yoE8bi9MGLdjLRMi56AN8ISgXoKYzSQT3hUzNLHoRcz4+ZLPPRz6Qgf
         6BTjUNxiVVrD4JTN4iVPie/APC0CcYty2qYoNa3ZwG0ScnObf2znrvo+lkvJONBrsIQX
         oI5xkuI14jUP1HOM9p4Uqk3uBtt9/dJZRe4SHNsKliJvSeDxllVzTZiP2zPfwNFDPw4d
         XXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=fWa3jW3EMubhTAeT7p52050rVh1TkqCD4q1XHhNkbUY=;
        b=OXZ5YJWeRy0ODQQU/WWlTd5gZlW5gf4ovDGT7AzSMagW5gzI3iIf0sZqof2jK4Rd/n
         C+WTLFscE6MBwEtLTP2Y6VeYtPLh8sTeHDwBp+2soTQa0L69Qh2tHIL1z5I0AuH7R9nO
         xbYTmnxD4qxS6IhOEMBxoI4jdTE70Bdz9cUi+gzQa3QnnkDmXSzAUiaLHiRog3hHUPrp
         MIMHyYQMHbCYLAyiwNzMRuduV2isjKxFPBqChfyNVeI/05hhxhOIfAi6Q+6dUd+yhq56
         vQIlYaP9JQrK9zIo5E235eGLue65wyTmTKxdrBDvl9F0oTJPD/umyFNWJNMKaKeYJ2qo
         DQAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lKeKBfGG;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lKeKBfGG;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 062/161] s390: extend expoline to BC instructions
Date: Thu, 24 May 2018 11:38:07 +0200
Message-Id: <20180524093025.935305947@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338299102356702?=
X-GMAIL-MSGID: =?utf-8?q?1601339281296136795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit 6deaa3bbca804b2a3627fd685f75de64da7be535 ]

The BPF JIT uses a 'b <disp>(%r<x>)' instruction in the definition
of the sk_load_word and sk_load_half functions.

Add support for branch-on-condition instructions contained in the
thunk code of an expoline.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/nospec-insn.h |   57 ++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/nospec-branch.c    |   25 ++++++++++++---
 2 files changed, 77 insertions(+), 5 deletions(-)

--- a/arch/s390/include/asm/nospec-insn.h
+++ b/arch/s390/include/asm/nospec-insn.h
@@ -35,10 +35,18 @@ _LC_BR_R1 = __LC_BR_R1
 	__THUNK_PROLOG_NAME __s390x_indirect_jump_r\r2\()use_r\r1
 	.endm
 
+	.macro __THUNK_PROLOG_BC d0,r1,r2
+	__THUNK_PROLOG_NAME __s390x_indirect_branch_\d0\()_\r2\()use_\r1
+	.endm
+
 	.macro __THUNK_BR r1,r2
 	jg	__s390x_indirect_jump_r\r2\()use_r\r1
 	.endm
 
+	.macro __THUNK_BC d0,r1,r2
+	jg	__s390x_indirect_branch_\d0\()_\r2\()use_\r1
+	.endm
+
 	.macro __THUNK_BRASL r1,r2,r3
 	brasl	\r1,__s390x_indirect_jump_r\r3\()use_r\r2
 	.endm
@@ -81,6 +89,23 @@ _LC_BR_R1 = __LC_BR_R1
 	.endif
 	.endm
 
+	.macro	__DECODE_DRR expand,disp,reg,ruse
+	.set __decode_fail,1
+	.irp r1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \reg,%r\r1
+	.irp r2,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \ruse,%r\r2
+	\expand \disp,\r1,\r2
+	.set __decode_fail,0
+	.endif
+	.endr
+	.endif
+	.endr
+	.if __decode_fail == 1
+	.error "__DECODE_DRR failed"
+	.endif
+	.endm
+
 	.macro __THUNK_EX_BR reg,ruse
 	# Be very careful when adding instructions to this macro!
 	# The ALTERNATIVE replacement code has a .+10 which targets
@@ -101,12 +126,30 @@ _LC_BR_R1 = __LC_BR_R1
 555:	br	\reg
 	.endm
 
+	.macro __THUNK_EX_BC disp,reg,ruse
+#ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
+	exrl	0,556f
+	j	.
+#else
+	larl	\ruse,556f
+	ex	0,0(\ruse)
+	j	.
+#endif
+556:	b	\disp(\reg)
+	.endm
+
 	.macro GEN_BR_THUNK reg,ruse=%r1
 	__DECODE_RR __THUNK_PROLOG_BR,\reg,\ruse
 	__THUNK_EX_BR \reg,\ruse
 	__THUNK_EPILOG
 	.endm
 
+	.macro GEN_B_THUNK disp,reg,ruse=%r1
+	__DECODE_DRR __THUNK_PROLOG_BC,\disp,\reg,\ruse
+	__THUNK_EX_BC \disp,\reg,\ruse
+	__THUNK_EPILOG
+	.endm
+
 	.macro BR_EX reg,ruse=%r1
 557:	__DECODE_RR __THUNK_BR,\reg,\ruse
 	.pushsection .s390_indirect_branches,"a",@progbits
@@ -114,6 +157,13 @@ _LC_BR_R1 = __LC_BR_R1
 	.popsection
 	.endm
 
+	 .macro B_EX disp,reg,ruse=%r1
+558:	__DECODE_DRR __THUNK_BC,\disp,\reg,\ruse
+	.pushsection .s390_indirect_branches,"a",@progbits
+	.long	558b-.
+	.popsection
+	.endm
+
 	.macro BASR_EX rsave,rtarget,ruse=%r1
 559:	__DECODE_RRR __THUNK_BRASL,\rsave,\rtarget,\ruse
 	.pushsection .s390_indirect_branches,"a",@progbits
@@ -125,10 +175,17 @@ _LC_BR_R1 = __LC_BR_R1
 	.macro GEN_BR_THUNK reg,ruse=%r1
 	.endm
 
+	.macro GEN_B_THUNK disp,reg,ruse=%r1
+	.endm
+
 	 .macro BR_EX reg,ruse=%r1
 	br	\reg
 	.endm
 
+	 .macro B_EX disp,reg,ruse=%r1
+	b	\disp(\reg)
+	.endm
+
 	.macro BASR_EX rsave,rtarget,ruse=%r1
 	basr	\rsave,\rtarget
 	.endm
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -93,7 +93,6 @@ static void __init_or_module __nospec_re
 	s32 *epo;
 
 	/* Second part of the instruction replace is always a nop */
-	memcpy(insnbuf + 2, (char[]) { 0x47, 0x00, 0x00, 0x00 }, 4);
 	for (epo = start; epo < end; epo++) {
 		instr = (u8 *) epo + *epo;
 		if (instr[0] == 0xc0 && (instr[1] & 0x0f) == 0x04)
@@ -114,18 +113,34 @@ static void __init_or_module __nospec_re
 			br = thunk + (*(int *)(thunk + 2)) * 2;
 		else
 			continue;
-		if (br[0] != 0x07 || (br[1] & 0xf0) != 0xf0)
+		/* Check for unconditional branch 0x07f? or 0x47f???? */
+		if ((br[0] & 0xbf) != 0x07 || (br[1] & 0xf0) != 0xf0)
 			continue;
+
+		memcpy(insnbuf + 2, (char[]) { 0x47, 0x00, 0x07, 0x00 }, 4);
 		switch (type) {
 		case BRCL_EXPOLINE:
-			/* brcl to thunk, replace with br + nop */
 			insnbuf[0] = br[0];
 			insnbuf[1] = (instr[1] & 0xf0) | (br[1] & 0x0f);
+			if (br[0] == 0x47) {
+				/* brcl to b, replace with bc + nopr */
+				insnbuf[2] = br[2];
+				insnbuf[3] = br[3];
+			} else {
+				/* brcl to br, replace with bcr + nop */
+			}
 			break;
 		case BRASL_EXPOLINE:
-			/* brasl to thunk, replace with basr + nop */
-			insnbuf[0] = 0x0d;
 			insnbuf[1] = (instr[1] & 0xf0) | (br[1] & 0x0f);
+			if (br[0] == 0x47) {
+				/* brasl to b, replace with bas + nopr */
+				insnbuf[0] = 0x4d;
+				insnbuf[2] = br[2];
+				insnbuf[3] = br[3];
+			} else {
+				/* brasl to br, replace with basr + nop */
+				insnbuf[0] = 0x0d;
+			}
 			break;
 		}
 
