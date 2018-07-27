Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10AAC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6999420647
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5PIBqmh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6999420647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389850AbeG0XIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:08:17 -0400
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:41312
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389728AbeG0XIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLZgRg6wK9pGKuY0Mw41R1/PlCp63jo0AE9S31x1SFk=;
 b=5PIBqmh8puqCxRXe9W8xsttQvf38T4IJayCJuSDjBgxfZpP/HlrEAvqYeB1H1/4/44LmfAsqC79VZYfimJ5MeyccO0qGqdtuSrAuHP627pJfhp+dqOM4+fmrcUA4xpi3vxowZ6eANKQrLvAWEo1gPJiP+JvsgzEqjhg7MDBN8dA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
Received: from yaz-diesel.amd.com (165.204.77.1) by
 CY4PR12MB1559.namprd12.prod.outlook.com (2603:10b6:910:c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Fri, 27 Jul 2018 21:40:23 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org
Subject: [PATCH] x86/mce: Handle varying MCA bank counts
Date:   Fri, 27 Jul 2018 16:40:09 -0500
Message-Id: <20180727214009.78289-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CO2PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:102:2::28) To CY4PR12MB1559.namprd12.prod.outlook.com
 (2603:10b6:910:c::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d824eae5-7fa0-4e41-fd89-08d5f4098f6f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1559;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1559;3:KEdxoF8TL2eA5/1R6RVGt4g1vCwMeaJ1EuaNTQpNHws8fGMPaLhCbevlck6st8kZ+ckcqVjM3DXNN7gn0QIBwK87umGowWtyUrDJrjp+dHrFI+1UYVd+6/0i5kfD8NfrbRH0t9/J7cmHdVtiZgutakUi3T95DdGwrFUh505A6klmsgr3urNu764USSgVNeettw4CNlLm5c4ND3Tqrwaqk+K3DD9jSn8pa9MGPL/O3Q+jme150Ms0tbqRLsmhhYIp;25:us+6A0aI8Qn3N7E65dLgeXoZ7u8/8S82Kq4J6N13Z9saaNaBytxhokvV3PFIYI87W5713D7OwppIOFhv/7JPs79D7Uj81cJnNhkRm7CooQ/jFC5U8p1DNQeDor9fbT7JL3hlZJ39B5rq3fC/dsVhWhrJSclFeYCMLaLqOSZhc49AvQfTyuDlY4sGHnxgS0KXqqb8DPGNp7Yl62WLd7NRAMomgxwWmhrmiUx0V3GoWIhB07v5kdRUjKBUwtRLqioUwk17CVy3yxJIk2EVSmdwBwvm1aB0AiVp/Vt+PMGFk2jli4s4ndkI3SIaNnkG3meDWQEpGigNZT19uG1KAoah7g==;31:5S7KnkkmOMfErH7IG6cIoXdeN2PgdIO5JW8PSKjhDwFgaeS0T4ZdvfWo77sNNyXtppf+l0I7IcXhI+ZKpkujJZ+lYTSMu8OULb/t3VYC3wBMSOirb/EwAKLXdRcxyBG7sFFDkTEBjVcIA26o2FEvEB/yG4knGlnUhgl+TJW/3nqDfidqZ0xbV1edWKutKIuzlBTZc93Qm64disPzAgDsYJWYbJXX1g6MDxsLJHPWQSI=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1559:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1559;20:J0Hh8vh3BedTzwiHA8LgrPvgHii79DlpzSjL4a6CgFYXyBxPtnkoy88qIoks123OjV+RJYpukoIip/ehbT2UY0pkwW9Xgjtq0FX5j5IoQamedrR8eOac7znkRK+Wy6mmG8cR+U7OW8NDli8Sqc/FKTvx+uino7ojvZokPXPaimo+IRseoEPIftJI3OZ5AJpY4ulY3AcnnxIyQiVE79YjiHzESi32wOVGmDouedF4HUfydY4u6boO6Ohx9lzm4V39VYPa7gOWbso2Yzhz48EtHqkbTf6VoO3PVMF6TRrTkbJA7XvYYbdfcQ9ZsMmA9tLwB/+ZyZ0O1mpPO5waXlbV0YblszVskLchk2I8wfmrz7BqH82AZAuSLdlltRAx3vywxJR3XmhJ41FHexKC5l8VwlAYY+7x3xqGYsw3OpFhrJz3cWzhg4XZzoc07FRpg2ghXWf00jiQLF6fImkZJPQVg9wgn/GOEopGHA84PCTL4Q5Rk/ErmcYj7EYKfHEq79H/;4:LTyjINYf7qI+cMz/IzAoeQbV+Ju4Vys2Cy3OBwvRGxX1f2wxrUUlDbwwzGHmzDKR2ElEbefWMcz9KW0kTaRRb2FYizrTqXIBKQRdreVX8VcrZnYBPUjZRmJWrK/fC/UjCkdDtyMFE1XCwnoOYuow7YfsEKK+U1KcfjSl115Zp90zbUtj9zeBdYBX01NRFOx6HQd13LFCgvcz21DLDMd4qxOfY2eJdai/tUHk6rW2QxOJ27RZJwr/hLyoIh+zhFy9h3hXyHcMvxhB/rILb1LlJyjnASJ1pa+UonZLp7ILpitn8ZoSwgEhTBi4lPE0R9xi
X-Microsoft-Antispam-PRVS: <CY4PR12MB1559B7BDF8EE54EDE9C6AA34F82A0@CY4PR12MB1559.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1559;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1559;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(366004)(346002)(396003)(189003)(199004)(72206003)(8936002)(81166006)(186003)(26005)(50466002)(8676002)(1857600001)(2906002)(16526019)(2361001)(97736004)(16586007)(106356001)(386003)(6916009)(86362001)(51416003)(2351001)(81156014)(52116002)(6666003)(575784001)(305945005)(7696005)(7736002)(25786009)(478600001)(105586002)(6486002)(68736007)(2616005)(50226002)(47776003)(4326008)(476003)(956004)(66066001)(53416004)(3846002)(486006)(6116002)(14444005)(1076002)(316002)(53936002)(48376002)(15650500001)(5660300001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1559;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR12MB1559;23:jKZT/KtF6DB1lRE6bU61sVnAzWb9YHtB8rtlnwqOr?=
 =?us-ascii?Q?JigpdjtrjH1Kwf4fmJW2LQ/hafwMy4VhOTk9dkrAc8adNHMtGdAKHIlU1OHY?=
 =?us-ascii?Q?1/IpjJF+AKp9hAjdiR70cpWAA4VnTa/OI2pqtYwMpABP8GfLp3QGje7ZrcfJ?=
 =?us-ascii?Q?O3quZA5vwLxwOgbl66s+DRyq8iPpD2KFLSK4FQe/wu07SLHL5VD16kBPc9Ls?=
 =?us-ascii?Q?Wbt6dKwTDiZ4eqzIiuum0XEHQHl0OaNrTj6Qgy/DlybTJnEiCNyvtAnpNINd?=
 =?us-ascii?Q?lBTj1dH+EHC6OrZEGMZcyJot0unAFXMOLfVrIJUBNxYPfKPcSkTrPGSGKcm+?=
 =?us-ascii?Q?zIz2En/pXuzoRy2WkBvm3kEHvfGRjXPMrSd/9TZRLX+QxIX/i6PGqtL9rKoX?=
 =?us-ascii?Q?71oMVmHsRhEYniZe11AuyiFa32Nxw/V/nFz9qrBfrAmq1FEfynxuIArF7z4b?=
 =?us-ascii?Q?wcDvy3z5ZTYqjMocsDnwyjoGXBo+b9+nOScZfwgLCy4PX/pcdGHM6M/uZtv3?=
 =?us-ascii?Q?FFOF2+tPwqjL7G2b4/UdEKd+pWSZj4mPtRB2ltw1GfXJDDqhnKW5PX5qe0xY?=
 =?us-ascii?Q?AR7Db5FTid1y/J3u+qEq4O7ccnjDiml+upSXCBUm/jfqlRpraiFaU1Ka7zS+?=
 =?us-ascii?Q?i53vFXuk2lftT7WbD3jNOoFIB2RjG9Q7MMn+y+Efm/Z5fM7nEBJyMbuyGQNt?=
 =?us-ascii?Q?0Wpyz5Q473cge36g7sZGJObH+FHwBh9KTRb9PYD0ZuWGLwSODwve/GQSqtkY?=
 =?us-ascii?Q?4+ZRCDCl4ZLwuSt44fa/MTYGDOoyzCBcxJhXIAQ9pPiFbemNy/66aFvplw4u?=
 =?us-ascii?Q?nGvBMfaWCBgsNVhDT+jmmteInJHp6wWneRqsOzvsw2bAJJ1o8hN68+hqqd5c?=
 =?us-ascii?Q?oaptQKzRcCRsAl4cYex8mqRW1jlZnIHpco0E2mKDov3CPoaUcFD5EpbNysNb?=
 =?us-ascii?Q?LU1qRThZmqzejjVlcGa444G6kRTrAczYbjM34r8z2z/mXU002jSrc0aSYViE?=
 =?us-ascii?Q?kbC6x0HoVczPyh1qYnOzj1zYztqjQMv2hSiIPQMROM6BdUpeGqG9nduH93bO?=
 =?us-ascii?Q?aZhPDfYidoJjHRyP+HZcbKubrgPb0Oyvvo/+BnyGA53E48eiKKsqXbvhdy+/?=
 =?us-ascii?Q?FbBfPY8x+E4AuRMiKfEpbD6EKgBt60to2biNv67CkvLozmYp8YW8EWnKLOdj?=
 =?us-ascii?Q?XImA8ITwIGZW45aEcsnoBG2nDUhOVpp0BKr1bp/y/6A4r28WfNqs++8B9zUP?=
 =?us-ascii?Q?ZSXPsVBuQLTfPeMcrJbM1YgmG9rbqEMaU8pCdceF38A3ZkNdKu/Sr3u76Jv8?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: x8SQxSIipKIEdy3wbR1bvIK6eGaNv7jaydbK9z5eomOvUVeO6q0cMyXk3qpkl/vf8SSJX9AgDVlpgm2FoFSV8N2lroAp0XY2hWjCsZg4/M7W81s6XDVQnNCDRSYEx5fH4Z31w7ul3xqTXT3VjGWdIwEHBkd3zqI5SDsLzMMfNPSLjvrtCeC/ibhVh3cllayj005V6ELxDxp1r3dMy20SygQ1OSV5k2z3+ax8m0sIRmenN/a/QAoNJvVxyYR1gFlRGALDbXjOmSf+gBYeQA90JD+6Cdm0Pp4oHlkasbY5B8Y2E35v1dLZUGY9FJ9XYj47M2kxHaUbH3z6WNbLwXlRh4qojfUt3p64F4bnsGWh5Fc=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1559;6:RWx9Ez6YsxV7/XNDms6RhU3Ro5gIgFloHl1FDeyJhMZRmOrt/NQs5VNeg4uYl7wx6fU1kMQ8pVn5AzeDrqB045MfnhD0ESEDon0S3w/5j75qcGRoms6B5bpVfCJTB79Rjxtxf+6giYmVDYKO7kosTXia+W67HRxOav0LFlJ8CEEny/JtMA9gYdFOs4QP/D0bo5j8Vvo4nClwl//e1+rgtQYAlyY341oX9uMEyH4KbQ3hjNnTDgZdW6jWst5vHNnfbiz423B9Q4JMlTLbVhimSLg1oDS5fM28qw4nj1lLPo5owutr4uiH0qw4tGsi1o2C7w7dB2I9h/k7N608bGci3abDO4XqbD/ZyH9FBBKIvEBwUMR48GkIfYwryG3DTo5u/xsXxATN3YCgIHnQ0rltX0sQibAc3FTca8TKJVeugyWW/HCshXngBLPCj5r9WguDSWQI9n/aQ5eKDUxbDV6PQw==;5:DzLgCk9snjB6y0fmNXSv0arJAMZUCgEc57Z9G9ZFKC/QjwkqgxKE1fa+sfZfrD8RrmK7wVRO/6iwkDepp/0Bo5o2XvMEps+ip3sDERwoRHhOOhUN9HaOCJPAprRhcm3HvPPSzQl5Q1qA4UtzIticnDGyrTq3+O4Yr2tu1CDF9AU=;7:bZMvWb6yrL+OMqnhopLLGkprvRGJgEsHcpdN6SpxZgDFN+iD2oaCewnSiqioZKFhOT/I5tjL+KYTigipYvDzIYWwneR2yQoc88zKUWeynWXeligNywjUd3qtCr3bAOBPn1zXKGJvfup7Km8WFIrhr7YhEMqp62ruUdXZ+sr2JfKskHQIeGcbtix+UUTWZP7tcmVuM+M3fXyQYstO1m7hU9a25dRJ9f+PGNy4RZWdUMvTkzRS2hOMtbqYWj6Bd580
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1559;20:iOpW9sdrX7JoRWyaTqUxbiaaRCj89z11v/qxKgauVlYZrMeKUkuDm5kqm4UQm8G0bZj0V5ijmfgaJ2NF35PR0aBK6C5wp5p/kVHi40KhfE0FBuEROBGTIefergyWXxvx/H14OteMtrZTCm/+fMo8AI4gUUsf/hYyukntx8KwR9XX0rE6/C7BJsTUh8yaSioXarBTXq5vt+9cd3r/k6RqjZrLTmwKylJjcVLC0hfiVtRzvoTND3914NVUFMzD/ZN3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:40:23.3721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d824eae5-7fa0-4e41-fd89-08d5f4098f6f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1559
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Linux reads MCG_CAP[Count] to find the number of MCA banks visible to a
CPU. Currently, this is assumed to be the same for all CPUs and a
warning is shown if there is a difference. The number of banks is
overwritten with the MCG_CAP[Count] value of each following CPU that
boots.

According to the Intel SDM and AMD APM, the MCG_CAP[Count] value gives
the number of banks that are available to a "processor implementation".
The AMD BKDGs/PPRs further clarify that this value is per core. This
value has historically been the same for every core in the system, but
that is not an architectural requirement.

Future AMD systems may have different MCG_CAP[Count] values per core,
so the assumption that all CPUs will have the same MCG_CAP[Count] value
will no longer be valid.

Also, the first CPU to boot will allocate the struct mce_banks[] array
using the number of banks based on its MCG_CAP[Count] value. The machine
check handler and other functions use the global number of banks to
iterate and index into the mce_banks[] array. So it's possible to use an
out-of-bounds index on an asymmetric system where a following CPU sees a
MCG_CAP[Count] value greater than its predecessors.

For example, CPU0 sees MCG_CAP[Count]=2. It sets mca_cfg.banks=2 and
allocates mce_banks[] with 2 elements. CPU1 sees MCG_CAP[Count]=3 and
sets mca_cfg.banks=3, but mce_banks[] is already allocated and remains
having 2 elements.

Allocate the mce_banks[] array to the maximum number of banks. This will
avoid the potential out-of-bounds index since we cap the value of
mca_cfg.banks to MAX_NR_BANKS.

Set the value of mca_cfg.banks equal to the max of the previous value
and the value for the current CPU. This way mca_cfg.banks will always
represent the max number of banks detected on any CPU in the system.
This will ensure that all CPUs will access all the banks that are
visible to them. A CPU that can access fewer than the max number of
banks will find the registers of the extra banks to be read-as-zero.

Print the number of MCA banks that we're using. Do this in
mcheck_late_init() so that we print the final value after all CPUs have
been initialized.

Get bank count from target CPU when doing injection with mce-inject
module.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mcheck/mce-inject.c | 14 +++++++-------
 arch/x86/kernel/cpu/mcheck/mce.c        | 21 +++++++--------------
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-inject.c b/arch/x86/kernel/cpu/mcheck/mce-inject.c
index c805a06e14c3..5dda56d56dd3 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-inject.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-inject.c
@@ -46,8 +46,6 @@
 static struct mce i_mce;
 static struct dentry *dfs_inj;
 
-static u8 n_banks;
-
 #define MAX_FLAG_OPT_SIZE	4
 #define NBCFG			0x44
 
@@ -567,9 +565,15 @@ static void do_inject(void)
 static int inj_bank_set(void *data, u64 val)
 {
 	struct mce *m = (struct mce *)data;
+	u64 cap;
+	u8 n_banks;
+
+	/* Get bank count on target CPU so we can handle non-uniform values. */
+	rdmsrl_on_cpu(m->extcpu, MSR_IA32_MCG_CAP, &cap);
+	n_banks = cap & MCG_BANKCNT_MASK;
 
 	if (val >= n_banks) {
-		pr_err("Non-existent MCE bank: %llu\n", val);
+		pr_err("MCA bank %llu non-existent on CPU%d\n", val, m->extcpu);
 		return -EINVAL;
 	}
 
@@ -659,10 +663,6 @@ static struct dfs_node {
 static int __init debugfs_init(void)
 {
 	unsigned int i;
-	u64 cap;
-
-	rdmsrl(MSR_IA32_MCG_CAP, cap);
-	n_banks = cap & MCG_BANKCNT_MASK;
 
 	dfs_inj = debugfs_create_dir("mce-inject", NULL);
 	if (!dfs_inj)
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 4b767284b7f5..4238c65a0cce 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1479,13 +1479,12 @@ EXPORT_SYMBOL_GPL(mce_notify_irq);
 static int __mcheck_cpu_mce_banks_init(void)
 {
 	int i;
-	u8 num_banks = mca_cfg.banks;
 
-	mce_banks = kcalloc(num_banks, sizeof(struct mce_bank), GFP_KERNEL);
+	mce_banks = kcalloc(MAX_NR_BANKS, sizeof(struct mce_bank), GFP_KERNEL);
 	if (!mce_banks)
 		return -ENOMEM;
 
-	for (i = 0; i < num_banks; i++) {
+	for (i = 0; i < MAX_NR_BANKS; i++) {
 		struct mce_bank *b = &mce_banks[i];
 
 		b->ctl = -1ULL;
@@ -1499,24 +1498,16 @@ static int __mcheck_cpu_mce_banks_init(void)
  */
 static int __mcheck_cpu_cap_init(void)
 {
-	unsigned b;
+	u8 b;
 	u64 cap;
 
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
 
 	b = cap & MCG_BANKCNT_MASK;
-	if (!mca_cfg.banks)
-		pr_info("CPU supports %d MCE banks\n", b);
-
-	if (b > MAX_NR_BANKS) {
-		pr_warn("Using only %u machine check banks out of %u\n",
-			MAX_NR_BANKS, b);
+	if (WARN_ON_ONCE(b > MAX_NR_BANKS))
 		b = MAX_NR_BANKS;
-	}
 
-	/* Don't support asymmetric configurations today */
-	WARN_ON(mca_cfg.banks != 0 && b != mca_cfg.banks);
-	mca_cfg.banks = b;
+	mca_cfg.banks = max(mca_cfg.banks, b);
 
 	if (!mce_banks) {
 		int err = __mcheck_cpu_mce_banks_init();
@@ -2502,6 +2493,8 @@ EXPORT_SYMBOL_GPL(mcsafe_key);
 
 static int __init mcheck_late_init(void)
 {
+	pr_info("Using %d MCE banks\n", mca_cfg.banks);
+
 	if (mca_cfg.recovery)
 		static_branch_inc(&mcsafe_key);
 
-- 
2.17.1

