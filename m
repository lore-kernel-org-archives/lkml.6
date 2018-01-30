Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbeA3Ws1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:48:27 -0500
Received: from mail-sn1nam01on0071.outbound.protection.outlook.com ([104.47.32.71]:50832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752303AbeA3WsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:48:25 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCHv3 2/3] x86/mm/encrypt: Rewrite sme_populate_pgd() and
 sme_populate_pgd_large()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20180124163623.61765-1-kirill.shutemov@linux.intel.com>
 <20180124163623.61765-3-kirill.shutemov@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <7666cc8d-a79e-7ae2-0277-4da7ada308cd@amd.com>
Date: Tue, 30 Jan 2018 16:48:17 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180124163623.61765-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0045.namprd14.prod.outlook.com
 (2603:10b6:404:13f::31) To CY4PR12MB1143.namprd12.prod.outlook.com
 (2603:10b6:903:38::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e322f7bf-2048-4df9-e369-08d5683390f9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1143;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;3:NKl2+MPPlbSNrRxXsQJC5Jc0JvYzFcpO6IoDmgmK2V4jsmkNuuWAzJ8oydg1Ufegytcsbl6DFCj4pbqWEp13YZSrdWHOkPKorCRPHl3jEYrxxHt6HiRgSqkkcyXZQPUUCdq4JdQDMNSTnKlmDfVuCjfG9tXRf74lYSHR4TGGXgmEgl3bhXcnev7Rmo52Uq5OBlfEoLM9iZCdCqoh/Rn7Cb62oJCnJqqLYZo2bDyw8FnIm9YmkiqXB7VwsKapbL5r;25:o6wcokIMqD6+Uy4D9jJoZeTDYxbGhgv67McVf4ln8a7ud0QAhrUP9Z6QxSx//VhUHhKGRGH/vKhFClPrQz5j28TPTMuIgDAG8VTMBWhp+kpJvMRr7FdZNlBWi6wWMOC2sxI5mbxDiVTW/iYlnPW83878ZIz722ICkTVOyli1tWMYsw81zwLYXojPf+UF5/noyBhrucXFNwitnapsIn+urzs++fAuLlJfhLN/3W+y5grACl7m6U7rG842DQLWY89JH04uCTgQKx2gki8J3B7bWP/aV+2WSdyacbTH6Qu/sAXNwHD7n8dZQCdbCG4MGi7KqLEn+9ih/7YUnevZcHdnYw==;31:MZPKLJXIysiwz47kZTLSn4pgbKrUCkNshPlYTOyiKnHCziTvFgZYMNPqWCgsJ4Ns7mbY1PXKJYgZUUz6JkQ8M+rBch0J/O38AQo6UKvsCAx0+8pHekmSbDdIcrxQinHnLYwJAZoqZELzN0x1fHdErxzfuhToGlATppSaAaCrcbgANk2Bx+AXYQukrHYyDlZ/vnomtVSsEaTzT8RdO1L/Kj2McL5jH1fS1dor2Sn81+I=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1143:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:EfyHz56j/YKNgMJg7Oruhs0G3E/xP9G4a2iPpTuGk/dRjyrSLzabahyHbYxt1+93q0xNtqs8Kc2RMqtuUm3Xbj6W9pxH4f/azaeTGqMBAB3hLWy9LizlUHBSRvJP/++7Wycq/eU1foSKdOOKpOkRvWjcA//nKoWQRxJlkpwYlQ4IMis5eMQ//RseXyr5ACNEIA40B22973hY/wXjq6j/VzgvCrjz8acPDCm4gNwd8URExtJQ0isnTn4Z/b6ZCZ/M+XFsID/32pHwNescJ3LuP8l1eepFtt74S7w0RwDfejRnIpqnBRt18zjnUZxYpaH0B4Jo7X92c1UQ2Pp5zLneBeFYoeUD8TqG/4b6LLL37QX4ffUR3AG+2a0o3U3Qm9vH7HfVhUZZDc4+lyUPFMK7P11qyYo+6Mf86coNWVUX1nyj1r0/zLfxVgheKOfv1NCVxYI4iq20WiutxMH5zL+ujs+yUhCb/UryDjxAHDm79ga5p/UjAfpUzQn81qtrD1+w;4:npaTs9dphvz6QauJ0H7KKw43F7gUnilzEdr5oTPlovA/RU4JLA+8mW1j2BShkJKUiA2n46vcy7zHdMqd6vMH1DG3vKUbx+t/CMhlRlzncVOwrS10zCk4Gp9G0wDrRSz229H56U3WPnyZ0mdRIhZB9uP9JnXCEwy09WPeDqT0csVDy4fo9uXQGh4T1SN+D8OiDplxTpuTn/6eBma1Be7w/9UYjnlxoVXeFjqwsaLehe1IR7nDBdgVwj+Ifk2w8pogqSR7hydzbZ/AKGJkg3trQVDGciIgESNnBkSw14X12Q54BXe1RXxp5CcVLJVd4PkpPjlOkppIC9uRR4Tsu0r3rQ==
X-Microsoft-Antispam-PRVS: <CY4PR12MB11439DC382B218FD4635A6A6ECE40@CY4PR12MB1143.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(944501161)(10201501046)(6055026)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR12MB1143;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1143;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(52314003)(7736002)(81166006)(8936002)(2906002)(86362001)(65826007)(186003)(5660300001)(81156014)(83506002)(26005)(8676002)(305945005)(386003)(16526019)(6246003)(3846002)(53936002)(6666003)(6116002)(50466002)(66066001)(65956001)(31696002)(31686004)(105586002)(97736004)(47776003)(52116002)(6486002)(64126003)(229853002)(106356001)(2950100002)(478600001)(77096007)(25786009)(68736007)(4326008)(52146003)(316002)(23676004)(72206003)(53546011)(65806001)(230700001)(58126008)(54906003)(3260700006)(76176011)(2486003)(110136005)(36756003)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1143;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQzOzIzOkkwUHUraDNFcXFuSzVLL1ZBOFE2L2RuK08x?=
 =?utf-8?B?dk1sYjEzdnA5MTFMdXNOT3VzVWFBeVZza2FsOC9Bblp1ZGVYd3cxVE1iMU5r?=
 =?utf-8?B?bjJrNHppeEVIdy9BdjFaZXYzTzhBajlua3JVNzFJd09SSzdhQURrNVo2bjVu?=
 =?utf-8?B?NmRHZ0xITFQvajRpcUpHVHZCMEZ4N0UyTVk4L1NlbmlxanpuQWlRVi9GL08y?=
 =?utf-8?B?ck9DbG15dUUwSWFnVTZMQUk0SFFXaXYwdXlUVEpzTmdkV0dsWnV1SXpTeFA5?=
 =?utf-8?B?TDY5eGhkSlhMeEpBZnFqakNNRTdzRGR0U2o5MC96RTQ5VFpzcmFJZGRPNDF5?=
 =?utf-8?B?OGs0WFV4ZVpUQUFEcFVHQnBUVHZ2c1RTbGx4SVhRV2RmUm9GbmxmRC9ZbTdQ?=
 =?utf-8?B?cU9qSzh0bnZwaVUzK2RsVWNVblVQc3VNam81Z05BVlhlZ1ZGUHExSnBkRFFh?=
 =?utf-8?B?cTF6SVc1Vml5M24za2VWeitBcmhZOVNpVHhmS3FCbHV0VFNSdlpUUEFZUVd6?=
 =?utf-8?B?ZTRwMTVBbTByam5NOEVER1RmVkJ6dnd0VmI5L0NLUWtxbXd5dGlwTG9LYVlp?=
 =?utf-8?B?aTVERjBXRzRDanlCc1dJTGkwQnFaODRoMnYrZnRZdjlCZ2ZHZlNXcUVYZ2p2?=
 =?utf-8?B?akhtSFlqWlNDYk5ZMUdTVjlKMjdzNU45allyUEJoMlJuZHZ1b0sxL3BjZzYw?=
 =?utf-8?B?NTVKUjV2QmdUdUdLY3J3b1M2eFpzcXFWWUxqWTlkcmVKYWw3VHd5ODRNbElO?=
 =?utf-8?B?RlNGcW1VaFViYkRlcUd1ZTN5OGo3SFBwSGZ3UUJyNUZTd2ErL3B1YXpEdWo1?=
 =?utf-8?B?emw5eTdFdnU1VXdPOTBMTmdXK2xLM1duRm1LcFNGRHhFS0l3ZkozTHprR3hw?=
 =?utf-8?B?cWJEamxUNXpZb3l6dHI2cEtiVDdWNlp1RWNWd0ZlYmFFS3pmM0tzTEU5UnA5?=
 =?utf-8?B?K3ZHdU4rOWQ2anNWZko2WUZNNXArelJHZXZZWk44YkptSVFNdjZKL1V6bDF1?=
 =?utf-8?B?Tk5IS05MUmRqdVpndGhLRUxwVElOc3cycjBXYlduVTQ5SjdTUmlUdzh0VVpp?=
 =?utf-8?B?amNsMUZadWhJRDJuSk5YTVo0bkc4RmUvWFNISUU2Q0kvY0ZVWjZqeERqVjMx?=
 =?utf-8?B?M3lWcXZ6QXVvTlRUZlVDRGVtZWVlYUwzN0lzckFKZi9OdlY1eG9CTGJlUHgy?=
 =?utf-8?B?d1ovbjZzUytMUEtmSmI2d0RkU2JBQzFJc3VaV1lLSUg3SnF4bGFheFRSdlV0?=
 =?utf-8?B?c1FqQUdZb2Y4WWVSVlhoRFQycHgyUTBrZDRzbUZjZkNrTGJxMEdvS0xtWjlJ?=
 =?utf-8?B?bHN1bTh4L3BUK21xTkJ6L0o2NTVuZjFGdkhTWlJCNTE2SmEzUHViS3BWeHZK?=
 =?utf-8?B?MkFlYXp1NzFBRU0xS0RTUUtaR2g5UkNpOWNLdU5UeGFjZDZpV0Z0UUFidTYv?=
 =?utf-8?B?M3VDQ0kzbHlXQ3c1Q2lCUStVK0c0WlNpa3ZBSkRhRGhqNExjUURINjBneldZ?=
 =?utf-8?B?MW1ZMUFGZnRwUXp1dFR3V1VZRUhVdnArTzBPbk5tb2x1eGJRRzJLZytsUVJX?=
 =?utf-8?B?cHhKaEdBOU5DWFNNWlhRS1VLTy82YTcrSVcvM25zU0J3a20wa2ppaW95aVhU?=
 =?utf-8?B?aDM1ZTM2YW1xaUFjUGdTSEgrcnhSV3hYUVJ3MXVhZHVHQWhKOTg3dG4wc1pB?=
 =?utf-8?B?Z2hJc2hRYjltUGN3OUFFeUNIRTliNlRURHB3YUU3RjI5R1h0TElHdU55QlU5?=
 =?utf-8?B?dnp5RG5JbWhIbU4wQnNjMit5RjdBdk1JWGVHYVBqY1RpUi93S2lzRkJDdFNy?=
 =?utf-8?B?OEVTc1pRY2VQQUw4QVpHQzV0SFpTMFRleTZ6clB0d0ZBNVMzanlydnp3MHBP?=
 =?utf-8?B?NXBjUXR6eTRKdU9zV2xnUE9hdGRldjhIZVJJMkFyTmVJd3l4SHBBK3VaZWpJ?=
 =?utf-8?Q?LWc8OPnXbjr3xlNL6fKuKtIXAaQq/0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;6:a9tskjJVuLS0HO7XeTBRS9h+YyOcKpCXcIM+nry5SWJvMo6Nd6G9hV/mUEp2SD5DVp2vHNFt9eKk70pee89/dVuccJzcfoGO3bNd1bwclQrYVS/TkLQhOGcnvpNy34H96CJur09Y+MTOVNH2noPet/KSyexadLwg5hCK42TiHpzUlxbvVHp0tlochN/dN/zF+E/V64Z28kw2kNuGCxzXDAVtcw2MAs2GMdU18sesIEQoC+VTJmNNe9FOC60BrZpqls/PA9Bn8QRL9ftMUmTLgbMdxQ7Hei0iFumOL2oUv2uk1s3pKGxxX6zJ9bKzM0OP1IWPK/Lf0UnzsDnLjZgYGJXQ2thZXXvbdxuAoukZyq4=;5:ZiSpg8E6JJ1cGOZlSDdKq++SfPrT3hd/pS4wxHEDDyhQvbO5OOL2oL+6FSCMlpQotys5tqOBrIa4apSx/Iu/Bp8xRCz/T+X1BbL3iqC0BLhScQsOUkxyGoH+EuNwWQMIal5GZ4iEc0IJbxfM+MCX0taa4qGS5JzQVIwv+Fvp+1w=;24:Pc8IkumP9FIo/jLoBc4oVj+GWpOBgvSQvIKBEfVIrscFJsHnHBUR5/V2KLPdXAfTD+TPnH8PboSm5c+keScoqn43fASOlA742Ms+YBwdoxo=;7:tlwTSVstjAfuU8lHHdBZ35h5R4RLxUUCMeXgahYZ5UFmQC4xBEAMOF1O352NTxtcm3UBE5/hVEIrBhmZEwwaFWP9Z6MAAZPAc7TtYvMROGqilxz47UzgH3YcwuNoCWQFiDCqCcn9+ae7pTHcCWPqQtpDrGGVxpt+lVx4aYHd3EaJjEHLBHQFIJtdTXFs7ru5Y0SyuEy3JxA9p8v+DnoSm0lseiDHonlZy94Cv+OLQ3b+8m7/+DKqNPMmFoQGKvfa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:rbvqY6hah+KSgcqhpt8GW06lzOl+vemy/2cjgBc2CXWPu/JOHIZuXgosI44mssy4dOq4CVJtZSu7j13qG0eVHu1mJuTrihkTIiKV1EHYS280zTIsK+wlUAnHhIhyt09KeI1PpqLvbvjO0Zv+B44sskRszqqViCiRd3g8FNdcOuJDSrOxv66CPsaij5n68/v1pznFEhdrn106KngnmxjJq0mH9qFjcT5QMfBatWn64OoVjY4B5UUb6iNjrwATEpgq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 22:48:21.3647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e322f7bf-2048-4df9-e369-08d5683390f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/2018 10:36 AM, Kirill A. Shutemov wrote:
> sme_populate_pgd() and sme_populate_pgd_large() operate on the identity
> mapping, which means they want virtual addresses to be equal to physical
> one, without PAGE_OFFSET shift.
> 
> We also need to avoid paravirtualizaion call there.

paravirtualization

> 
> Getting this done is tricky. We cannot use usual page table helpers.
> It forces us to open-code a lot of things. It makes code ugly and hard
> to modify.
> 
> We can get it work with the page table helpers, but it requires few
> preprocessor tricks.
> 
>   - Define __pa() and __va() to be compatible with identity mapping.
> 
>   - Undef CONFIG_PARAVIRT and CONFIG_PARAVIRT_SPINLOCKS before including
>     any file. This way we can avoid pearavirtualization calls.

paravirtualization

> 
> Now we can user normal page table helpers just fine.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/mm/mem_encrypt_identity.c | 159 +++++++++++++++++--------------------
>  1 file changed, 72 insertions(+), 87 deletions(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index c23d55cb25c4..69635a02ce9e 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -12,6 +12,24 @@
>  
>  #define DISABLE_BRANCH_PROFILING
>  
> +/*
> + * Since we're dealing with identity mappings, physical and virtual
> + * addresses are the same, so override these defines which are ultimately
> + * used by the headers in misc.h.
> + */
> +#define __pa(x)  ((unsigned long)(x))
> +#define __va(x)  ((void *)((unsigned long)(x)))
> +
> +/*
> + * Special hack: we have to be careful, because no indirections are
> + * allowed here, and paravirt_ops is a kind of one. As it will only run in
> + * baremetal anyway, we just keep it from happening. (This list needs to
> + * be extended when new paravirt and debugging variants are added.)
> + */
> +#undef CONFIG_PARAVIRT
> +#undef CONFIG_PARAVIRT_SPINLOCKS
> +
> +#include <linux/kernel.h>
>  #include <linux/mm.h>
>  
>  #include <asm/setup.h>
> @@ -72,116 +90,83 @@ static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
>  	memset(pgd_p, 0, pgd_size);
>  }
>  
> -static pmd_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
> +static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
>  {
> -	pgd_t *pgd_p;
> -	p4d_t *p4d_p;
> -	pud_t *pud_p;
> -	pmd_t *pmd_p;
> -
> -	pgd_p = ppd->pgd + pgd_index(ppd->vaddr);
> -	if (native_pgd_val(*pgd_p)) {
> -		if (IS_ENABLED(CONFIG_X86_5LEVEL))
> -			p4d_p = (p4d_t *)(native_pgd_val(*pgd_p) & ~PTE_FLAGS_MASK);
> -		else
> -			pud_p = (pud_t *)(native_pgd_val(*pgd_p) & ~PTE_FLAGS_MASK);
> -	} else {
> -		pgd_t pgd;
> -
> -		if (IS_ENABLED(CONFIG_X86_5LEVEL)) {
> -			p4d_p = ppd->pgtable_area;
> -			memset(p4d_p, 0, sizeof(*p4d_p) * PTRS_PER_P4D);
> -			ppd->pgtable_area += sizeof(*p4d_p) * PTRS_PER_P4D;
> -
> -			pgd = native_make_pgd((pgdval_t)p4d_p + PGD_FLAGS);
> -		} else {
> -			pud_p = ppd->pgtable_area;
> -			memset(pud_p, 0, sizeof(*pud_p) * PTRS_PER_PUD);
> -			ppd->pgtable_area += sizeof(*pud_p) * PTRS_PER_PUD;
> -
> -			pgd = native_make_pgd((pgdval_t)pud_p + PGD_FLAGS);
> -		}
> -		native_set_pgd(pgd_p, pgd);
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	pgd = ppd->pgd + pgd_index(ppd->vaddr);
> +	if (pgd_none(*pgd)) {
> +		p4d = ppd->pgtable_area;
> +		memset(p4d, 0, sizeof(*p4d) * PTRS_PER_P4D);
> +		ppd->pgtable_area += sizeof(*p4d) * PTRS_PER_P4D;
> +		set_pgd(pgd, __pgd(PGD_FLAGS | __pa(p4d)));
>  	}
>  
> -	if (IS_ENABLED(CONFIG_X86_5LEVEL)) {
> -		p4d_p += p4d_index(ppd->vaddr);
> -		if (native_p4d_val(*p4d_p)) {
> -			pud_p = (pud_t *)(native_p4d_val(*p4d_p) & ~PTE_FLAGS_MASK);
> -		} else {
> -			p4d_t p4d;
> -
> -			pud_p = ppd->pgtable_area;
> -			memset(pud_p, 0, sizeof(*pud_p) * PTRS_PER_PUD);
> -			ppd->pgtable_area += sizeof(*pud_p) * PTRS_PER_PUD;
> -
> -			p4d = native_make_p4d((pudval_t)pud_p + P4D_FLAGS);
> -			native_set_p4d(p4d_p, p4d);
> -		}
> +	p4d = p4d_offset(pgd, ppd->vaddr);
> +	if (p4d_none(*p4d)) {
> +		pud = ppd->pgtable_area;
> +		memset(pud, 0, sizeof(*pud) * PTRS_PER_PUD);
> +		ppd->pgtable_area += sizeof(*pud) * PTRS_PER_PUD;
> +		set_p4d(p4d, __p4d(P4D_FLAGS | __pa(pud)));
>  	}
>  
> -	pud_p += pud_index(ppd->vaddr);
> -	if (native_pud_val(*pud_p)) {
> -		if (native_pud_val(*pud_p) & _PAGE_PSE)
> -			return NULL;
> -
> -		pmd_p = (pmd_t *)(native_pud_val(*pud_p) & ~PTE_FLAGS_MASK);
> -	} else {
> -		pud_t pud;
> -
> -		pmd_p = ppd->pgtable_area;
> -		memset(pmd_p, 0, sizeof(*pmd_p) * PTRS_PER_PMD);
> -		ppd->pgtable_area += sizeof(*pmd_p) * PTRS_PER_PMD;
> -
> -		pud = native_make_pud((pmdval_t)pmd_p + PUD_FLAGS);
> -		native_set_pud(pud_p, pud);
> +	pud = pud_offset(p4d, ppd->vaddr);
> +	if (pud_none(*pud)) {
> +		pmd = ppd->pgtable_area;
> +		memset(pmd, 0, sizeof(*pmd) * PTRS_PER_PMD);
> +		ppd->pgtable_area += sizeof(*pmd) * PTRS_PER_PMD;
> +		set_pud(pud, __pud(PUD_FLAGS | __pa(pmd)));
>  	}
>  
> -	return pmd_p;
> +	if (pud_large(*pud))
> +		return NULL;
> +
> +	return pud;
>  }
>  
>  static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
>  {
> -	pmd_t *pmd_p;
> +	pud_t *pud;
> +	pmd_t *pmd;
>  
> -	pmd_p = sme_prepare_pgd(ppd);
> -	if (!pmd_p)
> +	pud = sme_prepare_pgd(ppd);
> +	if (!pud)
>  		return;
>  
> -	pmd_p += pmd_index(ppd->vaddr);
> -	if (!native_pmd_val(*pmd_p) || !(native_pmd_val(*pmd_p) & _PAGE_PSE))
> -		native_set_pmd(pmd_p, native_make_pmd(ppd->paddr | ppd->pmd_flags));
> +	pmd = pmd_offset(pud, ppd->vaddr);
> +	if (pmd_large(*pmd))
> +		return;
> +
> +	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
>  }
>  
>  static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
>  {
> -	pmd_t *pmd_p;
> -	pte_t *pte_p;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
>  
> -	pmd_p = sme_prepare_pgd(ppd);
> -	if (!pmd_p)
> +	pud = sme_prepare_pgd(ppd);
> +	if (!pud)
>  		return;
>  
> -	pmd_p += pmd_index(ppd->vaddr);
> -	if (native_pmd_val(*pmd_p)) {
> -		if (native_pmd_val(*pmd_p) & _PAGE_PSE)
> -			return;
> -
> -		pte_p = (pte_t *)(native_pmd_val(*pmd_p) & ~PTE_FLAGS_MASK);
> -	} else {
> -		pmd_t pmd;
> -
> -		pte_p = ppd->pgtable_area;
> -		memset(pte_p, 0, sizeof(*pte_p) * PTRS_PER_PTE);
> -		ppd->pgtable_area += sizeof(*pte_p) * PTRS_PER_PTE;
> -
> -		pmd = native_make_pmd((pteval_t)pte_p + PMD_FLAGS);
> -		native_set_pmd(pmd_p, pmd);
> +	pmd = pmd_offset(pud, ppd->vaddr);
> +	if (pmd_none(*pmd)) {
> +		pte = ppd->pgtable_area;
> +		memset(pte, 0, sizeof(pte) * PTRS_PER_PTE);
> +		ppd->pgtable_area += sizeof(pte) * PTRS_PER_PTE;
> +		set_pmd(pmd, __pmd(PMD_FLAGS | __pa(pte)));
>  	}
>  
> -	pte_p += pte_index(ppd->vaddr);
> -	if (!native_pte_val(*pte_p))
> -		native_set_pte(pte_p, native_make_pte(ppd->paddr | ppd->pte_flags));
> +	if (pmd_large(*pmd))
> +		return;
> +
> +	pte = pte_offset_map(pmd, ppd->vaddr);
> +	if (pte_none(*pte))
> +		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
>  }
>  
>  static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
> 
