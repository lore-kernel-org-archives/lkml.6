Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AG47ELues/VsTA8A+KVIhv84hq/m+Yp2QNZhmlXmkactjEVwOkZTjrZw8nU17PJSND8mSTl3cmvW
ARC-Seal: i=1; a=rsa-sha256; t=1521378849; cv=none;
        d=google.com; s=arc-20160816;
        b=rLX9f+LM1fmVIaR8poYDvL578zYNA5ZGpEe/ksoysaxQjs+q2b8jrGvtxeMQLzyVrd
         Sygnlz+sBuYuAsDsHZ0lHq5FW6s6YUR9pjAeKz/jtOMkTwLicniVH3Ldwiu1NRanBMOX
         D1AFsAPCwPIwlqWTuMcM62chKil1cW3bHvZA3Hng1zg5tMqpcG3vuV0kwgenp++w9wPG
         fhoLXekm5SO+lide9h/RygfX54vZq1raQYQlxPmZj1B3kPnVI4tZQoS6D47/T73c9RmL
         F4clCN2Kg0ucEMR4JK+TlvQhychCNGtiR07VZFShjiBwxwU52haTEcRApDdg17NVCdOD
         /rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=GzflMZTODJ2UvrdMTJR1/wOm8H+vDOEFmKTDBbKWTvw=;
        b=YCFktQfb8vM0cKqzVk8HfLYqLZkP7Y9v86acyVy4Zkls0JGuzNC9GoS8wgLsMNbVR0
         FeJqc36HjI4s6zePBpOWH6oKSy08oirxM88Pynzz6xgd4o2eT9/xlrBgjvDVD5y5UyFk
         2JKHfzq9nllKTEjh+ApOCtTN3KYO0BH6y05MEoDDmr9h7eEmrpgIAJuSjaUDhP3zh5By
         d9Uzjph8AeK06N2BOCHND14zpchAG1+CQsBKtlp1Hwe0Ot2T3W/BjOcq3tQYb1flNpYm
         hz1Z/TUX/UYx79p/Rw289/CwHTUfOwuAf0fx9sqay+jItLCR5VPygkOEriJc80UWGhzW
         eRtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: Abbott Liu <liuwenliang@huawei.com>
To: <linux@armlinux.org.uk>, <aryabinin@virtuozzo.com>,
	<marc.zyngier@arm.com>, <kstewart@linuxfoundation.org>,
	<gregkh@linuxfoundation.org>, <f.fainelli@gmail.com>,
	<liuwenliang@huawei.com>, <akpm@linux-foundation.org>,
	<afzal.mohd.ma@gmail.com>, <alexander.levin@verizon.com>
CC: <glider@google.com>, <dvyukov@google.com>, <christoffer.dall@linaro.org>,
	<linux@rasmusvillemoes.dk>, <mawilcox@microsoft.com>, <pombredanne@nexb.com>,
	<ard.biesheuvel@linaro.org>, <vladimir.murzin@arm.com>,
	<nicolas.pitre@linaro.org>, <tglx@linutronix.de>, <thgarnie@google.com>,
	<dhowells@redhat.com>, <keescook@chromium.org>, <arnd@arndb.de>,
	<geert@linux-m68k.org>, <tixy@linaro.org>, <mark.rutland@arm.com>,
	<james.morse@arm.com>, <zhichao.huang@linaro.org>, <jinb.park7@gmail.com>,
	<labbott@redhat.com>, <philip@cog.systems>, <grygorii.strashko@linaro.org>,
	<catalin.marinas@arm.com>, <opendmb@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
	<kvmarm@lists.cs.columbia.edu>, <linux-mm@kvack.org>
Subject: [PATCH 3/7] Disable instrumentation for some code
Date: Sun, 18 Mar 2018 20:53:38 +0800
Message-ID: <20180318125342.4278-4-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180318125342.4278-1-liuwenliang@huawei.com>
References: <20180318125342.4278-1-liuwenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.187.223]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281348586667199?=
X-GMAIL-MSGID: =?utf-8?q?1595281348586667199?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Ryabinin <a.ryabinin@samsung.com>

Disable instrumentation for arch/arm/boot/compressed/*
and arch/arm/vdso/* because those code won't linkd with
kernel image.

Disable kasan check in the function unwind_pop_register
because it doesn't matter that kasan checks failed when
unwind_pop_register read stack memory of task.

Reviewed-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 arch/arm/boot/compressed/Makefile | 1 +
 arch/arm/kernel/unwind.c          | 3 ++-
 arch/arm/vdso/Makefile            | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

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
