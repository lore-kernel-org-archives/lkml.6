Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqSRlMc1Ugi28ZGQL+utJvspxH0I0kGdLfu/8P0X0MgDbnRxCnFP5Osm6aUfgn6tD3qhkrQ
ARC-Seal: i=1; a=rsa-sha256; t=1526938038; cv=none;
        d=google.com; s=arc-20160816;
        b=0/xdAIEvjZL6OnDUd5h2UZE04hTjY5f2a88DXuVJNCTt8E2Ikc6+hwIEa2hv2FxGCc
         DooW1I87/VeXwH2qyj2JGVgwYdzEmSRb8GjG5X47ROzfHtjYmXQ6qmYiHBOGbIpi9C88
         naNTKaWAQNpE0sIaAivQMHeyeXWIMrxKM1vRLv9luNticZzNAF2jYw4bvcM1MR9evLCV
         3Rwi/WhVBMLIcaDZ7g6yjTGAZ/T67/0MUMrzcEQe86LCtQFT9eZIPZVdr6lUn2VMRasx
         +Pf9O29SNuCcdNOKLUiWUDPeGdUGIRYxYe+nPC4pihTU2EuHmLbywO7QPrbv3e5Z+sZs
         FZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=4sYlBrAEKWJhCA4drEUOJarakGxwdXWI/hLxU5Y9YVE=;
        b=RwUEPiShifc3cOUolG2gVbQQvm+WriKqQtJfoyX6oKz3iTZxlTDRbvb80XvoX02eyh
         F+RsU8W/9tWch7hAAURJhPSavP+ZKWElWRis1HyvL4Q+Iky8yDFTh2aY1kUfJbmsltl8
         3X8ztowO63v3mbZYonLZY5GRh/e/iB59hRA/OgWOCxXhyiFyF4jgZ8DuXDxCRs0lvNcB
         Kefp6Y42TNY57VoPfu238mGrSF3qmjlGecLNeAj8+cn8f4w8fDbDUxPRzY/VMVZB5QoJ
         xDTPuMtDHHSt5QJ5RMFOH7dqd/rsxdGviTr/hB5g6lk6ADpurRVllZSeLDTPnRp36mx7
         HCqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=j1DNA9gO;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=j1DNA9gO;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.16 106/110] x86/bugs: Rework spec_ctrl base and mask logic
Date: Mon, 21 May 2018 23:12:43 +0200
Message-Id: <20180521210514.955223636@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109960928055699?=
X-GMAIL-MSGID: =?utf-8?q?1601110580804590619?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
