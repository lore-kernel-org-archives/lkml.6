Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B67FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0848520827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cwMRhWsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0848520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeKJGev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:34:51 -0500
Received: from mail-eopbgr740074.outbound.protection.outlook.com ([40.107.74.74]:39808
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbeKJGeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4I264eMYhDzfch/VEK7Il6J8jmO5IwvUK3o14NbQWg=;
 b=cwMRhWsqX6p80PW2VIfRhKshJlzFc8tD68JhK6RITwY+dmv8wo5zyOXvlpn641slLHv9tbTOb8EULOKS4BQR0G2hNxvpM5H+kfTRcmEXfbLYYVMkavAc9aZzPYr1F7aSXyGJSx9tKi186pwf3VT9cO4dz8BFEHiKMixp0AH5qc0=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1675.namprd12.prod.outlook.com (10.172.40.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.23; Fri, 9 Nov 2018 20:52:25 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 20:52:25 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
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
        "Moger, Babu" <Babu.Moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH v7 01/13] arch/x86: Start renaming the rdt files to more
 generic names
Thread-Topic: [PATCH v7 01/13] arch/x86: Start renaming the rdt files to more
 generic names
Thread-Index: AQHUeG4ehNbhFjGDFkObyLvWcXYs0A==
Date:   Fri, 9 Nov 2018 20:52:25 +0000
Message-ID: <20181109205153.14811-2-babu.moger@amd.com>
References: <20181109205153.14811-1-babu.moger@amd.com>
In-Reply-To: <20181109205153.14811-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0005.namprd07.prod.outlook.com
 (2603:10b6:803:28::15) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1675;20:9bkZrK1jnTLzVWTTk/8OhUxY2DCwD2ZAM7e363gNGmrSIhgROuzbHkBp4zPDB/kOPvw36fVrnMndrYqSd34IrJO3eLkuLMygjohcpI4kn/lGgUuta101l1T2VnD8o8WjYD7M4MZMwYgDzsFHpPcZkbnMXHgM0f51B/ZQNFv+sfNfut3EZVqSEMLJtUjzAFzUOM8qAr7PSOKYaN39/nC39c+duD6Sfls8nN2uwCfCca/vprW+3lMG5phOATAmjavu
x-ms-office365-filtering-correlation-id: 239fbbfe-85b4-42f7-f5f1-08d6468540a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1675;
x-ms-traffictypediagnostic: DM5PR12MB1675:
x-microsoft-antispam-prvs: <DM5PR12MB1675F39ABCB37F64E9E5445195C60@DM5PR12MB1675.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1675;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1675;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(305945005)(4326008)(14454004)(6116002)(66066001)(72206003)(36756003)(105586002)(6486002)(3846002)(6436002)(102836004)(386003)(6506007)(6512007)(478600001)(99286004)(2906002)(5660300001)(25786009)(86362001)(2900100001)(68736007)(575784001)(2501003)(2201001)(26005)(11346002)(7406005)(81156014)(446003)(81166006)(486006)(476003)(2616005)(186003)(1076002)(52116002)(53936002)(8936002)(7736002)(106356001)(14444005)(256004)(110136005)(71200400001)(76176011)(71190400001)(8676002)(54906003)(316002)(7416002)(97736004)(41533002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1675;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FKqXb2MRu8y8quI/RCTa4gYAsnOJY4tGVOeCtDEDOumDrGNbsTVJrp/IrU8w1qdPePVf8FqRxRikIFNsIutixQkhM+QOSru5hVLUrbuWcVBWjlnq0w/clFS4AwHxTBDyBBjRq62OiIwPUeeo58wbyMcrRpfE1scHZygP/xpcpnDVAg+WJLPmgsMF9pNXxiD0nss0oWQ8J5NdXdfyfjV8OkKZo2EhHe48z9Q5sNAo7KkS09M9uaG1zxJKoY7KpuTPQYt5h2GXr6UkHPkqZ+yIqQofH+iZFciB7IKOCW7lViaisQp71nJU3HAQaU/D2UVVvZGsV1lb4dkm6Qi2eSyjYjYRXE4lhqixpxvmdgV83lU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239fbbfe-85b4-42f7-f5f1-08d6468540a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 20:52:25.0628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New generation of AMD processors start supporting RDT(or QOS) features.
With more than one vendors supporting these features, it seems more
appropriate to rename these files.

Changed intel_rdt to resctrl where applicable.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/{intel_rdt_sched.h =3D> resctrl_sched.h} | 0
 arch/x86/kernel/cpu/Makefile                                | 6 +++---
 arch/x86/kernel/cpu/{intel_rdt.c =3D> resctrl.c}              | 4 ++--
 arch/x86/kernel/cpu/{intel_rdt.h =3D> resctrl.h}              | 6 +++---
 .../cpu/{intel_rdt_ctrlmondata.c =3D> resctrl_ctrlmondata.c}  | 2 +-
 .../kernel/cpu/{intel_rdt_monitor.c =3D> resctrl_monitor.c}   | 2 +-
 .../cpu/{intel_rdt_pseudo_lock.c =3D> resctrl_pseudo_lock.c}  | 6 +++---
 ..._rdt_pseudo_lock_event.h =3D> resctrl_pseudo_lock_event.h} | 2 +-
 .../kernel/cpu/{intel_rdt_rdtgroup.c =3D> resctrl_rdtgroup.c} | 4 ++--
 arch/x86/kernel/process_32.c                                | 2 +-
 arch/x86/kernel/process_64.c                                | 2 +-
 11 files changed, 18 insertions(+), 18 deletions(-)
 rename arch/x86/include/asm/{intel_rdt_sched.h =3D> resctrl_sched.h} (100%=
)
 rename arch/x86/kernel/cpu/{intel_rdt.c =3D> resctrl.c} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt.h =3D> resctrl.h} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c =3D> resctrl_ctrlmonda=
ta.c} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_monitor.c =3D> resctrl_monitor.c} (9=
9%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c =3D> resctrl_pseudo_lo=
ck.c} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h =3D> resctrl_pse=
udo_lock_event.h} (95%)
 rename arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c =3D> resctrl_rdtgroup.c} =
(99%)

diff --git a/arch/x86/include/asm/intel_rdt_sched.h b/arch/x86/include/asm/=
resctrl_sched.h
similarity index 100%
rename from arch/x86/include/asm/intel_rdt_sched.h
rename to arch/x86/include/asm/resctrl_sched.h
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 347137e80bf5..222cf8cc078d 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -35,9 +35,9 @@ obj-$(CONFIG_CPU_SUP_CENTAUR)		+=3D centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+=3D transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+=3D umc.o
=20
-obj-$(CONFIG_INTEL_RDT)	+=3D intel_rdt.o intel_rdt_rdtgroup.o intel_rdt_mo=
nitor.o
-obj-$(CONFIG_INTEL_RDT)	+=3D intel_rdt_ctrlmondata.o intel_rdt_pseudo_lock=
.o
-CFLAGS_intel_rdt_pseudo_lock.o =3D -I$(src)
+obj-$(CONFIG_INTEL_RDT)	+=3D resctrl.o resctrl_rdtgroup.o resctrl_monitor.=
o
+obj-$(CONFIG_INTEL_RDT)	+=3D resctrl_ctrlmondata.o resctrl_pseudo_lock.o
+CFLAGS_resctrl_pseudo_lock.o =3D -I$(src)
=20
 obj-$(CONFIG_X86_MCE)			+=3D mcheck/
 obj-$(CONFIG_MTRR)			+=3D mtrr/
diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/resctrl.=
c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt.c
rename to arch/x86/kernel/cpu/resctrl.c
index 44272b7107ad..3f1a135a4ae0 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/resctrl.c
@@ -30,8 +30,8 @@
 #include <linux/cpuhotplug.h>
=20
 #include <asm/intel-family.h>
-#include <asm/intel_rdt_sched.h>
-#include "intel_rdt.h"
+#include <asm/resctrl_sched.h>
+#include "resctrl.h"
=20
 #define MBA_IS_LINEAR	0x4
 #define MBA_MAX_MBPS	U32_MAX
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/resctrl.=
h
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt.h
rename to arch/x86/kernel/cpu/resctrl.h
index 3736f6dc9545..a9d906767bb2 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/resctrl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_INTEL_RDT_H
-#define _ASM_X86_INTEL_RDT_H
+#ifndef _ASM_X86_RESCTRL_H
+#define _ASM_X86_RESCTRL_H
=20
 #include <linux/sched.h>
 #include <linux/kernfs.h>
@@ -568,4 +568,4 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
=20
-#endif /* _ASM_X86_INTEL_RDT_H */
+#endif /* _ASM_X86_RESCTRL_H */
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/=
cpu/resctrl_ctrlmondata.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
rename to arch/x86/kernel/cpu/resctrl_ctrlmondata.c
index 27937458c231..e8d21306d0f9 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl_ctrlmondata.c
@@ -26,7 +26,7 @@
 #include <linux/kernfs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
-#include "intel_rdt.h"
+#include "resctrl.h"
=20
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
diff --git a/arch/x86/kernel/cpu/intel_rdt_monitor.c b/arch/x86/kernel/cpu/=
resctrl_monitor.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_monitor.c
rename to arch/x86/kernel/cpu/resctrl_monitor.c
index b0f3aed76b75..211d97bcbde5 100644
--- a/arch/x86/kernel/cpu/intel_rdt_monitor.c
+++ b/arch/x86/kernel/cpu/resctrl_monitor.c
@@ -26,7 +26,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
-#include "intel_rdt.h"
+#include "resctrl.h"
=20
 #define MSR_IA32_QM_CTR		0x0c8e
 #define MSR_IA32_QM_EVTSEL		0x0c8d
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/=
cpu/resctrl_pseudo_lock.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
rename to arch/x86/kernel/cpu/resctrl_pseudo_lock.c
index 966ac0c20d67..f9c15fafd467 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl_pseudo_lock.c
@@ -24,14 +24,14 @@
=20
 #include <asm/cacheflush.h>
 #include <asm/intel-family.h>
-#include <asm/intel_rdt_sched.h>
+#include <asm/resctrl_sched.h>
 #include <asm/perf_event.h>
=20
 #include "../../events/perf_event.h" /* For X86_CONFIG() */
-#include "intel_rdt.h"
+#include "resctrl.h"
=20
 #define CREATE_TRACE_POINTS
-#include "intel_rdt_pseudo_lock_event.h"
+#include "resctrl_pseudo_lock_event.h"
=20
 /*
  * MSR_MISC_FEATURE_CONTROL register enables the modification of hardware
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h b/arch/x86/k=
ernel/cpu/resctrl_pseudo_lock_event.h
similarity index 95%
rename from arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
rename to arch/x86/kernel/cpu/resctrl_pseudo_lock_event.h
index 2c041e6d9f05..d354851ed66c 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
+++ b/arch/x86/kernel/cpu/resctrl_pseudo_lock_event.h
@@ -39,5 +39,5 @@ TRACE_EVENT(pseudo_lock_l3,
=20
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE intel_rdt_pseudo_lock_event
+#define TRACE_INCLUDE_FILE resctrl_pseudo_lock_event
 #include <trace/define_trace.h>
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu=
/resctrl_rdtgroup.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
rename to arch/x86/kernel/cpu/resctrl_rdtgroup.c
index f27b8115ffa2..6308ba3905e5 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl_rdtgroup.c
@@ -35,8 +35,8 @@
=20
 #include <uapi/linux/magic.h>
=20
-#include <asm/intel_rdt_sched.h>
-#include "intel_rdt.h"
+#include <asm/resctrl_sched.h>
+#include "resctrl.h"
=20
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5046a3c9dec2..d16207e7d1e5 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -56,7 +56,7 @@
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
-#include <asm/intel_rdt_sched.h>
+#include <asm/resctrl_sched.h>
 #include <asm/proto.h>
=20
 void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ea5ea850348d..af73223ad6ba 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -52,7 +52,7 @@
 #include <asm/switch_to.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
-#include <asm/intel_rdt_sched.h>
+#include <asm/resctrl_sched.h>
 #include <asm/unistd.h>
 #ifdef CONFIG_IA32_EMULATION
 /* Not included via unistd.h */
--=20
2.17.1

