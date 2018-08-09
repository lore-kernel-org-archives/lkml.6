Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6EFC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C5221E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oN/WWO9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C5221E21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbeHIQeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:34:17 -0400
Received: from mail-by2nam01on0070.outbound.protection.outlook.com ([104.47.34.70]:17168
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730803AbeHIQeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPu8OgVcE9mNS73xRVOzqyNgFfwU2w8F45W9PPZMCLM=;
 b=oN/WWO9NDwN7g0dnVqOYBIb66OJdtWq6oU/3uNCiTIaWogBklwtYrcmEKBTQv84Lj8algR2NENWo6VQfrxj7g9C0k4yE0dBU/G83+9mWcBcHD67FipfqV4b4NfD8eiupd6w/CXid67VhSITQ7XKMIpleeB/OMik/Ek4Sf5lnxFM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
Received: from yaz-diesel.amd.com (165.204.77.1) by
 BYAPR12MB2600.namprd12.prod.outlook.com (2603:10b6:a03:6a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 9 Aug 2018 14:09:06 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org
Subject: [PATCH 2/2] x86/MCE/AMD: Skip creating kobjects with NULL names
Date:   Thu,  9 Aug 2018 09:08:34 -0500
Message-Id: <20180809140834.59264-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809140834.59264-1-Yazen.Ghannam@amd.com>
References: <20180809140834.59264-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM6PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:5:f8::39) To BYAPR12MB2600.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbc77773-658b-42da-7315-08d5fe01ab97
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2600;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2600;3:vO8QA8uLEbvBliQvzL7pgdyp/7LEPm0FaOcCmmiKpIaIwApC2dJNZ+f8CD4nF1qTa68nsdPYd/MhW9+Yhi/+etcJs6KbbOsthPvXM4oe86Q9p5CTj5YEOYhumIp3LNzio9TskANA5Ld3fmQHEirXpsI++BylVVtpNKVTwyFnfunHKXBQh9RXvZPOKuEyu/+TKOLCgsbWHa5pjY2m177QDRI07RDNe/RdFQeV6F/OMoESVk1/cgmkGaov4NCe0IEq;25:jw3Lw+9emyWVDNn1d+aJqhkSraYuPWqvKUUNqATBpsOcxSXKGX7FIEQyoFUo/5NQF+E7M1KqjCYF1qONHkj5QWasTIn9D0O+fvwIerBXGu87Akc/ZIyh9xXlhdeUokYsyEtURS6KJikSLh/DjGeFKh2dc+fzA+3HCbVgFybfvtri7l+A/rQyQEyEEKAd9J02u/7xCahbTzrc1UnCJ7gw0l9LligWCTkkEnl5PkaJdlDtVzUX7GeRXZQABDmG8yWzbnhAaKcg3lU4+9i1tmUFnaG1ocuhfsPVe75bvHtZrZka4/xlwucHClktENA09HRlt4iJYIPrE7ZDhuHtBio1tg==;31:tCSHbBPUsLVQh0rKazBpn4Z4oFyw/6CJZOj2jxD7GjUZycXuUkFPxZV2aK58bmKw13EmI/q3QNIalO4AZyREi/wc6d0tkFPyiRCxU0GJ2UySOeGrufOOVFsqgbCXMsdh8y1pAeff5bs1kwFKKJqSPpp5c8qftQWWZHpoCibpVQQyxtFi0l42At7UeyezUMMKQjOmbtJ9R1sGX+DLcpPx+F6aAi5DBCwr/ghhaDj3gVc=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2600;20:KDiH8LduL6Wq6ew+CkkIdKNUfPNXWTv+HKDWLSJ0O6wAB+qBHgbBYAtpwZ6W/0qKk+igMVh7+ohahMPjzc/iC99SwvR66NbekdOySrtz5hxYCe8+zNnYmFKkzEhgT3OlLQ1I1+3iOt1NHh3sY8TwTi2jPKo05Ey+UEOhfaEGLfDPadku9YLkuGbqp86av8atrcw1Luk+ISxfHJJY6Gw69FYH9P4sNeC+mycHIM6Rg3uBpnV7wCf5Wk1c6j66Cb/Yw/THMH2OKqP/z5RMJHSnEmylTOFnBxWZ5GV7KgenaFbn7QooWAYGapN9u6i3yX4GGuSKhq9Szl7dLHOXaINBUhwl9mJBgU16lip5uUnR8Qo3lP6Vx77ZS1Gm1yfB2fpJ02rbhWWLqnai7iKxxiFACPQLoG/1+7ntUkIzB+blCiMSZSwPF92TJe0WOSaBQzgN8V3RkCODdq++euutHNhRsLNRJyZBR+DxuiGnraprvclx0RfjbfsCEqm2b3+aByCa;4:zwwbXEFQEYsCUXfOpDS1fCj8n3jNkzxyDeQShMIm3jwi4xcSpk70jAMEro7Sl/Ih1swj2h5VbfLHyPG170/2dd3KA1FN2f7rA5gvVjtsrr+IUM1mftsGessbFZYBHyh3jRznXrMgmeKKhHPTiq5y59aURCs8GgEj9zgnUqc1yoXXM7pelSivQf//MUAXPczLj7Ur6Cf4Q62IRoGs3EG4WhYL6QbIPPBdC3OI6Va0+XDRwV+HD99fwov8luopeyP+o0ixbpVZg8VzTW5ThhBSNlmJWdrUcto1gDwKzj/cP8h5MI3cgA9WcS+A1amoQDmng8GPP8ScgoxMaB3d5VPewg==
X-Microsoft-Antispam-PRVS: <BYAPR12MB260050070EED6EA7C1ADCA25F8250@BYAPR12MB2600.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR12MB2600;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2600;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(8936002)(106356001)(50226002)(8676002)(105586002)(3846002)(81166006)(81156014)(68736007)(11346002)(48376002)(6116002)(1076002)(36756003)(53936002)(446003)(72206003)(53416004)(2361001)(50466002)(14444005)(476003)(6666003)(25786009)(2616005)(486006)(2906002)(52116002)(6486002)(478600001)(4326008)(97736004)(386003)(6916009)(7736002)(2351001)(66066001)(316002)(86362001)(47776003)(16586007)(956004)(5660300001)(51416003)(7696005)(16526019)(76176011)(26005)(305945005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2600;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR12MB2600;23:VrVRBHDY2AfMKCgcYL4QekFEBfF8XWu5c+7TUaHkm?=
 =?us-ascii?Q?LHwc1rJjj23RxWvichbp6CuJN1hf30NJ/9+FS/GdIU8/yy+7fbyLXCpfk5wj?=
 =?us-ascii?Q?Z0E0aFGOMRvt4HYKL+AafYQuY8hez+d5tm4bf/c/L14Lkzihn1W5WCnrH2kT?=
 =?us-ascii?Q?dBg4HjELyGAy25xU8Tc3SYvoOEZX9b06p5wb0UTyZE4dlRw7XD5clfyfeST8?=
 =?us-ascii?Q?KgUCwSQ7YmHgbIyCZ0gi4Waa+HfKA9BxvPU24050V7Yi+JOdzf7znlm2jpwq?=
 =?us-ascii?Q?IFMCQdPaMtHbc3b8FV9U0XyDGcObyefgHi+hb8ICmrX2NoB6CkKb0Zwn7Y5E?=
 =?us-ascii?Q?OwUhMzVv+5/yy9N3SDXiNilYQNYIszUQdlpz/vWYxDXUT04Bqm67+6u7594A?=
 =?us-ascii?Q?bbYcyfUrGvIysGlsL/mpnr63G9rwkhm+ZrvhOHKr3dxmNBHX7dAAc0jZfa+H?=
 =?us-ascii?Q?jwxA0WFEA4bqmzi1jkqBP5/yshcp7hx9taPqgn/zOVA2jN7ZrreDzogauUEV?=
 =?us-ascii?Q?cI+wKMfq5QPuwyp0Dnrcl4Fwp6IgyTqAZFpLJIb0aOgb090WaUBh4DzgESMv?=
 =?us-ascii?Q?W+miGhuZtiS2cKkYwbasmo9ngUgAYoQfnbyBSjJq+KmIGNTv0hxot0RGZjyj?=
 =?us-ascii?Q?wburGF+wKrPw0vtnKii/WwfXD0PYNyu9Tn/cwyxQk5DZToifu3A3O71zC8X1?=
 =?us-ascii?Q?EZKdHcaLacFTkxcP75VSeRpUBDM18CK7r2Oapx+sGnBvPJctcLJJZmM5+sP0?=
 =?us-ascii?Q?Di+2SRVoWPxnng/Gic8GY0huJ/7oZvJq4ZdaAUqZQeRRJICIcbNjb27vAYvY?=
 =?us-ascii?Q?kmkLf1fs+A1gRAfNPJ0JeqQQ/Fc/M52TUEQdqahSvMgilIgAK0eTJAz/IAXH?=
 =?us-ascii?Q?tWxJlPjBUsmA+Q2Y4R7cRQf5AexYI4m6m4q42sViEXE3mHKwvZXnMnbpQVwQ?=
 =?us-ascii?Q?690354KXq/gJf5dCvsn76vP4EDMwJTslpaORdvMqw2XNCy5d8a/chmhM6Bcn?=
 =?us-ascii?Q?YJuExXCSJgvIFrGSzNh/SBXiae30dOjSFkGlyW/wsHZkQdR485vgZat3z8p1?=
 =?us-ascii?Q?RLiK+/bg92FKOpQQ4PdKIpWeuXhsFgLCwMsiikgKHHOPsTj3ALRrRcBn1YUj?=
 =?us-ascii?Q?2crcBrERXp5GkMClLKeNIF+/A1CmcrFuIgkvML1iNKM2dRv7UQdWgv76J0x2?=
 =?us-ascii?Q?/B466U6A4H9UTNpoL0w+Aq9eEwfAGtpbo0D2titXRQ1OtcyoIhpgSFcDopW6?=
 =?us-ascii?Q?FSi72G4uMDqq9rnk1ursTH7i2aYjFsx03tceg+V?=
X-Microsoft-Antispam-Message-Info: 3XXxyOJDZ3DXstkjvdDAfA0ob0odLeWZzMVIrPcecBLD4j+873ISiWKMG8vIKkrcFyPtPsEYQ4hBspDbq9vf8EGwIgj/tG4dmGn5bPBEXgBXKaTPE8Kr/IiGEKwXUh68HpRd+AfXJVtUfnyzc2Ce0d+X40CtQUBn8X0wocrUBj4vaVn+dKaP4OZgzjJurkapMXRnTRccT1cL9OJaP0qW8RjvQXh+E4jSrgkaD+r26FifSwXZqo+bwiihkOMh7Lp/zDFDDH6pwVKzcJ8sbJEg+ARvZItdIK1jZYXvrkxLE25B1dqfcyDppp9bE0tJVA7gEajOBog/WYLIpIKAFzLxBAQdoZYKUYPx4VvxoJxmqto=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2600;6:hhr3BAm16v3qBLt0Bid9BSvmkZPpyCCFGt07uvW2frEBhV/Qk524AETEowmo6e1Ksj0LEARNnrlkumJIGz//gIYcypsDipancQyb2oArtzBWwgeUVBaBqGTYMhCjjM+kBXXFbGxVw3+wwbICxM7fdDhF4fFv7x8K+b2H/B1yETmOpeSnVKDQ95B/LJ/lI/W3RboMmPTQIiLKA+mQJVFJE1yKq9yt8Pwz86Fh8L3Wo0ELk6C8ae5M8kFXTgd8u34lXwE8ZLyusbTo3vnPPPKszDzP3wbEJdG//actP9NY633EIqWp9Q93RRWGkH7hk1Q7n2+rCT5g0Ls+r0u6OAjdcO2vIaErguMq1f98ceV39GAYTGisQaJbdnPRi1wMZw6UXKE1KaxvXVv7TMSEzCZ35AfVV1gvoIUjEs//WQCZC+cPfl8Isb7RD5DneUqJXVFTgG27gi6h2KmXfD8M7pK8+w==;5:JRGpi0yam+Wd+3ikGalPnoQurvaiA/WPAdvW7cIsxy2ylsTo7x5t9M4y6TVA+YpbLhOp0edMXeMzOz3hjE+JPSddoq+2GrvpC1RnERYtekrMJXMjAsw3XjBoKGBf98gC+IBMxBXbH2MadbkJi59SoLch8z9F7CraiXBoFZqS+lY=;7:e9ihQz6+QKdcAFecmFarGs8kmeao1F2KRoMAbOXhdiVndoML7M+9HteHHjDHjm5cqt72HS4EXeh7xRkZAtmThjAdTh6XrNaqr5Qi1+MFGcQbCt4kJS/pEb0XI+67SOm/PDmOA62E6nxJuyL3PulH2V4pGAeJyV+nqgvzUIaDVv/tcY6XIquh0rzeBoTjEaOiB7+IC9WlVRhrmIcv9Cp7JP22PX7/07aOjEOztYYl9NV6WB9YGfUxEhWHNG10cMcB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2600;20:2XVhSrhGEp4k9h2yR3y5zj8pEU+2EE0di8G4XAPZSU9UswMCAEakn15WKE2tzK/R2xBavdKNhqYbA0dyqdu0YUB6DCPk8ZjKqtrlET8Fawhvxc2kj8ELR+/MazSULHr56LqlQZQdVuwrM0atqPJQXpujs2NyntNlHjm3ujhNHl4CG6/xzQiy2UK/SE60ZklnqQsLvo4qDkT2rvXJJ1ngxuRWOXqOhcSeHHSY2mvOFkF3lQmRwBYpa2/z69UJvR6A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 14:09:06.4060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc77773-658b-42da-7315-08d5fe01ab97
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

During mce_threshold_create_device() data structures are allocated for
each CPUs MCA banks and thresholding blocks. These data structures are
used to save information related to AMD's MCA Error Thresholding
feature. The structures are used in the thresholding interrupt handler,
and they are exposed to the user through sysfs. The sysfs interface has
user-friendly names for each bank.

However, errors in mce_threshold_create_device() will cause all the data
structures to be deallocated. This will break the thresholding interrupt
handler since it depends on these structures.

One possible error is creating a kobject with a NULL name. This will
happen if a bank exists on a system that doesn't have a name, e.g. new
bank types on future systems.

Skip creating kobjects for banks without a name. This means that the
sysfs interface for this bank will not exist. But this will keep all the
data structures allocated, so the thresholding interrupt handler will
work, even for the unnamed bank. Also, the sysfs interface will still be
populated for all existing, known bank types.

Cc: <stable@vger.kernel.org> # 4.13.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index 2dbf34250bbf..521fd8f406df 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -1130,6 +1130,7 @@ static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
 	struct threshold_block *b = NULL;
 	u32 low, high;
 	int err;
+	const char *name = NULL;
 
 	if ((bank >= mca_cfg.banks) || (block >= NR_BLOCKS))
 		return 0;
@@ -1176,9 +1177,13 @@ static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
 		per_cpu(threshold_banks, cpu)[bank]->blocks = b;
 	}
 
+	name = get_name(bank, b);
+	if (!name)
+		goto recurse;
+
 	err = kobject_init_and_add(&b->kobj, &threshold_ktype,
 				   per_cpu(threshold_banks, cpu)[bank]->kobj,
-				   get_name(bank, b));
+				   name);
 	if (err)
 		goto out_free;
 recurse:
@@ -1265,12 +1270,16 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 		goto out;
 	}
 
+	if (!name)
+		goto allocate;
+
 	b->kobj = kobject_create_and_add(name, &dev->kobj);
 	if (!b->kobj) {
 		err = -EINVAL;
 		goto out_free;
 	}
 
+allocate:
 	per_cpu(threshold_banks, cpu)[bank] = b;
 
 	if (is_shared_bank(bank)) {
-- 
2.17.1

