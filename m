Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1141DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEEB2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wzT5G73r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEEB2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbeIYBXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:23:02 -0400
Received: from mail-eopbgr710062.outbound.protection.outlook.com ([40.107.71.62]:19302
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732945AbeIYBXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk+a4Kcm6mD5e9Sc13447C3da+Mfpv57EYm8oU5Jvk4=;
 b=wzT5G73r06+MmqwP5rHmvo/m5PW1ouf67Fe1wD5gJv0yVLb24X/iZcLGuRa8EA1UX/VZfgGwk8PTg5lxe4GtZh7XPYm+0pDxW2ghKUdMDNza8Dg3aiXQHQmxX1SJzPAPjNNvhr2nhBt7XE8n3cWnRvAx3PHq6SL7SbHbeBSSxOg=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2455.namprd12.prod.outlook.com (52.132.141.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 19:19:16 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de%5]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 19:19:16 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 10/10] arch/x86: Introduce QOS feature for AMD
Thread-Topic: [RFC PATCH 10/10] arch/x86: Introduce QOS feature for AMD
Thread-Index: AQHUVDt7FEaq7WNkoUWHOChzTz42MQ==
Date:   Mon, 24 Sep 2018 19:19:16 +0000
Message-ID: <20180924191841.29111-11-babu.moger@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
In-Reply-To: <20180924191841.29111-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:805:16::22) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2455;20:DHMfZQmXhUUWKCYV8/1fgL2zUxNKFIpxLoDI6q4jNs44I/9nyS93TJLbFPNE8kF7me5vSyd90yl8KoTKdAUJV1cyGZbSOgWe/ghN1qxKC8GWpFQMG68l+F21AZqDN4g0nPhfY0VdnRtckKHlGasrNZJPYFd4kYY8iLC5Bfz3+r/+3NVdkZFHyvBsxnAAno90xOZTtpb8rUMop9n3dLjG9urw9q2hn9l905Fn473s4xFx8rfQTlhM5WF962nPmhKV
x-ms-office365-filtering-correlation-id: 03962e79-a323-4fc9-bc55-08d622529e39
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2455;
x-ms-traffictypediagnostic: DM5PR12MB2455:
x-microsoft-antispam-prvs: <DM5PR12MB2455B67E943A13155A76371D95170@DM5PR12MB2455.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(269456686620040)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB2455;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2455;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(39860400002)(136003)(346002)(366004)(396003)(376002)(43544003)(189003)(199004)(97736004)(217873002)(256004)(14444005)(2501003)(5250100002)(316002)(2900100001)(52116002)(7736002)(68736007)(305945005)(5660300001)(1076002)(76176011)(386003)(66066001)(6506007)(478600001)(72206003)(25786009)(7416002)(14454004)(4326008)(6436002)(106356001)(8936002)(8676002)(81156014)(81166006)(6512007)(36756003)(53936002)(26005)(2906002)(3846002)(6116002)(6486002)(575784001)(54906003)(86362001)(110136005)(102836004)(186003)(2201001)(486006)(71200400001)(446003)(476003)(11346002)(99286004)(2616005)(71190400001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2455;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QtbPzjCh4nIn+I6yqudE4ENH+hxxiEWUn+6bEcui/RrZIkdV77kf819xQDe4MC/JCxIRWsSt1iL+/iWEu0QhuXQe39E5DqnAvNf8uLCo9HjA+rfrOAAXhdQG0NuLa93RUH2V3axPU7PVUveRf1iTwVqFQpCcglphhAeDvFJeyyxgYCIzWEbDwjyRLWdieMBxGRl9oSNup9hJu88hBLoSUqUffAf3GuVx80L2fP3elitCWaXTrstrSHFWwFxFVexi0fm8baJHHP1NcuY1iytM7228KPpXtGqHodcpiBFuTgXXujwxjXmqP/n5CFplAQ0O/gwUXMVucgErIKFXNljqqutHYCNhTcfDqqzvvu/v6kY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03962e79-a323-4fc9-bc55-08d622529e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 19:19:16.1223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables QOS feature on AMD.
Following QoS sub-features are supported in AMD if the underlying
hardware supports it.
 - L3 Cache allocation enforcement
 - L3 Cache occupancy monitoring
 - L3 Code-Data Prioritization support
 - Memory Bandwidth Enforcement(Allocation)

There are differences in the way some of the features are implemented.
Separate those functions and add those as vendor specific functions.
The major difference is in MBA feature.
 - AMD uses CPUID leaf 0x80000020 to initialize the MBA features.
 - AMD uses direct bandwidth value instead of delay based on bandwidth
   values.
 - MSR register base addresses are different for MBA.
 - Also AMD allows non-contiguous L3 cache bit masks.

Adds following functions to take care of the differences.
rdt_get_mem_config_amd : MBA initialization function
parse_bw_amd : Bandwidth parsing
mba_wrmsr_amd: Writes bandwidth value
cbm_validate_amd : L3 cache bitmask validation

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/rdt.c             | 70 ++++++++++++++++++++++-
 arch/x86/kernel/cpu/rdt.h             |  3 +
 arch/x86/kernel/cpu/rdt_ctrlmondata.c | 81 +++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/rdt.c b/arch/x86/kernel/cpu/rdt.c
index ae26b9b3fafa..21c17893cc0a 100644
--- a/arch/x86/kernel/cpu/rdt.c
+++ b/arch/x86/kernel/cpu/rdt.c
@@ -35,6 +35,7 @@
=20
 #define MBA_IS_LINEAR	0x4
 #define MBA_MAX_MBPS	U32_MAX
+#define MAX_MBA_BW_AMD 0x800
=20
 /* Mutex to protect rdtgroup access. */
 DEFINE_MUTEX(rdtgroup_mutex);
@@ -63,6 +64,9 @@ static void
 mba_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *=
r);
 static void
 cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *=
r);
+static void
+mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
+	      struct rdt_resource *r);
=20
 #define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].domains)
=20
@@ -282,6 +286,31 @@ static bool rdt_get_mem_config(struct rdt_resource *r)
 	return true;
 }
=20
+static bool rdt_get_mem_config_amd(struct rdt_resource *r)
+{
+	union cpuid_0x10_3_eax eax;
+	union cpuid_0x10_x_edx edx;
+	u32 ebx, ecx;
+
+	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);
+	r->num_closid =3D edx.split.cos_max + 1;
+	r->default_ctrl =3D MAX_MBA_BW_AMD;
+
+	/* AMD does not use delay. Set delay_linear to false by default */
+	r->membw.delay_linear =3D false;
+
+	/* FIX ME - May need to be read from MSR */
+	r->membw.min_bw =3D 0;
+	r->membw.bw_gran =3D 1;
+	/* Max value is 2048, Data width should be 4 in decimal */
+	r->data_width =3D 4;
+
+	r->alloc_capable =3D true;
+	r->alloc_enabled =3D true;
+
+	return true;
+}
+
 static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 {
 	union cpuid_0x10_1_eax eax;
@@ -341,6 +370,16 @@ static int get_cache_id(int cpu, int level)
 	return -1;
 }
=20
+static void
+mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resour=
ce *r)
+{
+	unsigned int i;
+
+	/*  Write the bw values for mba. */
+	for (i =3D m->low; i < m->high; i++)
+		wrmsrl(r->msr_base + i, d->ctrl_val[i]);
+}
+
 /*
  * Map the memory b/w percentage value to delay values
  * that can be written to QOS_MSRs.
@@ -858,8 +897,12 @@ static __init void rdt_detect_l3_mon(void)
=20
 static __init void rdt_check_mba(void)
 {
-	if (rdt_cpu_has(X86_FEATURE_MBA))
-		rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
+	if (rdt_cpu_has(X86_FEATURE_MBA)) {
+		if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+			rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
+		else if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
+			rdt_get_mem_config_amd(&rdt_resources_all[RDT_RESOURCE_MBA]);
+	}
 }
=20
 static __init void rdt_init_res_defs_intel(void)
@@ -884,10 +927,33 @@ static __init void rdt_init_res_defs_intel(void)
 	}
 }
=20
+static __init void rdt_init_res_defs_amd(void)
+{
+	struct rdt_resource *r;
+
+	for_each_rdt_resource(r) {
+		if ((r->rid =3D=3D RDT_RESOURCE_L3) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L3DATA) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L3CODE) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L2) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L2DATA) ||
+		    (r->rid =3D=3D RDT_RESOURCE_L2CODE))
+			r->cbm_validate =3D cbm_validate_amd;
+
+		else if (r->rid =3D=3D RDT_RESOURCE_MBA) {
+			 r->msr_base =3D IA32_MBA_BW_BASE;
+			 r->msr_update =3D mba_wrmsr_amd;
+			 r->parse_ctrlval =3D parse_bw_amd;
+		}
+	}
+}
+
 static __init void rdt_init_res_defs(void)
 {
 	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
 		rdt_init_res_defs_intel();
+	else if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
+		rdt_init_res_defs_amd();
 }
=20
 static enum cpuhp_state rdt_online;
diff --git a/arch/x86/kernel/cpu/rdt.h b/arch/x86/kernel/cpu/rdt.h
index 7205157d359b..e0244ac071e4 100644
--- a/arch/x86/kernel/cpu/rdt.h
+++ b/arch/x86/kernel/cpu/rdt.h
@@ -11,6 +11,7 @@
 #define IA32_L3_CBM_BASE	0xc90
 #define IA32_L2_CBM_BASE	0xd10
 #define IA32_MBA_THRTL_BASE	0xd50
+#define IA32_MBA_BW_BASE	0xc0000200
=20
 #define L3_QOS_CDP_ENABLE	0x01ULL
=20
@@ -438,6 +439,7 @@ struct rdt_resource {
=20
 int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d);
 int parse_bw(void *_buf, struct rdt_resource *r,  struct rdt_domain *d);
+int parse_bw_amd(void *_buf, struct rdt_resource *r,  struct rdt_domain *d=
);
=20
 extern struct mutex rdtgroup_mutex;
=20
@@ -569,5 +571,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_d=
omain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm);
 bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r);
+bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
=20
 #endif /* _ASM_X86_RDT_H */
diff --git a/arch/x86/kernel/cpu/rdt_ctrlmondata.c b/arch/x86/kernel/cpu/rd=
t_ctrlmondata.c
index 5a282b6c4bd7..1e4631f88696 100644
--- a/arch/x86/kernel/cpu/rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/rdt_ctrlmondata.c
@@ -28,6 +28,52 @@
 #include <linux/slab.h>
 #include "rdt.h"
=20
+/*
+ * Check whether MBA bandwidth percentage value is correct. The value is
+ * checked against the minimum and max bandwidth values specified by the
+ * hardware. The allocated bandwidth percentage is rounded to the next
+ * control step available on the hardware.
+ */
+static bool bw_validate_amd(char *buf, unsigned long *data,
+			    struct rdt_resource *r)
+{
+	unsigned long bw;
+	int ret;
+
+	ret =3D kstrtoul(buf, 10, &bw);
+	if (ret) {
+		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
+		return false;
+	}
+
+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
+		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
+				    r->membw.min_bw, r->default_ctrl);
+		return false;
+	}
+
+	*data =3D roundup(bw, (unsigned long)r->membw.bw_gran);
+	return true;
+}
+
+int parse_bw_amd(void *_buf, struct rdt_resource *r, struct rdt_domain *d)
+{
+	unsigned long data;
+	char *buf =3D _buf;
+
+	if (d->have_new_ctrl) {
+		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
+		return -EINVAL;
+	}
+
+	if (!bw_validate_amd(buf, &data, r))
+		return -EINVAL;
+	d->new_ctrl =3D data;
+	d->have_new_ctrl =3D true;
+
+	return 0;
+}
+
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
  * checked against the minimum and max bandwidth values specified by the
@@ -123,6 +169,41 @@ bool cbm_validate(char *buf, u32 *data, struct rdt_res=
ource *r)
 	return true;
 }
=20
+/*
+ * Check whether a cache bit mask is valid. AMD allows
+ * non-contiguous masks.
+ */
+bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r)
+{
+	unsigned long first_bit, zero_bit, val;
+	unsigned int cbm_len =3D r->cache.cbm_len;
+	int ret;
+
+	ret =3D kstrtoul(buf, 16, &val);
+	if (ret) {
+		rdt_last_cmd_printf("non-hex character in mask %s\n", buf);
+		return false;
+	}
+
+	if (val =3D=3D 0 || val > r->default_ctrl) {
+		rdt_last_cmd_puts("mask out of range\n");
+		return false;
+	}
+
+	first_bit =3D find_first_bit(&val, cbm_len);
+	zero_bit =3D find_next_zero_bit(&val, cbm_len, first_bit);
+
+
+	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
+		rdt_last_cmd_printf("Need at least %d bits in mask\n",
+				    r->cache.min_cbm_bits);
+		return false;
+	}
+
+	*data =3D val;
+	return true;
+}
+
 struct rdt_cbm_parse_data {
 	struct rdtgroup		*rdtgrp;
 	char			*buf;
--=20
2.17.1

