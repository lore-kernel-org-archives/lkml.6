Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvf/ftJhtFTTW0T8A//KbHvFaZKWXU4QHR07r4HcGfNYI7F1pN7JBYADPnqI2ay8eVMzspS
ARC-Seal: i=1; a=rsa-sha256; t=1521483398; cv=none;
        d=google.com; s=arc-20160816;
        b=g192VQmcm4gFNIF1LQLAJbRdgBQ0B24AZpLZEb8kV45EEZQNXkCuIBqRy4rVhky3qg
         scnaazLaz84FG/jzarLjb/qM9OrjvSgos3oicjPSAzWNJFgFvIFjzAY5j7UTFRCNaRUq
         X1IEycfpwrrJKoJX4D+mAdCxQTtTJmlfFq4OttRRxx7W8ixCd8KAxmFnLSquxs6H/u4k
         3I/VZHLGCSbN5t9VG7QV/EnR9MHX9FB5G1zoRPnzGcU7GS3RYPeZZcBH5AeQKabKMyIR
         PrBZn8LLztllIb4iYmpbHAu/Uc7YlJpkLVAbRFQl4T1T+tquTwyAW4jzLF5wkPRQoTPY
         f2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LFFX240I0lPoSXrqH8MCVMsVMn0HZUAi0CD1H4kE8+E=;
        b=CFnhYvJc83b5pthdzCzzSVD/6Pst8EnNdTGOXeZMZ/9sv315XCUyCQoDQ+U7KO2LQq
         xA6ufBdyusVr/HoFSnP/5rnSc0rU9w5OTWhM2q7HtDBMagUoHPQIgn+hi/yBv1n/xdhp
         Nnux7jk4A9PZ6uEd8oOpZm+Tqm6bfqaRS1Pkd1lSNBO55dNQuBiUJzZD7SH37L7kwWuo
         kMKEbK7Zk4OPXOoyAfAKCOdp3yfBR1hhUuAn+UYUUr+WS6WR45n3uwTmUdfO5A6VvcJf
         CUy2QTzySqGp3uHPeweGXuWnhLQgKCWn3alEdDje/GeSBPvWV6hB6pXn2aWbCysWROTN
         zLQA==
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
Subject: [PATCH 4.4 075/134] kprobes/x86: Fix kprobe-booster not to boost far call instructions
Date: Mon, 19 Mar 2018 19:05:58 +0100
Message-Id: <20180319171900.096699499@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390676528153798?=
X-GMAIL-MSGID: =?utf-8?q?1595390976649616760?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -196,6 +196,8 @@ retry:
 		return (opcode != 0x62 && opcode != 0x67);
 	case 0x70:
 		return 0; /* can't boost conditional jump */
+	case 0x90:
+		return opcode != 0x9a;	/* can't boost call far */
 	case 0xc0:
 		/* can't boost software-interruptions */
 		return (0xc1 < opcode && opcode < 0xcc) || opcode == 0xcf;
