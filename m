Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AIpwx49E1EsNvHj30y7qjkkvB7m9LGp1u/MaNrVkYPgB7N+R3neoDhTcvw2aDQczgHC/ZVh1GeFW
ARC-Seal: i=1; a=rsa-sha256; t=1522671904; cv=none;
        d=google.com; s=arc-20160816;
        b=aaueX4EyU0PuRUC9E+/24JOgNv29WBpNVOybCTTv0G4u00GFK/9IwAbbFjZ9kLysj1
         QY0nNZuHkKAl/SKtwCZIuFyVvz1NBpB/s6j9RSS+h5+efKNz8ZnkCzTvjRDfM85EA0cC
         rWSDu4bldRS2ce9/8QAaqNXDXnKu+pZ8/KbHg/JaVM4c7B0XZdgWJX6jxL8ZR7hEA27j
         UBILCjeIEA2w66qBXP+F0Uk8AAU8B6i04m8hl3QIEHyodSGFcgI91ZyxpXsIxCcwsP3y
         sMF+PgqiPT89+bYys00nHy4V3eS3/z7bGXzc5rfhQbZQfUq4QKkQr3NxzMrE/341pY6A
         oZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=53Fp4WTPSxm9in+fys+oCx87HpMIeXTLmZmGB/nUx14=;
        b=cSQHCe84gwhLIskzijC0WGfCdP1wnOwU/7BCBD/lczJBJgBXIPq7jL0esVWi6FnJK5
         tuGET0robeqeKGRE79r017UFl7OXvSqOSVsj2tLFCW2x/uhm/ceKiv2DgUsX3iFKqO3v
         8rvggIeSMTYt0b8vJB8+beSCHkBARV1MzBTW515zccOJcAzh083xg+AcbYqjyt4sedrB
         A5/VrGXdhas9sZffJ/GWRzWUTKVR4ZAnOWsf9E4BEtEChkKF9XwklzaB+d5zwkhNv6Ww
         Rt0jGjuL3SgwLCT6au4V+ySrUR9ipFdRu0D0Jx1DxSY39m8OBxSB3L7gMFO7T6hIAM9J
         hh+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: Abbott Liu <liuwenliang@huawei.com>
To: <aryabinin@virtuozzo.com>, <dvyukov@google.com>, <corbet@lwn.net>,
	<linux@armlinux.org.uk>, <christoffer.dall@linaro.org>,
	<marc.zyngier@arm.com>, <kstewart@linuxfoundation.org>,
	<gregkh@linuxfoundation.org>, <f.fainelli@gmail.com>,
	<liuwenliang@huawei.com>, <akpm@linux-foundation.org>,
	<linux@rasmusvillemoes.dk>, <mawilcox@microsoft.com>, <pombredanne@nexb.com>,
	<ard.biesheuvel@linaro.org>, <vladimir.murzin@arm.com>,
	<alexander.levin@verizon.com>, <nicolas.pitre@linaro.org>,
	<tglx@linutronix.de>, <thgarnie@google.com>, <dhowells@redhat.com>,
	<keescook@chromium.org>, <arnd@arndb.de>, <geert@linux-m68k.org>,
	<tixy@linaro.org>, <julien.thierry@arm.com>, <mark.rutland@arm.com>,
	<james.morse@arm.com>, <zhichao.huang@linaro.org>, <jinb.park7@gmail.com>,
	<labbott@redhat.com>, <philip@cog.systems>, <grygorii.strashko@linaro.org>,
	<catalin.marinas@arm.com>, <opendmb@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <kasan-dev@googlegroups.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>,
	<linux-mm@kvack.org>
Subject: [PATCH v3 2/6] Disable instrumentation for some code
Date: Mon, 2 Apr 2018 20:04:36 +0800
Message-ID: <20180402120440.31900-3-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180402120440.31900-1-liuwenliang@huawei.com>
References: <20180402120440.31900-1-liuwenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.187.223]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596637215509017214?=
X-GMAIL-MSGID: =?utf-8?q?1596637215509017214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Ryabinin <a.ryabinin@samsung.com>

Disable instrumentation for arch/arm/boot/compressed/*
,arch/arm/kvm/hyp/* and arch/arm/vdso/* because those
code won't linkd with kernel image.

Disable kasan check in the function unwind_pop_register
because it doesn't matter that kasan checks failed when
unwind_pop_register read stack memory of task.

Reviewed-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 arch/arm/boot/compressed/Makefile | 1 +
 arch/arm/kernel/unwind.c          | 3 ++-
 arch/arm/kvm/hyp/Makefile         | 4 ++++
 arch/arm/vdso/Makefile            | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 45a6b9b..966103e 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -24,6 +24,7 @@ OBJS		+= hyp-stub.o
 endif
 
 GCOV_PROFILE		:= n
+KASAN_SANITIZE		:= n
 
 #
 # Architecture dependencies
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 0bee233..2e55c7d 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -249,7 +249,8 @@ static int unwind_pop_register(struct unwind_ctrl_block *ctrl,
 		if (*vsp >= (unsigned long *)ctrl->sp_high)
 			return -URC_FAILURE;
 
-	ctrl->vrs[reg] = *(*vsp)++;
+	ctrl->vrs[reg] = READ_ONCE_NOCHECK(*(*vsp));
+	(*vsp)++;
 	return URC_OK;
 }
 
diff --git a/arch/arm/kvm/hyp/Makefile b/arch/arm/kvm/hyp/Makefile
index 63d6b40..0a8b500 100644
--- a/arch/arm/kvm/hyp/Makefile
+++ b/arch/arm/kvm/hyp/Makefile
@@ -24,3 +24,7 @@ obj-$(CONFIG_KVM_ARM_HOST) += hyp-entry.o
 obj-$(CONFIG_KVM_ARM_HOST) += switch.o
 CFLAGS_switch.o		   += $(CFLAGS_ARMV7VE)
 obj-$(CONFIG_KVM_ARM_HOST) += s2-setup.o
+
+GCOV_PROFILE	:= n
+KASAN_SANITIZE	:= n
+UBSAN_SANITIZE	:= n
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index bb411821..87abbb7 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -30,6 +30,8 @@ CFLAGS_vgettimeofday.o = -O2
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
+KASAN_SANITIZE := n
+
 # Force dependency
 $(obj)/vdso.o : $(obj)/vdso.so
 
-- 
2.9.0
