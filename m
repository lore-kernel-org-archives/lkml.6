Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226wP5x+Non65ZVr3q10zaEXdYU0sY4TOAEnT3BTcoDAGKDWQKACWtJDtms41Gnmej3RyhbQ
ARC-Seal: i=1; a=rsa-sha256; t=1518708887; cv=none;
        d=google.com; s=arc-20160816;
        b=llUWZU7gvFL7EGtHyOoO0YtCOQGXc+F5ndL0QatFIAWrW7tdtbGgxTEFBUhjyT/BnA
         ENgm60k7ucrz3Qgdlti+FqJbSQamsV52IEkqNDieAYX2XiDpg/T7c97+bdRPzHCMFvJu
         v0zCPaDYXbI7KtFMMqHjB8G1PeYM/uw0bDy6OblkkvNC6jkNDU9X5IaRgnfo0EkTibUD
         grB1ZUwOv90HMUUuZhw+ZxItHp3rM2WttyE3vMNwbGXFHSTB98OvznVJbyXP/Lfq2bA8
         vhrKOu+lKZlIHvHzfcWNYKessLmyByDnIZW2SWOiG31bU+66FUh2OphkPcCV5I+j0Ur4
         hA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oEWElBpeHxXzBrUO4fs0JqLTtU/jxCHVpp/e71ZKB8w=;
        b=xp18jozuxx37gmBQUtj//zoWyeBk+lxtKYZp57EokfwD1QyeHegByKBZAwKqZGLoEb
         ER7YBrpozwGyPGPuxuJ0IdBMUM8962gGT46zI33cHmRJQDmctXATMUOkz8yl/GcSYS0a
         2Ctjwq7yGLI6DoYMqoNKv+JhUBxktkThg5m24P+gmN7Lw4T8V5y6TlRGW3Ej9kvnGoZp
         iw9RU5cbCrLLIxnXSbgtX6qU+QEYzdjxYkxv/YGk3rJMcv+vQUSN2hys/LEiQJxmjBT+
         q9uDxhJv+fSYzpVVReRCmhzcfaMOkS8WdelLAMW7bWo0mGUb3fOyna4xQlqfUYCgR3qy
         QhNg==
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
Subject: [PATCH 4.14 089/195] [Variant 2/Spectre-v2] firmware/psci: Expose PSCI conduit
Date: Thu, 15 Feb 2018 16:16:20 +0100
Message-Id: <20180215151710.158532521@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481690157218241?=
X-GMAIL-MSGID: =?utf-8?q?1592481690157218241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 09a8d6d48499 upstream.

In order to call into the firmware to apply workarounds, it is
useful to find out whether we're using HVC or SMC. Let's expose
this through the psci_ops.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/psci.c |   28 +++++++++++++++++++++++-----
 include/linux/psci.h    |    7 +++++++
 2 files changed, 30 insertions(+), 5 deletions(-)

--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -59,7 +59,9 @@ bool psci_tos_resident_on(int cpu)
 	return cpu == resident_cpu;
 }
 
-struct psci_operations psci_ops;
+struct psci_operations psci_ops = {
+	.conduit = PSCI_CONDUIT_NONE,
+};
 
 typedef unsigned long (psci_fn)(unsigned long, unsigned long,
 				unsigned long, unsigned long);
@@ -210,6 +212,22 @@ static unsigned long psci_migrate_info_u
 			      0, 0, 0);
 }
 
+static void set_conduit(enum psci_conduit conduit)
+{
+	switch (conduit) {
+	case PSCI_CONDUIT_HVC:
+		invoke_psci_fn = __invoke_psci_fn_hvc;
+		break;
+	case PSCI_CONDUIT_SMC:
+		invoke_psci_fn = __invoke_psci_fn_smc;
+		break;
+	default:
+		WARN(1, "Unexpected PSCI conduit %d\n", conduit);
+	}
+
+	psci_ops.conduit = conduit;
+}
+
 static int get_set_conduit_method(struct device_node *np)
 {
 	const char *method;
@@ -222,9 +240,9 @@ static int get_set_conduit_method(struct
 	}
 
 	if (!strcmp("hvc", method)) {
-		invoke_psci_fn = __invoke_psci_fn_hvc;
+		set_conduit(PSCI_CONDUIT_HVC);
 	} else if (!strcmp("smc", method)) {
-		invoke_psci_fn = __invoke_psci_fn_smc;
+		set_conduit(PSCI_CONDUIT_SMC);
 	} else {
 		pr_warn("invalid \"method\" property: %s\n", method);
 		return -EINVAL;
@@ -654,9 +672,9 @@ int __init psci_acpi_init(void)
 	pr_info("probing for conduit method from ACPI.\n");
 
 	if (acpi_psci_use_hvc())
-		invoke_psci_fn = __invoke_psci_fn_hvc;
+		set_conduit(PSCI_CONDUIT_HVC);
 	else
-		invoke_psci_fn = __invoke_psci_fn_smc;
+		set_conduit(PSCI_CONDUIT_SMC);
 
 	return psci_probe();
 }
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -25,6 +25,12 @@ bool psci_tos_resident_on(int cpu);
 int psci_cpu_init_idle(unsigned int cpu);
 int psci_cpu_suspend_enter(unsigned long index);
 
+enum psci_conduit {
+	PSCI_CONDUIT_NONE,
+	PSCI_CONDUIT_SMC,
+	PSCI_CONDUIT_HVC,
+};
+
 struct psci_operations {
 	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
@@ -34,6 +40,7 @@ struct psci_operations {
 	int (*affinity_info)(unsigned long target_affinity,
 			unsigned long lowest_affinity_level);
 	int (*migrate_info_type)(void);
+	enum psci_conduit conduit;
 };
 
 extern struct psci_operations psci_ops;
