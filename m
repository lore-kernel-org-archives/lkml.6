Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C410C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B2A2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vDpRRJqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B2A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJLEDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:03:04 -0400
Received: from mail-bn3nam01on0087.outbound.protection.outlook.com ([104.47.33.87]:21632
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbeJLEDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEU+Y9hAcaSM671Yd7pMF+DyHK6FCwzM/8p29i7IeF8=;
 b=vDpRRJqvGg6ynWQLMvNIyE9aXwsOJVgvb/opxp9Ra7PQSZio0Cw6Mpc/unxMthclowlBPCipWcc58VoNnxQl/acOej+V/7IC2h3L+ECX2UJPf7FIdyrq8ET9d+kFI9jTG6ONQ4uzQOHC0FWQlNCURjbQpEQw8oLUBcksInma/rE=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1211.namprd12.prod.outlook.com (10.168.237.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Thu, 11 Oct 2018 20:33:35 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 20:33:35 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
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
Subject: [PATCH v3 09/11] arch/x86: Introduce new config parameter AMD_QOS
Thread-Topic: [PATCH v3 09/11] arch/x86: Introduce new config parameter
 AMD_QOS
Thread-Index: AQHUYaGv1vrx53eHGU6x4h2+Q6V54w==
Date:   Thu, 11 Oct 2018 20:33:35 +0000
Message-ID: <20181011203223.18157-10-babu.moger@amd.com>
References: <20181011203223.18157-1-babu.moger@amd.com>
In-Reply-To: <20181011203223.18157-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0062.namprd22.prod.outlook.com
 (2603:10b6:300:12a::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1211;20:5cy2PDq6QCK+O/ydbLtuXufaxqOvcLtvVTPRHxBQEA7uSiE9Dtj2dBGtV19b+zMQ6a7H3OWSLMXJPge7Gg+Cd5BSLxcnANQeO0yJk1fW6Ip7xL7OWIoAwvZoBgWMIBFN5tGRczvpOreqODkcPVOByLyrs9imssfp84iKsAP/vjY2DaKHI5QPAI3pdJtR84xu4y4GbLiaL3HO0dNTOGwlMPXrEbXu2nEJa4dH4SD5RAqioxxq6ucYxAMF6zNefkjh
x-ms-office365-filtering-correlation-id: c1ab5243-2169-4462-bdd8-08d62fb8d156
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1211;
x-ms-traffictypediagnostic: DM5PR12MB1211:
x-microsoft-antispam-prvs: <DM5PR12MB1211B0E689AFE172EFB83A5295E10@DM5PR12MB1211.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991062);SRVR:DM5PR12MB1211;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1211;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(316002)(2900100001)(71200400001)(71190400001)(14454004)(97736004)(86362001)(2501003)(5250100002)(105586002)(6512007)(6486002)(106356001)(36756003)(6436002)(478600001)(72206003)(5660300001)(102836004)(476003)(486006)(186003)(2616005)(446003)(11346002)(7736002)(305945005)(7416002)(81166006)(14444005)(53936002)(68736007)(8676002)(81156014)(66066001)(386003)(52116002)(256004)(4326008)(8936002)(99286004)(6506007)(2201001)(110136005)(3846002)(6116002)(26005)(76176011)(1076002)(54906003)(25786009)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1211;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3laj1ptOaqx3Gpe2BwutLT+o3vSZiQQy6aAbjJHKJuehwhbZ22uz0KD5NyvWOyPand2YTaUAl4ANV0ytaO8nCytFNeSf5XsGS4nyI1a6XLQ2UWSMQqOHVgb4B3ixnVb8254F4XsuZVowKW0ppyeUyEQ/3B9Kv+hH86Y6nhoj9gV0FcWeMSB0CTECF0wcP7jdfESM5xepWZN1kJt3VdRmxBcNOZnkRd1qJInddrgSNBqnxeJlkWk848Uv18UlLkIOUaK+yura3kwZiJz4ejWNrJeNfXnAKFchyHe2T2HtqSPHgkQW/V8OM27C+Lns1HPGCLwn6hiX7pLSDBlxhr1CaobOJOYkEYbchJUT66oc8NI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ab5243-2169-4462-bdd8-08d62fb8d156
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 20:33:35.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces the new config parameter AMD_QOS. This parameter will be
used to enable cache and memory bandwidth allocation and monitoring
features on AMD processors. This will enable common config parameter
RESCTRL if selected.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/Kconfig | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 91a703ebdc04..5cef55935a5a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -458,9 +458,24 @@ config INTEL_RDT
=20
 	  Say N if unsure.
=20
+config AMD_QOS
+	bool "AMD Quality of Service support"
+	default n
+	depends on X86 && CPU_SUP_AMD
+	select KERNFS
+	help
+	  Select to enable cache and memory bandwidth enforcement and monitoring
+	  features of AMD processors. These features are intended to provide
+	  support for the monitoring of the usage of certain system resources
+	  by one or more processors and for the separate allocation and
+	  enforcement of limits on the use of certain system resources by one or
+	  more processors.
+
+	  Say N if unsure.
+
 config RESCTRL
 	def_bool y
-	depends on X86 && INTEL_RDT
+	depends on X86 && (INTEL_RDT || AMD_QOS)
=20
 if X86_32
 config X86_BIGSMP
--=20
2.17.1

