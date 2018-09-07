Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99348C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F10C20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GYPPmWo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F10C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeIGWj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:39:56 -0400
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:59456
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbeIGWjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6NWRmT1MHxuQGpUxYzj4VuHOnSWLDZMxzj86WU5iPI=;
 b=GYPPmWo2SsB/N5nrG0eGhJ2yTBlvYm6gcRm2rKHZFih1HJUNMUW0P+yb1waVtbTCIZqCPj0m0ucYOp29BcseV4WdkfqANVmeu6s88MIv8Dnf2bgRpqCMt+0szjCa7uWxZEcB4jV4JRLkg8swIxQne2cJ9MfDxXB666QV7/CqHWU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 7 Sep 2018 17:57:42 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v6 4/5] x86/kvm: use __decrypted attribute in shared variables
Date:   Fri,  7 Sep 2018 12:57:29 -0500
Message-Id: <1536343050-18532-5-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0401CA0004.namprd04.prod.outlook.com
 (2603:10b6:803:21::14) To DM6PR12MB2684.namprd12.prod.outlook.com
 (2603:10b6:5:4a::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fc228f8-ebac-4505-116a-08d614eb691c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2684;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;3:xSgBWy/zVrbo4/s20I4Dcz9nNKMKIPZVvUVgsxi/uUeynS0fftPq44MBvDIRmRXU59J6w9AOKH9KIG7UreFdNgwKLdjb/9EvtlWnODdygCZ0lvlH99wbU9TQrV2ZSnFK4f5b69nEA3E+xKYgUeHMiH+46JoC66BiJ8UqFBKRnyxwqFuVW35cDCGFzoVjjH/PXY+cnXvc4wlTJFoqLTJrjpJCEogaywjqItb85U7xD+ScC4L1PC64SCKK2CB0aNcH;25:+l9ny/O9s4OpHuX5/XFvWR9EvjUyjxRBP+mkK5kYhHU/moTBeP85VdgoWKAHrYB6AVFTSCbrcykpA0eHVimyJJLSAY422Iz1ANYXg8vvAGKXe4AYNjk8qgEjZx3JTAU6Cf42rrdL7pFQyBAOozLbfVLMsizBfHHJ36DTXDucgGg4lwoMz+IrogL3uWabhLGy9Sr4ZMzhFo5/BqOxfa20jdbCjx4j9BC4SOK/4WBl5n+LFcrJ38D0Yw1cMZ2JDo82VXKWklW4sGLvNkBqlGxOVJQyMGP5+D9cuTz5z+2AWjg0sPDCL3VmGT2okiwpYblKvmMnCZAfEpm/+N+X5dvmug==;31:/fuWaloqrHNDD2zyu0Z8pARGmP49Q1vADn6XuiO16eKoDZNGO2O+vunwVv24vRGv6ChgmCxooM+KF2AJviACGT/8Sa9AZuZWLtcFnM7Bw8w0mF0lUQKobBGGV2R5yIO+n8uMSyubiE/Q8/eZNmdzDjxrlbOr54RRUwyNu/rIKQEPWVzASNlGoQxYo0CBgmzQAPdaf+kpApQgJgHJsM8uixcO3ezLhueUXFBl41TWSRs=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2684:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:vdYuPy6uTWeI8nkmvU/XfpLNQmQorQLMdaosfCXvtD/sg6nxhOoRZsg2LAx4330Dv59XwTSi8roWTaLPMb1Pm1a56RhnoXuMq8WI4RDMQvPvekFlFOJ2UAFYpXYSAtc7A6pyBhrvE1vY+UFQMMPrGZeFf6w7fGH9J+lWC6x/yAeuMskpCYMKr2+5qCYY8Q3dJWCQR+YKzdcKTOBkksJcQ3dxbNCkM0yHUjhi56z7BiXyAJTRzqLgbvH/hOtyn3nkRXbctYlZemA+XjiM5bykxBSCdSu3lE1H8aoVWym7fdlKtuvWSq/Rm8txYJuStrPudm+zkElLRmLe4QJB+F1OHrZPm/oYa7nEc5x5JLjoBEX8fmx+S1YDpUNw62BdAP/xQvitPBKSEeB0huvMAtaHJcD1l+N7LrPwgqTNH00X8SBFPLR1eDUKpYdgstxlNsybeyxd0R2+dLdkvqAFXEzePXD8DD1sc/miTVOmje7flbH/ydxujy072XS/mJ7vXbZd;4:m4IXGEE2Fo/uwfWHexEzUGdFoK5pe/NcesAADYk35Fj2P4xBhndd8iL0crxrT6OU5PRFmtCzg9Kx6OSkHL5MvgSYNvnKrBjRDzoSyJjGimbfnIkR7v+fceZm3edEanyCxO8YSoZNRo7gYFTQuNe/lUUVDmUq+tmofrYoGldHrg1Du1MN47FHPuw2ZFDEnCjv1kDnsUbjhe2d9SDg/4DUom2SUm2lg7npr7o9vtgEMrAZqUOKfqFhWZ+0DoLc+Jl4QDqnB83+xjgeNBbO168W5G89U+g9OT6RTrdzy2H5/lMtQBoYMvYZOOwsBO9YejIdL8QXu1Om+x488FFk+O1jLshKeQPDgVw3Emx5JrzbL4nWrW+NJUgkGD+mxtswAhLy
X-Microsoft-Antispam-PRVS: <DM6PR12MB26843555F32E5B31094880A1E5000@DM6PR12MB2684.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:DM6PR12MB2684;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2684;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(14444005)(8936002)(81156014)(81166006)(446003)(476003)(2616005)(956004)(86362001)(11346002)(36756003)(486006)(2870700001)(44832011)(2906002)(47776003)(25786009)(50226002)(66066001)(4326008)(6116002)(97736004)(6666003)(7736002)(105586002)(316002)(54906003)(106356001)(76176011)(3846002)(23676004)(7696005)(8676002)(305945005)(52116002)(16526019)(386003)(186003)(68736007)(6486002)(26005)(5660300001)(50466002)(53936002)(478600001)(53416004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2684;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjg0OzIzOkx1dXNrQis2QndBQ0huLzBDRnV3eWdwTWJK?=
 =?utf-8?B?NzA1OSt4a1ZmSGZsVW1FSExvSDBkZFIzL3dnaUFjZ09FaGJUK25OS2o1WFN4?=
 =?utf-8?B?SWRtQTY3Z1RsdjNyN3ZrNytLRGxzV1JRdTZqS3BDMnduNTdUK3F4TXJzOXlj?=
 =?utf-8?B?ZzYwTDJZVDNyOFBucll3L0tpRmJVeXV2a01GWG9OQUlqZk5zYTlOWDhYeTVn?=
 =?utf-8?B?M3lERDBIbzRPREQ1SXFLT0xWSXBTbDRoV0dnWlBsdGp4WGs4QXRZQlhPTEZJ?=
 =?utf-8?B?NlF1NGtEblZvL1ZuMHR0UWZ0ZXJhUnhaV1dBcHpSQkZYcksyY2c0bTBHTkZC?=
 =?utf-8?B?UDBkaDZOVEdnbjk2d3VyaHZoRmUvZ0MzWi9FeUFPdTdySnBYdWd0NTY0Qk9V?=
 =?utf-8?B?Y21RMUthd3daL1dCcEYrOFNFbWZnNjJRNVlRL3dLUGluMGh1K0hUa2kxc01D?=
 =?utf-8?B?YWpEdXZueG00ODRBYU1OOXJkWXc2Q1IwbktTRmRMUlZuU0hLRGlOYmQ5Njdq?=
 =?utf-8?B?NDQwTDd2UFpsRDFsNWM4NE82cmlDM0FQS0R2R0s3c1JTaUZ5ci9WSW82Qll3?=
 =?utf-8?B?VUtKQ1VVNXRuZHI1a2E4MGE0cVlTa1hSSGpiSXhHRzVxL2VLRXVLc1VYUEtE?=
 =?utf-8?B?dTJMNTN3eHFXZXhhZk41Sjl0SEx2MDJ3K2xLYURQWTgwelg1d0hKOVJ5aWJn?=
 =?utf-8?B?SDBHV2gzN3hJc3h5TnlOTHlwL3ZhVElHMHh2T0djUURaVVQrRzFMcThWS3oz?=
 =?utf-8?B?QmZoa29TNldvek5wMjZvQnFYY1ZjaW42eGNWRm9FMGY5ME01eVVBYUFiazdk?=
 =?utf-8?B?d0hUTVRRTEFEOEJmTWI0NkdURG9SQmMzZ2o5RHFsNEN0RjcxbXkwb2pkbytY?=
 =?utf-8?B?OVV5RXNHQWpIeTBZNEt3c0M0QXd3cnJtUU9maEFDd2NmbWoxVUtUcXVtaFgv?=
 =?utf-8?B?Q25DOHAxVXJrV0JCSVVoMVNrelJmVzZWL1NLNEZ5VjRmSFh2R2cvYnBST0Zs?=
 =?utf-8?B?NWNtWS9uRFJEdXh4djlwSUpSYy9zMThPSmhzS3JpK0FObzRUaVhremNFSHY4?=
 =?utf-8?B?ZVhIRWEwRUFZQ2J3UVY0cTRob0JiNVNidHhxR01QblZFbmF1RWJURGdweGNa?=
 =?utf-8?B?VzdmYjhOcE5QWFY4TjRvQTYvNVB1RVlGTVJuZnZadEZPQXpMVGNSWWxmbmlK?=
 =?utf-8?B?cG5RdWpiM05vUHZrNTBJUnN4RU02cUFFUVRsblZRRmxTcklKL1IycGsybCtl?=
 =?utf-8?B?alpkdWJGUVRERnZRWkFMcG1xY01mRXEyVHpGVFdpVWQxU09ZendUcWpPRkI1?=
 =?utf-8?B?OUV2bWwzRm5TdmY3QUo0V0lLeVd0bjdaL2RVdkdRR2s2aTNNdkNtK2tpdFpH?=
 =?utf-8?B?cUdCSkFmUUUyZFVaL2VtdUZiQXgxNlpITFBrRk5tUmtjVCtleFZ1RCt5a0JU?=
 =?utf-8?B?MmhzdHdyNzI2VHdYTEVzQjU0T0RuTi9xZ1I4WTJQSzFtM1MyOHFOUWVtbXU3?=
 =?utf-8?B?L1NNUnBDRnUySFBqMkE5YkFiRDVac080Z0wrRW13VDIydGlEM3N0NHA2Mk1J?=
 =?utf-8?B?a09oeSsxRlpKZitzUCt1dFQ2dXJwSEpwQnFZYTVyRldYc3cxL0tlSjg0L005?=
 =?utf-8?Q?cLc6FSeEpTEx3mAbDW9q?=
X-Microsoft-Antispam-Message-Info: p1NE2tYIbDuhOjHjhl4zU5s2v5JG7kslsYkrb9YCFdWa29EsvMzqtS4k5EWmpKw1W91bE5+f/sfvJChrthNkq79R0C7TS7KzYfENHMqjBXZxS8OYyMGhO4e8nffKVbLBHBfsCiT48r4jyQQHk4v9HuJdATpbQmxuCtUSfW/Jlu/riTW6jVVnt6q1FNzR9kQ5bRc1MdJWXsz39WyRBOgteH1tFHq7QvRtPAi+Lo6tfTGp/YsBV8EAJDsoc3L9uNMIU18DfgFuqNo4c+tPhoClt3pI2TZJitlSbr6PaC/7+m700oXDVRkVqqOWBexMqZp/6cSEUzi+96zUjkK8bY54qMbmJcHwtdyOwWG5gwO80mA=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;6:KvDqsT1e6R+VycoCkPjD+yH2TviADZ7gzCQNow0MMKS06qwvVX+wTnQ+q6PTUyMpurB51o0//rsEQnPdfIqCvJTsbK5Uo7HC97a5Hmc3ds44hi4bnzEj+3OuclmsXYoMXnOj2je3FsqRMepjb9KOgV6WgaBLZeYpssrIj0CETsoIqc1huFckLZvI1SVmrrKM7S8eE95nOjtURNjgMQiL/x3wyM9RSeNcgYWX9DFhKJaHyT464vRnCBuS9Tr0EICGdN4olp1KOTcT6DRhPR7a1Cb6IKOOtnthjiz7MfK3cy/8V+2eCPgQOGYbrYQqBvBoNzPFl1TrFckznXPxMhJVboVoCdKcQIGPuBX8I/UVEtDQ25O/bJVz1SN4hfkKfvMgDVnLESD+zyRy3dclz8Heuzh4JSPbj9C13RZDYzosqd/uGQSZOZVY0JgToOECd+SPcebCb+jmZ5d43Oo/dslV4g==;5:TLZfW1ftTwqG0VgS/ILeosKU1zIEBzIU/jF2HFczipmd4OlG42KS2z13IxG6Aub5M0+ap0zdyIwSWjVyuemt+zezTtwbaO5yoyOg6SYKtv3gWS1sRF7RoK7lpo1G5zZE2313ga4hbvdYuwidhOl5kr1++AgdirV1Jbh5a1H+z7A=;7:MSnk02YQkTA42FUfr8OPmnf0QvMF+EzW/EXpZyFqEZ/07vRW4bKaSZp3t/1Sz1U3+TKIPE1I70ZdgkMXtt3yBixQcmwqrjI4/hLol90BAH7INiwFG2RuZOM/cRl0v5Ksj0QXvbL5fLsTnRyvgdMP4F8SuofujsExub+kWepp8pdKCIu9OOYzW/ceFmQCuOrvSRfE25hI4sTNhv579aWfdoANvT5IJtilbS1xlHdP1I/3CBojTPcIekrQCHmFkT7d
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:nSYhT/GI5zeBKmEPuvp1b5qOaytWfZge+2sn1e1MMWPAjp34sRaokHO86Q2R17ORQFbzwtsbZ6BVgz8R1NZHM5J4iE+Jvm8WzkM3iuBwmFmm+wgDQI/mYdpTGQVVjlMK3pLUjxa0GOYQNOIZ/amicdDR1thnnDVG8tE0w1mA4l9nhWpZBt+ncST4OlULWCLLEWYJ5tNrmG9hC7wFgDbarIeuDJEPMd3/eYgKH3Jt2azOyloHHCoh8q+HzI10GnqP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 17:57:42.6206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc228f8-ebac-4505-116a-08d614eb691c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit: 368a540e0232 (x86/kvmclock: Remove memblock dependency)
caused SEV guest regression. When SEV is active, we map the shared
variables (wall_clock and hv_clock_boot) with C=0 to ensure that both
the guest and the hypervisor are able to access the data. To map the
variables we use kernel_physical_mapping_init() to split the large pages,
but splitting large pages requires allocating a new PMD, which fails now
that kvmclock initialization is called early during boot.

Recently we added a special .data..decrypted section to hold the shared
variables. This section is mapped with C=0 early during boot. Use
__decrypted attribute to put the wall_clock and hv_clock_boot in
.data..decrypted section so that they are mapped with C=0.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Fixes: 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: kvm@vger.kernel.org
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
---
 arch/x86/kernel/kvmclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1e67646..376fd3a 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -61,8 +61,8 @@ early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
 	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))
 
 static struct pvclock_vsyscall_time_info
-			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __aligned(PAGE_SIZE);
-static struct pvclock_wall_clock wall_clock;
+			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __decrypted __aligned(PAGE_SIZE);
+static struct pvclock_wall_clock wall_clock __decrypted;
 static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 
 static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
-- 
2.7.4

