Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48eCv/O4JQLTYjFyrHeXCOuca399maBTl2INPmEP+xKQE2uVgfwPQZCkhIMpiVkMG68hMje
ARC-Seal: i=1; a=rsa-sha256; t=1523981383; cv=none;
        d=google.com; s=arc-20160816;
        b=Ntdm8kufEnW0UT+DlAW5XER19CWEr1Ua3f8/J6xxf7MrvYYiTYG5AoP/jfKJh6jxEF
         2rQH0Xh1VnC2TIslNmu2wATt3Xdi/0VRTltdcGpR0U5XFteBIlranwj8/VPfUwq0gjGh
         aCUtONbCf3xr5rm5HO3xQ2i9egAgEEKFbl/g6sv+E9ez7ia04/Wa86qgKCfO4s/EX8ux
         atlWsaPc3uChgMkGf6ZvMyD4MiMTgzZMacoU6aG6LOhDJEqnYdbtF2ptx/IrXR6sKMr+
         uj53yp2JGH0Th0mMkGEshEPNSVdFa33ETAH+uNEu5fRxUvE/WsQ7kwPP/5O1LtM/h49E
         Vb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+7sDUBiUD7ST5ztSGAxtuj4l6tJDlbwPbyLmw4a13xk=;
        b=iE4u1xf0GisSMqPHhVYlOHtyUfCbpLAPwPRDTjWI5pcPcb+45T+Qy5wchB03we6fIS
         RGrau8yiOiG0KwoVhcoLluHauwdiGRTcZIxTrvW38c9IhqsPasw+KXswpz+UNKHDTBYS
         /SsncnHfdkDNLC64pvZGeU4aadwE6AYUBMpq4P1QJAEv4c27ucie/mahKmcqxytsAyLG
         CBfI4IwOK5GvHoF8yqwIuaomykCCuoTC0+OkR3/ygAqSeMkt+tH/HcwOrQ18UWgXQCOP
         Q0dC8UikmNsANFwLaT9mJd6VfJvPPOvaCz/np2MB1siWI1nSgkZUMJoYbe2pxeDhI1PK
         aQpA==
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
Subject: [PATCH 4.9 45/66] firmware/psci: Expose PSCI conduit
Date: Tue, 17 Apr 2018 17:59:18 +0200
Message-Id: <20180417155647.836926132@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010302311346566?=
X-GMAIL-MSGID: =?utf-8?q?1598010302311346566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Marc Zyngier <marc.zyngier@arm.com>

commit 09a8d6d48499f93e2abde691f5800081cd858726 upstream.

In order to call into the firmware to apply workarounds, it is
useful to find out whether we're using HVC or SMC. Let's expose
this through the psci_ops.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
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
