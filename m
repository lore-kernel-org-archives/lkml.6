Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbeC0WHW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:07:22 -0400
Received: from mail-cys01nam02on0079.outbound.protection.outlook.com ([104.47.37.79]:19955
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752296AbeC0WHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:07:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH] x86/boot: Fix SEV boot failure from change to
 __PHYSICAL_MASK_SHIFT
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Tue, 27 Mar 2018 17:07:11 -0500
Message-ID: <20180327220711.8702.55842.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:405:39::44) To SN1PR12MB0173.namprd12.prod.outlook.com
 (2a01:111:e400:5144::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7664aee4-fe6b-4f9e-1185-08d5942f19ef
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0173;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0173;3:FbThS9fbEp4LDHhm7Nvxxa9BpUzQSfvc1VSrA1SlLHUbheYy/CvSuXw6MI1BWSXqapkzV4kS8HWIl3YY0SusKX1woLpP5N58atc+FbLdhxXPO/19gZElJQZ6lM+ltoMcVzUEkUOyxpFHZaQmo1F+FWRGDz8sIA5ENuib6TOBb8j0Sc9i6IIlqGx1+achMuz5Dd72wqZOK4yiLyuSROy6M/aUrUwoyHAsu4Qhp6BbvhRlVjIBxwnNoySaz9o/N6yb;25:q0e2w8zn3FCkrMoVmMmWjUbdlV1biLZy4wLT8Li26e/VB/JeLC0+LkmImrpAc+luETg188qZTsRZOJlap2LiE+5X5cDTZCvrOsqCNQMLCtk9RdKzYtLq2LOPrCdO10pUOosueC9c8plGr2JS32Ezs9HMPJgiE5kkrnfWU25uaBlY4C5fkheynBbcvQqXFnzEisyTsmlCNUliTbjUu7Nj/JOzxWqPzG5l+AqO9BrXfA4OVZF+NESvUaEmeRI8q5eCg24seFGL6XeNlCQgrhP9UOyzN2tfAYHwXqrXWyrPkkGlanvaxjPjg3taCzTg7R8W0ZWU1NR/EORUYCzSc12mfg==;31:83S40Q860Y2KeG2E2e8ZHnvJVhApCpKWg8of8Vz2Jc552NQQ4bCp63DxyZAtaXYitbRT5fkyL0ZSXIv+Y3CCpqiQ4VkSq5ZTChD2rB6M8HAKNh17ctHIu6cqpJe7W5tfDukW3N44gjwBZrCEDy0ZL5hFE7XPzbZjd92DvgLVTn1sauBnP0ufh7yqqKN0TbjOJloYJs4Ha4+sCPIMJhx7W6vaZ3MPkoFhsYXMlrvHDhc=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0173:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0173;20:YbXgVxHiYxQAGL4wPpArYB6pl7vmOk9mxgiwbv7Yt7k552Pg4+byYoYU+Aac6850nB/e2JVQBzOedEMpWhDWupJPL/FPySBsiK/7uiGey4335aiu+XiWzI0JKKy3OJ+fY5m7QD89vSxYSRIKdDeqBfOLhkZ+DWBh7+n4CQlnsEtc97JQDim7EiUgLvszSAB/ZeZLMBj7RI4lJ43WMT2Yo3CvWszy/3sVh2pK95ZFbKXW93yBZMaXaQj1ccCUOHh9D08emsLXBrBPPzqucyiMHIAin3pA6d4L0e/eyiCU04sDq/N0vPZxnG+hZ0NIkqty1lpMP4EhnI/10kNm3cjo7zKWyeqV71Zf+wT7pu6JaEuT10U6GkNDXUvx4L5LjERHIY7Si4wzv5b6kLpl5+BuS5YN4tTlb2rY/82+9IWdfr30qOeZSum6RHwufpg+xEVbUBYtrW6esGkjcMakWyDVNbvaAJdeBZlJRixTfciEeY7xOfKrBP7A8CeZW/cuPNHd;4:RCWyZcH2mrQBznHEOaRsRtQxHhO+T+hBYbeWIz1/eUtkMdpFgUocWH0qbdQOdRxBPG42+wqJO+Ef4DnBhFIBoUSJ/d36zVW6ABbheTtoIBDxmjuTfvBcurIapjPEqkZaXG1S3/IBszM4GZKoEEgC95xSuNGDFSJo0F3ciRRbbqsbc2P41+b1uoeBzxdWzp8VFTRf0qaNHqMa/DTpGIFOeveaBdeF5GzNHJyHBlBOoaFyKGlff1iY/ldh/GYF6vglum7WKelw8ph2mRRSCM7zpBeIzdSbGdxYa45B2L0syslsGKTkD3XjN8EZEoCzMKam
X-Microsoft-Antispam-PRVS: <SN1PR12MB0173A83F270C951EBFF4D477ECAC0@SN1PR12MB0173.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:SN1PR12MB0173;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0173;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(86362001)(230700001)(2906002)(105586002)(25786009)(81156014)(53936002)(81166006)(50466002)(486005)(69596002)(486005)(476003)(7736002)(72206003)(16526019)(4326008)(53416004)(8936002)(2486003)(59450400001)(7696005)(956004)(26005)(58126008)(6506007)(386003)(103116003)(305945005)(478600001)(54906003)(9686003)(52116002)(55016002)(97746001)(66066001)(6116002)(23676004)(47776003)(8676002)(6666003)(106356001)(68736007)(97736004)(1857600001)(1076002)(3846002)(5660300001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0173;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTczOzIzOnVHN0t2cWorRE81NW9UdU9Ydms3U1Q5OVUz?=
 =?utf-8?B?RitmUVo4QW1iMnE0Z3pnVGdGcy9VQnllWmpjdUlpMUpZTlpOMHdaNS9sdWMr?=
 =?utf-8?B?Tmc2RW5RK0dYL0huUGtFeEUrUVhoWkxEQ2thVDMwS1B5c0pZdXYySVNLMWUr?=
 =?utf-8?B?dWE1U1lJeXp6Q1JRekdHKzhKQjhlS0xrMWllTGlsbHllaHJhb2xtS0NXMWRE?=
 =?utf-8?B?SGJLU0MyRnY1Zlk2QUVjd1g0amFkblJIb0MyOEFURERkS1MrMlVjVXN6STYx?=
 =?utf-8?B?Z1M4K2NuQ3IxZXlBbTN6TDR4YnZPZWxsa1pSYkpxUEhCT1dmVFM4MGRqMW56?=
 =?utf-8?B?WU5BWThibVVabjZuUml5ZnFoaFJnYzRjeW9zYjE0QTVvTTF4RWpicllDbXZH?=
 =?utf-8?B?ZnFKVkNJeTJOdDl6Z24zWnErSjg3Q08vWjU2UWVPaUJEUTNUU2x2WER5Ullr?=
 =?utf-8?B?MmEyT200dk5ETVdPeGhraHhMb1dleU9sNXFXRmlHUmdsQy94MEhaYUxBZFpl?=
 =?utf-8?B?S3hDcElIZ0h0cjYxMHFLOUpibmJQSXE2dDNZeEtKNEhQaHdKRjYxMUNwSkRL?=
 =?utf-8?B?NzcxWFVkazFzMEFHcUZHZFdtN1JidGYrWUk2YzRxdDFqNHU3WE1aNEpQNEdC?=
 =?utf-8?B?QUx1bHU3Yk1ZZVl3bGkzM3lGWXJGbUozNGR5Q0ZIU1BSbFRpWUdqWUFkVjla?=
 =?utf-8?B?bG5PN2k5MWhjMEkvaGV1V2UxYVJJWWxFWDhkUVNENFlZTzRBUWJRd3FUakxR?=
 =?utf-8?B?TEwxY3pXeUJpUEZZTnRjK3FTTlpMT0hNMkZvakV3ai85MFdCTUM4bE1vdnZt?=
 =?utf-8?B?TUhUM3ZBRVByNDJ0NUJscFBwMWI0ejcwbDZRVHo0dUxOZHBabWlNWE5heGMr?=
 =?utf-8?B?WTcrS3lDdUdIeHVOank5K1ZabU9yUVI0clpJc3RpQUhyUm9ySFFST1VHY2VR?=
 =?utf-8?B?cG10citwNlZZb3RDOCt1M0ZVUTZ2b1hnU3RZcGExNFZMVk9GYW5YbVEyYzZi?=
 =?utf-8?B?QUp6aUZOTW16YlVNK0YzNTRnRkNRVTZzN2M3dkZLQzRUaVphL0hiZlZHa2px?=
 =?utf-8?B?Y21uNkdEQm1CckNoUStac0JOM2JiNGZFZkVBTG5TNm15MUFRQTZ3c2J6SFND?=
 =?utf-8?B?THEzM2hkMFdBZW9PMFp0Zkxxdks2TmFVZDhLVGduYUdDUXVFK1pGR2dEa3FT?=
 =?utf-8?B?WU12cmxzOG9BclQwVXJjUUE3MzFLMjhKNjRFemd6NUtBcllBU0t1eWtVcDlt?=
 =?utf-8?B?cVA2U0s3SUZPU2gzQk9DbTErdkRvSkVwSDR2SS9WMDRQNHNWNnF0eWZiYWRI?=
 =?utf-8?B?UCs5WmJheXpIQjJjVWFFU1JWV0V3YXpRQU1lSkZtWnRaWS9OMDR4a2MvakpN?=
 =?utf-8?B?NDBYallnaUkzM2tveGdKRXpKbFhDZjZnWFMrVzErSC8rVWVUL1lTZGRzMGVv?=
 =?utf-8?B?MEEyMTVqcEpON0VzdU5US1RrVXBxaVJ4ekJQcFo1eStCVUtydDY4aXEvYm1o?=
 =?utf-8?B?NSs2TVJkRlhDekpxRUJVU0ZUb1VYZVRUU1o2T0FWTzdvT1phWnFkWU00K0c0?=
 =?utf-8?B?eHlpSGE1bE1vTmJoN0JZdVFMQ0VldXhTeW1sREdYRE1zOXFuTVVqb2RZKzJW?=
 =?utf-8?B?ZElXOEY5Ni91NkxZd0NWalExMk95YS9JbFBuSXIvb2xFQWJKODZwcURCVXNH?=
 =?utf-8?B?cEhmY3o1cnlJM0IvaGo2bEdGbjNhYjYwZXhLcmljUmtLeHVtZjM5Vkh1SFNI?=
 =?utf-8?B?NEtUTXVSQVpESk9RYW9EZz09?=
X-Microsoft-Antispam-Message-Info: +am77jFYQmbKtQ47sLinY9vvzswRuPM+cohtsZLexlbeU8hB2JdxEj0QKV9akEA6JOdnSBjfrTfm8zXNJg3HNX0zcutT48HHa+lsHmAw3rMYQXcK8aIxm3zgG3pKHWELgAOxFaUpMWPcEgU3pprEHcWG4EkL7ATL8Iw1J1HTG+X8ji4ZiC2LKn2tNQ2ySzr+
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0173;6:at0TlNZkpIICsx9IOyvtDjUbo+HNk1KlSzbaUxXukmHzPxPZs2bFBYPA9GoTjKVmoDXwzIAi5wwwelwFeioTHxGc03hwP7iwbzDx/BfWQKA/zhk7X/M/oOaqhbAFAWRfT2xZ1QaAO3wOinHjISDG0dpj+YtIfvYV55Z7mOC4I3LmtMhDvTi85PxEh7OtpgfCnZ3/gYVij5Q4aZGOsiB+B69SgMtSap9MjI2vPwoQS0SsasqqGI3/ICJ7yhpmX4cmO7q551tR6UuQPBE7sax5Ru9dpka0zF9iwcsP9wZIrCBg4+7LVOACw9ny6K+PBuI87eEWkYupIxpCJCsfUZRqxr9BnrzHGdRPMBpuxTdpByje1DopQxT287u9U7Xg7YxIxhNs6hTWfm+J0mPCRPahYzXVBvQkvisojmyIoGiR3brtJ8fsFfLkOB+AqxWSCNVx/bI4U/KgZ58+KEowzE43NQ==;5:TmLUmQ26qSTpQXqZdAgVFZiNtHKqufWsz2kb+1vxZKP6/mgxM1UUPvRBbnEbPxxXktf4X8yJiCZYuiISjZYjrrisgFTRxm0gdVoQ0ob3zMgsfoLQgqPoZqS1pvliLzYti6r4vDPPfK387FXTwE2mp8ltVwQ4R3KqKPh4F4R4bC0=;24:P4A2Z9iveaMxp75kOkrNg9VOylO5wUM6tEh8S90XsDgGUeD2y/8s85M0WVS/gt86jnVYwvnALFLxhOwBRZwQJOwjSpWzv+herub49aWUazw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0173;7:dvwKbEx1ElE4D+520ukSGeoa4w6XjI/fjsEE3maHpBLU1wfV1fpqaNWEBAx6LGjCNZTzfHJF+Wrguzk0bESu8saUYWQUOF3NfiuGHfiMJHYRollekrIjWritMnYYcApM7jysPVOQSBJL6XwrGL7D8PCkBUwv8GarTrVtf/WdnS5mBiYr4t/ZM2QdfRnpiw0OSkBUn4AQ0bgI5WgP88eQgm6SEl/9Nv6CenEcoenPWCB1agl8xeElMQwXkCuFXaRO;20:vAWhUPrAsMwSPFELAb4Okpjp9mA677/cXXhSBCEs1sza/iwdqLwGxvFLebgz47QsNzt2sT8Ju/YI+sNJZuFebU1BXET0lAsVAtE9ILSnF5c50pLuW1v/NZJGf35FcUzperLp8KAXQcUhzfSnzR+WLg1+QWc7Hf+34CDviZLp+YhpC1l9+s3ncen8BsyUyhzzFnhRO0gPShFtJhVz3jUGUuU8MMvCK3O38ztXv5vlvM625h4rU3uFJL27M9odXzeg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 22:07:15.1171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7664aee4-fe6b-4f9e-1185-08d5942f19ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0173
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/x86/boot/compressed/kaslr_64.c, CONFIG_AMD_MEM_ENCRYPT support
was initially #undef'd to support SME with minimal effort.  When support
for SEV was added, the #undef remained and some minimal support for
setting the encryption bit was added for building identity mapped
pagetable entries.

Commit b83ce5ee9147 ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52")
changed __PHYSICAL_MASK_SHIFT from 46 to 52 in support of 5-level paging.
This change resulted in SEV guests failing to boot because the encryption
bit was no longer being automatically masked out.  The compressed boot
path now requires sme_me_mask to be defined in order for the pagetable
functions, such as pud_present(), to properly mask out the encryption bit
(currently bit 47) when evaluating pagetable entries.

Add an sme_me_mask variable in arch/x86/boot/compressed/mem_encrypt.S,
which is set when SEV is active, delete the #undef CONFIG_AMD_MEM_ENCRYPT
from arch/x86/boot/compressed/kaslr_64.c and use sme_me_mask when building
the identify mapped pagetable entries.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/kaslr_64.c    |   14 ++++----------
 arch/x86/boot/compressed/mem_encrypt.S |   17 ++++++++++-------
 arch/x86/boot/compressed/misc.h        |    2 +-
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr_64.c b/arch/x86/boot/compressed/kaslr_64.c
index b5e5e02..522d114 100644
--- a/arch/x86/boot/compressed/kaslr_64.c
+++ b/arch/x86/boot/compressed/kaslr_64.c
@@ -16,13 +16,6 @@
 #define __pa(x)  ((unsigned long)(x))
 #define __va(x)  ((void *)((unsigned long)(x)))
 
-/*
- * The pgtable.h and mm/ident_map.c includes make use of the SME related
- * information which is not used in the compressed image support. Un-define
- * the SME support to avoid any compile and link errors.
- */
-#undef CONFIG_AMD_MEM_ENCRYPT
-
 /* No PAGE_TABLE_ISOLATION support needed either: */
 #undef CONFIG_PAGE_TABLE_ISOLATION
 
@@ -85,13 +78,14 @@ static void *alloc_pgt_page(void *context)
 /* Locates and clears a region for a new top level page table. */
 void initialize_identity_maps(void)
 {
-	unsigned long sev_me_mask = get_sev_encryption_mask();
+	/* If running as an SEV guest, the encryption mask is required. */
+	set_sev_encryption_mask();
 
 	/* Init mapping_info with run-time function/buffer pointers. */
 	mapping_info.alloc_pgt_page = alloc_pgt_page;
 	mapping_info.context = &pgt_data;
-	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sev_me_mask;
-	mapping_info.kernpg_flag = _KERNPG_TABLE | sev_me_mask;
+	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
+	mapping_info.kernpg_flag = _KERNPG_TABLE;
 
 	/*
 	 * It should be impossible for this not to already be true,
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 54f5f66..eaa843a 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -88,9 +88,7 @@ ENTRY(get_sev_encryption_bit)
 ENDPROC(get_sev_encryption_bit)
 
 	.code64
-ENTRY(get_sev_encryption_mask)
-	xor	%rax, %rax
-
+ENTRY(set_sev_encryption_mask)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	push	%rbp
 	push	%rdx
@@ -101,9 +99,7 @@ ENTRY(get_sev_encryption_mask)
 	testl	%eax, %eax
 	jz	.Lno_sev_mask
 
-	xor	%rdx, %rdx
-	bts	%rax, %rdx		/* Create the encryption mask */
-	mov	%rdx, %rax		/* ... and return it */
+	bts	%rax, sme_me_mask(%rip)	/* Create the encryption mask */
 
 .Lno_sev_mask:
 	movq	%rbp, %rsp		/* Restore original stack pointer */
@@ -112,9 +108,16 @@ ENTRY(get_sev_encryption_mask)
 	pop	%rbp
 #endif
 
+	xor	%rax, %rax
 	ret
-ENDPROC(get_sev_encryption_mask)
+ENDPROC(set_sev_encryption_mask)
 
 	.data
 enc_bit:
 	.int	0xffffffff
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	.balign	8
+GLOBAL(sme_me_mask)
+	.quad	0
+#endif
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 4d369c3..9e11be4 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -114,6 +114,6 @@ static inline void console_init(void)
 { }
 #endif
 
-unsigned long get_sev_encryption_mask(void);
+void set_sev_encryption_mask(void);
 
 #endif
