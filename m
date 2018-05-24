Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqv25DQ+0FbbpxHY3G1jcueB+HOwRiBIX/hWfAM4JUr6fAgna9iULOymZNA3ZMtoRnhGlnR
ARC-Seal: i=1; a=rsa-sha256; t=1527156075; cv=none;
        d=google.com; s=arc-20160816;
        b=VrdHIbPQVPHaNOMYOsCG1tLYSwmqjjRIybRHBiT1oZ74triIxMtw6gk4+ORoZXdhp+
         CeVjDiSZhe9HbQtBe+EYlg1T7VFznb99dosZcIcZVsv56iI7NY5kAIG3QP85ChwNwrnd
         MpJeqM6qixQSxQ9Z4hAaCeRQpEDafcVdFqEo7NH47Km+UoUZD7XkmA1pR/fhVXwSt44H
         ly9HzLmP7oXj/6cq7Neydo1aR06e0fsSr8IzDiwakMOOQP8BfMn0nHS1MgzPjPn0kHXR
         GiQ+c7oWTUiyeYJkEUdwq8VV3XiNl9AJddOtPVoz5mZXbiLhQTZcFY/04sx2xSD1Sjx+
         YWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=rUChubLUzqqRAVqrzfnacIzAz65zjCWbAqQVngomVrM=;
        b=COQvd9iLUjbZLexPkXdoflBQms48sTlxE0GyrNB/pfykM+z5Zig4+yYIAlb9qBlygI
         uo3KSSvTNRy0unkmZb7U5ouIVaW/e5VroXsL7XEmFEgD17hYegkHYj5VQkpfwL9oxt/e
         s6vNrgOf4fgiRl277IURzYB+j0bf5oi42Ch3+rO0r0ERhgxcRxsCnC99BfQtMOOU4Ezf
         +kbJ8yAQY3Ezrw87PLJMFbLl+JAIsaxZNXXuPQngZYWFduAmVTrmt+Yy8hwVNLSTozaH
         iwzstzXTpQLazLTTePTHBm2umVYPfoCKkEqqhdFR/Y3UZXL1PBvsujiBDbMRNCvL26gG
         DWjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vOFyS/g8;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vOFyS/g8;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Vasily Gorbik <gor@linux.vnet.ibm.com>
Subject: [PATCH 4.16 053/161] s390: add assembler macros for CPU alternatives
Date: Thu, 24 May 2018 11:37:58 +0200
Message-Id: <20180524093024.812635901@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338251446142102?=
X-GMAIL-MSGID: =?utf-8?q?1601339208690721910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit fba9eb7946251d6e420df3bdf7bc45195be7be9a ]

Add a header with macros usable in assembler files to emit alternative
code sequences. It works analog to the alternatives for inline assmeblies
in C files, with the same restrictions and capabilities.
The syntax is

     ALTERNATIVE "<default instructions sequence>", \
		 "<alternative instructions sequence>", \
		 "<features-bit>"
and

     ALTERNATIVE_2 "<default instructions sequence>", \
		   "<alternative instructions sqeuence #1>", \
		   "<feature-bit #1>",
		   "<alternative instructions sqeuence #2>", \
		   "<feature-bit #2>"

Reviewed-by: Vasily Gorbik <gor@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/alternative-asm.h |  108 ++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 arch/s390/include/asm/alternative-asm.h

--- /dev/null
+++ b/arch/s390/include/asm/alternative-asm.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_ALTERNATIVE_ASM_H
+#define _ASM_S390_ALTERNATIVE_ASM_H
+
+#ifdef __ASSEMBLY__
+
+/*
+ * Check the length of an instruction sequence. The length may not be larger
+ * than 254 bytes and it has to be divisible by 2.
+ */
+.macro alt_len_check start,end
+	.if ( \end - \start ) > 254
+	.error "cpu alternatives does not support instructions blocks > 254 bytes\n"
+	.endif
+	.if ( \end - \start ) % 2
+	.error "cpu alternatives instructions length is odd\n"
+	.endif
+.endm
+
+/*
+ * Issue one struct alt_instr descriptor entry (need to put it into
+ * the section .altinstructions, see below). This entry contains
+ * enough information for the alternatives patching code to patch an
+ * instruction. See apply_alternatives().
+ */
+.macro alt_entry orig_start, orig_end, alt_start, alt_end, feature
+	.long	\orig_start - .
+	.long	\alt_start - .
+	.word	\feature
+	.byte	\orig_end - \orig_start
+	.byte	\alt_end - \alt_start
+.endm
+
+/*
+ * Fill up @bytes with nops. The macro emits 6-byte nop instructions
+ * for the bulk of the area, possibly followed by a 4-byte and/or
+ * a 2-byte nop if the size of the area is not divisible by 6.
+ */
+.macro alt_pad_fill bytes
+	.fill	( \bytes ) / 6, 6, 0xc0040000
+	.fill	( \bytes ) % 6 / 4, 4, 0x47000000
+	.fill	( \bytes ) % 6 % 4 / 2, 2, 0x0700
+.endm
+
+/*
+ * Fill up @bytes with nops. If the number of bytes is larger
+ * than 6, emit a jg instruction to branch over all nops, then
+ * fill an area of size (@bytes - 6) with nop instructions.
+ */
+.macro alt_pad bytes
+	.if ( \bytes > 0 )
+	.if ( \bytes > 6 )
+	jg	. + \bytes
+	alt_pad_fill \bytes - 6
+	.else
+	alt_pad_fill \bytes
+	.endif
+	.endif
+.endm
+
+/*
+ * Define an alternative between two instructions. If @feature is
+ * present, early code in apply_alternatives() replaces @oldinstr with
+ * @newinstr. ".skip" directive takes care of proper instruction padding
+ * in case @newinstr is longer than @oldinstr.
+ */
+.macro ALTERNATIVE oldinstr, newinstr, feature
+	.pushsection .altinstr_replacement,"ax"
+770:	\newinstr
+771:	.popsection
+772:	\oldinstr
+773:	alt_len_check 770b, 771b
+	alt_len_check 772b, 773b
+	alt_pad ( ( 771b - 770b ) - ( 773b - 772b ) )
+774:	.pushsection .altinstructions,"a"
+	alt_entry 772b, 774b, 770b, 771b, \feature
+	.popsection
+.endm
+
+/*
+ * Define an alternative between two instructions. If @feature is
+ * present, early code in apply_alternatives() replaces @oldinstr with
+ * @newinstr. ".skip" directive takes care of proper instruction padding
+ * in case @newinstr is longer than @oldinstr.
+ */
+.macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature2
+	.pushsection .altinstr_replacement,"ax"
+770:	\newinstr1
+771:	\newinstr2
+772:	.popsection
+773:	\oldinstr
+774:	alt_len_check 770b, 771b
+	alt_len_check 771b, 772b
+	alt_len_check 773b, 774b
+	.if ( 771b - 770b > 772b - 771b )
+	alt_pad ( ( 771b - 770b ) - ( 774b - 773b ) )
+	.else
+	alt_pad ( ( 772b - 771b ) - ( 774b - 773b ) )
+	.endif
+775:	.pushsection .altinstructions,"a"
+	alt_entry 773b, 775b, 770b, 771b,\feature1
+	alt_entry 773b, 775b, 771b, 772b,\feature2
+	.popsection
+.endm
+
+#endif	/*  __ASSEMBLY__  */
+
+#endif /* _ASM_S390_ALTERNATIVE_ASM_H */
