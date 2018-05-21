Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpHxYZvwKgRyx59dT+e1bS+5zt37Ilh+2nGl+Qa7VspcoNbSnj1aKowkt5FqgK1Wca0awjR
ARC-Seal: i=1; a=rsa-sha256; t=1526938027; cv=none;
        d=google.com; s=arc-20160816;
        b=uCdDrh8C+2pd9XrYfs73UEtfJDQyG3A9RE/QDR5KofziDkLcXOT5huFAmtcaKmVYBV
         9+CUwN0ynfHWixSPUSr3NUQZn1gk4lNaSPdnf2Eoqx8eLMs/X6+FJpvoUk4LkL/IqKFg
         Ae8M/+uoCQq4iTKLG9KQKrQiBHJjtAQpWq/Ydmhn754h7Ter8Zx1iG9N7D0QcXYCcJzB
         vMqam15a2Gy0SJ4inFhOrR7Ku2imQBgHtlIxk3H8/KqudNQb3giOuGD0LCJ5r/oG4PD3
         hhHof/0kZ/qYu5XZjwhCHz2xUO3uuWEi9/WPZKLv8kRlbkL0Y6aRMvEQNGyh2nTYrsan
         GZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wXdihtaGZBzn4jIJgDjT+hakTnFGC5ZWQ1tAYWjUT28=;
        b=ZUn2dc8ULWJgZKFyeG0yxiwQ698UkplMxLFd1J/kOfBjI2P9eRwUHrZiPlfDSbiR6Z
         uVM/rSCjblavIEWCKXwllikGVB7+0gcuVNMjy8JAbKSdW6fod0IIx1u0SBI+6I896Uqn
         LqlsIHByEh12zb7qFdYb6qav35PJVD+vYKgRSvCr1AvXsfWxvxILAMmpSqYP/PlHBHUk
         k5J6Auvj5Gqp0sAfPISh5GwfVPYX2KPTftWnIiZ3N0frwkAjbrHad8VKBg7gs6keikrQ
         vQ17+1F28aeN8YHK7DhmalGKkW8SS9l8DgJgXuleI5bNHOakcydwYskbunnD5uPwS1vz
         52CA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=uGusPKJt;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=uGusPKJt;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.16 102/110] x86/speculation: Rework speculative_store_bypass_update()
Date: Mon, 21 May 2018 23:12:39 +0200
Message-Id: <20180521210514.708160559@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109947411733771?=
X-GMAIL-MSGID: =?utf-8?q?1601110568766492866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -414,10 +414,10 @@ static __always_inline void __speculativ
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
 
