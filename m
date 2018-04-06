Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/YcfGVvaou34LLnaHnCvjjTUcnil9UVCwxTwsxNBpuvOQBMnYIJO7VhMIf1locQeKITP3O
ARC-Seal: i=1; a=rsa-sha256; t=1523021710; cv=none;
        d=google.com; s=arc-20160816;
        b=PZ0PLonyxHS6v+QP1CNCOwIHerEnlAcqDgZisXDgfNEi0+yV3YipAcKIbTYFpiWoFk
         vOueUYHvW6GKQhdolz0SgVnnDKnMwWDBY8GPJxAiuZLDzKPiDCmKvRXhG/V6oLg1/GPI
         Leu0/0ETiujQQ+942qTib5K0R26JWWheZ90XB5TMBiRPN4/pRIDBvJbABlHg1BAXCcaj
         Ol5h6AXyuWg1ob0+ZrAaOvK+j1/5PE9GAUr1Wr+DdFZrMPacSSVAv1b/jN5jIQTWl23t
         U2Ems8Qub6Na3tP/u8unLzh6h0KkvZgrwZD/hOdrwOAHUA9MmYPi+8dIOyVYkJv3YZcY
         z4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j87reN/DDdwrUMLNSJqL/TMSwRsPa5woUJ1KVf9YRNI=;
        b=HobpgOyQ/8TzYu0SwFVDPiSR6yQKdmoRFbCP3A2FwECJQTaLEyHvnCwaiqZn7Biqxs
         bNObKokMncKrErCU6evjai5Jvlqh91pONq0FSyUOnZeGL6hZ4sN7PTU1YvGtepkiXN4V
         VdDNkq+pzVDlaNXmjOGEtSzZu4gF3YUWHJWAfDOZgvdhO0hDV1ljBvtTFETiFZp6IFHm
         coy8CPagsXyXtEuZsJ8NBztrWeDIPt7DeE63IhBfPjrk22VBoY99zek4iK1FBg2GevHk
         Ejs0UQYmzua8HCkT+8oiU4kOla9sh2bWLNTkXscFZv2b7LgwoiOErd46YeoK78TWfv8E
         yVLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 4.9 061/102] arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks
Date: Fri,  6 Apr 2018 15:23:42 +0200
Message-Id: <20180406084340.132540841@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004012545038833?=
X-GMAIL-MSGID: =?utf-8?q?1597004012545038833?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 18011eac28c7 upstream.

When unmapping the kernel at EL0, we use tpidrro_el0 as a scratch register
during exception entry from native tasks and subsequently zero it in
the kernel_ventry macro. We can therefore avoid zeroing tpidrro_el0
in the context-switch path for native tasks using the entry trampoline.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/process.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -306,17 +306,17 @@ int copy_thread(unsigned long clone_flag
 
 static void tls_thread_switch(struct task_struct *next)
 {
-	unsigned long tpidr, tpidrro;
+	unsigned long tpidr;
 
 	tpidr = read_sysreg(tpidr_el0);
 	*task_user_tls(current) = tpidr;
 
-	tpidr = *task_user_tls(next);
-	tpidrro = is_compat_thread(task_thread_info(next)) ?
-		  next->thread.tp_value : 0;
+	if (is_compat_thread(task_thread_info(next)))
+		write_sysreg(next->thread.tp_value, tpidrro_el0);
+	else if (!arm64_kernel_unmapped_at_el0())
+		write_sysreg(0, tpidrro_el0);
 
-	write_sysreg(tpidr, tpidr_el0);
-	write_sysreg(tpidrro, tpidrro_el0);
+	write_sysreg(*task_user_tls(next), tpidr_el0);
 }
 
 /* Restore the UAO state depending on next's addr_limit */
