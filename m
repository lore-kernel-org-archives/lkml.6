Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FBFC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D42B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VjZHtN/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D42B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeIFQSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:18:55 -0400
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com ([104.47.33.67]:46448
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727728AbeIFQSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6NWRmT1MHxuQGpUxYzj4VuHOnSWLDZMxzj86WU5iPI=;
 b=VjZHtN/vRkAqzYjUqDH6rNzxogABhswzWtow2j3GKBGigdyYzqvhojaS++pGfe+9Uub4ezJKi+ED+EWcGNRYaQ/JcoetXIDugSSdvykid/jCvfKuod8E8QMGsgWxjQABcr219X6cfsNO9LDx1USAg5QZBUZrznJe70Ed8XcyDFo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BN7PR12MB2675.namprd12.prod.outlook.com (2603:10b6:408:29::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 11:43:33 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v5 4/5] x86/kvm: use __decrypted attribute in shared variables
Date:   Thu,  6 Sep 2018 06:43:01 -0500
Message-Id: <1536234182-2809-5-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:903:33::12) To BN7PR12MB2675.namprd12.prod.outlook.com
 (2603:10b6:408:29::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4822186d-8402-4173-d039-08d613edfa9f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;3:WWlbqQwzUDG296BbS6CP6Tm6kS/2LmhvtMAu/vdaQbeULN18kIONxmgUdYbZS+hhNwA1ecOUaCr9zWX6Rb4dQS1OJhd3LYxu9XhPgpS913+4SNSvPRrCpRLj0tAThF1Sw7ts5bcJcRcv0LFge9F1Ud+qvnxBCVEL6NtrXFiNx5QnkCTFNamWv4cWkXX59YsbWMYf9phuYbAmTOxZPxFj8rDY0P34KEw6DMtPT/w8C+NK/bTcTquyAduO18aBqYAG;25:BhpB3AXRm/3s6LS8BOQrUpUP/Ro/douQ6/rTu4D98b84JoqrQC5QkqVvmqI31uPVWHM/5o17vIy8YB1Lg73qQLvHIbG3CACBA9uGl6M7qO++WvEv64LsmXM2hTGozaw+ZSQMkUAB5kbtHa0hR6Uf1Bk5foeqai2XiLDOT/sEEGNKpS4NQd4UwAF4o14HRV+OG213aovVFSDc45oq1YBiXzKwlf7UjXAFOfcRE0Uw6KmBHYjrikVhxnBGDHyRngTHZfAVkVYhBiYDpeD7j9nhmzA9XNt+6xKpjuTjAV4bHTBGem4ePG+92CKKMPo70bkdzLQhpiPKZ/DnU+d5EOlFmg==;31:YC8zSaS2Ya7S3DXi/qPstyrVJSgx+0artopmyBNC91Lic8mPsdLimif/7fwXNYX+YJvkb/9GILvdH5878OGIOSEj9Cx1BKLDwjHyCE0uowB02XKhklWc79SufG/BCj71O2JdoT/wQvpYSSCPZ3or1vFvpGDFaqW0e1BpjT3g4VrA6a0hUrQLFBSKqoF9XdOYxgsFSMPDjnAU2xls1SZp548O1NW9G4FKHkLer+1kzCw=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2675:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:xtwtvNkQ8j84OHMtbjrwQ8mpAuIcBPUHmg4pyQpJxr5kxPlkN0O0lBm2rHpTaMDtOrLf2b9EzrzCf2dNIrBL1k2FVDyNYhf4Qt+O76cUsBE2bUtt144LUboD9yuy1spkNw7zb6eRvI6mzCpMU4WsJ6PxYd9/QuXp1JGDv2PGPJajKimGAI1MfG99PsWhCsRsaBotoNyF9cEEXovwDPiT/p+3FLOtFYfLi0RKBp+cgbXBm+5F9yzAJoKT04rfCNrySQQsCHU3kctPzLpO8SRPEbGlRlZzuucAAyk9xILQTXowC5FWhhSb5gAUMwXfmb2KoMGZAnOGxxOQ51q5dvdDNbjArgPfFhFsCUBKOlH4ZAipt/Ev3Bc6FPIN958V7irUZoTufUTSHK3UUEpLT+NTwwy7edJlVfEdWsVculRfiPMcjjraoVFayapUQWb6cdOAXkZ1Hnfg1IWjKIQqhNjROMkEFuxUAgi6D8z0wjsvbEuJ1nvoe7PBLT3PiMYaIiWt;4:YpH7KuMZyRS1aoTtNRo41o6/CInZ7kFPP+IaMGOWvFrIvUndP+XSEZsK2XAsIW8ijCNQv7XEAuIkUjTVfCy0rdbyKkrUuXHEbdHUYcZyVs0qTKrGE9Jw0kkUmbId3D1Zq9fiDnEWZYqRhU+ynOwOMixr+y1QpfboCDBZd6LGL5xQiKSNAtPQdKE3WenMz3qnKV9Gr++U+gxAne1BXpoT3e9SxwaMC5Wp7mQAQw3yitazFrKaCHACS05+cd/DhAE7QNWndVE8IWgVkO6Fqq/4QdCN7jiW53ajbJOy4vW5S5bzLDMyoAJi8EgXpCdFDPhUsRUbhKP33OPOpT39Urz13unxgmcTzYDMr7yK//yaBqobJfgnVoTiMnIPHdIPNpLN
X-Microsoft-Antispam-PRVS: <BN7PR12MB2675801F1E9013A989275A77E5010@BN7PR12MB2675.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BN7PR12MB2675;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2675;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(199004)(25786009)(47776003)(86362001)(14444005)(68736007)(66066001)(7736002)(6486002)(53416004)(106356001)(6666003)(5660300001)(3846002)(305945005)(4326008)(6116002)(36756003)(105586002)(26005)(7696005)(50466002)(52116002)(8676002)(11346002)(50226002)(956004)(446003)(2616005)(53936002)(2870700001)(97736004)(23676004)(478600001)(316002)(76176011)(186003)(16526019)(54906003)(81156014)(81166006)(2906002)(44832011)(476003)(386003)(8936002)(486006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2675;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjc1OzIzOjB5ZVpWR01hSDgwUzkyc3JTOW0zby9tWUpB?=
 =?utf-8?B?bjY3TGMxZTNsYXlLTHJzQ1RTSm91YmZFdlFldU8yQzI3RFdHR0tvZWpxZ2Rs?=
 =?utf-8?B?dnNhUFVWRkdiV2pXNEh5RWZTbUNuTEpTS3NIY3JranV1YUE1Q2FIYVRFendJ?=
 =?utf-8?B?bjA2WjFoV3RnZnRIZnlCQTlkb1gyVi93R0Y3ZjNLaWlKZmlTcy9lVjBVcmQ5?=
 =?utf-8?B?U1VKeTl5OGpSMXZzdGh5QXV4NkJBbjk5YVBXWWlieXVNT2pHMDNnV205ZjRM?=
 =?utf-8?B?cmlQMHRPNlFtQVBkTHp1cDhXd2hXeDdrSW4xTTNRM0pqWG1HTEN4aGF1MGVY?=
 =?utf-8?B?N3dSWGNVcHJ6SGxaajlZSlVWWmJ2aFZXdkZXSm9wK2cwazYvczloc0FrdGgv?=
 =?utf-8?B?L3Y3OHFQTzQzVU9zRm8wYmJacytUYlYzbFVFWmw5OUdmYU16d054VkEvRHo4?=
 =?utf-8?B?OElyZFliWXJ2ampSS3FHRVlkaWdsS2xSR0VOakxNYXcyR1BRbXVWNW5HOHFs?=
 =?utf-8?B?U3dPekdIRkFnYzVGcU1XVHo3VjRKd1JjYlJnVHV5QTNWUkRHUE9UMWNXQzZX?=
 =?utf-8?B?WVVWUzYwbTFFZWIzNERQQUl5SVpCRTZWSVVaS0lyZ1Q2MzBRR2N2TkNYbGt0?=
 =?utf-8?B?MjZlSUtHamRrZDZqVW43S3lYb1VjNUxVWTVyWDhNb0JiNjkxSDIxTmNKbnhQ?=
 =?utf-8?B?TVIvMi9vQWJXMzhrSmRqcmxBWTVTWG1LTzl6dkd1L01LUkk3cHhFNVR1U2Yz?=
 =?utf-8?B?TWMvNk16MnMvUzBVbys2MlZxdEUzbDFMeHdzRWg0WE9HTHFXK2NIR294dEZr?=
 =?utf-8?B?cnRiSGhqdi9QQzE5ZjM3cnV0bVVOemd2Q2VyeWtwWllMdS91UEdoOXNYTnh5?=
 =?utf-8?B?bkVXZ0FNNldPQjFRSEdoZlgydm56SzdaVjdISTFRNGFuSzhSb2hoVlFCRUU0?=
 =?utf-8?B?RDRCNTdNaFBYSDR0cnFyNit1NTAwbEZNM2xXQVJWOCs0ZDRVdGJDU2FNNklv?=
 =?utf-8?B?M0IrRWs3VXlDT2JpUlNTcWlldldJQnFUdFZ4ZmZ5UWttbWhPbjRnSFBMU3M0?=
 =?utf-8?B?aFJCaDB0dDFlODBmNGFKdy9VK3VzRzc0bzZWNmk0UGdqUnFZV01DZVk2WFNH?=
 =?utf-8?B?aDhkUHZUb0p0MTVoUWZBQUlaVzhUenYxbm9ZNFkxQkltdDNxSHdRbXpwSHU3?=
 =?utf-8?B?aGJZbERRTUJzZVZrRjJITTM1cWNtSGZvYUF5ZzF6ckR2eGdBT3BPY0YvVlIy?=
 =?utf-8?B?L3hxQWRNTmV0NkU4bkd5aE5EM0Q3cDB3MWVYOWM0bmlVSG4zSFdtUUwrakpF?=
 =?utf-8?B?eGkrK0NWejU4UnJqUjRtdWRMbFBSa3JLdWtvWUxxZml1bmR3c2YzdEhCRTR3?=
 =?utf-8?B?QytjaGpJUEcvYVFPNjlXOFIyb0pwV3hXQjVXbTBZZVR0WGhSOXE1K1ZtZ2U0?=
 =?utf-8?B?aTZqOVBSaUtNaEJOUzAyWnBMcUV3WG5ObHVPelZaQjQ2b3dJU1RRRFdXbU9l?=
 =?utf-8?B?eFZiaW1pTWJRRnJhVi9FSW10YTByK05FdU43UlNqMlBacFM2L0ZhMVFqOU8v?=
 =?utf-8?B?bkV0VDdaaURVWFNpNml1UlM0U3hxM2crc0w5K0lPRmd6RDdyRzBkZmN6RDRa?=
 =?utf-8?B?MXp0Mk9Sa2xtZElTbDl6cFl2OHRpcUZ6YUFqY09SZUpqMkNQbE9RcjQ0bzk3?=
 =?utf-8?B?ZGxTU2ZCVzlpazQ5WW9nUjB3OUZ0cWkrK3Z2aUxzUFF2VHRjUUxRclFkaURl?=
 =?utf-8?B?VFRKdDJmNU12b1dyZy9PZz09?=
X-Microsoft-Antispam-Message-Info: AxQUXUlXS9lcjHjRdIDpF/B/Xx5LzLtm3TORqs4s6Ym7C5RdcuyginFFFBR3LsFJRYQpfmaA/jpJWmYJ57OqbIHXwinf1NgYcYBWGB/VDHdU5aSfEsgqDiJrkU3OvB0Fk1j0AnOvo172oUrW9OZ/qnxDT+L37yYVzMf8fzizhCi4WAxnH5tQH7upVjJ40QhHDJWVuMVw/cgrNGN7VNyu74gfn2yOluNmYJ4h5FmfTPRc5M9v29NMO3tYVZz+qixoDEAv4owC6azQ6Y8SMWIGoMJLBdNWf0c9LDU1fg8uDI13vPo1YtY+rYSIwtvoWIvdW+AcDlfB+CJzY46Ak6+3pXXTmAJ2UbTQ4bDaji21Vic=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;6:g+znywysGNQazeWMWpuzJvE0BFIu0CFO1eDtuGSA587q8iBwiG4P21zq9u9lm2Nmzsa7DDeEr6rDSvsqOntDLfBIt3JYkDoX/ePMMU25pylcs0kHvnMxVkficuLduwB3Fdn7RS43j0xtZziOR+ivvTEK+hOt1uOxB5RdMiTWUR2CphTa2Ow6fCQmfR562gHyEXswgFXQwCXbQWWR7Eqj/8d67WThvw+779NTAfuiCQgDbuXLaIjvfZsCff7CNSBNZ1m4R2AKjM+QaPIiXUFs8MAlKREAo6hbnM4upZ08uxtQpd0JETmPSt86mw6im29Sz5Dz1y/fX2Y2mJs8hn6g1kqF6Ei/AZiXmltq+b/DKi3M17adx2F3fACMzzMMQ1+ziPRMXzyJvz/69S8i0vmpHWQIwhZXS376ifWYCRpz0bvda75G+EeDCAff0rFsja/VAY/uIC0z8RK65yzz2REuaw==;5:caxUnybFGDwLaOm1YHy0aq1Eda7elESc5aUkSfY2iW8mh4k5I2qOgVIuAWJOIytXD7rpzGUTQ4ZyidtozqFeBZ4EYgE3+Je8ZaDFlKQ0FGh+1oSwup0+oMzE5a3zYcqqN+/yrfM78wpLyp5g4xMk05TQgRyBQ1Hz9RXrRNLKUWE=;7:43Xdnbl9E2q6oMHAjTiMlVrMDVoC6Kveq7O3TuKVuD37nZPPZWa6KBPHUbwvGpVkZQqfcxl3lo/jJpks5huTg45A90+cqMKuGX+hjVSQD8Yad5+fOfQrlm6BIOKU9IoEwLDQf5KamsN3+l1UW7bfeAJujNORi671Z2id2u8fij+qCm6aOnP+IBo0Pi+ORP9Io0gi0Nu7wG/pj3Hn9V9WW5Yb1ZXnZY9pMP1xM2CZzgAjPZkaW0DpziVb8YOlTt3L
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:mOqQZAMw/nsTWYMl9Bapy1QJJaVtLj/QkuYJCPggrhrsTJf8SIvJnsZMUpzyl7T34U3bgQCquUuaynMkAjGdRyrd5oE7eJhgPyBgoKgnjrE2sU/PF3Yw8d+b45JxWX7JvgMg/Qs7pKOBeHFQBRr8euFQCdBQw2j0IIb0WbOjMqxXMdZQpc1EHZ7trVw+p67Dv2pJ8j+EVOpKUnqTQSLMI+Xlsv4GYG5cYJUroEFDhbLwkyxRXWg3WrYcVz2Z8v1D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 11:43:33.9801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4822186d-8402-4173-d039-08d613edfa9f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2675
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

