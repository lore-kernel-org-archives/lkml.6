Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo+vc3/l3C711FGGD5VUjfZGydOS0oqtminjWCqGNSGR93fPsvooczF+x30ppgqCZdiwyQF
ARC-Seal: i=1; a=rsa-sha256; t=1526937450; cv=none;
        d=google.com; s=arc-20160816;
        b=EsgnT4LGbTjM/fd/E1JEOkv1lpBPO0/Zk0/KnRDopRr3bOoUGY54OJ92t9LKOczGI3
         rfFmADUWJFiy2feY7Gteg4phl1ebP3oVlqp+jj7ojMW5dQO8o0BFcPlh6/+H2v7OHHV/
         uJ8FAceA16BB4lu+PzTng07G+ohdBL+TWVQyR16oRRAYpX2IBc51ashM76Oa3MU1pPrx
         8sNJ7BhHPPLRwMVWfT6pEJLm6wHbQ/+Il33bnpyahdj8Jks3jGg79d2fM32F54yPgceF
         tnF2o93z/DgEH8jzn85e0UsQ7s2dhKmbd66NEoDmI9EZMAWx7+QwDdVNVXX5HHYnDr94
         Z3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=O1vQ5SJMY/BY/qvYAEQtv88Nmhz2PoshlEXLWUB+fow=;
        b=KGrwNkIgwqd/HaDtCAN8EOcBHxl5t5rVC/yjWwmzQAhM9XWxXB0COoJx9eN1e9B30M
         IZ8Ne6r+M0zeM7xMxK3zZg6rGVjfAhcnRv9j+LgE7MLJ1WrlHeHSojB2Uz0jUSVInxka
         4cgVwLp+ta/r7WexatFKnpekyN7FlCX4VnpIGUtKguXfzmQ4GB9F2O7CIsyMDWafahB4
         2LxcAwJ81QHDmXcb+YxcoiA8OdI4O/HzEJc9UhFW364CJ6srBLSgTTshL554KrJ1SmF3
         /hUo5rAxPz9pD4yjD+G3+dJVUG5er6kMQUcuQxRi8Fiphs3zt/1wAzPRF3vpQnrapArX
         KFDw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IPYZIbxS;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IPYZIbxS;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 85/87] x86/speculation, KVM: Implement support for VIRT_SPEC_CTRL/LS_CFG
Date: Mon, 21 May 2018 23:12:01 +0200
Message-Id: <20180521210427.202110729@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109963617470446?=
X-GMAIL-MSGID: =?utf-8?q?1601109963617470446?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 47c61b3955cf712cadfc25635bf9bc174af030ea upstream

Add the necessary logic for supporting the emulated VIRT_SPEC_CTRL MSR to
x86_virt_spec_ctrl().  If either X86_FEATURE_LS_CFG_SSBD or
X86_FEATURE_VIRT_SPEC_CTRL is set then use the new guest_virt_spec_ctrl
argument to check whether the state must be modified on the host. The
update reuses speculative_store_bypass_update() so the ZEN-specific sibling
coordination can be reused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/spec-ctrl.h |    6 ++++++
 arch/x86/kernel/cpu/bugs.c       |   30 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -53,6 +53,12 @@ static inline u64 ssbd_tif_to_spec_ctrl(
 	return (tifn & _TIF_SSBD) >> (TIF_SSBD - SPEC_CTRL_SSBD_SHIFT);
 }
 
+static inline unsigned long ssbd_spec_ctrl_to_tif(u64 spec_ctrl)
+{
+	BUILD_BUG_ON(TIF_SSBD < SPEC_CTRL_SSBD_SHIFT);
+	return (spec_ctrl & SPEC_CTRL_SSBD) << (TIF_SSBD - SPEC_CTRL_SSBD_SHIFT);
+}
+
 static inline u64 ssbd_tif_to_amd_ls_cfg(u64 tifn)
 {
 	return (tifn & _TIF_SSBD) ? x86_amd_ls_cfg_ssbd_mask : 0ULL;
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -161,6 +161,36 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl,
 			wrmsrl(MSR_IA32_SPEC_CTRL, msrval);
 		}
 	}
+
+	/*
+	 * If SSBD is not handled in MSR_SPEC_CTRL on AMD, update
+	 * MSR_AMD64_L2_CFG or MSR_VIRT_SPEC_CTRL if supported.
+	 */
+	if (!static_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
+	    !static_cpu_has(X86_FEATURE_VIRT_SSBD))
+		return;
+
+	/*
+	 * If the host has SSBD mitigation enabled, force it in the host's
+	 * virtual MSR value. If its not permanently enabled, evaluate
+	 * current's TIF_SSBD thread flag.
+	 */
+	if (static_cpu_has(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE))
+		hostval = SPEC_CTRL_SSBD;
+	else
+		hostval = ssbd_tif_to_spec_ctrl(ti->flags);
+
+	/* Sanitize the guest value */
+	guestval = guest_virt_spec_ctrl & SPEC_CTRL_SSBD;
+
+	if (hostval != guestval) {
+		unsigned long tif;
+
+		tif = setguest ? ssbd_spec_ctrl_to_tif(guestval) :
+				 ssbd_spec_ctrl_to_tif(hostval);
+
+		speculative_store_bypass_update(tif);
+	}
 }
 EXPORT_SYMBOL_GPL(x86_virt_spec_ctrl);
 
