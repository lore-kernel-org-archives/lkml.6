Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZooR4jxy1R6s1o2v9X1mdBt/lds3Y2WsIPBbHwmYcflj7qmsK6Hb+s4rJVhoj8eqYAE2g/h
ARC-Seal: i=1; a=rsa-sha256; t=1524702376; cv=none;
        d=google.com; s=arc-20160816;
        b=atvaFUA8lPTlBik6o8KlM/HmmkC6WQwpCcFx5ZayweIG0mlihiutxiyrPFvdq4ieLt
         RZErDgP9FoHaM4ydfCxhdrdBJLEtmj3kz2Toa1ud333IrKYSq/SmAOFf6kLV0nPsA98H
         qowdfxdhesTl/xIMmPOSEW6YWwYd1FZkAgh4pQwic+V3wwDvtzJ+rnKE54DtAq2kLgsu
         fW88PynNsDB6Q/kqRplTGg+LZOMQLmEdmvkH3XA+INu5I7G4QUL61cxY4J0WWcnnKLu3
         5k3T3bjRky9UI0HEbJV8XPnxwmOK7MNPWJXlfCGCYBD6a2Xdkgm1IoP7+dRHbHnQUNXr
         uLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=iPZKjSeNcnhcG2wFRWM3tqfYzqKCEuP7rtJqHUpKyCs=;
        b=ist88FgR+TWCfs7Zw0tSvNRzd69giccA2QePoEB/izcmBvG/U4/KMJPlTb2mOUpcmP
         miHS8vRn5gysSu/3ehoFICUxSkxUsYoIdVZmZ0OPf7rFQEfU2juVGh4gs+fgDxTr46xP
         mKlVsumKlcYVWiK/sf1g3xc2eHcVdHRh+8ta85QgBEI7pFVXy8FhBbvrykKk2gdg+eCr
         rNOeTKBc6qNW03hGzGdPNBZ91PhUiqTlYB6CJcPfscgRiU6q5CNOJTQ2NqYQeZ/dMG/U
         IteryohW730lT+P56xFe3VkThLdzSTsjYkDFlVhk/YPNERJKbc86TSRzKL+z1t76SQCP
         6GRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: Sudeep.Holla@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo.Pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	Will.Deacon@arm.com,
	Catalin.Marinas@arm.com,
	gregkh@linuxfoundation.org,
	Mark.Rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	Dietmar.Eggemann@arm.com,
	Morten.Rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	jhugo@qti.qualcomm.com,
	timur@qti.qualcomm.com,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v8 06/13] ACPI: Enable PPTT support on ARM64
Date: Wed, 25 Apr 2018 18:31:14 -0500
Message-Id: <20180425233121.13270-7-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766319386198121?=
X-GMAIL-MSGID: =?utf-8?q?1598766319386198121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that we have a PPTT parser, in preparation for its use
on arm64, lets build it.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/Kconfig    | 1 +
 drivers/acpi/Kconfig  | 3 +++
 drivers/acpi/Makefile | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf4938f6d..cff33d9eff0c 100644
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
index 516d7b36d6fb..b533eeb6139d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -547,6 +547,9 @@ config ACPI_CONFIGFS
 
 if ARM64
 source "drivers/acpi/arm64/Kconfig"
+
+config ACPI_PPTT
+	bool
 endif
 
 config TPS68470_PMIC_OPREGION
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 48e202752754..6d59aa109a91 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
+obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
-- 
2.13.6
