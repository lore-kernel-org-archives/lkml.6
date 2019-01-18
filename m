Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEC1C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279802087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ek024r4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfARS1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:27:25 -0500
Received: from mail-eopbgr790057.outbound.protection.outlook.com ([40.107.79.57]:56814
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729102AbfARS1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csku/qK7hd8ZoFIvf7O7lTUDMQHd0H8w1bej8qLYFok=;
 b=ek024r4OpjWJnE08YHl6yI4J2gPTPqlaI/hT+RlHO5bnrxGAOfk2zTnTnlCTx4DNdEDsTwGCVs52F7DTc1kLOxSwHbVVWYy5rFQRHrBhXmPiLCcPjYCgwf5Be77xzB6/nf0Cfjq9FZ1OxOianCA6JH7r2xL4rMcL8wfVNmOM0to=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1737.namprd12.prod.outlook.com (10.175.89.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 18:27:15 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:27:15 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "sai.praneeth.prakhya@intel.com" <sai.praneeth.prakhya@intel.com>,
        "arshiya.hayatkhan.pathan@intel.com" 
        <arshiya.hayatkhan.pathan@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: [PATCH v5 11/13] selftests/resctrl: Add vendor detection mechanism
Thread-Topic: [PATCH v5 11/13] selftests/resctrl: Add vendor detection
 mechanism
Thread-Index: AQHUr1tvBMGnddDBJEG8QhQMFdIGjg==
Date:   Fri, 18 Jan 2019 18:27:15 +0000
Message-ID: <20190118182646.16594-12-babu.moger@amd.com>
References: <20190118182646.16594-1-babu.moger@amd.com>
In-Reply-To: <20190118182646.16594-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0014.namprd04.prod.outlook.com
 (2603:10b6:803:21::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1737;20:XhL3NqBqr0GgaWkLt+B44yKCPmPT85TJy4E2ZUZW8quI7YB91t6Nn3sfY9bt8aarfgouT5N0uQuumWB5kM/YM2VfCTFcC+YF0v+HKpiO86fbEj01tvTU5VuaS48J4975CHy9RfopSZQntoQU/Xb6hSsgr/NW6YqTb4ao0JuQaa7gfCpi222OZUC8gep9YCVQbJhz6a732w6ld9prfMwZhnKt+MTiYaqSTm6mBE153zfEs2z3xWTGI/JstQ4z7VZR
x-ms-office365-filtering-correlation-id: abcebf74-7421-465c-f617-08d67d729232
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1737;
x-ms-traffictypediagnostic: DM5PR12MB1737:
x-microsoft-antispam-prvs: <DM5PR12MB173775240D9E0D1FD5EFB341959C0@DM5PR12MB1737.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(54906003)(50226002)(6512007)(8676002)(6436002)(99286004)(1076003)(110136005)(53936002)(6486002)(7416002)(25786009)(8936002)(36756003)(26005)(4326008)(186003)(81156014)(316002)(6116002)(81166006)(3846002)(6346003)(476003)(71200400001)(105586002)(2616005)(68736007)(2906002)(71190400001)(14454004)(106356001)(486006)(2201001)(14444005)(6506007)(5660300001)(97736004)(102836004)(72206003)(256004)(11346002)(2501003)(7736002)(86362001)(52116002)(66066001)(478600001)(305945005)(76176011)(386003)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1737;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ELM8zQIRS3SARqvz6g6V1rI4+crrtixZCYIWshWnogqMeGisgR+pPzxyZ/a55fpfWS9HLqdL1JCCW2HT8ERkToFMSS7kYT1bZnJKCrYqQEb80ecXFwL+VkVf+OQbG4rhHYBV/3GLogk79rrUZChhIXbzZgqtxQoiyjOx1iYls1PJ8yt2xYfGcBVaqwRqBvvujRMGizfDEkcksis288NSi4izU/fk3gBwD9ZcvkSleI+Lwx81Tk0mAP20Fx6Oile2E+43B+bm9RDwRejtV5h5OsRs+EnlJPtF5h4c3rQHs+WS9S1grlRdp79mNhitz9oxZtnC05YG9gcHv/rdiWSPUhhKm+HVeRDgbGjp5IYeGn/UnDij0ex1K+OloveWW4+wExKu/zlBGwjHHGu0mUvGckV3NpJlSFW4zkv1soktp9U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcebf74-7421-465c-f617-08d67d729232
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:27:14.3935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RESCTRL feature is supported both on Intel and AMD now. Some features
are implemented differently. Add vendor detection mechanism. Use the vendor
check where there are differences.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/resctrl.h       | 13 +++++
 tools/testing/selftests/resctrl/resctrl_tests.c | 68 +++++++++++++++++++++=
++++
 2 files changed, 81 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/self=
tests/resctrl/resctrl.h
index 3da2afe..1ec97d1 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -63,10 +63,23 @@ struct resctrl_val_param {
=20
 };
=20
+/**
+ * Results of CPUID operation are stored in this structure.
+ * It consists of 4x32bits IA registers: EAX, EBX, ECX and EDX.
+ */
+struct cpuid_out {
+        uint32_t eax;
+        uint32_t ebx;
+        uint32_t ecx;
+        uint32_t edx;
+};
+
 pid_t bm_pid, ppid;
 extern char cbm_mask[256];
 extern unsigned long long_mask;
 extern char llc_occup_path[1024];
+extern int genuine_intel;
+extern int authentic_amd;
=20
 int remount_resctrlfs(bool mum_resctrlfs);
 int get_resource_id(int cpu_no, int *resource_id);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testin=
g/selftests/resctrl/resctrl_tests.c
index 2397c3b..e8cbcd5 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -14,6 +14,69 @@
 #define BENCHMARK_ARGS		64
 #define BENCHMARK_ARG_SIZE	64
=20
+/**
+ * This variables provides information about the vendor
+ */
+int genuine_intel =3D 0;
+int authentic_amd =3D 0;
+
+void
+lcpuid(const unsigned leaf,
+       const unsigned subleaf,
+       struct cpuid_out *out)
+{
+        if (out =3D=3D NULL)
+                return;
+
+#ifdef __x86_64__
+        asm volatile("mov %4, %%eax\n\t"
+                     "mov %5, %%ecx\n\t"
+                     "cpuid\n\t"
+                     "mov %%eax, %0\n\t"
+                     "mov %%ebx, %1\n\t"
+                     "mov %%ecx, %2\n\t"
+                     "mov %%edx, %3\n\t"
+                     : "=3Dg" (out->eax), "=3Dg" (out->ebx), "=3Dg" (out->=
ecx),
+                       "=3Dg" (out->edx)
+                     : "g" (leaf), "g" (subleaf)
+                     : "%eax", "%ebx", "%ecx", "%edx");
+#else
+        asm volatile("push %%ebx\n\t"
+                     "mov %4, %%eax\n\t"
+                     "mov %5, %%ecx\n\t"
+                     "cpuid\n\t"
+                     "mov %%eax, %0\n\t"
+                     "mov %%ebx, %1\n\t"
+                     "mov %%ecx, %2\n\t"
+                     "mov %%edx, %3\n\t"
+                     "pop %%ebx\n\t"
+                     : "=3Dg" (out->eax), "=3Dg" (out->ebx), "=3Dg" (out->=
ecx),
+                       "=3Dg" (out->edx)
+                     : "g" (leaf), "g" (subleaf)
+                     : "%eax", "%ecx", "%edx");
+#endif
+}
+
+int detect_vendor(void)
+{
+        int ret =3D 0;
+        struct cpuid_out vendor;
+
+        lcpuid(0x0, 0x0, &vendor);
+        if (vendor.ebx =3D=3D 0x756e6547 && vendor.edx =3D=3D 0x49656e69 &=
&
+            vendor.ecx =3D=3D 0x6c65746e) {
+                genuine_intel =3D 1;
+        } else if (vendor.ebx =3D=3D 0x68747541 && vendor.edx =3D=3D 0x697=
46E65 &&
+                   vendor.ecx =3D=3D   0x444D4163) {
+                authentic_amd =3D 1;
+        } else {
+                ret =3D -EFAULT;
+        }
+
+        return ret;
+}
+
+
 static void cmd_help(void)
 {
 	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t te=
st list] [-n no_of_bits]\n");
@@ -109,6 +172,11 @@ int main(int argc, char **argv)
 		return errno;
 	}
=20
+	/*
+         * Detect vendor=20
+	 */
+	detect_vendor();
+
 	if (has_ben) {
 		/* Extract benchmark command from command line. */
 		for (i =3D ben_ind; i < argc; i++) {
--=20
1.8.3.1

