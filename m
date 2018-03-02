Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936456AbeCBQTY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:19:24 -0500
Received: from mail-by2nam01on0044.outbound.protection.outlook.com ([104.47.34.44]:42045
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935554AbeCBQR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:17:59 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
From: Babu Moger <babu.moger@amd.com>
To: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org
Cc: babu.moger@amd.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 1/3] arch/x86/kvm: SVM: Introduce pause filter threshold
Date: Fri,  2 Mar 2018 11:17:34 -0500
Message-Id: <1520007456-85293-2-git-send-email-babu.moger@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1520007456-85293-1-git-send-email-babu.moger@amd.com>
References: <1520007456-85293-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR14CA0041.namprd14.prod.outlook.com (10.171.172.155) To
 BN6PR12MB1761.namprd12.prod.outlook.com (10.175.101.22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5c75642-f93f-4bf6-db71-08d5805928c9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1761;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;3:HJ0+YFWVvh/f8UogAQvKwzmwdWCDe6mpBhaoM2SO6DlZAQvBU7HxibcNX6e1Yjkg6fvcu/qgCqFhbG1YisjaQFbZD5B+QKtpqNlIEakfTsTse5NTpyCibBlvFhhgzferVaTR8P0t2Kpe8iVS217LwiatFkHGvl0i6C0uofnOAbH3FqHV5e5Al/zwUJ9FaJEuPOH94idBENPhS/BaUpEYR//Sv9H0mpQVu8aNKBuV19ngf78CIDjFE947h3oSPcbb;25:dGQxs21eVSOzdL9+nwzDHdV0wayWDTKVzNmirTeyx1uPU6Ia7182aNBWdfIARYD0rng2Sey68n5CI8Hk+H7++KD3qablHzAAZgMJhPGMoFJRyhaudjlOECxFYaNgTTUdNhaNgsyeJZop4QKx3BR2Sur0Pq/6bJy/+yUnNZTIW5trQU4sISMEWV6Bd5kVDqtBop+Gqga9o/D6GyejpWWsaTNOA+6p2bYXmDzgc+MvkN98TdnqfnO5xAf1IOImBXoM6oAyvh4GYU8dwS8PvFNUAHTH/NPbXWSoCku2BKlOZ1qloMft0QCnILsB1LZZFy1l7DYGaV3l0Z5tn2x1GYqnAQ==;31:9A8aOBAz2SM/gc0NJ8G3Ggysrulmqq2QhKhCtvtcX7AiZsxrDyq3c2cil6NrExfdzAu8EcLcKGAX0usZs7vOwIimaEXDGDmACnfo8HWDgUV6SjhmOP1+A1Zlby/bWn6iO0MejLjQgF2VViP5yAbVqYsemQsS0mzH1aLzxFnFa7bE4LiwatVE26+n6GO/CHbXj2qibCfdbVx/vTW8zOPbCgx+YAQklF48APwW+AnxxbY=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1761:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;20:I62fmhwRQORTt3guUU5z650lWUOe9PD+MNtCKW8e1CtJZcep9o6OBwkcMRuqmqIFrJzmyv2gygenanoSbXpu7hCgo2FNRQPsbdy/DLBchTT6VEWlQcoTsbnjU/eRvg7RxD1V0aUjqqTAG/+uKi+T2gTSHKTxmdUe9rLetSBbyaPIggH6jEEta4iwKHVwzNPgsQgPkJNkWKiz0FsZMk6FeQnmZxFLJ1uH6u1FVOcvoBuR2Rm7PrJ/Sk+R9a/EehF7PV9OAgBaz+wPntMAucEJ0Unl7fMgPxZwYCBKFGdvM/XMr3fpY5/ig5blMN5IcFygPb+J/cVKMoxlZRfBUkNFcoFtFFZu6MyyKRhj6m8QWkTF0Vgl9D6/Cp4x20wJwKNFrj3oeyLSxkX8HOUHIwFCtGKQS9tJ5VA6SiQIdjphFj4mP7m8/pCveGefC6LUsSKnNXuBiUjnKS+CRLBaUWnVpSOtPfNUQ3kxNKGraybsVsyJrNqk2f3KDSL2JQ197QAs;4:jvi5Zo3emdwxHXw4/oJdyEkUhZQn1FArIYxVFbhMmB/zGOLEq+g0OB1BWYReqb28Se9oc8jd6G0+Iy+yI47viQZRJ5H3vapOQXsfT0KoAkFZMHIAumO1C/VA8eYKQL9tL83LzZRvIrAfT6uCi0VajNS5gzdI7/p/J74E9dX1Jt/Zm7oKhi5VAj0AWgFhPvSHVVlYEG0B0ClP9q67eq+JLpg73rv12dvR8aOC3tNQAHFeAQ3a7xapdTICNLj2/5ETV0meLyVkr0TJIfd57psBc5GAVPTw4lmXFhz/sNu8owgGeMNdk2lgax7y9IB/z5Vy
X-Microsoft-Antispam-PRVS: <BN6PR12MB17614A8EC66536880145F8A095C50@BN6PR12MB1761.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(10201501046)(6055026)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1761;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1761;
X-Forefront-PRVS: 05991796DF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(39860400002)(366004)(346002)(199004)(189003)(51416003)(2950100002)(386003)(53936002)(186003)(26005)(7696005)(6486002)(52116002)(16526019)(68736007)(6666003)(4720700003)(76176011)(106356001)(16586007)(59450400001)(316002)(8936002)(50226002)(4326008)(5660300001)(36756003)(81166006)(86362001)(48376002)(50466002)(575784001)(81156014)(2906002)(7736002)(3846002)(66066001)(105586002)(305945005)(8676002)(53416004)(47776003)(97736004)(6116002)(478600001)(72206003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1761;H:linux-pyp0.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1761;23:+VHJEGDn1u79f4hqbB7Dh0yni237kOS4ZRTjON+jT?=
 =?us-ascii?Q?XwU5oHSB/ZsrVCzDkFYG1oOB84ZvDefQqUtQ2xj9qpD2K/98oKuC1d31p98N?=
 =?us-ascii?Q?uXnxTzhe7qAY6IBrLtCGO9nkdc1rV1QX3MVf28uv1W3k4IZExGgerZ7F3h8j?=
 =?us-ascii?Q?CMILHkDwQD1ND2J40nuUDtVSq9FsGE9tgJ0G7Zejv/M1JC7biKOW6RK0YnAX?=
 =?us-ascii?Q?Z6zn45qOwlWmB8vcHJzzy9acP/l4RPlQQk21l4Zw+gOuP7eWAEsmyYf5/8bM?=
 =?us-ascii?Q?t7vqf5pFerXbJJzhIzfvPu4v1y+d9w9xTjia/DyTCxkbIjFuPfcrFs38yqPW?=
 =?us-ascii?Q?3JKILL3oUnBJMhp8CntJ238xephzQ6ENUZPvQMvPwfy+GZDDqyRxh1f1XMUv?=
 =?us-ascii?Q?psiAshHBGUgQN+UJ2/8XZi0+mEZpEm+ERCHI/wJoyhnFai78NZfmb8wWklXh?=
 =?us-ascii?Q?kez6oAmL+nIesKqjusrWUMsw/BlwNPU3/z5VvqMP9irmXurcC48lfAWcKQgR?=
 =?us-ascii?Q?Xg/jhYll7cAvrdkrZuR+ZyxQZ/aj3vcO5T9Bd7+7VLei/a4OTSTvvVKz7dkL?=
 =?us-ascii?Q?EJWkX2rIfPC5eONoawTyR0EvwmXvwqV6l1wR31xdmiVR2T4V+iu+v94XEwRE?=
 =?us-ascii?Q?1aT3/Iz0itLZ+bn1PcBOrd5I544lWoRYCS1Xux+j9qyC6pMzMHWInaBgDrAH?=
 =?us-ascii?Q?tW6b8PI4kTdL/bzENARNTuyYeZXnmdiR65DEmdzxlaChLNBhE1Rk4ynJfC28?=
 =?us-ascii?Q?PAdcf3nZUFG3Lzq4d6G7TLiT2A8sfLTCcEG7U6HaXe5QbXfH0v/a8ohNjmJ/?=
 =?us-ascii?Q?nwS5IPBUYfdqOqhPpt7dPFa4xmJ8ezJ/JL9N8v+XnUMp4avarYbEvV54BYRv?=
 =?us-ascii?Q?riS2g6IsgFFa5sH1hvuBMT5BqY4dvrWqVp5wLpiRex9Yd5qXxuOjNT6iLdSa?=
 =?us-ascii?Q?5nLTer7O15Xg2Rqg6J5h9wm11Ijiooi0KPUAIoyIqvEm+phfYIhl3nPJ2TGB?=
 =?us-ascii?Q?OhRauPOwyE9ckBiEaSQIZJ+zpwXDfvCYNSUzdfHMgf/GhJ3KezKqhgQ8nSoz?=
 =?us-ascii?Q?Cn0uV8v6kkPbAJ+qS6KjioOAnH/M0FG3YCtSGuWStTpYIiGW7m4GPbsJmB9W?=
 =?us-ascii?Q?jAilwCrMJeSF6jWdDMMtEqwXnEDfriRYrC5gs385sw1L44qit0MIAm6nl7TQ?=
 =?us-ascii?Q?0lVVr9Qig+dong=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;6:43xx1b6KVlx2hatL+WHuGH1KwTVNbOzfb/xxTAAVMDwKXQnU7xpuw4DrX/jk43mLziiLd9ldqRP9CAGnQc3e5ioWUCo4RaAuFgjt5YpmRuQnVMrR1/vH9zbX/VTRX69o5vI9qT8ZL5xuY4hAt6Ko+4/rUIGl3Zc7pO05jg2VKNxSsDt75ZfTZL6iA7ZP9jtQAvji1FTr8W9+yZ5cOmMDnw5j3NCQE9Qr7rUi2+1ja5fEyVWV0Cwxn9eN830zPr4R2L8zpoNAhExP9AChrZWL90xymHhoTr+aNaJt+dxgtsDVovX1DOpDMr3tMa7gEGeXzHfuyqrpu2L3YibySbUSkS+iUASZuc6G3i7KaMa6QAs=;5:CbOjxtcuWUq0wrrkiJ++K2i5rbMQYMVrpiQfFAxRgn64uljUxoE5bALqbJBHy0t1ZLar80cu/B7/8g1Pqw0PUvgQB/7zLRGgb9hhKOJTlZ3f/TJrucpq5Cj1mXvi/Pr10twhAjdKLE6uAPPVslEKSEoPUgz3IlXntsWCfGE+APU=;24:sEZN2hN47WOQ3PiAKrLKMMFla/TWxgA6bF+uVuwYVcTHmlq5hpiee/w+Z8I5du/e0DjaUp97XThbYG6m1ptGYNeK+bzNuDj3FoZKJKiZ6EE=;7:61r2TXdYeoJj+mI/ry9bUKo3IE6HboxmD5eRPsa+oLGlbX552jOQ/Fcb7V8Rk1SigG5vF6aNy3oSpKUEWPZSvRfhaQgUhdQ5l0sHgOSIefA8SIni/MQs+MDLgy43oTakG4NV88U7dOEpwNcrZftuOgONll3W+XHJllnR7W9R9rRhRla+FLgDIPvxlDzX8DNFr/dcEgVvEzMohrRZfxGsgNs/QdYW8+AVMax+pOIHArCjaXLAt+L0ro0u4/5PTHaA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;20:mko53rOSD1aKWM5jwGwjUwSCpGT3UZyYo6SNZhuTNyUnKN/HyEw1bvBq04G9g7nsswjB76xXvp1AAf3AA/fHfv6RoSMOy0bFIAajRoRFe8XX+/Mequ0/fRziasxuHlY0xknAC3xm/u4RB6hB1JQeI8l3CqHwDfgAOxvIykvUpPfu+oNW8SwaKvPF0kQ3sZzV+wkHoI+/Vpqd0t6qY5UzH2tznR632Ex1klRJvLZ1t8uI95EEds6xQEG/dDCwyUKj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 16:17:56.2391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c75642-f93f-4bf6-db71-08d5805928c9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1761
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the support for pause filtering threshold. This feature
support is indicated by CPUID Fn8000_000A_EDX. See AMD APM Vol 2 Section
15.14.4 Pause Intercept Filtering for more details

In this mode, a 16-bit pause filter threshold field is added in VMCB.
The threshold value is a cycle count that is used to reset the pause
counter.  As with simple pause filtering, VMRUN loads the pause count
value from VMCB into an internal counter. Then, on each pause instruction
the hardware checks the elapsed number of cycles since the most recent
pause instruction against the pause Filter Threshold. If the elapsed cycle
count is greater than the pause filter threshold, then the internal pause
count is reloaded from VMCB and execution continues. If the elapsed cycle
count is less than the pause filter threshold, then the internal pause
count is decremented. If the count value is less than zero and pause
intercept is enabled, a #VMEXIT is triggered. If advanced pause filtering
is supported and pause Filter Threshold field is set to zero, the filter
will operate in the simpler, count only mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/svm.h | 3 ++-
 arch/x86/kvm/svm.c         | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 78dd9df..7a3d9c7 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -60,7 +60,8 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u32 intercept_dr;
 	u32 intercept_exceptions;
 	u64 intercept;
-	u8 reserved_1[42];
+	u8 reserved_1[40];
+	u16 pause_filter_thresh;
 	u16 pause_filter_count;
 	u64 iopm_base_pa;
 	u64 msrpm_base_pa;
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f40d0da..50a4e95 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4175,6 +4175,8 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	pr_err("%-20s%08x\n", "exceptions:", control->intercept_exceptions);
 	pr_err("%-20s%016llx\n", "intercepts:", control->intercept);
 	pr_err("%-20s%d\n", "pause filter count:", control->pause_filter_count);
+	pr_err("%-20s%d\n", "pause filter threshold:",
+	       control->pause_filter_thresh);
 	pr_err("%-20s%016llx\n", "iopm_base_pa:", control->iopm_base_pa);
 	pr_err("%-20s%016llx\n", "msrpm_base_pa:", control->msrpm_base_pa);
 	pr_err("%-20s%016llx\n", "tsc_offset:", control->tsc_offset);
-- 
1.8.3.1
