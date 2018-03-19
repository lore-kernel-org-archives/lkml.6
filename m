Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuLu3fzyXvshAfQ8lky4BQtpTvaoNogTnu+6R9yG8gnpXiDXVJrk8+lCkW2cy9ZSZ3CKSIL
ARC-Seal: i=1; a=rsa-sha256; t=1521483477; cv=none;
        d=google.com; s=arc-20160816;
        b=hBVdpAzXN/dn2cUw8Zpf7vDTSqnyQqFZw4Dj+CF5tx4+Dsc0FtcVl41n5cUnn4NNJM
         ba4Rkdwwex8omPQQ5u3iJUYEXhZdcvLyOSZzOcNgAaI0XAe7a10RozBjZB0R7vwi/DBj
         m3YKwd/klWqbZ264WLZSLZgyfutEJ1jcvFkznYQXP2eKacJS0U6Yhxx2w9+zGOG9b0b9
         1JrdnGOeoDA5hh2W3ntFmLqla5xaf588n7LzE+NNEzUMyo4vW0Vm8Z0eXr/XCBAXRsyU
         eS6Snc+PJdXXSOB3jscDG9j0k/eCAYKZbt0XbP9ycgK5iGjQdu8tcTJTGsORZcEm0IVX
         a73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nQypa26QO26F4wgnisr1/felO3rGExSnhn/QtzRpmEo=;
        b=GK4JRMM5AEvrGJMUNXbbOdrZYRm2dGrpYcPGmO3XiV57y1s8dVidkBO1kEaCBzeTjN
         p8OXWfQNdfUf1q61++6wVZljlbO3RdHSSEaPsEASePSrnON8Lv/YMUMJccG23/nw3tO+
         eICrAePqf4k26wbl7Qzl9dZ7qn+SKKqZ9jyw8UODYfhSrBDMKqpWqrtEXxWjfMLij1Sz
         MeG+9h7l2FW4NF6C+cfiwpQMcuhFQFsPQ/2LA5h/jvh1UVVuXbhn9ueqB2MpUJVDphz0
         1z8Th4MqBcLTgV9fY+lelIfxX7a/+WtMLzsfmZT7r1o6nMzn4n0+ERy8T3eRDzjchJMx
         t2Xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stas Sergeev <stsp@list.ru>,
	Bart Oldeman <bartoldeman@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 114/134] x86/vm86/32: Fix POPF emulation
Date: Mon, 19 Mar 2018 19:06:37 +0100
Message-Id: <20180319171905.750832502@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391058826275806?=
X-GMAIL-MSGID: =?utf-8?q?1595391058826275806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit b5069782453459f6ec1fdeb495d9901a4545fcb5 upstream.

POPF would trap if VIP was set regardless of whether IF was set.  Fix it.

Suggested-by: Stas Sergeev <stsp@list.ru>
Reported-by: Bart Oldeman <bartoldeman@gmail.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: 5ed92a8ab71f ("x86/vm86: Use the normal pt_regs area for vm86")
Link: http://lkml.kernel.org/r/ce95f40556e7b2178b6bc06ee9557827ff94bd28.1521003603.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/vm86_32.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -715,7 +715,8 @@ void handle_vm86_fault(struct kernel_vm8
 	return;
 
 check_vip:
-	if (VEFLAGS & X86_EFLAGS_VIP) {
+	if ((VEFLAGS & (X86_EFLAGS_VIP | X86_EFLAGS_VIF)) ==
+	    (X86_EFLAGS_VIP | X86_EFLAGS_VIF)) {
 		save_v86_state(regs, VM86_STI);
 		return;
 	}
