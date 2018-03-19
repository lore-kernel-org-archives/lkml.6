Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsffr0+VHXEep3FKxlyn12sFLvYnJUGvDOTpJNd83h/GWKCyD+JtOezDUPBuAd0HuWdrMKQ
ARC-Seal: i=1; a=rsa-sha256; t=1521483881; cv=none;
        d=google.com; s=arc-20160816;
        b=cDG+tq7tYQfm7QkupzuzC+0iviZqQZJUU3e+xi920MJ6W1Ug1OmhtEfBKZgio5nOCd
         rHYPNrwOauvDcW83d4Pj/b0bCc8C7n91NriQNUDBm398SkCt3g6NldRbC/RUjDEbJZCP
         3MXcfZmusNCLWlsbpmuyHAVWtngS0nUOBObQ+0p4P2XEP4b0YrrKnYlfNlBrgQ9kBML5
         WbkNw3TQVbdtcRthqyZsxqrUNhPb9NnbxPS8tfY+e0WZ/aScM1RHwbJw3SaTZ31QjOs8
         c6aFIOE/n1xu1o6aXB+sHjDZQVKf2XD1J0pFSK+iS+ZLJuxoNPc2NoaacNYF6UuU0tTC
         u60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=07srMcpQnXqp/qdQHluKeXOGHdXpxTzSqwGXc6Gsaww=;
        b=izDm2P0Omlpw82HSknTJB9RhMXWmFEM5NcF1qrH1m210sz+tIDi+yfQkAdPgPuXZAR
         kkKerpc9Rf2YqyP3tLobk0QQaiabI6AEKkiTwhVslg+nrhcI2YuiWHHKhQEVBSOu0DaE
         uI20yU7eblYFoihRPXLqtmNkj2upk0VMYuYqkmuUApJRVKzlFjdZFKkLLdfyJ0VvZUxa
         V8t0BDSs4bOElI20MxVqo8IDhmlwhQBvbU/iL2/taST6aS7uA569NTTQt7B9isGjSNfJ
         vBQWeoxA+t/blcf43a+0ESVCZN3DdTMuxYOdQa97kRLgdhTCNb0t30b2X148/Kpq9YCV
         B2Ow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ye Xiaolong <xiaolong.ye@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 152/241] kprobes/x86: Fix kprobe-booster not to boost far call instructions
Date: Mon, 19 Mar 2018 19:06:57 +0100
Message-Id: <20180319180757.472270630@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390676528153798?=
X-GMAIL-MSGID: =?utf-8?q?1595391482605545642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>


[ Upstream commit bd0b90676c30fe640e7ead919b3e38846ac88ab7 ]

Fix the kprobe-booster not to boost far call instruction,
because a call may store the address in the single-step
execution buffer to the stack, which should be modified
after single stepping.

Currently, this instruction will be filtered as not
boostable in resume_execution(), so this is not a
critical issue.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ye Xiaolong <xiaolong.ye@intel.com>
Link: http://lkml.kernel.org/r/149076340615.22469.14066273186134229909.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/kprobes/core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -199,6 +199,8 @@ retry:
 		return (opcode != 0x62 && opcode != 0x67);
 	case 0x70:
 		return 0; /* can't boost conditional jump */
+	case 0x90:
+		return opcode != 0x9a;	/* can't boost call far */
 	case 0xc0:
 		/* can't boost software-interruptions */
 		return (0xc1 < opcode && opcode < 0xcc) || opcode == 0xcf;
