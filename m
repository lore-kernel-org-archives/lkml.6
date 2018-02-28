Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELs1qxeNQtIpe+SeNTGe/DL4Z0QMB3k3RR44xgleKQX6LuZ52RnavspZZO38N7COJ+5V5Cpa
ARC-Seal: i=1; a=rsa-sha256; t=1519855643; cv=none;
        d=google.com; s=arc-20160816;
        b=npIrHff5l4kwLfSIQdtZhN2cxscD974zC7GJvKXDRzhSQPgxm7EdZX1KSMBXcKWZDX
         7s6aZ52jA/J2YUovpO277rYn2UtlkHBagGJmngPjp7ajhfRth+XV8hMGbHj9gx4zP+gY
         jnZZa6WIUxRA5nVIs5lUEmUH+1ZZcGAwEwh5u+IJ4q7vn9NgF5174ybglcIXQYsWMYj3
         9XgvbcKEBcAPbuwdZIdI1gfZaXDFVDXikK1C2d0sdV1N2s+lUknLuElXeVWrdUA/3e4E
         cLvMcCcjrbB6FisOFSPu62Bgj0zPw8n/c8Bj256o4RU6si/3IxSnK2qKQeCQ7w0Glvgi
         QNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=FrB7HgXlFWgsSuKF1xSmw8vLLH7A0luH2WsPNter7ng=;
        b=UVACdWBMBwRitvamGMIHX+eArnKfx528Oi55UA9ATiSu1Pvngvc/VzsJE0yCgVanty
         lL897nnKOSlm7EAifm8FGOqIEB+YueQdoFM30BrInIY8K+d/kpMAvmaT/fez7iqtC/WR
         anpa2LrluZAjYGE0AVJEAKTYGN6shg+uXO7Yhn6n8rUH02vnmJY+hglMMu/ggt7g6P7S
         y9EeJpAymf+s0pEqYuhFls4MLao52vzrGVfPcPa+kcMEfqcCQWzneHRurfWxj3MsqY4A
         s4FzoyAT0k2cykcaVYldJ7+IHerIJznQRxYdLF7EG9MGLxZMHegP9/JntiNgQ1OSvkpG
         Kd1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com,
	lorenzo.pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	dietmar.eggemann@arm.com,
	morten.rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v7 06/13] ACPI: Enable PPTT support on ARM64
Date: Wed, 28 Feb 2018 16:06:12 -0600
Message-Id: <20180228220619.6992-7-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684151159305303?=
X-GMAIL-MSGID: =?utf-8?q?1593684151159305303?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that we have a PPTT parser, in preparation for its use
on arm64, lets build it.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/Kconfig    | 1 +
 drivers/acpi/Kconfig  | 3 +++
 drivers/acpi/Makefile | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7381eeb7ef8e..439684a71e18 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -7,6 +7,7 @@ config ARM64
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ACPI_SPCR_TABLE if ACPI
+	select ACPI_PPTT if ACPI
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f505e9a01b2d..55aa9789d474 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -534,6 +534,9 @@ config ACPI_CONFIGFS
 
 if ARM64
 source "drivers/acpi/arm64/Kconfig"
+
+config ACPI_PPTT
+	bool
 endif
 
 config TPS68470_PMIC_OPREGION
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 41954a601989..b6056b566df4 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
+obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
-- 
2.13.6
