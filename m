Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225B7sY6R9ZbBKuEfUwJ3GilkrJtdcAl+NTN0gHVpBXzJjqCqk8T9GtJFW2TfZwJ4rstwYhT
ARC-Seal: i=1; a=rsa-sha256; t=1518709344; cv=none;
        d=google.com; s=arc-20160816;
        b=yagN4kChr9e0oyzWK44lIrPYi5YdRCL7ra3CZmwjZgXIhJdK1oFSNOFISQMJ5oBxv+
         +bmTGG5RW8F+8+DkMg0I2uNGPjU+BkS1doj/pexysv/rhiM/o/H7OK2/nfIG64wYWA2K
         9jiKY2OwDVg/UyDySRboVhdoG6gudnq+BYulEeb1MVKSwwSljVUA5BY2XKNYrWUorb0s
         N5kWYbEZf1yozM0VAcx5eeXny2xC/+zV6suUGJJqrTq49og72xaJr34aN8YHVhjqPBvG
         FHZ8D3P0VUS71pzjVbfPANzcDF9WEwhMXCMeIe9+hP2LPCimJv3cec0StO9lOzRkV2Ta
         RZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wzh+J5sSZqtVYG43tfbqKsbQPl2USyYCMyuSFvcw6Ms=;
        b=H+nQy602NXBPW17AzWWzSQyZbSGOQR1QEytwApB+RBSv4n6MFI8fJDAwsXe7w5QXZ7
         RSgHSalAV4+uFiUGYuMxi4cR45CK8EDyyeDgHex92tLp+Lb/wLUk+8ewGkZVCiqkufQQ
         Phajg9NoI6KPTuCGMeM7+mjVImOaHqLgOfrT2Mo3H9F3NzBAxf6esC9yoslicJTh37Xr
         Yt38OXblvlruph1Xu1ljRzVjKscaMjvdVlPcZfrp5VXcSU8/krLIkL5ytjrz5wh8/01V
         /IFh62l1p9A3e6CNNrFS5PSzUX8E9Fx75/usk7GD+09TZZIZk+LVTDZDJVyQ9K9w0s1v
         xEiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 083/202] [Variant 2/Spectre-v2] firmware/psci: Expose SMCCC version through psci_ops
Date: Thu, 15 Feb 2018 16:16:23 +0100
Message-Id: <20180215151717.804235463@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481708878297459?=
X-GMAIL-MSGID: =?utf-8?q?1592482169763511101?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit e78eef554a91 upstream.

Since PSCI 1.0 allows the SMCCC version to be (indirectly) probed,
let's do that at boot time, and expose the version of the calling
convention as part of the psci_ops structure.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
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
