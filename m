Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr5nWsl4A9VjNTRfwz+1jgVkGGhyc8R1CdVz/BD5ZEeUF3TGOqULu2ZpqLM2gENNWr6nLeb
ARC-Seal: i=1; a=rsa-sha256; t=1526937697; cv=none;
        d=google.com; s=arc-20160816;
        b=ob6Y0wzXl4x+TtoUE8yaR60onye8vEArAppVaCgwh5NuQZFB5GH6ZQP1OaC3BFi0Ne
         UuXdEgT1VeXmF+Trkmd6F7NEiDeR+n55DWesvly5J5C9nJqF9HHum3X87LGP0qa7ohbJ
         bYK1CikxiD2+Lt70gGubqSwkmSXXtSOb1q1EjKD07zLEV8H6M8YZ16xNio9XZjNPN51v
         CoS4eDfNUQLdcpAWkicheUmSMW4GmChm52VOo7DYiP14gA2qE1GR6QE8IfZgrU/5yyiN
         uWAt9IOGK+Ln+JQ6HtCvj/8+uc49VRKySM6j/TRZqCEA1s9yalelyaRcv65sYu2+9LEG
         pR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=hpzzR1P9VQuh2ev+73KUsFoqhEFV44gJoLfn+HPux08=;
        b=CZRCk/vLN94rpmWqv0/fAbKH6CE6bKXZ2DGgMZa1NLZgc9dKR7nsR/t5tbAo27qSHO
         jnf8dsssPYOLOGMEuZgI3frhNBwIrXbqJfnLXPy6zivRQS0+rQOqDQ7m1TdDiNF+U1fW
         QqmJ1coB5DiemkCJJXtnr4BfmF8s1KXrrq6tMWweiSg5/m7wPegc7bppa5ebImntIIke
         1CGgfZMclas3CyGS7ItIranpOSkEVksVMJAuXksB2785T96R2CHRNa71W/ritTho+rvL
         lVYlBY8c2SPDXKH5TzStB+NtpZ8h4v29fxmVDm55wL5+cpFTwQCdGYQ89DectzU1dd+2
         h7YA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=adNx8DPD;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=adNx8DPD;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.14 88/95] x86/speculation: Rework speculative_store_bypass_update()
Date: Mon, 21 May 2018 23:12:18 +0200
Message-Id: <20180521210502.958196868@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109947411733771?=
X-GMAIL-MSGID: =?utf-8?q?1601110222341173728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 0270be3e34efb05a88bc4c422572ece038ef3608 upstream

The upcoming support for the virtual SPEC_CTRL MSR on AMD needs to reuse
speculative_store_bypass_update() to avoid code duplication. Add an
argument for supplying a thread info (TIF) value and create a wrapper
speculative_store_bypass_update_current() which is used at the existing
call site.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/spec-ctrl.h |    7 ++++++-
 arch/x86/kernel/cpu/bugs.c       |    2 +-
 arch/x86/kernel/process.c        |    4 ++--
 3 files changed, 9 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -42,6 +42,11 @@ extern void speculative_store_bypass_ht_
 static inline void speculative_store_bypass_ht_init(void) { }
 #endif
 
-extern void speculative_store_bypass_update(void);
+extern void speculative_store_bypass_update(unsigned long tif);
+
+static inline void speculative_store_bypass_update_current(void)
+{
+	speculative_store_bypass_update(current_thread_info()->flags);
+}
 
 #endif
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -598,7 +598,7 @@ static int ssb_prctl_set(struct task_str
 	 * mitigation until it is next scheduled.
 	 */
 	if (task == current && update)
-		speculative_store_bypass_update();
+		speculative_store_bypass_update_current();
 
 	return 0;
 }
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -415,10 +415,10 @@ static __always_inline void __speculativ
 		intel_set_ssb_state(tifn);
 }
 
-void speculative_store_bypass_update(void)
+void speculative_store_bypass_update(unsigned long tif)
 {
 	preempt_disable();
-	__speculative_store_bypass_update(current_thread_info()->flags);
+	__speculative_store_bypass_update(tif);
 	preempt_enable();
 }
 
