Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0467CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A921320863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kDMRQO88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A921320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502545AbeKWTnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:43:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56566 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393693AbeKWTnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:43:51 -0500
Received: from zn.tnic (p200300EC2BDC9100898E5A1DF8FAB135.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:9100:898e:5a1d:f8fa:b135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 460591EC09A0;
        Fri, 23 Nov 2018 10:00:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542963628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OADAj/SyzpVniib7Gx8mP4T9xOnDyTjwAOFOCkFomoE=;
        b=kDMRQO88zDy+nJNk7yRJ0R26ioH8cKf5G30/9QkodY3lgxu4RJ2j4ObZZpnGqFMALq4g/D
        X795zkFmxgr6Yx5fSTv1WTJt24BH+KzNkHFBCbtClcT473hoH3qzFfsIvig4nQTl/flMls
        wa4gwkT2RbRAHuzEaqQjf4Eo5NgSEm0=
Date:   Fri, 23 Nov 2018 10:00:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Moger, Babu" <Babu.Moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 01/13] x86/resctrl: Rename and move rdt files to new
 directory
Message-ID: <20181123090011.GB30697@zn.tnic>
References: <20181121202811.4492-1-babu.moger@amd.com>
 <20181121202811.4492-2-babu.moger@amd.com>
 <20181123072839.GA51597@gmail.com>
 <20181123082258.GA30697@zn.tnic>
 <20181123084117.GA130228@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181123084117.GA130228@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 09:41:17AM +0100, Ingo Molnar wrote:
> Then at least make the directory name resource_control/, which is only 
> marginally longer and a lot more readable.
> 
> We really don't have to fit directly names into the 8 character DOS limit 
> anymore. ;-)

How about

resource_ctl

?

resource_control/ is kinda long-ish and the other names we have there
are nice and short, see below.

BTW, while we're talking renaming, I have a patch which renames the MCE
pile and am planning to slap it in around -rc6 timeframe since we don't
have a lot of RAS commits this time around, see also the end of this
mail. It makes the naming there all nicely regular. :)

> Also, the Kconfig space, when it gets extended with the AMD bits, should 
> probably follow the same nomenclature: CONFIG_X86_CPU_RESOURCE_CONTROL=y 
> or such.

Sure, I can do that together with the directory rename once we've agreed
on the name.

Thx.

arch/x86/kernel/cpu/
|-- amd.c
|-- aperfmperf.c
|-- bugs.c
|-- cacheinfo.c
|-- centaur.c
|-- common.c
|-- cpu.h
|-- cpuid-deps.c
|-- cyrix.c
|-- hygon.c
|-- hypervisor.c
|-- intel.c
|-- intel_pconfig.c
|-- Makefile
|-- match.c
|-- mcheck
|   |-- dev-mcelog.c
|   |-- Makefile
|   |-- mce_amd.c
|   |-- mce-apei.c
|   |-- mce.c
|   |-- mce-genpool.c
|   |-- mce-inject.c
|   |-- mce_intel.c
|   |-- mce-internal.h
|   |-- mce-severity.c
|   |-- p5.c
|   |-- therm_throt.c
|   |-- threshold.c
|   `-- winchip.c
|-- microcode
|   |-- amd.c
|   |-- core.c
|   |-- intel.c
|   `-- Makefile
|-- mkcapflags.sh
|-- mshyperv.c
|-- mtrr
|   |-- amd.c
|   |-- centaur.c
|   |-- cleanup.c
|   |-- cyrix.c
|   |-- generic.c
|   |-- if.c
|   |-- Makefile
|   |-- mtrr.c
|   `-- mtrr.h
|-- perfctr-watchdog.c
|-- powerflags.c
|-- proc.c
|-- rdrand.c
|-- resctrl
|   |-- core.c
|   |-- ctrlmondata.c
|   |-- internal.h
|   |-- Makefile
|   |-- monitor.c
|   |-- pseudo_lock.c
|   |-- pseudo_lock_event.h
|   `-- rdtgroup.c
|-- scattered.c
|-- topology.c
|-- transmeta.c
|-- umc.c
`-- vmware.c

4 directories, 61 files


---
From: Borislav Petkov <bp@suse.de>
Date: Sun, 18 Nov 2018 15:15:05 +0100
Subject: [PATCH] x86/mce: Streamline MCE subsystem's naming

Rename the containing folder to "mce" which is the most widespread name.
Drop the "mce[-_]" filename prefix of some compilation units (while
others don't have it).

This unifies the file naming in the MCE subsystem:

mce/
|-- amd.c
|-- apei.c
|-- core.c
|-- dev-mcelog.c
|-- genpool.c
|-- inject.c
|-- intel.c
|-- internal.h
|-- Makefile
|-- p5.c
|-- severity.c
|-- therm_throt.c
|-- threshold.c
`-- winchip.c

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/Makefile                           |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/Makefile           | 10 +++++-----
 arch/x86/kernel/cpu/{mcheck/mce_amd.c => mce/amd.c}    |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce-apei.c => mce/apei.c}  |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce.c => mce/core.c}       |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/dev-mcelog.c       |  2 +-
 .../kernel/cpu/{mcheck/mce-genpool.c => mce/genpool.c} |  2 +-
 .../kernel/cpu/{mcheck/mce-inject.c => mce/inject.c}   |  2 +-
 .../x86/kernel/cpu/{mcheck/mce_intel.c => mce/intel.c} |  2 +-
 .../cpu/{mcheck/mce-internal.h => mce/internal.h}      |  0
 arch/x86/kernel/cpu/{mcheck => mce}/p5.c               |  0
 .../cpu/{mcheck/mce-severity.c => mce/severity.c}      |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/therm_throt.c      |  0
 arch/x86/kernel/cpu/{mcheck => mce}/threshold.c        |  0
 arch/x86/kernel/cpu/{mcheck => mce}/winchip.c          |  0
 15 files changed, 14 insertions(+), 14 deletions(-)
 rename arch/x86/kernel/cpu/{mcheck => mce}/Makefile (52%)
 rename arch/x86/kernel/cpu/{mcheck/mce_amd.c => mce/amd.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce-apei.c => mce/apei.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce.c => mce/core.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/dev-mcelog.c (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce-genpool.c => mce/genpool.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce-inject.c => mce/inject.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce_intel.c => mce/intel.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce-internal.h => mce/internal.h} (100%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/p5.c (100%)
 rename arch/x86/kernel/cpu/{mcheck/mce-severity.c => mce/severity.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/therm_throt.c (100%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/threshold.c (100%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/winchip.c (100%)

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 1f5d2291c31e..43afe707c6fb 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -40,7 +40,7 @@ obj-$(CONFIG_INTEL_RDT)	+= intel_rdt.o intel_rdt_rdtgroup.o intel_rdt_monitor.o
 obj-$(CONFIG_INTEL_RDT)	+= intel_rdt_ctrlmondata.o intel_rdt_pseudo_lock.o
 CFLAGS_intel_rdt_pseudo_lock.o = -I$(src)
 
-obj-$(CONFIG_X86_MCE)			+= mcheck/
+obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
 obj-$(CONFIG_MICROCODE)			+= microcode/
 
diff --git a/arch/x86/kernel/cpu/mcheck/Makefile b/arch/x86/kernel/cpu/mce/Makefile
similarity index 52%
rename from arch/x86/kernel/cpu/mcheck/Makefile
rename to arch/x86/kernel/cpu/mce/Makefile
index bcc7c54c7041..765759765ab7 100644
--- a/arch/x86/kernel/cpu/mcheck/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y				=  mce.o mce-severity.o mce-genpool.o
+obj-y				=  core.o severity.o genpool.o
 
 obj-$(CONFIG_X86_ANCIENT_MCE)	+= winchip.o p5.o
-obj-$(CONFIG_X86_MCE_INTEL)	+= mce_intel.o
-obj-$(CONFIG_X86_MCE_AMD)	+= mce_amd.o
+obj-$(CONFIG_X86_MCE_INTEL)	+= intel.o
+obj-$(CONFIG_X86_MCE_AMD)	+= amd.o
 obj-$(CONFIG_X86_MCE_THRESHOLD) += threshold.o
-obj-$(CONFIG_X86_MCE_INJECT)	+= mce-inject.o
+obj-$(CONFIG_X86_MCE_INJECT)	+= inject.o
 
 obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
 
-obj-$(CONFIG_ACPI_APEI)		+= mce-apei.o
+obj-$(CONFIG_ACPI_APEI)		+= apei.o
 
 obj-$(CONFIG_X86_MCELOG_LEGACY)	+= dev-mcelog.o
diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mce/amd.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce_amd.c
rename to arch/x86/kernel/cpu/mce/amd.c
index dd33c357548f..782bf1d2b102 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -28,7 +28,7 @@
 #include <asm/msr.h>
 #include <asm/trace/irq_vectors.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 #define NR_BLOCKS         5
 #define THRESHOLD_MAX     0xFFF
diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/cpu/mce/apei.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce-apei.c
rename to arch/x86/kernel/cpu/mce/apei.c
index 2eee85379689..1d9b3ce662a0 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -36,7 +36,7 @@
 #include <acpi/ghes.h>
 #include <asm/mce.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 {
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mce/core.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce.c
rename to arch/x86/kernel/cpu/mce/core.c
index 8c66d2fc8f81..3b2f2d399d6c 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -52,7 +52,7 @@
 #include <asm/msr.h>
 #include <asm/reboot.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 static DEFINE_MUTEX(mce_log_mutex);
 
diff --git a/arch/x86/kernel/cpu/mcheck/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/dev-mcelog.c
rename to arch/x86/kernel/cpu/mce/dev-mcelog.c
index 27f394ac983f..41d9169d27fa 100644
--- a/arch/x86/kernel/cpu/mcheck/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -15,7 +15,7 @@
 #include <linux/kmod.h>
 #include <linux/poll.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 static BLOCKING_NOTIFIER_HEAD(mce_injector_chain);
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce-genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce-genpool.c
rename to arch/x86/kernel/cpu/mce/genpool.c
index 217cd4449bc9..3395549c51d3 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -10,7 +10,7 @@
 #include <linux/mm.h>
 #include <linux/genalloc.h>
 #include <linux/llist.h>
-#include "mce-internal.h"
+#include "internal.h"
 
 /*
  * printk() is not safe in MCE context. This is a lock-less memory allocator
diff --git a/arch/x86/kernel/cpu/mcheck/mce-inject.c b/arch/x86/kernel/cpu/mce/inject.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce-inject.c
rename to arch/x86/kernel/cpu/mce/inject.c
index 1fc424c40a31..8492ef7d9015 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -38,7 +38,7 @@
 #include <asm/nmi.h>
 #include <asm/smp.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 /*
  * Collect all the MCi_XXX settings
diff --git a/arch/x86/kernel/cpu/mcheck/mce_intel.c b/arch/x86/kernel/cpu/mce/intel.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce_intel.c
rename to arch/x86/kernel/cpu/mce/intel.c
index d05be307d081..e43eb6732630 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -18,7 +18,7 @@
 #include <asm/msr.h>
 #include <asm/mce.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 /*
  * Support for Intel Correct Machine Check Interrupts. This allows
diff --git a/arch/x86/kernel/cpu/mcheck/mce-internal.h b/arch/x86/kernel/cpu/mce/internal.h
similarity index 100%
rename from arch/x86/kernel/cpu/mcheck/mce-internal.h
rename to arch/x86/kernel/cpu/mce/internal.h
diff --git a/arch/x86/kernel/cpu/mcheck/p5.c b/arch/x86/kernel/cpu/mce/p5.c
similarity index 100%
rename from arch/x86/kernel/cpu/mcheck/p5.c
rename to arch/x86/kernel/cpu/mce/p5.c
diff --git a/arch/x86/kernel/cpu/mcheck/mce-severity.c b/arch/x86/kernel/cpu/mce/severity.c
similarity index 99%
rename from arch/x86/kernel/cpu/mcheck/mce-severity.c
rename to arch/x86/kernel/cpu/mce/severity.c
index 44396d521987..dc3e26e905a3 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -16,7 +16,7 @@
 #include <asm/mce.h>
 #include <linux/uaccess.h>
 
-#include "mce-internal.h"
+#include "internal.h"
 
 /*
  * Grade an mce by severity. In general the most severe ones are processed
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
similarity index 100%
rename from arch/x86/kernel/cpu/mcheck/therm_throt.c
rename to arch/x86/kernel/cpu/mce/therm_throt.c
diff --git a/arch/x86/kernel/cpu/mcheck/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
similarity index 100%
rename from arch/x86/kernel/cpu/mcheck/threshold.c
rename to arch/x86/kernel/cpu/mce/threshold.c
diff --git a/arch/x86/kernel/cpu/mcheck/winchip.c b/arch/x86/kernel/cpu/mce/winchip.c
similarity index 100%
rename from arch/x86/kernel/cpu/mcheck/winchip.c
rename to arch/x86/kernel/cpu/mce/winchip.c
-- 
2.19.1


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
