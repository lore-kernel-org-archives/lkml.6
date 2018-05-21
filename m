Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrvR1MCaiE3plOLO3MzVbMOgem/caeIIIjvCvrWHLPvPpsD/c0lySuQhWRpRhZ2tJ4Rgux4
ARC-Seal: i=1; a=rsa-sha256; t=1526937710; cv=none;
        d=google.com; s=arc-20160816;
        b=J1wRL9vsY0iMhg+hXklGLS5Y1ogL1XRbFgxRbxMoQ8ct3K7s3kG9OK83E4VfbJfj1+
         Tot8n8osszvqeE79iQK2zyX1Ukn7J10yi2dXAXAMmJviyvPzxjqlvpjE+MElJhi2BeR+
         pLmxNQ1+akrlcViU5stPihbNVdZKTpmzNEz16Fz0pND3zzC6svfQJfD+rKSultG04GpE
         222ZYhQi4to3k90KZRRPZ2Iqt+CtzHbnoaXavLlDyOkNGyuMWDkvf9gfSVJT6cjXtdiK
         1HuFS1QZ4tl+Ac0SMTjWcNRTUPMleZHPC8ExbzifMVPPKiPIUUSKstZTU0XsGCEgynfu
         UWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=l6+8InCZpc7veoLxKewU7KiStvC2PvNhQJwCgRrCHm0=;
        b=pVb6ES49JVLxpTQ1vH0oVNJa8kSrtcHioi0/5DB3aOaaMHhxHE9NA55pquokiLRTvI
         CGOQYkmwX11mnBjcI9IXsAkneumzGF/uh95fJCSdLxAWcrOr5ek39r32znmJysv+96RO
         P2XIza5Jz4VhW3IauBvXVlR8A1mkeEda7ubObs8rMasV9OJg3q9b00QXCKpb23JKZzc6
         Oyly227Na2KaFhALyttCSsLk0t4FV3HDTsS/ynbNk6cNxEyINwvC/cUOnu+KrHdFRg3R
         4Vr2AXDEEq4f59hwp8Jf0joIctF+FGzwvybxu/wIrKZ7jXN01tUZN9ANG9ZWers9oL5E
         lEBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sJqtBUiF;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sJqtBUiF;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 93/95] x86/speculation, KVM: Implement support for VIRT_SPEC_CTRL/LS_CFG
Date: Mon, 21 May 2018 23:12:23 +0200
Message-Id: <20180521210503.396581233@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109963617470446?=
X-GMAIL-MSGID: =?utf-8?q?1601110236616885177?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -162,6 +162,36 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl,
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
 
