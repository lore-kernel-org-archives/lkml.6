Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE99C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5192086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PIkCkJo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5192086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeIDFxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 01:53:24 -0400
Received: from mail-bl2nam02on0082.outbound.protection.outlook.com ([104.47.38.82]:42369
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbeIDFxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 01:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kAZqKdOFTzMMAAeVXWLDFW+lmC15xXpNRUUXTogFWM=;
 b=PIkCkJo6vsJYRGlMGVMrxE5m2rrypkTuyFirzQhoVmj4UPclY2fI9ldOV9ue5fu1oOCKFxMuDgxHi0k/xuZRvV7vDVls2+Z6s60Y5NSMchSNFnpqoSypIiIztb+HGAp8MjuDVIgiIjCpB4ehmb8Z+HzfbL1zKDyL9yIX/abT084=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:6f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Tue, 4 Sep 2018 01:30:02 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v4 3/4] x86/mm: add .data..decrypted section to hold shared variables
Date:   Mon,  3 Sep 2018 20:29:41 -0500
Message-Id: <1536024582-25700-4-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536024582-25700-1-git-send-email-brijesh.singh@amd.com>
References: <1536024582-25700-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR20CA0066.namprd20.prod.outlook.com
 (2603:10b6:404:151::28) To SN6PR12MB2687.namprd12.prod.outlook.com
 (2603:10b6:805:6f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2c463af-fa96-4294-c6ee-08d61205f03c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2687;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;3:usJh4YIqEqCq2qAXP9/QS/fDX0sd+c8QoMQse1sECGc3q5B76rALpOp1ehjSpaDyHqP10hfMtaEADjCpNwDM2MuHMlDwXweacWQV0D+UTxYFWkVyNkrLoMzlM7NOcmwqcWUIgdbKHc3n6myEKGJ1ye35kAEviSoXpAYr4zTlXOH8IbDr+Jf+hxdPsa3Y1XjwRaWT5+22wLkVMreDwDqOyRlV1LPRtEYImBJMWhKnjjuip/dZWKgq9E6bwJQ7CqKH;25:yPdmTo+m1xtumMqK1Ykt93FGPxMtv30WpjvJnyIcjuU8DgKnsgrzitthJdm/PGPC2gId8AXKyGxnW0kSlcBCZxxF1OwlqLszAFugtst2Jw2x+y6LU2iv9tFY6Cl7h7SN1OUCqAXcJkvXrMfz1RQ0ILXDU25gwXvg9zodwBlWjReC1w7HITY9WW4yREoa59hLqtWaRFbn+P+oMxyv7cSUiebMKk0oihYEi4fq/mP+pOb286b4FonIaCc1COXI51xZGaUEcbmQab5z2RfDnUfkLL3ZOnSSPZ6n1oWIX34F7AyQUb6CrVV+C24aitCDgPwukV4CYqxlOxFB3WJFzgmYTQ==;31:iOIHIRHaPZbJMom5XPnHGvdjdljd22xWg/TNXw7zXpRdygIhAG9OCNkYiXVegUb7+yXMPoqhLogUtehJP4qARw9RpZeymbjFic++fDu4w3jjJbd1zYaqK6LSMtlVRJc1ymvgsUcT8AYQW8T93mmhe6aW138NuKl1KxUMXglcyGgeu2FQlp70uVxy6vwc/TRcXmgCgy2n8YB8RPXK7ZgsW8MgfN1nQ0keUIS9Jra89UI=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;20:egjf6WYfOr1DX03v8IogGhHIkCTxp+/xuMvBkt7VJ2MJ68h3+FkjHJ6pWrmnBhFhL+JT15B+PWEf/2ol5g+irGMAK04V6vEZZ1EEZqd3KMf5gRfV/+M7lhU6TWcOF3F9vZ/u2JymbSA56FA+GO0GEhaR2X4ytBZ8n/uQA0xiwEhtu/1/dWSwfBhUmk0RG/lRvvENOp0XJ1AYTivkoeE2cLYCzkRJ2/ZM74Mdfv4O67d6DE8jo+mr05j2PrUTZVi6BTlYFe8iEMbZE3qUgFBgg/DvMfw5MiluFUsoPDsOcAd1pRaVcSSd+N/d+uttYqVls/uyUyyK8/Ep2e0uIpqhCmki6cne3Y9qi/NQUfeNO40uvLW1lKFMzWbaEC/Ap8CnqzSYOOKn4hhicHCT4BVWEvsiZ7XjaCbsJT5twl3uEcZOF0dI5Tv1XoCGS/jy/cNchyshdu3FZz1MkTsy4QdZuGB9WTNhZLt+hqpJhMSWtbLMOKPmVeKqJeE2/Vy1ftqJ;4:T028tw0En/A94Xo0hviVjZJqJElFwL1BxtK7reFr4oy+StseiUcfvpdwVy7i+zQKSP8Kj4bdyXdhlZXubw46smNRnDofJ+mtiwpEJwH+IxAykdB6zrmzqvOVVj9OhmCGKSzTzDIMBmtMdow5Zx0N0eGu1TQ8khvqOyKilGP72kesJTkYdjH7Qg7J5mujQSPK6kM8VY8xxAw/5w9ZkFNaHzwauR1DeJX6ogye2zUw9ZsRta5KqS1Fz3NPTg/MJVyRw5sje6c8b+FZ6xvBw1Zfjoh5Yog/vZBg+/L+WNQ1FGmtDfK0rw3I8Ou/UonspcFMgrYeVGYnowC1m1Ve8TU3YIns+MfnKKZ96/4UbUYIP6MZuJbTbli3KL/T6UWQ3RIakH40ZE1f4Qn2fr8fBnQMow==
X-Microsoft-Antispam-PRVS: <SN6PR12MB26870AFA582126AAED3F66D4E5030@SN6PR12MB2687.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(163750095850)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:SN6PR12MB2687;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2687;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(6116002)(105586002)(76176011)(7696005)(47776003)(23676004)(66066001)(68736007)(52116002)(2870700001)(53936002)(53416004)(2906002)(316002)(36756003)(3846002)(97736004)(6486002)(50226002)(4326008)(25786009)(54906003)(106356001)(81166006)(81156014)(8936002)(478600001)(2616005)(6666003)(50466002)(575784001)(86362001)(8676002)(44832011)(5660300001)(186003)(7736002)(305945005)(16526019)(386003)(486006)(476003)(26005)(446003)(11346002)(956004)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2687;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg3OzIzOnB1c1FmaFZTUWJ6K0RnV1d3Y25oRTYzV2Nm?=
 =?utf-8?B?RktFRVpMVGNUTjYweTRjY1JZTktsRm9MUG40Z0h5S1Fsa3VMcC82SC95Q2V3?=
 =?utf-8?B?aXBLSU9yK09ONElZMHNmMFFLdVB4SkFaa2pSNXRRWSs0cHFSQWVlY0lIWWVs?=
 =?utf-8?B?UkJrZVUySXZab1RUWFBwc013cXpzOXMrZ3hmMUs2UUZYdG9HRDVCSjdYZ3JY?=
 =?utf-8?B?cVN4Z3phVWNOZ1Ywb3dJWnVFaGpqVmdUQlh5TFhPTFYxcDYzeU40TnZ6UXdk?=
 =?utf-8?B?c3JHVjN3MnFuWFBEMVdNWDB1MmRhQlU1V1RLT2dKdVBBbUY1VW91SUV6dWVF?=
 =?utf-8?B?byt6dDVTM3VnRUlwY01qcUhJQk1IdXBZUWR3Q0hUKzlaOHN4dUg5c3VlV3Zq?=
 =?utf-8?B?RlI0U1A0TVpyMVZrMktWbzlERFMwWFVhWkhOYTZmUTFuZ0RqMS9MeG1vRnU4?=
 =?utf-8?B?Mzd0Y3AzdmhqSHdwN0xobjd6aUZjZWQyemh1ZTNSa2ZYZ05YNm5ueTAxN2NR?=
 =?utf-8?B?c0ZqSFFiOFpZTDEwMElXdzVhS0I4KzhzN292cXdXMFdhM2tmYm9HSFZzODFp?=
 =?utf-8?B?TG9teVUxTVdzOSt2eHd3WTZYSGNnZkp0ZHEyUmoyQk5HSHBJN2hFYVJMZ3l4?=
 =?utf-8?B?NFRsMUE2M3UrUThnVDBQS0tuVDMyeEVhQUJKVjlKRmduVmwwVzEzM2pyeXNB?=
 =?utf-8?B?bW1sS1RpSVVYUlB1NFRkTElLelEyMkdWUzh5UG43Tnh3dDdpdStrT0MwNXpv?=
 =?utf-8?B?Zyt3ZmFnQjhPeXRwemRCcHNyRTV4Q0c1czF0UXdaRU9ENHdEbjc5MEk2bS81?=
 =?utf-8?B?VVNUbExZdXN1OVRTaTdSRzhzNk8wQ25LUFJBWnQyZ0xubk1RV0VKOTNIVlNM?=
 =?utf-8?B?cEtjSFh3aXFnN0F6cHVFOWtNOGc3Y1ZnUDZCajhSaTlob21QdjBYS2xHYlVH?=
 =?utf-8?B?WXY3cklpeitDRHc0ODJic000WWlmdFFoSzRpZmpGMXl4anQ1UlJORlMvMDB0?=
 =?utf-8?B?MGlCY3pQZUJyb2FhVUYyc0JuOERCUGFEeWx5dEphZll5enVKRFVzL1dSb0Rr?=
 =?utf-8?B?aytNNC9vMmUzNHhoQ2didnJENzgvdTdCMDJkcTlzUHZtMzIvWEdDckVodEZC?=
 =?utf-8?B?WmV1MytZcC9KYlRCcThOUGV0ZUhXTXFGcFQ3eExPeld6a0xLbXZEY2dWSTYy?=
 =?utf-8?B?ajVTQ05nRHI0bWJ3NVA4dE83ek5pUzVGRVlUWDJWZTR6RGtzWFY1eGNrQ2lJ?=
 =?utf-8?B?ZXltS1ZvZWI5c2M1QUtOUXNYSTN0NkJIY1Y3c3REUGdGb1hlTSsyTjE4SEha?=
 =?utf-8?B?ejFWSmFueVZGenlTdVE2TDljL0xmc0tRUnIzVjkva2tMQ08wOG5NcmY0anc3?=
 =?utf-8?B?dGU5T0E0RFRCZnJxbld3Ykg0eStLbGVoakRYNFAwMG42elk1ekJiaDYzTTB6?=
 =?utf-8?B?VWF5R2diZGIxamcrZTV1Q0tuaUR0c09jN0Y1eVkrbjErS3FJclEwTXc2ZXFH?=
 =?utf-8?B?THAvRWVVNElveFk4VXYxY1ZvRU9sbmVJNytRaHRUaWZ2Z2dINXFWSUhTMjZU?=
 =?utf-8?B?RDBlbWlCanJQeXpWSzkwWURsUG9CRkVJV2prdld5NldMNlRqSmxTOFdoSzlK?=
 =?utf-8?B?b1M2SmxIaW1LV3JzZkt4MXh5cVZhQjFpOS9oRStXMXBqK1JMMWw5RW9PS015?=
 =?utf-8?Q?TqKkBr+fx2pX5LyC98=3D?=
X-Microsoft-Antispam-Message-Info: rM4tN798/NHB1N7Q9hCpdiJ8cRg2dRzdBeMgM6QAaYzCf992D9mEQapMwKyjmrZlIVLrHks3IxbDeovyUWvqThYwKxkd/lB9ihSxb0qZhed+Dp9yV86AmzjOvkXol1rWdlUK/1hYYPCny7cxZxp7mYWRQOoxGx0LndlhRXTA9kDWst3tw5tJHBmeiCmTyZbAzkllz5UBbMXcnoKFrT4pikywFBVAB9AK3Oa0kBJI4bH12DdSdci5tYutVPoj9/BCvSttBbO308Sy4PSHnI+KEUeg5UY/4bYqfDDw19LnKDx34mQ3f3JYaW+dsC2eMjY7nLaB0DzUSb2pZdg8L7dZbth85fZmroO7ROKi6oWhytU=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;6:JXstH2CRTN00D8BRujBVwn81AJ/4a5wdVFpUWiuLZNWMSfyl262sOUdHC/djerqaH1du7b4pF1FMRBGSoOcYe8ap3srOdzzY8LsAfqEXSfAWXwUPv/UQrCeTT1pvMTDas5bT6E6OvdzQMARZagcrpg99A+aFA8u66qql/OWjT/7ujNQLRjb5ByxB9NwatqD764jNNJl0pRbqO2k5LaZtAd7ydm9KQE2iYY7qhs6CHjJW6Sfey6Q7+6TcOanB4KNMm7HnhqdwVW3ZyCmp3qXmdwKrq9qCMGK2UjM+D2nHTSiShV+ztJNTLLDIZ0NCWiQoXmbQn5RHp8SE56gAp1GbZjb9H4kKbZ3h+WIPb+T7Iez+53WQTHVEf0qzUV9eL0bnZ6h/FO/HkZCo/kmP12cFCim1BqGWm2tKNvcpNdtEinxSNd0Rl9zH9OC+P1oqoWCH6MYJfES1Y8VOrBUYe7mGKw==;5:fyCz999zSJOdAo0VtzF7Z6WZQg7hAgGDsAKvfyfluTeevz6iWDcbpKrepabjO4KcdxBiDc02/nYOs4AEPhvS61VZyLa4EdESTJ9v4VdIttQqGcgLTjcOMzs2BL/JyYeKftSZj5xLxHzJ53B+q33Xj+KF2jsViMYU6gy8VbGWKww=;7:Qf3e3PXtSKC/Hty7HDAO0B4kdns1iZdqTL+GohK8wFFgvDZuwIX4Yfu0LiBOFilNturhnO+EfWDuAqN1/tZ/ePfeCwxchD80N+jBGRD37P0I/WGPDkkTvjfR7z9XbU5wLH1F1bQDEUDv95gecLUaoALwRuYeGHxGul0hdSUInXIBVyBm9tRHB8fO3FhJNDwcFktRYkumzMsa6E7m6KYDynEvTXyuhWqndKwF/kcc+FNAQcL8ZMB/hQQ83Ad41nEj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;20:xFkLBY+brCvV9XiOWY8iw8q1Pxmgh4W//EDrgL0whovC5or4yUYq75Xq/QNnCJM8OkWtlyxtmlmFEftzWL1snTI6PgTh3ZtO+m4VAconezOyn1V3tvn68pKLm4UapdwatEWX5cAkbY2M62kuwppOnYabCH8Cmp1SQDlUgzrGeUiq3+/gF/33eantSC+sB+X4+209mv3x2++m8WBPLoNVuz5gRnxB7QJH8W+SzNOXwzMllI2Vwt1z8n69vOmzMn19
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 01:30:02.3998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c463af-fa96-4294-c6ee-08d61205f03c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmclock defines few static variables which are shared with the
hypervisor during the kvmclock initialization.

When SEV is active, memory is encrypted with a guest-specific key, and
if guest OS wants to share the memory region with hypervisor then it must
clear the C-bit before sharing it. Currently, we use
kernel_physical_mapping_init() to split large pages before clearing the
C-bit on shared pages. But it fails when called from the kvmclock
initialization (mainly because memblock allocator is not ready that early
during boot).

Add a __decrypted section attribute which can be used when defining
such shared variable. The so-defined variables will be placed in the
.data..decrypted section. This section is mapped with C=0 early
during boot, we also ensure that the initialized values are updated
to match with C=0 (i.e perform an in-place decryption). The
.data..decrypted section is PMD-aligned and sized so that we avoid
the need to split the large pages when mapping the section.

The sme_encrypt_kernel() was used to perform the in-place encryption
of the Linux kernel and initrd when SME is active. The routine has been
enhanced to decrypt the .data..decrypted section for both SME and SEV
cases.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
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
 arch/x86/include/asm/mem_encrypt.h |  6 +++
 arch/x86/kernel/head64.c           | 11 +++++
 arch/x86/kernel/vmlinux.lds.S      | 17 +++++++
 arch/x86/mm/mem_encrypt_identity.c | 94 ++++++++++++++++++++++++++++++++------
 4 files changed, 113 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index c064383..802b2eb 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -52,6 +52,8 @@ void __init mem_encrypt_init(void);
 bool sme_active(void);
 bool sev_active(void);
 
+#define __decrypted __attribute__((__section__(".data..decrypted")))
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
@@ -77,6 +79,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0;
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
+#define __decrypted
+
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 /*
@@ -88,6 +92,8 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 #define __sme_pa(x)		(__pa(x) | sme_me_mask)
 #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
 
+extern char __start_data_decrypted[], __end_data_decrypted[];
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8047379..af39d68 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -112,6 +112,7 @@ static bool __head check_la57_support(unsigned long physaddr)
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
+	unsigned long vaddr, vaddr_end;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -234,6 +235,16 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	/* Encrypt the kernel and related (if SME is active) */
 	sme_encrypt_kernel(bp);
 
+	/* Clear the memory encryption mask from the .data..decrypted section. */
+	if (mem_encrypt_active()) {
+		vaddr = (unsigned long)__start_data_decrypted;
+		vaddr_end = (unsigned long)__end_data_decrypted;
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
 	/*
 	 * Return the SME encryption mask (if SME is active) to be used as a
 	 * modifier for the initial pgdir entry programmed into CR3.
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 8bde0a4..78d3169 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -89,6 +89,21 @@ PHDRS {
 	note PT_NOTE FLAGS(0);          /* ___ */
 }
 
+/*
+ * This section contains data which will be mapped as decrypted. Memory
+ * encryption operates on a page basis. Make this section PMD-aligned
+ * to avoid spliting the pages while mapping the section early.
+ *
+ * Note: We use a separate section so that only this section gets
+ * decrypted to avoid exposing more than we wish.
+ */
+#define DATA_DECRYPTED						\
+	. = ALIGN(PMD_SIZE);					\
+	__start_data_decrypted = .;				\
+	*(.data..decrypted);					\
+	. = ALIGN(PMD_SIZE);					\
+	__end_data_decrypted = .;				\
+
 SECTIONS
 {
 #ifdef CONFIG_X86_32
@@ -171,6 +186,8 @@ SECTIONS
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
 
+		DATA_DECRYPTED
+
 		/* End of data section */
 		_edata = .;
 	} :data
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7659e65..08e70ba 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -51,6 +51,8 @@
 				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PMD_FLAGS_ENC		(PMD_FLAGS_LARGE | _PAGE_ENC)
+#define PMD_FLAGS_ENC_WP	((PMD_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
+				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PTE_FLAGS		(__PAGE_KERNEL_EXEC & ~_PAGE_GLOBAL)
 
@@ -59,6 +61,8 @@
 				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PTE_FLAGS_ENC		(PTE_FLAGS | _PAGE_ENC)
+#define PTE_FLAGS_ENC_WP	((PTE_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
+				 (_PAGE_PAT | _PAGE_PWT))
 
 struct sme_populate_pgd_data {
 	void    *pgtable_area;
@@ -231,6 +235,11 @@ static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
 	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
 }
 
+static void __init sme_map_range_encrypted_wp(struct sme_populate_pgd_data *ppd)
+{
+	__sme_map_range(ppd, PMD_FLAGS_ENC_WP, PTE_FLAGS_ENC_WP);
+}
+
 static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
@@ -378,7 +387,10 @@ static void __init build_workarea_map(struct boot_params *bp,
 	ppd->paddr = workarea_start;
 	ppd->vaddr = workarea_start;
 	ppd->vaddr_end = workarea_end;
-	sme_map_range_decrypted(ppd);
+	if (sev_active())
+		sme_map_range_encrypted(ppd);
+	else
+		sme_map_range_decrypted(ppd);
 
 	/* Flush the TLB - no globals so cr3 is enough */
 	native_write_cr3(__native_read_cr3());
@@ -435,16 +447,27 @@ static void __init build_workarea_map(struct boot_params *bp,
 		sme_map_range_decrypted_wp(ppd);
 	}
 
-	/* Add decrypted workarea mappings to both kernel mappings */
+	/*
+	 * When SEV is active, kernel is already encrypted hence mapping
+	 * the initial workarea_start as encrypted. When SME is active,
+	 * the kernel is not encrypted hence add decrypted workarea
+	 * mappings to both kernel mappings.
+	 */
 	ppd->paddr = workarea_start;
 	ppd->vaddr = workarea_start;
 	ppd->vaddr_end = workarea_end;
-	sme_map_range_decrypted(ppd);
+	if (sev_active())
+		sme_map_range_encrypted(ppd);
+	else
+		sme_map_range_decrypted(ppd);
 
 	ppd->paddr = workarea_start;
 	ppd->vaddr = workarea_start + decrypted_base;
 	ppd->vaddr_end = workarea_end + decrypted_base;
-	sme_map_range_decrypted(ppd);
+	if (sev_active())
+		sme_map_range_encrypted(ppd);
+	else
+		sme_map_range_decrypted(ppd);
 
 	wa->kernel_start = kernel_start;
 	wa->kernel_end = kernel_end;
@@ -487,28 +510,69 @@ static void __init teardown_workarea_map(struct sme_workarea_data *wa,
 	native_write_cr3(__native_read_cr3());
 }
 
+static void __init decrypt_shared_data(struct sme_workarea_data *wa,
+				       struct sme_populate_pgd_data *ppd)
+{
+	unsigned long decrypted_start, decrypted_end, decrypted_len;
+
+	/* Physical addresses of decrypted data section */
+	decrypted_start = __pa_symbol(__start_data_decrypted);
+	decrypted_end = ALIGN(__pa_symbol(__end_data_decrypted), PMD_PAGE_SIZE);
+	decrypted_len = decrypted_end - decrypted_start;
+
+	if (!decrypted_len)
+		return;
+
+	/* Add decrypted mapping for the section (identity) */
+	ppd->paddr = decrypted_start;
+	ppd->vaddr = decrypted_start;
+	ppd->vaddr_end = decrypted_end;
+	sme_map_range_decrypted(ppd);
+
+	/* Add encrypted-wp mapping for the section (non-identity) */
+	ppd->paddr = decrypted_start;
+	ppd->vaddr = decrypted_start + wa->decrypted_base;
+	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
+	sme_map_range_encrypted_wp(ppd);
+
+	/* Perform in-place decryption */
+	sme_encrypt_execute(decrypted_start,
+			    decrypted_start + wa->decrypted_base,
+			    decrypted_len, wa->workarea_start,
+			    (unsigned long)ppd->pgd);
+
+	ppd->vaddr = decrypted_start + wa->decrypted_base;
+	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
+	sme_clear_pgd(ppd);
+}
+
 void __init sme_encrypt_kernel(struct boot_params *bp)
 {
 	struct sme_populate_pgd_data ppd;
 	struct sme_workarea_data wa;
 
-	if (!sme_active())
+	if (!mem_encrypt_active())
 		return;
 
 	build_workarea_map(bp, &wa, &ppd);
 
-	/* When SEV is active, encrypt kernel and initrd */
-	sme_encrypt_execute(wa.kernel_start,
-			    wa.kernel_start + wa.decrypted_base,
-			    wa.kernel_len, wa.workarea_start,
-			    (unsigned long)ppd.pgd);
-
-	if (wa.initrd_len)
-		sme_encrypt_execute(wa.initrd_start,
-				    wa.initrd_start + wa.decrypted_base,
-				    wa.initrd_len, wa.workarea_start,
+	/* When SME is active, encrypt kernel and initrd */
+	if (sme_active()) {
+		sme_encrypt_execute(wa.kernel_start,
+				    wa.kernel_start + wa.decrypted_base,
+				    wa.kernel_len, wa.workarea_start,
 				    (unsigned long)ppd.pgd);
 
+		if (wa.initrd_len)
+			sme_encrypt_execute(wa.initrd_start,
+					    wa.initrd_start + wa.decrypted_base,
+					    wa.initrd_len, wa.workarea_start,
+					    (unsigned long)ppd.pgd);
+	}
+
+	/* Decrypt the contents of .data..decrypted section */
+	decrypt_shared_data(&wa, &ppd);
+
 	teardown_workarea_map(&wa, &ppd);
 }
 
-- 
2.7.4

