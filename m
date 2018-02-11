Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x227/WDtozSVGJ3uQAX9R4gbOq0HryIwCWCL5HdJqg571IxatlF9J+xFOeHc+PjQI99qgbDkG
ARC-Seal: i=1; a=rsa-sha256; t=1518323626; cv=none;
        d=google.com; s=arc-20160816;
        b=FqR8tFDB0Ysuf/5+ZCivHw15a3RubNHG+pLZiy5bzEgMYoLx4OynkclvZ/LnD0yHUC
         +z6N/1tMNJrXTdKtmqbzKse25slsUfwf7mVouonMjduCKf2HTBXrqoMxmpiiuO50oIXW
         LGNbMGXARy91VaIdBtLwuV++FfRz5nepZCS+Iym9efr5wAJ6tqcEB/slfQsw0wmubFXF
         AiVqJPGnsXCu4m2XmzxOpX7wbBcIaV5Kc646H+Xf4D/DZVsqgPM/K9IKj5E32gwTJQWB
         J8v0nFbJkTqVXTtF+0vD+whPmYVnqPxM8Pltbi9xngoelrA4T8NdThrMshWZIRRa6+95
         7STQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=UmCursKY8JWrpBiVGa/F3Dr9dj2SPWPo8r3P5hl/PqY=;
        b=o69Tun/eOKdyFm2vqTwRCMsbokFlkdbKsAnS/DJdNL8B1TzF44gVTHPzIAqQIe1y02
         SSyioCRmhNpKTEQ9I/KgkV11PZzCZbI8KYhTifVYK4vYcV+QLYIlTM7lwaE5g7EK0EmK
         fEzYcw3igFxcWEsxjhQaS2JkF89Z4fFnPBGucM+hLuqnvgNWmv/dS7MrsSWDWRNbr97O
         fHH+sWBxKCZ5d/Bh0qfaHa2OEqRMtbsF/e1MS6UFWm3xMTOkzMNPVlT6ElYnnUQFfX/U
         WaNngIDI6/WkT6To0QmNWpvIrRyDwKggRcWt/4pwH9ctyKikzoJ0dGejHoE1qswYHu1r
         XTMA==
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
CC: akpm@linux-foundation.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Ingo Molnar" <mingo@kernel.org>,
 "kbuild test robot" <fengguang.wu@intel.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.89839826@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 60/79] x86/decoder: Add new TEST instruction pattern
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077714785292297?=
X-GMAIL-MSGID: =?utf-8?q?1592077714785292297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 12a78d43de767eaf8fb272facb7a7b6f2dc6a9df upstream.

The kbuild test robot reported this build warning:

  Warning: arch/x86/tools/test_get_len found difference at <jump_table>:ffffffff8103dd2c

  Warning: ffffffff8103dd82: f6 09 d8 testb $0xd8,(%rcx)
  Warning: objdump says 3 bytes, but insn_get_length() says 2
  Warning: decoded and checked 1569014 instructions with 1 warnings

This sequence seems to be a new instruction not in the opcode map in the Intel SDM.

The instruction sequence is "F6 09 d8", means Group3(F6), MOD(00)REG(001)RM(001), and 0xd8.
Intel SDM vol2 A.4 Table A-6 said the table index in the group is "Encoding of Bits 5,4,3 of
the ModR/M Byte (bits 2,1,0 in parenthesis)"

In that table, opcodes listed by the index REG bits as:

  000         001       010 011  100        101        110         111
 TEST Ib/Iz,(undefined),NOT,NEG,MUL AL/rAX,IMUL AL/rAX,DIV AL/rAX,IDIV AL/rAX

So, it seems TEST Ib is assigned to 001.

Add the new pattern.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/lib/x86-opcode-map.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -759,7 +759,7 @@ EndTable
 
 GrpTable: Grp3_1
 0: TEST Eb,Ib
-1:
+1: TEST Eb,Ib
 2: NOT Eb
 3: NEG Eb
 4: MUL AL,Eb
