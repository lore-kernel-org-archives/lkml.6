Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq8KbJCTmE1IdLwkEYeuAi5Q69Bfew8S7P8ExF+HH7ZRJIYo5XRQg3iKNZSeQ24MSTHaciW
ARC-Seal: i=1; a=rsa-sha256; t=1526937708; cv=none;
        d=google.com; s=arc-20160816;
        b=DGSL85Q3v4x12EmqostYXs3w5Bg8dVgPJsxWKndw1DmywW1FAbHmkeZg/mUkq1GItN
         PgjUH7M+pG+loXb/nyr2YOKZLbtBmfCbbIfw1VY6PskzO0Wc0Vjj+RgVvwxuVDWKiC1v
         l/BRCgw0tuMTThruScaNHTlHAtSEfZBYj/RUBRrzKXB07PmIg6+xih8iVLu6WhGe4/AC
         aUHP17DoIiD7imZBA9ql6W22M/0egs71RgVzN1oA/aEPp1Dxnhy/qsIc5mQBz0O5jCSv
         Zg1mSQdM7OJABVtKOxJdFRuXTrbLMyj3uXNKEzoiChcdMEWkhRiLzYmmzelWamlESoun
         1ZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=zX87wORREyW0w5U7Joks26SF3MxEtxQkh9mZDr19DsI=;
        b=jTgeLPY/TCd/F67vrKSuRFurG7UbFKy1RJIi7ttqb7gqfhmtQkgcAK+evqqvUHW3Hc
         rmAsZDrMVkHhUZcOo8M4Sn6I+XOSuEsuyB6/fiUgSw71GtiVvh35bivw0B3jnmOXz8xj
         YoMZNVlrg2Qpj3T46Ir7dFJmjpkoQ4NiQmC8MtLpujIVgd2vb9cwn8B5+gnNMgJN/nxt
         KdDvTPLgLg55RfRl/NmXxVDzKrEjaZNLmhCfvjluaVzxV0BDnhakDK4D0OH0BosqfwB+
         sDAai99K6+dL9S4kEOBIk2eENXNPIKOIfL3eOf9KyVBTTj+okTaxWuksllx/2V+8kSYT
         aYtg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hz1VTfv2;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hz1VTfv2;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.14 92/95] x86/bugs: Rework spec_ctrl base and mask logic
Date: Mon, 21 May 2018 23:12:22 +0200
Message-Id: <20180521210503.314499619@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109960928055699?=
X-GMAIL-MSGID: =?utf-8?q?1601110234526443651?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit be6fcb5478e95bb1c91f489121238deb3abca46a upstream

x86_spec_ctrL_mask is intended to mask out bits from a MSR_SPEC_CTRL value
which are not to be modified. However the implementation is not really used
and the bitmask was inverted to make a check easier, which was removed in
"x86/bugs: Remove x86_spec_ctrl_set()"

Aside of that it is missing the STIBP bit if it is supported by the
platform, so if the mask would be used in x86_virt_spec_ctrl() then it
would prevent a guest from setting STIBP.

Add the STIBP bit if supported and use the mask in x86_virt_spec_ctrl() to
sanitize the value which is supplied by the guest.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -42,7 +42,7 @@ EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
  * The vendor and possibly platform specific bits which can be modified in
  * x86_spec_ctrl_base.
  */
-static u64 __ro_after_init x86_spec_ctrl_mask = ~SPEC_CTRL_IBRS;
+static u64 __ro_after_init x86_spec_ctrl_mask = SPEC_CTRL_IBRS;
 
 /*
  * AMD specific MSR info for Speculative Store Bypass control.
@@ -68,6 +68,10 @@ void __init check_bugs(void)
 	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 
+	/* Allow STIBP in MSR_SPEC_CTRL if supported */
+	if (boot_cpu_has(X86_FEATURE_STIBP))
+		x86_spec_ctrl_mask |= SPEC_CTRL_STIBP;
+
 	/* Select the proper spectre mitigation before patching alternatives */
 	spectre_v2_select_mitigation();
 
@@ -136,18 +140,26 @@ static enum spectre_v2_mitigation spectr
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
+	u64 msrval, guestval, hostval = x86_spec_ctrl_base;
 	struct thread_info *ti = current_thread_info();
-	u64 msr, host = x86_spec_ctrl_base;
 
 	/* Is MSR_SPEC_CTRL implemented ? */
 	if (static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
+		/*
+		 * Restrict guest_spec_ctrl to supported values. Clear the
+		 * modifiable bits in the host base value and or the
+		 * modifiable bits from the guest value.
+		 */
+		guestval = hostval & ~x86_spec_ctrl_mask;
+		guestval |= guest_spec_ctrl & x86_spec_ctrl_mask;
+
 		/* SSBD controlled in MSR_SPEC_CTRL */
 		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
-			host |= ssbd_tif_to_spec_ctrl(ti->flags);
+			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
 
-		if (host != guest_spec_ctrl) {
-			msr = setguest ? guest_spec_ctrl : host;
-			wrmsrl(MSR_IA32_SPEC_CTRL, msr);
+		if (hostval != guestval) {
+			msrval = setguest ? guestval : hostval;
+			wrmsrl(MSR_IA32_SPEC_CTRL, msrval);
 		}
 	}
 }
@@ -493,7 +505,7 @@ static enum ssb_mitigation __init __ssb_
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_INTEL:
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
-			x86_spec_ctrl_mask &= ~SPEC_CTRL_SSBD;
+			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 			break;
 		case X86_VENDOR_AMD:
