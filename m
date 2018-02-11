Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x226vb2m0zbzXv/OGQ7AJBTuYZAHMxiISYsUP43G5Ab0p8DabSnBkRX7jd75krucU7r75HIDk
ARC-Seal: i=1; a=rsa-sha256; t=1518323642; cv=none;
        d=google.com; s=arc-20160816;
        b=e56EvTX78L12wHnG9tWyf8zgkpdv9wM406gHDVcPWpf1spEj+DRYs5qJJBer0o0hVA
         xVDA7EqIkV3p/5Ja/Eth6xZhFeKLuvVG7HtH8oOUlO8G5kSlZPVLz8WjYZX5y8iVj1eL
         NAZtbIqDwCwCpt3O/goiLJ2h7w+tVvDHJaBL/AH0mDeG7nfnWwcunitCaiEx3IkI8tpu
         mOBd1jhbG/iMtG8iuGV1fh3qa2uE8slZJ3cmNYIrG7QZXFj4bBtVYNn1xBRprdXAgJa8
         U4fh5CM+vTb0VP5XV7Kva9pHCJtSKPQ9s0hJChFYArVFCdXrEsZCEptRwfD9spNe6q6g
         +t6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=Xv7C9/1JfhELLGn9noZh9SEoyYQbzPj9AfHtb4M5dJ4=;
        b=jRMD2jg1lxrfFYJuajSE7w1XMUtuznqGGyeh7nKot1UHYBmxpbyotKq6OkRn6TtSNA
         i6s2MRvne0Lt6aQaeAcX41LF1avmrV5VAAagEaBk7Z4L95KLqoUSkpVYaDC6PavE2iK+
         YkltURnAR9CcCGSR9stmWWTpZ+7T4g0LJJcYTfpwOzSQjWkpSxfR88/rr9wQbgDAwGv4
         A3eeHSwog0M1t2D9R76L+DqIj8oZjKSJuGMmzgUJlMFCYntk0bksccNCYWJdC23KgCPQ
         vrlPSyoDCO7oAEOp//dQUWiL5e56D5wsUNt8QTd5EPYPNkTAzfo58BrkQgWBKdIp2mAr
         0IYw==
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
 "kbuild test robot" <fengguang.wu@intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@kernel.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.893461445@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 115/136] x86/decoder: Add new TEST instruction pattern
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077714785292297?=
X-GMAIL-MSGID: =?utf-8?q?1592077731662397888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -814,7 +814,7 @@ EndTable
 
 GrpTable: Grp3_1
 0: TEST Eb,Ib
-1:
+1: TEST Eb,Ib
 2: NOT Eb
 3: NEG Eb
 4: MUL AL,Eb
