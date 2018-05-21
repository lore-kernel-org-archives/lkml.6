Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpwGgGkfl6WSUoq/C97+VaSS16/nGmCO5oDDBaSvKXSkHw4d3aIvqzllx5h9Qsb6YfpoJlk
ARC-Seal: i=1; a=rsa-sha256; t=1526937437; cv=none;
        d=google.com; s=arc-20160816;
        b=W6KPOgUpv0Gg9zMfv29R0ingpRN/pmtXL9nuks9yobuuuIZ0miXZYqBl3G9QiNr5LB
         gmVSay8CgTI15Y1Tf6PBw1w4MjNoHiHa6mnwJoWE4mCIVTFR1FB08zYl6eY1diidjqql
         9kN/OlevfQV4iRPGCu7VDDr3Mo81/avUij0f4Ppi75Fq8AhDG+en6/ci721mbDhN86cH
         zb5pDAcF7KrMH+ITsnI2WugL4HSyVdXuMaGFHIQhsu4kdm9u449/XrSNbiWIhry0IVr4
         tUeEwzcc3vZ4Be2d/RPBHIg0Qj4SpRBjASgX/iSn9pB3gcquNfmdDq1CkB0WpKDJ1uie
         cYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Pij+IlfwJrcGuaRYP9HTn9rUBiH2mlHZDi1P0nLOofY=;
        b=0PaR/znC7KFuoofcpNL4MlhhAGWbwVm2lOQwOgbcdT+dlszbvO5TGQGCfomLm62lmq
         LU8XcCc7JwjfoN3Q7a1e4XH28NknkFAjodRsMVs3XeyUIV+BNyE+CWW6orzy9RNJfahl
         JzOfMaxnithVbsOFiQA9V9QQ8V++WkkYUgKuLSzfTefaFKKo1pd2Dm0IYEkoMBJc7mhB
         M8Wg8mFf3Tm9JdASDWj/fckYgYHpbV+kyH+cWAymL62B2R+T9ynYmOWEiA0exgxwyhbg
         +QOHF5c4zF38IiSBll74RA+4q5K/GiHRFFRGVPMGmCHSAPaPsDty4rr9Q9L2O0ThvGYa
         mpkw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lkFpCQ3K;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lkFpCQ3K;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 81/87] x86/bugs: Unify x86_spec_ctrl_{set_guest,restore_host}
Date: Mon, 21 May 2018 23:11:57 +0200
Message-Id: <20180521210426.938406913@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109949692245896?=
X-GMAIL-MSGID: =?utf-8?q?1601109949692245896?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit cc69b34989210f067b2c51d5539b5f96ebcc3a01 upstream

Function bodies are very similar and are going to grow more almost
identical code. Add a bool arg to determine whether SPEC_CTRL is being set
for the guest or restored to the host.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/spec-ctrl.h |   33 ++++++++++++++++++---
 arch/x86/kernel/cpu/bugs.c       |   60 +++++++++------------------------------
 2 files changed, 44 insertions(+), 49 deletions(-)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -13,10 +13,35 @@
  * Takes the guest view of SPEC_CTRL MSR as a parameter and also
  * the guest's version of VIRT_SPEC_CTRL, if emulated.
  */
-extern void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl,
-				    u64 guest_virt_spec_ctrl);
-extern void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl,
-				       u64 guest_virt_spec_ctrl);
+extern void x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool guest);
+
+/**
+ * x86_spec_ctrl_set_guest - Set speculation control registers for the guest
+ * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
+ * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
+ *				(may get translated to MSR_AMD64_LS_CFG bits)
+ *
+ * Avoids writing to the MSR if the content/bits are the same
+ */
+static inline
+void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
+{
+	x86_virt_spec_ctrl(guest_spec_ctrl, guest_virt_spec_ctrl, true);
+}
+
+/**
+ * x86_spec_ctrl_restore_host - Restore host speculation control registers
+ * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
+ * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
+ *				(may get translated to MSR_AMD64_LS_CFG bits)
+ *
+ * Avoids writing to the MSR if the content/bits are the same
+ */
+static inline
+void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
+{
+	x86_virt_spec_ctrl(guest_spec_ctrl, guest_virt_spec_ctrl, false);
+}
 
 /* AMD specific Speculative Store Bypass MSR data */
 extern u64 x86_amd_ls_cfg_base;
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -150,55 +150,25 @@ u64 x86_spec_ctrl_get_default(void)
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
 
-/**
- * x86_spec_ctrl_set_guest - Set speculation control registers for the guest
- * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
- * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
- *				(may get translated to MSR_AMD64_LS_CFG bits)
- *
- * Avoids writing to the MSR if the content/bits are the same
- */
-void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
+void
+x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
-	u64 host = x86_spec_ctrl_base;
+	struct thread_info *ti = current_thread_info();
+	u64 msr, host = x86_spec_ctrl_base;
 
 	/* Is MSR_SPEC_CTRL implemented ? */
-	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		return;
-
-	/* SSBD controlled in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
-		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
-
-	if (host != guest_spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, guest_spec_ctrl);
-}
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_set_guest);
-
-/**
- * x86_spec_ctrl_restore_host - Restore host speculation control registers
- * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
- * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
- *				(may get translated to MSR_AMD64_LS_CFG bits)
- *
- * Avoids writing to the MSR if the content/bits are the same
- */
-void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
-{
-	u64 host = x86_spec_ctrl_base;
-
-	/* Is MSR_SPEC_CTRL implemented ? */
-	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		return;
-
-	/* SSBD controlled in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
-		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
-
-	if (host != guest_spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, host);
+	if (static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
+		/* SSBD controlled in MSR_SPEC_CTRL */
+		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
+			host |= ssbd_tif_to_spec_ctrl(ti->flags);
+
+		if (host != guest_spec_ctrl) {
+			msr = setguest ? guest_spec_ctrl : host;
+			wrmsrl(MSR_IA32_SPEC_CTRL, msr);
+		}
+	}
 }
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_restore_host);
+EXPORT_SYMBOL_GPL(x86_virt_spec_ctrl);
 
 static void x86_amd_ssb_disable(void)
 {
