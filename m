Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsXwPuFrIk5Y+2qSnQBkIuvBuNSGOZyMMdiPP427B4sR05tBN0yeEhPoNvuLx53v0JJ2nIk
ARC-Seal: i=1; a=rsa-sha256; t=1521483829; cv=none;
        d=google.com; s=arc-20160816;
        b=bzevebBLTgT6gLXyJbPACeLs9FIBqq1qJ5RtLSDr3QoZ1Vc0D/Sgej3Tf+pZ5QVyly
         3qXbXasyGT2i9nPfcV1fsfSPNZXV2GOQ1YkDT9AtvxY/JNIk8FG2GW+qFxrULIExnBT+
         kl4I0g9jL6/6Txvgintq6QA9H0yP1aK1T+lg6RJZKeCiPsFbJfcYMioOfhKwYcXXWsrH
         Uik7fIBXEcWYy3RkJOaSn5IHISyF9FBjGuxCLpQcykUcI8/YJ1J1dD7WcQ0Z2QooH6IC
         505c+cOHEQvN/gXu5lVHDctB5iDeVC2yBGIWx/FuZrIRUOFxLKSoRIPKVc1xh8Q60WbI
         Agxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=223BhW3CMHUMzckFxFVKRYufz9+TH/WQODvlfl6k1Wk=;
        b=CMfeAo++V3YRsD1x6ZkB3L4UP24MuyAGL1R9Q2J2fOibb4Ks2MC686WHGO3KcBoRB2
         qEaMFjBuHgGtDfr3n2c9iJDa0kSnH9igKfSTLoDROTJdeGZemwcj5aXGPsRgRwcrQqBP
         2rdLmbC6My46V3g16/D4jEJ6LJN66WLWJjOYrgeJLqkSgW+ts1a0JQJlJQYZzmD1S+sV
         4J7wGQgxgFsmChCRD1z/2/DUCZlfjcO2caayc0XLb6hd37aYIN8QItnRFTm7jT4sauvG
         2mLgFdM4u4Dkm3LmLOC0ucCrHdU0RM/nVRO9s1DpblNzznFm1xR0aWGo7eFpQtltaaGh
         1wpA==
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
Subject: [PATCH 4.9 131/241] MIPS: r2-on-r6-emu: Fix BLEZL and BGTZL identification
Date: Mon, 19 Mar 2018 19:06:36 +0100
Message-Id: <20180319180756.617770996@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390848888684960?=
X-GMAIL-MSGID: =?utf-8?q?1595391428246093925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1096,10 +1096,20 @@ repeat:
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
