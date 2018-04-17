Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx488X2IMerfTF/0Rmp2WeCldI3UUwXVz2w7VGY2gyC+myHJ9NQsD9NAfMszVVGUwIMudmLT9
ARC-Seal: i=1; a=rsa-sha256; t=1523981385; cv=none;
        d=google.com; s=arc-20160816;
        b=teo8pzQjJTXFZoL6c8klwY+WBHwVrh+2/+AhTR5K3Wh9gNcu7rukE2z0y1HpmGiGYz
         eWg1D0VhPaxIu+BMiUilID3TGz7BDl+KwqJans2PKZ+DpZ5FxWJ2YW//ObpZHsdui2G3
         Axy+C2QYIJSh3ai0528zJh4nNlRRHQXVFGszjWlmyM5Zn2cO1gXIyRMx22uLdrDN2LkH
         B68uWWJBm7d6ErP6jxMbCQbf+9AWeK/g01nE32sxSUyHeAfV60P/g9sLzvEh1y/xEBXA
         tMxMCNItzA89vSayeVItt+FphZ5R1AaFi6Yac3bquBR8Fb3cPMwsuig6tSahR3rKj5O4
         2IQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k52/znow8PSu1JxJl6UmFKfaDSUynOGcFf/uroqttjk=;
        b=G+D+q+jNlxWaYveNddzYDodl0V7z6FexhIP56HInoXOxdBSnLv9xUDFzc1RRp4BC88
         +5zatbJN+/oHTxqH6CNm/IizEYY2QpnLY9YbcjnhoojXLyojmSvjBtAhuW9tIyheCdfR
         +yYDPX/5f1zyvn5XT7uekO8BDVVmzLm9s/RrgN2VI642MdWPQJNbx0LUuW8x9gMAtmhI
         OdMmtjPn1QQOzVh3iHJ6YFAoM+vnWj3GYWEPxttZcGNR+PbFGMj+pZB9gEZ7BEn93CVQ
         wKx+8E8irKQi/jiPvY4aHUOEWEQF0ZsqJ/48OHaE+KTkJ4dqdvMpzQMAPEWIWFWYe+yJ
         nLIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 46/66] firmware/psci: Expose SMCCC version through psci_ops
Date: Tue, 17 Apr 2018 17:59:19 +0200
Message-Id: <20180417155647.883306120@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010305378133676?=
X-GMAIL-MSGID: =?utf-8?q?1598010305378133676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Marc Zyngier <marc.zyngier@arm.com>

commit e78eef554a912ef6c1e0bbf97619dafbeae3339f upstream.

Since PSCI 1.0 allows the SMCCC version to be (indirectly) probed,
let's do that at boot time, and expose the version of the calling
convention as part of the psci_ops structure.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/psci.c |   27 +++++++++++++++++++++++++++
 include/linux/psci.h    |    6 ++++++
 2 files changed, 33 insertions(+)

--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -61,6 +61,7 @@ bool psci_tos_resident_on(int cpu)
 
 struct psci_operations psci_ops = {
 	.conduit = PSCI_CONDUIT_NONE,
+	.smccc_version = SMCCC_VERSION_1_0,
 };
 
 typedef unsigned long (psci_fn)(unsigned long, unsigned long,
@@ -511,6 +512,31 @@ static void __init psci_init_migrate(voi
 	pr_info("Trusted OS resident on physical CPU 0x%lx\n", cpuid);
 }
 
+static void __init psci_init_smccc(void)
+{
+	u32 ver = ARM_SMCCC_VERSION_1_0;
+	int feature;
+
+	feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
+
+	if (feature != PSCI_RET_NOT_SUPPORTED) {
+		u32 ret;
+		ret = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
+		if (ret == ARM_SMCCC_VERSION_1_1) {
+			psci_ops.smccc_version = SMCCC_VERSION_1_1;
+			ver = ret;
+		}
+	}
+
+	/*
+	 * Conveniently, the SMCCC and PSCI versions are encoded the
+	 * same way. No, this isn't accidental.
+	 */
+	pr_info("SMC Calling Convention v%d.%d\n",
+		PSCI_VERSION_MAJOR(ver), PSCI_VERSION_MINOR(ver));
+
+}
+
 static void __init psci_0_2_set_functions(void)
 {
 	pr_info("Using standard PSCI v0.2 function IDs\n");
@@ -559,6 +585,7 @@ static int __init psci_probe(void)
 	psci_init_migrate();
 
 	if (PSCI_VERSION_MAJOR(ver) >= 1) {
+		psci_init_smccc();
 		psci_init_cpu_suspend();
 		psci_init_system_suspend();
 	}
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -31,6 +31,11 @@ enum psci_conduit {
 	PSCI_CONDUIT_HVC,
 };
 
+enum smccc_version {
+	SMCCC_VERSION_1_0,
+	SMCCC_VERSION_1_1,
+};
+
 struct psci_operations {
 	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
@@ -41,6 +46,7 @@ struct psci_operations {
 			unsigned long lowest_affinity_level);
 	int (*migrate_info_type)(void);
 	enum psci_conduit conduit;
+	enum smccc_version smccc_version;
 };
 
 extern struct psci_operations psci_ops;
