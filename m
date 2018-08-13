Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2034DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814B4208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VfkIaC89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814B4208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbeHMTOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:14:20 -0400
Received: from mail-by2nam03on0067.outbound.protection.outlook.com ([104.47.42.67]:59712
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728293AbeHMTOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmr0EyhdHoMORT3PdHTb5Kx4zS15vLlgO3BiOOf2gwI=;
 b=VfkIaC89sDR532ArYQ0Mf9oE0ocIQc6r5rEDDJY8aCOk/A0YYY8o0NfpUEFOzkOMIkzWc+A19vPdSXDzXnZDfo3wF314AGsDUhUNUVwsmGKUSabWaueepn1++rXRigF0uP1B1msSL7QNHzoWGpL4RFzqfL3+3BcDiN+WXYd0HSI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
Received: from gi-joe.amd.com (165.204.78.1) by
 DM6PR12MB2729.namprd12.prod.outlook.com (2603:10b6:5:41::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 13 Aug 2018 16:30:28 +0000
From:   Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH] perf/x86/amd/uncore: Set ThreadMask and SliceMask for L3 Cache perf events
Date:   Mon, 13 Aug 2018 11:28:56 -0500
Message-Id: <1534177736-18422-1-git-send-email-Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0601CA0002.namprd06.prod.outlook.com
 (2603:10b6:803:2f::12) To DM6PR12MB2729.namprd12.prod.outlook.com
 (2603:10b6:5:41::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7885b56-a7f4-48e1-068c-08d6013a1540
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2729;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2729;3:VJ99FT1NEXIaV8/t+7Ez1KBFaurYMDV5p6RDdWYxm00zt0twIXKPbn8idBETUHHYk36MUJRb0CNs6l2hnjEBNCeYxQy+wrlbBccV3F9k7/hSjwcgvCJENFkc5wyZRMG2itPO44EttV7tEgrWf99/jlZF2L3d+1BdViaPUvxco/gGwtQ4QCtsFcbclJiq7+ud2oi7vNDqFkStldfNbphzTftWSf2kKnQwbSiqsOiZ1Fj9vMEglwiBtM+BQRMv3JJm;25:voMh5h9iYdJwQlhN2uA7g1VxyHJ8PQtzZf3ah06hDDMO2rdTplGZ1aCzF2FgSRWnOlf/fF4B9MP8/7MdLY0r+nlcZMAzaFJOHcns2jmMjqQfq1wQC8EXeIo78UCDvXn/hlAi4gNE9zoaREEgaA4c9MKHKpiRLIJxms2ytJ9Y+n6QNmMH2bhitNL6neHlifRI9KCJDIFlY47RPvQ/vUgduuSWYKnM7MgcPzUkiazZJY8Qs9wUCsM1kiGIfPBzSOX/3yGNFTRn9b3hVsjdx0FYU2jSkpuE8MXUXFFPlqFsXbjcU98kQkAlDuliiWQRH5kZjRdSAiWTvlhPrUBZ8O5YLQ==;31:95sATVdfNXNM9TMAVLZV/xH1rDyrez8Sqq8rkGH/5uZZYkDg6Ci/cljQjsMAFnfscErcpB67DZ7sorTBX5V7dXBsfBqTeB3SEGVZiqQ2xLoV438Bg51F8W6GOdzNA15y3PrSCEWZoXTWGj2qF8tN42ZZ4UegvDdA6hDU/eUATc2Bxk+He3m/bewaa3tZ6Rf4Z8mRZBkfLztQexXnS7yLtv9LRNUsmVN+fQX5PPMcigI=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2729:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2729;20:xSez0hT8/neUYxJ/EDvnwGJK6bIwIIShLhbes631fXGYOFQDTyU1Sk2mnvjiO4u+R29Obem/7aqTLSlE58vFs0lz100CXKcpiKYdVyq+cEqQ/8J8GZI33pCAfd7nEfzfbsM8guYVt97xplvKIcUT3cCKxnhzTGxJRsK4g6lKAkQyM0p9/yX4IpzsvG7uA8mMGwRjgGV/mt2BphjMtdMcjVIuYdR7YaWfeGo9nCXU8FIiLZxwkZY7YbC/gKY46hDIGbQBQQjv/yNxoBt89p+U5CZ9vG0kMLGg+HM8FByDB55GzGZnfD852JNnPtvwkZxPww0KItkzg6XRIKc7E8E52g3g4mRJs2OpqxUNygQ1T69ED78V5hQ78vrgMjjsHdzAHLqOvCw57JQ7cOCSXX8frwybfauuzJ7ZyuV9BYzvq4n4s9FQRbz/v9W3uackb+tk3LNMhtdCwf8lCRJY1S3FzpK8G40MPRFYrRt+BNCbooWppu/NfpSMSjBa0/HQ8ztK;4:xqrUUlx5ODmv1fMt9h+pZfxlt8osfIYX35Soo3M9SOo9bx6LxHAjWeseAaLPqduY8ZQkhpxhpJHUfIS6Bjj1ebk7HjXz8FL7AbpqNOtk+/7HV1RizGoCfil5YHr9O1GbmL5zoE2o8twOyhBclSWVbHDLDTyzMgx2TheAxwbpZmiw5xzN0m/qYnJGLtsd/fEwMb4/SM+y3dVzGK8Y2AgTl694+hSny2R5DjDkomOb1EfI1TkWgM9oWa1h46KOqsYlHFN68Oca1K/EDq6+QXcXfvajfsX478uXfjfhLxrC70K85Huml3dNlChqkkFFQqNW
X-Microsoft-Antispam-PRVS: <DM6PR12MB2729517102F19346D3039467E7390@DM6PR12MB2729.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM6PR12MB2729;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2729;
X-Forefront-PRVS: 07630F72AD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(199004)(189003)(8676002)(8936002)(72206003)(66066001)(26005)(7416002)(7696005)(386003)(51416003)(6666003)(5660300001)(52116002)(81156014)(6486002)(81166006)(53416004)(50226002)(4326008)(105586002)(97736004)(106356001)(316002)(2616005)(53936002)(7736002)(305945005)(86362001)(47776003)(25786009)(16586007)(3846002)(476003)(486006)(16526019)(48376002)(956004)(50466002)(478600001)(68736007)(2906002)(36756003)(1857600001)(186003)(6116002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2729;H:gi-joe.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR12MB2729;23:M88lUVpRtDo35jGK3+U8JTVTHMeD8ZxPG2ERcE7im?=
 =?us-ascii?Q?AQBQY7RhUhi5+RRuyH+QEyqiBFuKnxp3/yw8hI8gPrXwmT7S2zc5C+SifTBn?=
 =?us-ascii?Q?4ssJq0LL5CSmgh2NvTgCObvodySxvztH9joHx7XbwqNRG+juyr14T/cRsyjc?=
 =?us-ascii?Q?iDXbXyWeccFQwnTwiPxCXvy1xEFfDz2/4t22p6VMkKTYXHMcEPSHVtoNjycy?=
 =?us-ascii?Q?yscrKef5c+GbUjM68xJGIqvJcI4MD6tmYIjyyAFxFxPq/dfj+nxPkOWPgnrl?=
 =?us-ascii?Q?xYaICfGDNErNgVx5rOyHsdAJFbQW0wcJLuUjAUtcCa/ld9EJNFaxxBuQ3346?=
 =?us-ascii?Q?e9XpqVW+Be+1CDIVi8H/VnhQCHVkM2KZzpmRt1A6viK/HBHWSDPKBhTF2Gin?=
 =?us-ascii?Q?dDuqhabBt97pPSajZAKqERNJKqleKXdNkzUHCRJ4Fcbhwt07h8KQPn4nX8sl?=
 =?us-ascii?Q?DhVBW89te6disO7KRXcaQln7fMy/4KR38HEs3qIhDZzFftdFo1z4SZwV36Dk?=
 =?us-ascii?Q?KPa7RgK5t+TrZxSRf7LFTFX4sgoLNy8M/v56UYgsEdh6ZuYh0ZO2X/m1QMlC?=
 =?us-ascii?Q?qDtuk8zWDVJ1bV3gz9WIN3GSVlPY+j4f+3nW6O5ZBN6s27Q4ybKcWQ9Y+ZVU?=
 =?us-ascii?Q?cY8EL7DuzaX71caRi1Ad3FQ8pt+5VE1f2PYZy7iiVXxWzYq5++LTTQN2KkKY?=
 =?us-ascii?Q?bmUA22al9oo2GiWnMNhyo9trMsGx+wtyLHBN6qB0bKx5OZ3xtykruOq19hW8?=
 =?us-ascii?Q?kG/YjeBPlmmr4GkQuVeIMLMImiVMKQUuKCFB0f8TPJsYcTBF+DQHWf19kGir?=
 =?us-ascii?Q?CA65d8h22iBGi1NY9TOFpb6+7fk/1D8UHPr0cpHGybctiKxFMo8qsEGnhQyd?=
 =?us-ascii?Q?J3ynw6XJdndNwSRIvtBMSKOGX4+YTSpIUXRp5m+qff4Br51+vTYD9BG3ux7J?=
 =?us-ascii?Q?gyiR5QEIQlrWyZ/xxq9KQnZSvKsJazewUbS9uYgU1zWHkv8RWXEh+Y4BK0la?=
 =?us-ascii?Q?mqCZwfolFFmY+i8saEwkerQrusxC8WE5T9mIMUS8C8kTJTyKR8W6q5abX0Tk?=
 =?us-ascii?Q?gEZVQzZjtE8NG8SODkZkRzgu8Egeny4p7z48kvQNlGav+fL52bOqraXqqaqH?=
 =?us-ascii?Q?jvUWi/xF+rxC6GlgB8XwvBIj12aKOwV1nITzYxOfE2JbiipZqQJpLxpPV9BQ?=
 =?us-ascii?Q?dmYgz95raUkrvk=3D?=
X-Microsoft-Antispam-Message-Info: iq74ee4pYoBw9716piodVYQA+Ke61uYjYWqoKIRsX2Szxwr4D1a2+oPSUYlciPUzFwLfOKNZvRnVNss4irlSG8bgNuvpENlLltzZ0+2q4YffvZcSvjnR28QWwOlMgjEyPa2A99Z6qGwWQWoxBH4Yft4FTxb25PuCofy4FWLdKAoTNpUiCa8VQE+rtnyi+c/QzjL/3/Rf2PzrgHB/+irO9/MEAgv+S69Awg7USMs+TY7QZQWLAFNRlyjhUTAzwmhsIzmzEtrfRIliF30nUJHqDwcb6LFD2fFoQTztOxYNqDeMeWo6N7YwizWJlPM7LRyMk7yufrzXNB1cmu8WbLEOqPaK99cuWdLucR99YF/jcwI=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2729;6:/WC6/gevFvhWJ3YpI1/gpP9ac27EMcOYfhz2rsaHulhus+SSy5YrM9uoWTX2WEglxZ8dnlTrEnXU///CkRPYXz8tXTlb+rCb+bqW5dwjCEj1qeeHIAd7U4qB5MVYQrFiRthnKuzbNtc8oTIPZSkG79i2yVp9mkSgSBexpAy7pSdnwD+qsF2YGlN+eaioSJqMKT+DPWaOWMP0RzOXISAsZoWzaFI5BemrVUkhCDCFVjPicvYdrbpcycG4hjWajR60uGr68Xm2ImsxZV0spURbXVUmnjz7FmkK3phVKqzWZ1ulLtw6mxnVLyHohpivaNhtY50yD7EBFUVCnrFHAlzfgX1rFOmLeFyW4mebKCpygvhfWE0PGtKjiLbHeNzWOTpOwuEbq9zf3UI4tZkWy2hc8w114dIIm4JRWy3IkRI84slLrDzni7bBkd0QaKd7TssaYauTyTxTskRpug2qDqaPqQ==;5:/XwRkjZmz62RowhJRT8X7AmERZwVWu1K+t96nP+QhiHCLq7lFVgkYOhD2oShX/1jNfvg54PnlQyD4+RX6iiVQ32SSVMCR2ThLc94AAU0REiimCHKA4jp3tS4W0YoZt6vPG9wGGEmCfoaSk2vzkeuQvQLeUK7/d166qDTwKSZvJc=;7:LVhbHsd9+/xmChgWtx4futeXflzvciXrpwde/o2GtTQGNeH8GCfFPSuaDUM+LQryAq7cSIq04DTkj2aOZ/4+UzOct/M0S/tsmQCxIvlVssiRNGTQtbxs+0hoX7TrzyR+Upy0TLihY1sIHGOHuIJ/w1nwjwGs5+v/XMqOy+M+y7sRZ5FmkIMkcbQk3zLN89A7HyUxycsevf9tdHdqrwewp14FVm4T8lbDznQAX0w4D1L1BPilkDaU6BNicBx5xVmT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2729;20:pBWDsQXjnDu5lzTzXV3/zE0uto4IYC4a4k1jaiSnrYYaND3TDEeIgwBqEUpthUOD0uqzjJEUg5vXZ0jE9kDc1zClYunn+YuNx5C0xgGdsSMelYKU2N8wODJdIsOV6qZimkmyZMIgBeYs7PxjaroSvONlQ68Lvb/UW3ITnsVIglSvjGRGDHb81bt9UrT9MeXQBsFJ7RZWpXirHfOq5+/bKUTVjLVBIAXTnWwPEYZrCrVeN6OBNJfriOfGm0M68Acq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2018 16:30:28.8406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7885b56-a7f4-48e1-068c-08d6013a1540
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2729
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Family 17h, some L3 Cache Performance events require the ThreadMask
and SliceMask to be set. For other events, these fields do not affect
the count either way.

Set ThreadMask and SliceMask to 0xFF and 0xF respectively.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 arch/x86/events/amd/uncore.c      | 10 ++++++++++
 arch/x86/include/asm/perf_event.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 981ba5e..8671de1 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -36,6 +36,7 @@
 
 static int num_counters_llc;
 static int num_counters_nb;
+static bool l3_mask;
 
 static HLIST_HEAD(uncore_unused_list);
 
@@ -209,6 +210,13 @@ static int amd_uncore_event_init(struct perf_event *event)
 	hwc->config = event->attr.config & AMD64_RAW_EVENT_MASK_NB;
 	hwc->idx = -1;
 
+	/*
+	 * SliceMask and ThreadMask need to be set for certain L3 events in
+	 * Family 17h. For other events, the two fields do not affect the count.
+	 */
+	if (l3_mask)
+		hwc->config |= (AMD64_L3_SLICE_MASK | AMD64_L3_THREAD_MASK);
+
 	if (event->cpu < 0)
 		return -EINVAL;
 
@@ -525,6 +533,7 @@ static int __init amd_uncore_init(void)
 		amd_llc_pmu.name	  = "amd_l3";
 		format_attr_event_df.show = &event_show_df;
 		format_attr_event_l3.show = &event_show_l3;
+		l3_mask			  = true;
 	} else {
 		num_counters_nb		  = NUM_COUNTERS_NB;
 		num_counters_llc	  = NUM_COUNTERS_L2;
@@ -532,6 +541,7 @@ static int __init amd_uncore_init(void)
 		amd_llc_pmu.name	  = "amd_l2";
 		format_attr_event_df	  = format_attr_event;
 		format_attr_event_l3	  = format_attr_event;
+		l3_mask			  = false;
 	}
 
 	amd_nb_pmu.attr_groups	= amd_uncore_attr_groups_df;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 12f5408..f15d51b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -46,6 +46,14 @@
 #define INTEL_ARCH_EVENT_MASK	\
 	(ARCH_PERFMON_EVENTSEL_UMASK | ARCH_PERFMON_EVENTSEL_EVENT)
 
+#define AMD64_L3_SLICE_SHIFT				48
+#define AMD64_L3_SLICE_MASK				\
+	((0xFUL) << AMD64_L3_SLICE_SHIFT)
+
+#define AMD64_L3_THREAD_SHIFT				56
+#define AMD64_L3_THREAD_MASK				\
+	((0xFFUL) << AMD64_L3_THREAD_SHIFT)
+
 #define X86_RAW_EVENT_MASK		\
 	(ARCH_PERFMON_EVENTSEL_EVENT |	\
 	 ARCH_PERFMON_EVENTSEL_UMASK |	\
-- 
2.7.4

