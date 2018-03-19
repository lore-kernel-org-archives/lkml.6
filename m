Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvr4fl4LUz+jL17x7dfRmz2nQgM6/5nsMbR49fu4oognsbJEkdG+ot7q+NcCZAmMsqE1YuH
ARC-Seal: i=1; a=rsa-sha256; t=1521483277; cv=none;
        d=google.com; s=arc-20160816;
        b=lM/4gXGSacgdqjrNDbwuY1szM6yzp7UtyL3JGhnPpoEcRMSNghBWxWcFjZcmsezA1V
         1TLUFT3ftB5iyT00GmZxrjjSMmi/HexpQOpr0KXmV7L0uduWnKuXh1I5tQAGCd3/HZev
         ssOQQwp1mSRsfkJLOGdOtGDYaKvGRO8nLajBw66P74nVDngIqqkhDN7wB2zSaUzAVQvU
         F911bNacHeQ8zifhJvbRpnKqxP6sFZl67z/iGwgQwZUvSYU+BtHN+RKwb6SoJwVDK/tu
         3390vFW24OSOECvzF4R+pcq8SYV2OOfLuRLl/m6OTUs30FSIdjcRb6g6Cu7hJLathByd
         dc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CLF4tjaimylaKnF/YCi+QVCjK+LQ0mJNP1V9zh4as84=;
        b=MhAsarO0BcrTLXav1prPb/ugxa7Qz3YP3nPlWu8AyOk8oRCe6bfuw5HZmFViDSLhny
         HQkdtIfvF2X97gyrv9tX+cIX/GSwwOA4i2/B1bH+/3KtIsKxyUvPOMDBFSIFD6AhcVwR
         my0ebTGTuwaJsm3PONENfFuGNZ+Od2VeqHBTvR6N7KQnMiWtikNF9GZebsr5XWwg6Beb
         nWOLuQnUC6SAa6ERegywbVP1bAwA2DHY7tXTwPipiQJLV+QQGOJ1Qb1gkiEJWpu0GV9L
         9WJMldg/FJRtw8CijTbj/upsg5M+WKYWzNX5b/6CaSdrVbBSXzBcDWIIe6zXIKGmxUSV
         68Xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
	Miodrag Dinic <miodrag.dinic@imgtech.com>,
	Aleksandar Markovic <aleksandar.markovic@imgtech.com>,
	Douglas Leung <douglas.leung@imgtec.com>,
	Paul Burton <paul.burton@imgtec.com>,
	james.hogan@imgtec.com,
	petar.jovanovic@imgtec.com,
	goran.ferenc@imgtec.com,
	linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 064/134] MIPS: r2-on-r6-emu: Fix BLEZL and BGTZL identification
Date: Mon, 19 Mar 2018 19:05:47 +0100
Message-Id: <20180319171858.532633977@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390848888684960?=
X-GMAIL-MSGID: =?utf-8?q?1595390848888684960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>


[ Upstream commit 5bba7aa4958e271c3ffceb70d47d3206524cf489 ]

Fix the problem of inaccurate identification of instructions BLEZL and
BGTZL in R2 emulation code by making sure all necessary encoding
specifications are met.

Previously, certain R6 instructions could be identified as BLEZL or
BGTZL. R2 emulation routine didn't take into account that both BLEZL
and BGTZL instructions require their rt field (bits 20 to 16 of
instruction encoding) to be 0, and that, at same time, if the value in
that field is not 0, the encoding may represent a legitimate MIPS R6
instruction.

This means that a problem could occur after emulation optimization,
when emulation routine tried to pipeline emulation, picked up a next
candidate, and subsequently misrecognized an R6 instruction as BLEZL
or BGTZL.

It should be said that for single pass strategy, the problem does not
happen because CPU doesn't trap on branch-compacts which share opcode
space with BLEZL/BGTZL (but have rt field != 0, of course).

Signed-off-by: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtech.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtech.com>
Reported-by: Douglas Leung <douglas.leung@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: james.hogan@imgtec.com
Cc: petar.jovanovic@imgtec.com
Cc: goran.ferenc@imgtec.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15456/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -1097,10 +1097,20 @@ repeat:
 		}
 		break;
 
-	case beql_op:
-	case bnel_op:
 	case blezl_op:
 	case bgtzl_op:
+		/*
+		 * For BLEZL and BGTZL, rt field must be set to 0. If this
+		 * is not the case, this may be an encoding of a MIPS R6
+		 * instruction, so return to CPU execution if this occurs
+		 */
+		if (MIPSInst_RT(inst)) {
+			err = SIGILL;
+			break;
+		}
+		/* fall through */
+	case beql_op:
+	case bnel_op:
 		if (delay_slot(regs)) {
 			err = SIGILL;
 			break;
