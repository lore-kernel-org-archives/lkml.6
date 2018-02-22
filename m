Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932449AbeBVNIC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:08:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932102AbeBVNH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:07:59 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <151024866805.28329.10437019941463042267.stgit@warthog.procyon.org.uk>
References: <151024866805.28329.10437019941463042267.stgit@warthog.procyon.org.uk> <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, jforbes@redhat.com, jbohac@suse.cz,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/30] Enforce module signatures if the kernel is locked down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30283.1519304877.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Thu, 22 Feb 2018 13:07:57 +0000
Message-ID: <30284.1519304877@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm considering folding the attached changes into this patch.

It adjusts the errors generated:

 (1) If there's no signature (ENODATA) or we can't check it (ENOPKG, ENOKEY),
     then:

     (a) If signatures are enforced then EKEYREJECTED is returned.

     (b) If IMA will have validated the image, return 0 (okay).

     (c) If there's no signature or we can't check it, but the kernel is
	 locked down then EPERM is returned (this is then consistent with
	 other lockdown cases).

 (2) If the signature is unparseable (EBADMSG, EINVAL), the signature fails
     the check (EKEYREJECTED) or a system error occurs (eg. ENOMEM), we return
     the error we got.

Note that the X.509 code doesn't check for key expiry as the RTC might not be
valid or might not have been transferred to the kernel's clock yet.

David
---
diff --git a/kernel/module.c b/kernel/module.c
index 1eb06a0ccbfb..62419cf48ef6 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2769,8 +2769,9 @@ static inline void kmemleak_load_module(const struct module *mod,
 static int module_sig_check(struct load_info *info, int flags,
 			    bool can_do_ima_check)
 {
-	int err = -ENOKEY;
+	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
 	const void *mod = info->hdr;
 
 	/*
@@ -2785,18 +2786,42 @@ static int module_sig_check(struct load_info *info, int flags,
 		err = mod_verify_sig(mod, &info->len);
 	}
 
-	if (!err) {
+	switch (err) {
+	case 0:
 		info->sig_ok = true;
 		return 0;
-	}
 
-	/* Not having a signature is only an error if we're strict. */
-	if (err == -ENOKEY && !sig_enforce &&
-	    (!can_do_ima_check || !is_ima_appraise_enabled()) &&
-	    !kernel_is_locked_down("Loading of unsigned modules"))
-		err = 0;
+		/* We don't permit modules to be loaded into trusted kernels
+		 * without a valid signature on them, but if we're not
+		 * enforcing, certain errors are non-fatal.
+		 */
+	case -ENODATA:
+		reason = "Loading of unsigned module";
+		goto decide;
+	case -ENOPKG:
+		reason = "Loading of module with unsupported crypto";
+		goto decide;
+	case -ENOKEY:
+		reason = "Loading of module with unavailable key";
+	decide:
+		if (sig_enforce) {
+			pr_notice("%s is rejected\n", reason);
+			return -EKEYREJECTED;
+		}
 
-	return err;
+		if (can_do_ima_check && is_ima_appraise_enabled())
+			return 0;
+		if (kernel_is_locked_down(reason))
+			return -EPERM;
+		return 0;
+
+		/* All other errors are fatal, including nomem, unparseable
+		 * signatures and signature check failures - even if signatures
+		 * aren't required.
+		 */
+	default:
+		return err;
+	}
 }
 #else /* !CONFIG_MODULE_SIG */
 static int module_sig_check(struct load_info *info, int flags,
