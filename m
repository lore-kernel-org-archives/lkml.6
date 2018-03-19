Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuukKgv4uvH2+Xt0Tx1ot2q9a8BHLeEC6gfzLVI/1NCgoeFfs9//dj01Kmba4mj5slbRn6u
ARC-Seal: i=1; a=rsa-sha256; t=1521483112; cv=none;
        d=google.com; s=arc-20160816;
        b=sD6e6UcY6evXe4/2LvuchouoA4S/yfNahbxot0W4jbM2jEI1+pdy8srkDv7/caEjIN
         zj5ZorBslnl/gYL9PJNmCoTXdItcU0Jms5u2iLy4052TVavMCOJvast22mceYFgYn+tk
         rBtQz4n16DxQ3tDOHBkr1b/ALe2/ZEdfxOSCb075pC8STn7beAvvCvdqtBtLgFWpqOAr
         VwcHBpDAH18rpDJAKK65NW7y/4rhlnCuGhuAZiU1M5v9iGr/knLKVERq8oWslcunu2Al
         n8jPsNfjyETyzD+R1eWZxmgtBOtdkJWUueNwyCB9RcwDURjyYrATsNnnpveBwWpG4Qjc
         A3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zf0d5wXt4KT4g3p19tKpPG2XI3shq+hJ8NnSRet71C4=;
        b=I88ABYlNXivf1ky13or4lq0PxMUK5JJ1JpkPqyqCpVBO/CJJuWM54bJDTKwuFIvwfu
         tqHbgLIvoNa5jfwQQScH5o57kY9IgJa+8T+2AylC0xB2tG6sdplPukGAAprEr/mkAvfj
         mzXa0/WrbPFgUJ5Gqa0o5t0UgBykrgxyqivS93nnLFQq86pUERV01r6ySN8mPVso3loN
         k21wpvuCc8E3bppSc9TtCrFxw1neG4VBnEagrO6LvrU15u82ADdiMIF4+hyf3y7RqfxI
         I1lNlra71EQa7UcGNBJX4icd2p5z2pXQ/tMGK2LvoparlU7xktJdxi3BLpj75RvRoivv
         31uQ==
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
Subject: [PATCH 3.18 41/68] kprobes/x86: Fix kprobe-booster not to boost far call instructions
Date: Mon, 19 Mar 2018 19:06:19 +0100
Message-Id: <20180319171833.629502202@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390676528153798?=
X-GMAIL-MSGID: =?utf-8?q?1595390676528153798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
