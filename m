Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753637AbeA3Wvm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:51:42 -0500
Received: from mail-co1nam03on0086.outbound.protection.outlook.com ([104.47.40.86]:47712
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752212AbeA3Wvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:51:40 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCHv3 3/3] x86/mm/encrypt: Rewrite sme_pgtable_calc()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20180124163623.61765-1-kirill.shutemov@linux.intel.com>
 <20180124163623.61765-4-kirill.shutemov@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <12ffff46-474b-5fb5-c143-e2db29b3f8a0@amd.com>
Date: Tue, 30 Jan 2018 16:51:34 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180124163623.61765-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:404:13f::14) To CY4PR12MB1144.namprd12.prod.outlook.com
 (2603:10b6:903:38::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbe451ae-3080-40ed-5040-08d5683405fe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1144;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;3:JqJHW3jKRP7aUX+xLt1TLMmowUqN6G1/DaDImX2LjzMxn/WGmd8zXh3/+/tkytTRbVBFLjvUEOcxFb6JYpB8uHXMiqqNutMcNwmmbAjW+Nb+P4vyvm1gB6BUuDi7bdvMKTCjoMQOwQfFAFonV0sLHR6hnuHPUVOVRA10OXmdioiMLC2ZuLAgzG7rhbn5FMqgYwWtPUAeYshXn6uxaGo79+y0ja6lmwIWu/QAy/tD9SMAS50Fjlo/Xd2Hw9ICst4q;25:Oq/VxDduaCsAWYQd8HlRPwhNqQogrKub00bIVTqm7nxh2vARFrIY2PRxXUTCulF6mc3v6xmRR7TeFCvEcHmYU4GX7f4bHGKcZBJ5/wkxbCqmtN4i+P7SF7z2y5ENWQcCkQfOGXyCEUfMBT2T7RAkEp7GfDeRrOgXvs8BJGt710GES1jLgLFQbbD6XAmISOtxAdU2itjy/lmzwoWmNKHmRpILmj8NKn87R6HKm3IN45s/wsC1FFqL0LkjvvdJuDIyz5jCBuy70+0KiRK8epsPUzPa/SiNvV5U46IY9ekTS8xkhxlzphWK3g5FO2wEzSNNKixOkVhAfwAfhtFW3ikhhg==;31:42Gjhm/0G7V6kIHZgKZzvbDUu1oevIYdeLA5qbqzPV9AVs/4+5MXv28O1POKPxE8t4xFNHA+quY8ls19UOGlJ7blz8ZlxzLMRs6Qql7ytcIjLSkTghFSLRasUv0PDVxi1H/WerOlndTTvNv9jN2c/8dFYhyHFsUq4jvCMiE80sEsARHCja3s77iP+BF0hkYp31FTSQurARBWSH+van5jD1C9Nw+nzOWlUcPdoDDWsaA=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1144:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;20:7tsEHSM/7yetw3sbm2l/hTYN4zZHUohlMrk02uup5m3hMOvPlbxQW2m7fPWWm1MR7aPFS989aOU7E51CMMLvGPQEu+KGWcf3zkDUBfsaPdxX99q46KxderbYl3QUjfHL3Dvf0KDgkvHv0ck1S5PzJ0mF3DGyRTNSoKSrTiyZFTVZV3cFYjaPul3JjF7PS6ktuRP6PXzvYCUbsP4pZYmudL2oKmz8TO2F7+2WATKYM0sokT/fUVVdFiTgsUNvQg+kmCQLxM9ajtuUbJHaTB/0OAtD+rFxTWfe7SZz6pywJjNgDPlxAPwm0hirPFrEQMATziRkzCSuQX6Ikt5YbisB0cmOHiRUOLDhuHOp4yIsVQ8Rx8htjtIXKy1IAlqlw6GUBA+PEZ0/O/vGP8CxF0nbo7XHEY0/VuqYxa9vRSiBLRywU1DlyeAtewzfJ/cEnUSYtfpS3t8clMfYC4KnziyI3CyiQDCZc1telt0rfkHMaVht+W5AoLk89HriQsuio+tl;4:yATssrO9cub22ZpWGRusLgQ4a7IeSnYe7wf3nwjuXT/fu7hwr3o474wUSEpp7G9Ln0Iq5de6optV3YZjdaULoiytsufx3nK4BCao2LN7Wk7x5fNaUIz5QoxOOENyPzhCWKJGOu6dWp77Q32Smnw/9ky4UCkrOdErHxa18P2Y8P14RqFdH4yzaliAN1Mh2lXJiFHN+wcMh1HsX6FTKrjHggUVQAJz5XGjq6M/lfhKQU3R2L8SiEK8NTnolwUyisdzYneqJzJp40imf8nagnZGJ3ZFbMrERcVOgzxj5gelVxnj/AWGV5cEraa726QRb1L+4eKFMTiU15m6fDv4GxBW8w==
X-Microsoft-Antispam-PRVS: <CY4PR12MB1144B7C79A1285311F9B9D6DECE40@CY4PR12MB1144.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(944501161)(10201501046)(6055026)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1144;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1144;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(31686004)(7736002)(3846002)(2486003)(2906002)(86362001)(53936002)(305945005)(5660300001)(2950100002)(65956001)(186003)(6246003)(23676004)(6116002)(6666003)(52146003)(16526019)(66066001)(26005)(77096007)(76176011)(31696002)(65806001)(65826007)(386003)(53546011)(36756003)(47776003)(6486002)(25786009)(3260700006)(64126003)(229853002)(50466002)(106356001)(52116002)(83506002)(8936002)(97736004)(72206003)(230700001)(58126008)(54906003)(68736007)(81156014)(316002)(110136005)(8676002)(16576012)(478600001)(4326008)(81166006)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1144;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQ0OzIzOmZ6RldsQ2NtQXRvc0dXblpER0VKOUJwS2VN?=
 =?utf-8?B?TW5vV1J3Q1M3MDdncUg4cmdwNndlOVVJT0wxWkQybHVNb2QyNElvYU9reitQ?=
 =?utf-8?B?Ti9mdVlYWmNWR0xVcUFzaVVwZnlCSHVYU2JGNDlxcG9Td3YyNTVyQU85d3Nh?=
 =?utf-8?B?ZXhxTjh1Q00zTVBKT3d5N2pMZEg1blNCR2REYjlXM3ZtK3VxN2xLMnplbjBC?=
 =?utf-8?B?eEl3bzVDVXpZeUVvYnY2RjAzTzc1M2NsN2h1TkluRDQ0WElMajUvRzNsb0RO?=
 =?utf-8?B?R3VScDkveHc2ZDVmMDRnYmhYekJXMHVBY1JQc3hIcnpJVEc4Q1hlN0RCZ3hJ?=
 =?utf-8?B?aENuRjY1NDVKTks2YXg2Y3hIbjhTZ2p1UWs1a2owWDlqRkE3M0VSWFErV3JG?=
 =?utf-8?B?S1RNVzlaVGdMdkhtZDBTcWhjaXg5OWdCbjBLc3EweElLWURuM3FKZTNDREI3?=
 =?utf-8?B?VFgweWNxQWppRVV1OGlHSi9NOE5Ra0gxY0NEcjhTSXFZVTk0STBLSjVSWEg0?=
 =?utf-8?B?d0VraG0zTEF6d3c5UWp1amttWEFFVDhGbGk3bkV4UDdzY25xVUFMNUd4Y0R3?=
 =?utf-8?B?QU1RaVhxTzUxZjh1UzJjeG9BUHVnK1hWUXIybCt5WEZkRStQQUtrakl1QzNQ?=
 =?utf-8?B?VVM4aXlSbHBvdnBtTStQVHloRDhhK24zRTZtNVFTaUFvaWxuNmFFVkJpV253?=
 =?utf-8?B?eTJCNnBJSFV4R0EzUVZVb0VtODZpZU4yQ3FtUUoySjVabzV0R2dXelRDcUdI?=
 =?utf-8?B?dnFPRUxlRGx3UUJYdGYyUFlXNmJjZzNrcDVmbFhzRHMvay93U3lNSjRiZEVv?=
 =?utf-8?B?YitqdXRndG80OWVXTXJlaENuUk9vVkZRb01xMVRKbDAydTBkTWhaN3FKRzFo?=
 =?utf-8?B?OWNJbEtOTWhDOUtZQUJaMUQzYWFJcWNRaDVEZHErb3Rzb2VCZXd3NmJ3NW5P?=
 =?utf-8?B?Nmt3dENFYVhXZUpqeThBNEFDcG1VR2VyeWFoT3Rxa2dZQmVxZlhnZW9MZ3oy?=
 =?utf-8?B?Ly9UelFHa3FkV1kyWmM3bkNOSkdCSCtqSk5KWkRTdEVMTGtCNDFXL05SMXRK?=
 =?utf-8?B?UFBxV1hXdmMyS1JtQzk2L2RXeXFkWFo0SzBENVAvc1orbHJnZ3g1NlFKdVNR?=
 =?utf-8?B?UzdoODZUVHFyWW9yeUdJckkzMFNHcWhTTzZsOVV6WE9GU28zaXdyRCtUYS81?=
 =?utf-8?B?bWRiL21QMnJ6TVpBcUhMbCtGRTlnWVpBMHVPcVArNG9KRStFUGFaRVdGU2Vw?=
 =?utf-8?B?ODA0OTBkcTl6cy8zdEloc3VSMlBtek9RNHltb0dlSmRlNmczQ2I4TmVzSExo?=
 =?utf-8?B?WDlEZ3R1MzMvVjdyako4NzVPekQ0c0tMYnhvdGN1Q2RPMEVDaFRMckh2cU9a?=
 =?utf-8?B?QldhZUFMVDZxalhPWDdBZitsSzJuNWV3Z2RHTEJONkV6KzU5dGV3UTRkYS91?=
 =?utf-8?B?OHlIL00yWHNjMVRYbGJYV240VTc4NUdibEMyeTQxTzY3eU1wVlZQd3FVMlNp?=
 =?utf-8?B?TDJCSDIrVnFtZ0pmOXQvTnNKcEl0WkRHaGlxZ1dRSUFGVHBaUytjT0VZS1Nr?=
 =?utf-8?B?ZHNUc2NMSXgrVlYzeEh2VHdQOHR1K1JMWERVVmxZbWQ4L3hIWnNHRkhONmNt?=
 =?utf-8?B?dFRYZzZsVkZJVUMxanpwSW03UFF5cjQ1WGJRT1dRQ0hKRmpVUTMvV2pEbVN2?=
 =?utf-8?B?YVFnSEhCVE5tNFJka2swb1FxaGxCTG5nU0dudkNyVUJLNWNULzJoNHg3ZXJp?=
 =?utf-8?B?Um9SVXA2b3lsbGYweURGalhtbEcxbE9zUlZydTJSR1dDOTFldER6SERRc09k?=
 =?utf-8?B?U2pqY1hJdnJIQ21QNUt6bm91U2c0NmRrai9WSkFuSVoycmJXMnQwcnl3dmUv?=
 =?utf-8?B?RjVQUUhFUzM0V1NrV2ZxejJQbWZoTEpINGdidTFMZTArQU45OUtlU3o0VkxC?=
 =?utf-8?B?UlFKZGorbUJnPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;6:z/p845bfQ+5YgUrzRRwJe6uHLCHpvZb0lKu7nKHZhCWDFN3bLeLI7Ikh2xGJU0uCN3fn+EL7bsvJL3ZxOenF4eg+ekkZJckscQIst4UiPDGku5C0nK++As2XT9hsye3g1k+sgMltL+pgPkBfYOSkvqdSzOFANblteg+QM0gIUlTq4Eaa4r3U7R+fNUylrowvg1fop1otwVbT8aS/fNBbcs1m4qh9Ffy6rHqBTS/UZ6Nd290OvRofeU62Fh0Eapl2IQM6eNidOq3wZLDXCzdB6FRZlpKSwkQDo7CBHBDF2O5zngd4W87bpZ5C5H9Re+UQsjbWgVRZiChDMlzlq4TGxounp94uFITMD4ZjZcpLyXc=;5:DLpjRhNHkeGGUzqGW4w9D74bvU1hBExfkPfwfhZL5RMSJ+rKsP1/JaPm3j3tZ6BbNEusNsQaHcFWDBDwPafKsk4tUKSa46iOpu9IdPOHOHQcdu6Mbtcp8LMg3+Oj3GSl7L8i4FLDfh+JRY7KXWyP/N494W/b5OnoZHHWGrH/7lQ=;24:/4rv6Hgawu1uwhX4WXD0XhfyskyM3sHsFroOxJWAWB7pJpSfKJgT101hIhI5Kx29iK4+4EoaojZSWtLHFZ2vRA/oJdjzrmEzw5AE3jjhTMg=;7:GKrXpkN5PhEmmXhUgCTDUSW7F/rTLRh0eyn1RH+DDMJdDO4PkNUEhn2SWFxYSn8kQew7Gukip1z4oB+zYlMUIqSd3RUGWeGWYVXWiAKiYIIMTEPTZLx0W9DBnNV8qM6F2icnGeKR7jxA0im3DSwajgCcGPqfqxG95UDU984zhwT7Z3cX0bGY8ZlyYlG2MRu1C+u2VpaIKmqmZokYkK6nlG5PYQWXkkPGYPdSb18tzW5/aFjqPNMEvS2I6FO35Sj1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;20:pFTG3A8TnoR29bE//5PEfzlAHxLKUZzBX67/uBSt5A5xj8x8iN5MikyhdHCf8i5uaUvadLIkeW5+fYv55mNJg2h0aSxIk9TVBCVBn7MbgWRkjy1gwewX7jbunHGHtSfHqX5eC0EuBlnVxcasGeAf3js9MJml+HLgg+xvHrSaBJleeoAuFu9vSZrVvv3bmAKNX4YSpE4Kqxt7zAglPAo038M72tvk/+4FcNgo7mtxmikpqxqBfFnBTVKGmM5GlPSN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 22:51:37.9840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe451ae-3080-40ed-5040-08d5683405fe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1144
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/2018 10:36 AM, Kirill A. Shutemov wrote:
> sme_pgtable_calc() is unnecessary complex. It can be re-written in a
> more stream-lined way.
> 
> As a side effect, we would get the code ready to boot-time switching
> between paging modes.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/mm/mem_encrypt_identity.c | 42 +++++++++++---------------------------
>  1 file changed, 12 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 69635a02ce9e..613686cc56ae 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -230,8 +230,7 @@ static void __init sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
>  
>  static unsigned long __init sme_pgtable_calc(unsigned long len)
>  {
> -	unsigned long p4d_size, pud_size, pmd_size, pte_size;
> -	unsigned long total;
> +	unsigned long entries = 0, tables = 0;
>  
>  	/*
>  	 * Perform a relatively simplistic calculation of the pagetable
> @@ -245,42 +244,25 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
>  	 * Incrementing the count for each covers the case where the addresses
>  	 * cross entries.
>  	 */
> -	if (IS_ENABLED(CONFIG_X86_5LEVEL)) {
> -		p4d_size = (ALIGN(len, PGDIR_SIZE) / PGDIR_SIZE) + 1;
> -		p4d_size *= sizeof(p4d_t) * PTRS_PER_P4D;
> -		pud_size = (ALIGN(len, P4D_SIZE) / P4D_SIZE) + 1;
> -		pud_size *= sizeof(pud_t) * PTRS_PER_PUD;
> -	} else {
> -		p4d_size = 0;
> -		pud_size = (ALIGN(len, PGDIR_SIZE) / PGDIR_SIZE) + 1;
> -		pud_size *= sizeof(pud_t) * PTRS_PER_PUD;
> -	}
> -	pmd_size = (ALIGN(len, PUD_SIZE) / PUD_SIZE) + 1;
> -	pmd_size *= sizeof(pmd_t) * PTRS_PER_PMD;
> -	pte_size = 2 * sizeof(pte_t) * PTRS_PER_PTE;
>  
> -	total = p4d_size + pud_size + pmd_size + pte_size;
> +	/* PGDIR_SIZE is equal to P4D_SIZE on 4-level machine. */
> +	if (PTRS_PER_P4D > 1)
> +		entries += (DIV_ROUND_UP(len, PGDIR_SIZE) + 1) * sizeof(p4d_t) * PTRS_PER_P4D;
> +	entries += (DIV_ROUND_UP(len, P4D_SIZE) + 1) * sizeof(pud_t) * PTRS_PER_PUD;
> +	entries += (DIV_ROUND_UP(len, PUD_SIZE) + 1) * sizeof(pmd_t) * PTRS_PER_PMD;
> +	entries += 2 * sizeof(pte_t) * PTRS_PER_PTE;
>  
>  	/*
>  	 * Now calculate the added pagetable structures needed to populate
>  	 * the new pagetables.
>  	 */
> -	if (IS_ENABLED(CONFIG_X86_5LEVEL)) {
> -		p4d_size = ALIGN(total, PGDIR_SIZE) / PGDIR_SIZE;
> -		p4d_size *= sizeof(p4d_t) * PTRS_PER_P4D;
> -		pud_size = ALIGN(total, P4D_SIZE) / P4D_SIZE;
> -		pud_size *= sizeof(pud_t) * PTRS_PER_PUD;
> -	} else {
> -		p4d_size = 0;
> -		pud_size = ALIGN(total, PGDIR_SIZE) / PGDIR_SIZE;
> -		pud_size *= sizeof(pud_t) * PTRS_PER_PUD;
> -	}
> -	pmd_size = ALIGN(total, PUD_SIZE) / PUD_SIZE;
> -	pmd_size *= sizeof(pmd_t) * PTRS_PER_PMD;
>  
> -	total += p4d_size + pud_size + pmd_size;
> +	if (PTRS_PER_P4D > 1)
> +		tables += DIV_ROUND_UP(entries, PGDIR_SIZE) * sizeof(p4d_t) * PTRS_PER_P4D;
> +	tables += DIV_ROUND_UP(entries, P4D_SIZE) * sizeof(pud_t) * PTRS_PER_PUD;
> +	tables += DIV_ROUND_UP(entries, PUD_SIZE) * sizeof(pmd_t) * PTRS_PER_PMD;
>  
> -	return total;
> +	return entries + tables;
>  }
>  
>  void __init __nostackprotector sme_encrypt_kernel(struct boot_params *bp)
> 
