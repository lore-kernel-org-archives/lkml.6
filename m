Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9283C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8662320855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rWowcCwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8662320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeIGWj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:39:58 -0400
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:59456
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727788AbeIGWj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2m8HRzQFzN854GkvPKpkwzXXcI/+sRpyoysssIAjZU=;
 b=rWowcCwdaY/aUMVR/iF5NNw89k49FPnz8MgcpXagKijDJLHuMszkXEUmRoAp1SugGXoNbS279c+GRFWBKA6M1ydPMaBhzBHKM9Gbp/zvv34yev7ZrzdDgB9WZBn9Ee1Y/HwqgBP2O1C5ZMf9wXqIjfT8R/it+zyGQc+RmzeiyZ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 7 Sep 2018 17:57:43 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v6 5/5] x86/kvm: Avoid dynamic allocation of pvclock data when SEV is active
Date:   Fri,  7 Sep 2018 12:57:30 -0500
Message-Id: <1536343050-18532-6-git-send-email-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51e8a1df-e131-4bc6-b169-08d614eb69d2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2684;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;3:HcHogJlCBHFh8CNPlOqMurGLbJqUWY2tKVyYG1yuePyPTiNC+9xv3AfyqgZLhbGxuq9a55bdvSYb5ghphMK4+YMO7pXPqn73+gOvhIxhOVMj5r0S+fJPdvKN8XmgALKWTqK3eZDy2sMIUa+1ppU9DKSGVpN+F3hTl0gxx6OYn0gPTvhP3HEk5fSueaBEOD1o/wVJM8pU3EuGKHcXMX6o4mN4Vd/F7MZ0RhPQgTqvXFE1jWEGNQqOPOihksLQHbYj;25:yTM7v+/YrZJ4zcRkKDVZBTFFSDOTwPIawpc+tPw3ha0GbKKZW8FUcSgV6wcISKDNc+Qhv748T7NHdEUnWV1rA0eDGYKBHwoQxxJjCqd1Xzl+JEegg3cYsznk4+gqIztYzwJvqIGAS9krPR2iThilhFe7KHHloi8RBz/GGRbqDgCNAceCffYBkK4XneoxR/rGCss1zw5Jb+Ugk39mWJj2KNhwa2nvaCBcXkfJAjnbOXcX+JbK3AFNsQT3CzAd+BFuLPkeixSE2wUDXdZ3OE/2GvYxnYepCDp6tCWg9CP8OQpQ+bKvBScfn2jGo0i+2zDxlUvMHEpII9a6ProgNaBJMw==;31:Vkt3srfBPd7g86as0Csum2JmnPBfMKdEoWdgueAmElfzYk1G54NTrsKIzgdb6R4L1bGwLukoWZ4YEAqSQxeBLMPGmJ5J8lcka3RJMFH6SOoD0TwgRExxQb1LfqlSvFwmKNnSsgZUeUVwLnUC1860/8lrSHKjKzyrHwYOoQ6WQMIw4luwcghmb2mukda1NzaHlQMLFDanr6FhbVOg262LS2KMc2k1xKkz1IIKeAcmMYY=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2684:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:l92uAN975segWTJtejfcExOed0DASgPkDZ3W4eXWTAy7A6s41JF0pxSPO3r4y/m35ERZmpNoyTOwuJSDY8i51DG5vevfWsR4Rlu/Ln3o37tN23IBr50c2/+OibL66bymB6csfJwr76KRFYBuuYzLVKouJWcjgKRSTRaf8z0mc+RS1wFh+KosOR0bqnFmNa18VpaETixH378hWyynzpaQPA3FFEoCKv3VEUZX/zeZgtv3Fv7S6S8cpXSzVsHcSigyFkhs5PEA0J+nl7ez6m5w62MSED4khI/xwTOYBpO7GJhGZTlitUt1N9+uYx3jX+dxgGZRMCLIj+rlEKrU5Pc5R0ht3N4+KaiwAJTvnTWgV2Fut7msdcYInebI9cKXzAqF5lCQMzXmnbCyPEg4bA8rcKOBvFV1XNr3Pu/H/o5XsT/Vvx2Kin1mM0JCnvb2fNvsVsxOq68l9dUfg0twDZSd0T+FI6aBTX/BIy49boWM+udARJdanllPhhXUrmwRDT1O;4:x2yVW9M6JXOK+PYXgIxsVIIo5FoeTHDo8/CmXCcaGoqq+SjkPLtPX6zjMhyEZOREUwslEWhG2XIg3WyJIpznQDwludK842Stxd4+Vi4bDrHpWHbi/4MfJh6aPUrpDFy6UJ/1Zxp7BqkxL/pUZD9dtyRJ002ATquP2lfHLZgo1u86T6WcBNsA14Zhc5JvgxMZfqP24d1F6bUujuX6x+U8PBvTSNZwLWs1kHJOE9b/qneehgooyeiLHMWOgazttVABgeYefY0MFw0HdM8aCy+ywBLugNixXYlE52ze8rSNKGbtemgoIWd9lUwXDTsYVMFzkANeFm27ESBMTgAaOrfm+1w8DKs7JLGMxwKLemuBIPWb4sWQRcaIzBYy+417xMxx
X-Microsoft-Antispam-PRVS: <DM6PR12MB26849A5225EE5EE15A5438D4E5000@DM6PR12MB2684.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:DM6PR12MB2684;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2684;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(8936002)(81156014)(81166006)(446003)(476003)(2616005)(956004)(86362001)(11346002)(36756003)(486006)(2870700001)(44832011)(2906002)(47776003)(25786009)(50226002)(66066001)(4326008)(6116002)(97736004)(6666003)(7736002)(105586002)(316002)(54906003)(106356001)(76176011)(3846002)(23676004)(7696005)(8676002)(305945005)(52116002)(16526019)(386003)(186003)(68736007)(6486002)(26005)(5660300001)(50466002)(53936002)(478600001)(53416004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2684;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjg0OzIzOmNMSHdqMUdxL2NMMWJvL0liWWwrSVNnRDhs?=
 =?utf-8?B?dFNsNTF3QlcwTEIyQjBYQ1VEMHRMeGdwMVdFQStFdmtLZyswTEFKTDRxQWRw?=
 =?utf-8?B?K3FBZDFIdE8vWjd6QzIyYlhIeWJRYS9yZnRSckR0Y3MrYlhERGlaVC9Fd01F?=
 =?utf-8?B?ZFVhOE5aTHQxeldxZjVZekpUUnIwU2N0SzFTWWZJQmdabEFoUkM2eTFOampl?=
 =?utf-8?B?bGlpc241dzhseExvNjlmYlBxRVJqUXRBbnRhOHpOaXNUM3BWeVBKSXo3Nk1v?=
 =?utf-8?B?bERHaThQNm1tMURVc2txSENyUURWTVRZU3AzZnptOU9WL2U4RkQvL1RES2Ev?=
 =?utf-8?B?cXVKcG9DYzhMYUhHdnlCVll2ZVU3L2dYYlBPNjAvSWpDNnFGK2paV1U2VW5N?=
 =?utf-8?B?bitONjFoUW5pM2RaeHR5VTl2UFR4aGlRbFhqN1AvRjFSb3lrUmFUeUE4VkYz?=
 =?utf-8?B?Vkg0MEt5blZqSVh2Mk5KdW1xU0JORlFkUmVSbVJnR2c4QTF0U2pxcExqRWJz?=
 =?utf-8?B?R3dkelFFcmlLSnhTakhhWENuUit3M0xlYmFpbUhyc3pPNkVNamxSYVFRaFNm?=
 =?utf-8?B?V0ZhUEYydEpCRUQrOUd6NTJ1RFlydTZxOWkxVWk5OW1PU01ia0htSWdKazhn?=
 =?utf-8?B?VGF1SWhhYmVhSS8xREJYQm51Qk5GdHRrMG9VbEdGb0RFakJDOUUvZ012UVFD?=
 =?utf-8?B?R3VaOXJ5MzBuYXlCY2NPK2doa0ZwYVMrWkp0WmM3a3J2OWxDNldaU0lHYmNV?=
 =?utf-8?B?YStKR3ZMaC9FRENmNVBsTVZaWkRuOStaQkVtNnhmb2JFNmtpSHAreW00MXFJ?=
 =?utf-8?B?dTYwbWRtcm9IMW4wQXhDV0VWN25xN1FZRkJzd09OMXdJeTRKamw2LzZyMnA0?=
 =?utf-8?B?MzQ4aVQ1S1N0UVJqaDJZb09iUzBDRm5WeDhwTXdNa0FmWFBVT1JLUWpIMGo1?=
 =?utf-8?B?cFBJWUNyZWdPRDN6UjU4ZzNxZFkvVFY1R1Y0Q09rb2t3Z2NlNTR4RTRZWmpj?=
 =?utf-8?B?b1ZtL2poY1RDeFpvbFd5alpCWkV5aG1iMzdFQ0hJazNzVmdoYndMd3JhTnov?=
 =?utf-8?B?SFprVUNPMlhCNEFSTDVlTzQyYitndmhrRHVwQTdaeTFhRjBwYnZsL1NwRFZt?=
 =?utf-8?B?c1d6T1VzR0pxdXFsaGZxam1rN0U2TWFxVU9BcmtabnBKMzRvQXJaaGd5NFNo?=
 =?utf-8?B?VjROZlpuaUM1eitHMFNScCswYXhEL2hSVE1vQXVjNnNuaWJPYWlRN1pWU3VO?=
 =?utf-8?B?c0cvY0tJeVhJTjEyNEFlNURCS3F2RU44NVhDTTBJeWs3M1pqMTNVbTgwaFQ0?=
 =?utf-8?B?YUg1eUtGWkhlNVRjZFVhNnNPRWE4T3dKdFNHU3lyYkQvbUNCZ01GMWlnOFFv?=
 =?utf-8?B?ZiswellERjhxaitwbnRaTlpNSW9ydi9iaDNqeFAxQk5SMnFaR29Kb2g2QmhG?=
 =?utf-8?B?NHpwTjRnaGdxY2hHRFZwUkhwYXl4dkZKUjBDNUZVRGVkNHdlZmh4UGgzWWRT?=
 =?utf-8?B?N1hrQXJuaFVhZUNFSEVjNXk2dlV3c3hIMUdrVWFpYUdzNVZjc1JsWVQ3WWE3?=
 =?utf-8?Q?b8PJRq4a+RwuW2WT3r3QvnVFi5JFyf5v96XM6LjwnFPs=3D?=
X-Microsoft-Antispam-Message-Info: mqauxotdWePdt+3lENXEdqDE3HYGykPzAImk9qU2GwLHTc4QPz11JZ++UUfoBwP6sCzpbHICT47irOXP5ZRilXIV113LXIMouj22tg6zvIHGjEhxFoiiB5/p77Nd1Pg2AItxbiNIX0xnxYB8uf/RSaNBTUH/puXeBpaH6VkdeFss+VwaltVuiUaOWkiMGjm8ozvfzbtCLm/WCKx0sV/cyFaGanLCK3rTrVJk4dw8lgFgjx40ZOwdlMlH3PIBKWajORb02YrZzTTqOysZk4ieKiKFuIMuSnlGFlSHDZgjww2bsW9Ug2wo/MV5HVMCUTzyBRm41m3t6+j+/XYCAyHLskOrBLDjXuALGEgGWCsYx8Q=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;6:sBhB3mMleloTuocrO/Xi58esL+edvK1hiGo6mHhCzcg8KYmKrLuyGLEhQG1YT5d+2oLgrPsPhLNbGISfu/JV1IaRx0oxw3RYYZMn+B6IVUOZfaiJnv2+1eUoIJFVGR1CS6sPImqXi4sSb7CAGKteJXoAEA0JSNH9T3ql+L4tYwtREVqDhC6B+ERgigHr39AfUvF+8B0MB8m35jSdaH/F7aMvphaWeNTYUmVzJOTBD/h9KZoSRZE02VAOE+12XsthftEzQjDXXtUUGwqVCHsrNcnfJ0o6qFmdZk4A4J4+5x80JUG3k2nWLJoQ01QwRZCAg74G0iLaYwXrgBVZcJr8NEL0mPusWur7WKTTwBP4oxjGMnKqWb5BhC4UOGBoD5e1P5ZH9Bf8GKixeOCVf69YnTFiC8AoCJzC+00pg314Ld8AKC7BHaeTIcsDQ0MW1eEJDEWzTn3N/shJJ8mhSunCMw==;5:Wj8LJ8jbx8fZRQc7v4NlUW6iUaC2sAd7Ihep9sdMD+wTWkQ2HlzPwV/gRoLi9J32Bontx8dNPQO+Ck2+YX8Co6eoRrZbiz4Gjs6Y73E8RYmivngzc0OENkGuJpwOLYalb5w2bzZxH4oCc2bmXncF40YBA1kf+V2Biq4DlwadSLE=;7:RzgovNdgGwTB7W3nnbSCJIjUeb2HG11HVwBnJjmUPTxz48ph2TAv7eFIDEcTXDhyTb1msqr8VCZE+O04c/HgunIriLr3D2uGVN+hJCnnEhI+wfjaFUvFJxE+En3e2whh1fuVCPnpx/Wd4HeQs9AUT8SU1lG+EdWFaKRcXeCPNRvRyaoUQttwNZ3YaJe2HRtPI46+hLyofFqMiyjvhz64xwmyxaXudizHs2B0vMMThdxLtjGgDOd+b0WqNNK2M6k4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:hp3fNpLK22ygieidEHavJsdigwuOinSdRBal3whJQkzdGNiqjnCyZ0iRisHowXT/4j6Xu3SGiJ3AIH//csRpifyDwwCw/2ENItHWg/oDe7rG/ulaDP7po8pq15GFcslkxuFdcASobOXq/R/+daNwM2TJp1S3MyRZJv4shdsqdSLi2AZmaogzx7+DwNXZeFkuBW7RoMzLYkW4BKidycISWOM0oAlZagW8dYNMonvPPYELcus6L9lQnZ9O1Mr5P1Q4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 17:57:43.8204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e8a1df-e131-4bc6-b169-08d614eb69d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the per-cpu pvclock data is allocated dynamically when
cpu > HVC_BOOT_ARRAY_SIZE. The physical address of this variable is
shared between the guest and the hypervisor hence it must be mapped as
unencrypted (ie. C=0) when SEV is active.

The C-bit works on a page, hence we will be required to perform a
full 4k page allocation to store a single 32-byte pvclock variable. It
will waste fairly sizeable amount of memory since each CPU will be doing
a separate 4k allocation. Let's define a second array for the SEV case to
statically allocate for NR_CPUS and put this array in .data..decrypted
section so that its mapped with C=0 during boot. The .data..decrypted
section has a big chunk of memory that is currently unused. And since
second array will be used only when memory encryption is active hence
free it when encryption is not active.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
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
 arch/x86/include/asm/mem_encrypt.h |  4 ++++
 arch/x86/kernel/kvmclock.c         | 14 ++++++++++++++
 arch/x86/kernel/vmlinux.lds.S      |  3 +++
 arch/x86/mm/init.c                 |  3 +++
 arch/x86/mm/mem_encrypt.c          | 10 ++++++++++
 5 files changed, 34 insertions(+)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 802b2eb..cc46584 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -48,11 +48,13 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
 
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
+void __init free_decrypted_mem(void);
 
 bool sme_active(void);
 bool sev_active(void);
 
 #define __decrypted __attribute__((__section__(".data..decrypted")))
+#define __decrypted_aux __attribute__((__section__(".data..decrypted.aux")))
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
@@ -80,6 +82,7 @@ static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
 #define __decrypted
+#define __decrypted_aux
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
@@ -93,6 +96,7 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
 
 extern char __start_data_decrypted[], __end_data_decrypted[];
+extern char __start_data_decrypted_aux[];
 
 #endif	/* __ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 376fd3a..6086b56 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -65,6 +65,15 @@ static struct pvclock_vsyscall_time_info
 static struct pvclock_wall_clock wall_clock __decrypted;
 static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+/*
+ * The auxiliary array will be used when SEV is active. In non-SEV case,
+ * it will be freed by free_decrypted_mem().
+ */
+static struct pvclock_vsyscall_time_info
+			hv_clock_aux[NR_CPUS] __decrypted_aux;
+#endif
+
 static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
 {
 	return &this_cpu_read(hv_clock_per_cpu)->pvti;
@@ -269,6 +278,11 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	/* Use the static page for the first CPUs, allocate otherwise */
 	if (cpu < HVC_BOOT_ARRAY_SIZE)
 		p = &hv_clock_boot[cpu];
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/* Use the static page from auxiliary array instead of allocating it. */
+	else if (sev_active())
+		p = &hv_clock_aux[cpu - HVC_BOOT_ARRAY_SIZE];
+#endif
 	else
 		p = kzalloc(sizeof(*p), GFP_KERNEL);
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4cb1064..bde287a 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -77,6 +77,9 @@ jiffies_64 = jiffies;
 	. = ALIGN(PMD_SIZE);					\
 	__start_data_decrypted = .;				\
 	*(.data..decrypted);					\
+	. = ALIGN(PAGE_SIZE);					\
+	__start_data_decrypted_aux = .;				\
+	*(.data..decrypted.aux);				\
 	. = ALIGN(PMD_SIZE);					\
 	__end_data_decrypted = .;				\
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7a8fc26..052b279 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -815,9 +815,12 @@ void free_kernel_image_pages(void *begin, void *end)
 		set_memory_np_noalias(begin_ul, len_pages);
 }
 
+void __weak free_decrypted_mem(void) { }
+
 void __ref free_initmem(void)
 {
 	e820__reallocate_tables();
+	free_decrypted_mem();
 
 	free_kernel_image_pages(&__init_begin, &__init_end);
 }
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index b2de398..9a08c52 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -348,6 +348,16 @@ bool sev_active(void)
 EXPORT_SYMBOL(sev_active);
 
 /* Architecture __weak replacement functions */
+void __init free_decrypted_mem(void)
+{
+	if (mem_encrypt_active())
+		return;
+
+	free_init_pages("unused decrypted",
+			(unsigned long)__start_data_decrypted_aux,
+			(unsigned long)__end_data_decrypted);
+}
+
 void __init mem_encrypt_init(void)
 {
 	if (!sme_me_mask)
-- 
2.7.4

