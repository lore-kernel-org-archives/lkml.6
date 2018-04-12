Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AIpwx4/LonDp+vzW6VVO/zlyc7T19wl/MENFnJrTuWELL4enh2/TP0IDB5m7emnoC0znhXoW7HPf
ARC-Seal: i=1; a=rsa-sha256; t=1523538881; cv=none;
        d=google.com; s=arc-20160816;
        b=D5JwloY3IevevGXAWa7BBa+3r8eDG+tnyaASVygwOLs+B0TJ6XDIGUbA5ljy5GKQYz
         HHlTb/7xEhGxS0okAzWciN4mfdOOxeeFreh9MxcCgSPu8b5Axg74eHc+Sy+9pF8tOhCc
         G5NinlF3WM8jrQ2k9uBRIgpGFXEDGwRJED81RHOcK9PvXmNNZzCZbSGFyV+htzw32ey2
         TaFTKMlB9NnolmS64swcRiIfITEF5HmkGi5d/T7OOyDT7NGLi8ckmUi5VZAYxB8gMFv5
         gjf1Adbd9EZgrGfQkEM+iVDJ6z+QKDjPxMDjU4vQC8G1B1bcwMQ0IhiLFXycJCFJ5YoO
         vNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=JHMRP0AEs2eC5QvoB/SOJ2fOyOn0afsgC7H1o500Fo8=;
        b=Gpeal/d9yzAOukEz1rKj+UqxqcRq8z8kF/RgxaW7/7hD/+ENPRY4du6hBGfiTL1KcE
         zaWv9SrY/CwG2XkBQHTA7Y25EhTN8Oy3ncDCTqY79yS45wmMbMLghvgyxBTVa3WhsGkY
         qBAKKbaR4Z94u5HEDkH9KWm14JHMDcs3P4GpHWB+xBh26kd2EpVGDN/8ErWgfhyt7nXo
         5Zh6M3IgIkJbjSJHjcPNl6IcbPk8eVksScAEagAbI7B+Kx52EUqfv5IW0vOKHQpjOiK8
         y7hTQaxpLMA4Cf/gZ0bHyqQdRRX53hdzmoGlfIkN3GHUVS2eJjoGGL33xqOHcDtQiUgj
         cL3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: Abbott Liu <liuwenliang@huawei.com>
To: <aryabinin@virtuozzo.com>, <glider@google.com>, <dvyukov@google.com>,
	<corbet@lwn.net>, <linux@armlinux.org.uk>, <cdall@kernel.org>,
	<marc.zyngier@arm.com>, <arnd@arndb.de>, <nicolas.pitre@linaro.org>,
	<vladimir.murzin@arm.com>, <mingo@kernel.org>, <viro@zeniv.linux.org.uk>,
	<alexandre.belloni@bootlin.com>, <ard.biesheuvel@linaro.org>,
	<daniel.lezcano@linaro.org>, <pombredanne@nexb.com>,
	<kstewart@linuxfoundation.org>, <liuwenliang@huawei.com>,
	<gregkh@linuxfoundation.org>, <f.fainelli@gmail.com>,
	<mawilcox@microsoft.com>, <akpm@linux-foundation.org>,
	<mark.rutland@arm.com>, <afzal.mohd.ma@gmail.com>,
	<alexander.levin@verizon.com>, <tglx@linutronix.de>, <thgarnie@google.com>,
	<dhowells@redhat.com>, <keescook@chromium.org>, <geert@linux-m68k.org>,
	<tixy@linaro.org>, <julien.thierry@arm.com>, <james.morse@arm.com>,
	<zhichao.huang@linaro.org>, <jinb.park7@gmail.com>, <labbott@redhat.com>,
	<philip@cog.systems>, <grygorii.strashko@linaro.org>, <opendmb@gmail.com>,
	<mhocko@suse.com>, <kirill.shutemov@linux.intel.com>,
	<kasan-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.cs.columbia.edu>
Subject: [PATCH 2/6] Disable instrumentation for some code
Date: Thu, 12 Apr 2018 20:54:07 +0800
Message-ID: <20180412125411.326-3-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412125411.326-1-liuwenliang@huawei.com>
References: <20180412125411.326-1-liuwenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.187.223]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597546306442823003?=
X-GMAIL-MSGID: =?utf-8?q?1597546306442823003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Ryabinin <a.ryabinin@samsung.com>

Disable instrumentation for arch/arm/boot/compressed/*
and arch/arm/vdso/* because those code won't linkd with
kernel image.

Disable instrumentation for arch/arm/kvm/hyp/*. See commit a6cdf1c08cbf
("kvm: arm64: Disable compiler instrumentation for hypervisor code")
for more details.

Disable instrumentation for arch/arm/mm/physaddr.c. See
commit ec6d06efb0ba ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
for more details.

Disable kasan check in the function unwind_pop_register
because it doesn't matter that kasan checks failed when
unwind_pop_register read stack memory of task.

Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 arch/arm/boot/compressed/Makefile | 1 +
 arch/arm/kernel/unwind.c          | 3 ++-
 arch/arm/kvm/hyp/Makefile         | 4 ++++
 arch/arm/mm/Makefile              | 1 +
 arch/arm/vdso/Makefile            | 2 ++
 5 files changed, 10 insertions(+), 1 deletion(-)

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
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 9dbb849..c056e17 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -16,6 +16,7 @@ endif
 obj-$(CONFIG_ARM_PTDUMP_CORE)	+= dump.o
 obj-$(CONFIG_ARM_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
 obj-$(CONFIG_MODULES)		+= proc-syms.o
+KASAN_SANITIZE_physaddr.o	:= n
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
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
