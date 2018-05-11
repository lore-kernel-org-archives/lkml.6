Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZqySN4k4K2XrZQg/B4E5So59zYD9ACaDBlHbxs5IzCI+kpLMn/mrU5FzoRotDFBFl2IIUOQ
ARC-Seal: i=1; a=rsa-sha256; t=1526083147; cv=none;
        d=google.com; s=arc-20160816;
        b=rP88khO+F7eUyEQwdNKpz8Tf500VKBM2J1jxuuRzCdxlTvIwlqYj1z/eA5grBL+tPi
         CcS11iSzJaIzRs+wyegaoRCmzaccYj+aDiKZ7PoOjaEwlB7eksuVAfiw0LzaS9iH4TN9
         hFR7yYN3fBj0YUmlG2u/bC228oYbV5JcFaCjbG3fPTzW7OAzwL59dY1vBpTw6j+s0H4Y
         bw56PqSuQOIXiaMskPbAiyJyV29p6nVb2P356T0lgluXRtlWaBdfMj/bagewMqeT37VM
         uxeQhWgwC4JqYZOhuSDTMinG+Wf0nrDbkofT/jJ1hccIkknEsax/z6XFw05YKCeTNJqj
         8D5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=KI88hQ+QtJXnQyQQNDXeocUR3hLl7Wk3Kxs0n5iJEF4=;
        b=1IcQxJYbtyqfKw//0OE9Sdcu65FPixzIA8DLtP8MMKQZNrcNw3BI8u4HPEWxITq0/c
         jxjkWTXWsLqmvcfwX7A/uFIsGSE9970J8lfiPRqdBEKu0u3mZBWpL+8h//rEz8+xy5T2
         di+iYcI/3a1JRmYw04CdDYYfFVJlRX03r7VIQfK/nYeDhq1KLm1yh3RF46m6ud/TCpDd
         a46d32nFk8nknus27tkDh+O36f222BjBPwxXkC1Bxss3hJDL/sk6XrJnTiVmwSz9KeMI
         z2qQ8q/oRPlvxyLqGyszrFXaQ1NaAD5n5cyw9w36Jo8S0Bk3cuK7k9Y7Sdh/IxBGI3z+
         Ck8A==
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
	jhugo@codeaurora.org,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v9 04/12] arm64/acpi: Create arch specific cpu to acpi id helper
Date: Fri, 11 May 2018 18:57:59 -0500
Message-Id: <20180511235807.30834-5-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214161845271552?=
X-GMAIL-MSGID: =?utf-8?q?1600214161845271552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Its helpful to be able to lookup the acpi_processor_id associated
with a logical cpu. Provide an arm64 helper to do this.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/acpi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 32f465a80e4e..0db62a4cbce2 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -86,6 +86,10 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
+static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
+{
+	return	acpi_cpu_get_madt_gicc(cpu)->uid;
+}
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 void __init acpi_init_cpus(void);
-- 
2.13.6
