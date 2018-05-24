Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968830AbeEXL05 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 07:26:57 -0400
Received: from mail-ve1eur01on0106.outbound.protection.outlook.com ([104.47.1.106]:28736
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967833AbeEXLYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 07:24:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=xemul@virtuozzo.com;
Subject: Re: [PATCH] userfaultfd: prevent non-cooperative events vs
 mcopy_atomic races
To: Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrei Vagin <avagin@virtuozzo.com>
References: <1527061324-19949-1-git-send-email-rppt@linux.vnet.ibm.com>
From: Pavel Emelyanov <xemul@virtuozzo.com>
Message-ID: <0e1ce040-1beb-fd96-683c-1b18eb635fd6@virtuozzo.com>
Date: Thu, 24 May 2018 14:24:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1527061324-19949-1-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR09CA0061.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::29) To VI1PR08MB2991.eurprd08.prod.outlook.com
 (2603:10a6:803:44::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB2991;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2991;3:CsIHCvzP65Nhqr3qIGF4Ab9ZiZWLDKehEZzrK2SFJ1HTWFmgpP/eGnY8LtnIImF7vKwr/xWlLoOqN/h7efTxQXvVKO31t9kuzpmtKZvG5cybvCVCYMYErWIX1ejJ0bPtReygRu00JRNhfofkayAz6YwgtuLgX+AAb4aC0yiQackNlY7OOFnURBhIfdgN/A9S8kECxUKnHW58MlalWwdsSEyECKa+Z2ryqZWC9c5blrSzBPbshz+Ebgu/ifqd6yFJ;25:8iJbtRrEdi/1v8r7iv0UpYMtfafKwlOmrF6AW/sGFOJ80LeTT0j4vcLCnkG+3wfGjMqhCti8wu1aX0iC8nDNh4oaZBa21SrsR3E7NTEb3XipBYCxkDFcVyAODXdroyh6ZSmEZG3fCvvsoidv9u3+ypcw7WMcNtbCX9quuInD89DOph82rhzLJP7rz2OPlHS6iqGkAPi07UteKy/aclKdwGogw6shmqmjKfc6n4vm4kmZy56m747t8n1YPRgopiP+O/1YfBMkkJmhqvDdOIoneUcYNy/3CxWLeMTypB321Z/VrIadTrJA764tCUa6mbf68PCUe0ef/d32e86cOs3prQ==;31:q1miyJGAtXHThXiwFPKTmBqG1d2l61BiJuemgcddAOMrv/NqjbVmGOdzFKC7yY9yxJtHuZ2IDMQ1R8kvmBq3vI0Wpg+gfPxGr29/YNBj/gyYpQJjkYFUivDti8r566h57EabXdtiip7U2lVl0H/s99r5UFPYWEN5tdiaoHABB1tC1b1zNFhk6AGba/MCkA7fzxDh727qdU0u+Kt5LaGfidVLbl0o81Neudw4EImimMs=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2991:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2991;20:/dWyYkEr5+FbzXu2mxVX7xqPCe4BU0WgUoh2l3DgYB0PmpTkeBQMY+AbZoZi9ywWfQ7/r1HA0e3g6hSy/q3Qgh/ONWm6owXSuam6jOpSpovLbwwZ/pRviVyfSb3nQqjTcrEcGl7RSq1IMkqc8naCmsJ/LwdgwApkUEawIXILS6jmRSp+5/cPlUV8ssd7a0CQ6UpMB1w/21L0NvCYaP3DYarHdAYvUpdLtOIgS/585QqTm2NROFAQn7phwMuqAcDb7v0I0fXx1g3lyT+3EToJEuWrpMd/R2aRzfURKa4yeLaW3j61pJHS00f92hkHTmV960Bg95UUKR5YS8oZfodEz8ghAeqzKzb3ZvEqAj/2BD5f0IgDkRsmcbZ/S5TjoiQErO+Qooq+X12oNFHrz1QsfFtsSJRb8uj8KLfgAub08TPopE61/vcj88hmJNXwir17kGDaZLY7urkvUPR5mfb/21Vl85N5/cskh/VxthdFIfi8fw5kvSMtsPmth2Bk+sLT;4:IGmno1RQppJWByIOgFm09itW4MokgLo9MUELMEhimknEgj+2xnq+EGwemFavnWqqlyk6U6LmvRu+Pb36h9K86DKEWwQI4bKgbxf6tk/Zf4aEwxTJqfw+AxVQmJ4fPk/hWAYMWKoyAyV3a/ATRqMxdypxOpZqPOTEn58UwRQhJv2fQEE1YyHDy+4IrgErr1HT4ltL2Kjt6YtvUEXegxmbZPG/Ng2pfVAf+WMvs6rPmqlPfdgPcAYqNerd2QMv2/AnAheHurcCozhF9agueMY34nAZ9KN4p/HR6xqhrDJXwoPN7Pa4ErIyqcPnjxGIKw/R2oRMhDFJ+zQGc5iev65qwXNyaJW34H6Pc7DIK9KUISs=
X-Microsoft-Antispam-PRVS: <VI1PR08MB29914F2FD1388AF8A9A3B088B06A0@VI1PR08MB2991.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB2991;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2991;
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(376002)(366004)(39380400002)(39850400004)(189003)(199004)(230700001)(36756003)(6246003)(86362001)(575784001)(107886003)(53936002)(6666003)(105586002)(5660300001)(106356001)(65826007)(305945005)(7736002)(8936002)(8676002)(31686004)(81156014)(81166006)(31696002)(2906002)(4326008)(478600001)(25786009)(5890100001)(97736004)(68736007)(6486002)(229853002)(77096007)(16526019)(26005)(2486003)(52146003)(23676004)(52116002)(59450400001)(53546011)(386003)(76176011)(2616005)(956004)(476003)(11346002)(446003)(65956001)(66066001)(65806001)(47776003)(486006)(3846002)(6116002)(16576012)(316002)(110136005)(58126008)(54906003)(64126003)(50466002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2991;H:[172.16.24.160];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIyOTkxOzIzOmdDODhybEdUNHNKWVdZREZwcURIMjNwNnND?=
 =?utf-8?B?MFVFdC8xVVk4SXZ3aDBXbUpIdktKRVBjVG5GNlFNUUNZN1hNVzRGQ2NHSldt?=
 =?utf-8?B?WkpWa1lHcDlZVnZ1Sk81UlBKNmhBZjg2bDkzcUYxd3g2OXl5WS83VjYxY2Np?=
 =?utf-8?B?cVk2TkV5VDhRN3FLeEFERUdWSmNDTk1rMk5kMmJNMHJOdXdjZ2lFcThienkv?=
 =?utf-8?B?dmNRRUhYWnFlUDhrb3AwdWxCK1JMdm1VdEcydHFLUGxRNC8wRDE3UDM4Nzcz?=
 =?utf-8?B?Ykc3dUdNN0FtY1E2M01vUWpIdnRPRDNjaE9wVjhLQXlBVEpuU2hVcEh2aHFM?=
 =?utf-8?B?b0NObXRCNDJicGIyN1VNWUdxRmxKSXFON3huSkJycS9XVUxHbllrdERUd0JT?=
 =?utf-8?B?dnk5REhVL3dveUZWY25SRzdBRkFtbVBYd0pWc1oxWXdGTVJDMTFUSTlEaFlx?=
 =?utf-8?B?TURkeDdwdEU5U1NDbVcyTHBGN1Q0dkRVcWxVWVlwOGZFeTNSR2NLZVlhbGdm?=
 =?utf-8?B?ejZiWlppcWl5OGU1eGM4QTVuV09sRXpLbVFkQk16UHZiUENsZkRjNlloZ3p1?=
 =?utf-8?B?empMNDNycmpCQUZ6bjdwK09jWWNZMDZxbDg4aFpSZ1FVVVFmTkVYelA3R1dH?=
 =?utf-8?B?bk1MUnQrZHdVUVZRakU0T1l6eUs0MGVsTktWOUZ4LzdRaS91TkloalhJOHFk?=
 =?utf-8?B?NThwLzNBSmNHdjlwR29qR0U4S3NFRys2bEdEQXlKOHhRRjFUZDdEUFYrNzJo?=
 =?utf-8?B?bDY3NmZEa1cvN2huVmpmUUEyUlRqRFRzdlJSQzBINUI5UiswY2QwRGJBL09R?=
 =?utf-8?B?Um1MMXA2T3ZqVEpPaEpYS25qMXdCQmJ6dytHSVpRY2ltOWZ5U1lCREx2M1E0?=
 =?utf-8?B?MFJXRmM1bFkrSk0vUmZDRTdqU2tjSVJhaEQwQ2NCWVlvcVpIY2ttOCt4clFv?=
 =?utf-8?B?clROemN6TE5oSnhHRmhUdjl5NlkzL0QyN2phYXZ3L1RmRjgrVGQvM1lRRUJJ?=
 =?utf-8?B?cTIyeXpBd25zY2ZGbzQwYjFOWnM5VEs1UjZDOFJnc1FYNnJMYVAvemFHdFc1?=
 =?utf-8?B?RlUwN2tEeTFLeHRlZ0ZoUGdtRWEzUUN2dm9ZYlMvcTNtN1c2N2JHQTVjRFEv?=
 =?utf-8?B?dWxUV1VWanRiVHVxOUpWNzc3UFBUb0VId1lHbmQwMEdpQk5xN29qc3hyY2Qz?=
 =?utf-8?B?RjA5YVlkc1FwNS8rdXc4Vjg1VEFhSEtFTzFBYVMyZ0ZOazQ5N0hpUmhuNm9s?=
 =?utf-8?B?c2JnL05FbEMzT1hESU9UR2JmWnQ4SHZINHFFczZYMmVCR2ltdTFIYVJMQXFr?=
 =?utf-8?B?azR5MXkydDc2TnhSdGlOWmNZbnQyblRSRHBNb1hFREJxL29KRjl1Wm94bElK?=
 =?utf-8?B?VUI4RDZqQm8yVXVUOFovOWRhOWJmWXYzTVRJeVIvMVZoVjZFM1BXOVNGbmdJ?=
 =?utf-8?B?RVN4TXg0bm1oRHJ5S3Z1RzNnVzJ1bjd3UGhIVmdpdVZSakowVXRCd1ZwV0FY?=
 =?utf-8?B?SnpENG5SVWg0SThNM0hWZGt3MC9YS0VQUmk4RllYbytVSHNQQmovV3YzUGti?=
 =?utf-8?B?d1FOS2VPaXh5c1prSEFUbklOUkJINFNtdDV4WEtFZ1dmbDZyREhMckFualVu?=
 =?utf-8?B?VzhVVlBnVmhhVS9kVFhtRy9leEJodEthSUpFQ2xXZjFiMHF2Ly9wdTNnbDc4?=
 =?utf-8?B?QS9LMUtwcUE1V0dsMEFJUUVwRG1leUNlNG5ITXlhMGtZQW4wK2NTUzJmRVMv?=
 =?utf-8?B?djNqdVdTcmU1VlpHTk5nTCs0WmtuM1RrT3ROOGZLT2Z0NWluejhFU3J6N1Jw?=
 =?utf-8?B?MkVCUkhlZ05yMlI0aTZJOEJITnN3ZWoySkRva0liVkxJVkVXeGd2MmFPTFEx?=
 =?utf-8?B?bC94ZWhqdGdSa3VYL0o4MTFZaFUyQldlWWhtYUp4R1NnVHJ6QndXRlljcWVJ?=
 =?utf-8?B?d0N2Y1hTL2VSUksvWGdQTDByZzU3YWdEdHFGVm52ZGVYQmR2VXg1M3AwWWs1?=
 =?utf-8?B?ay8wS2FtYmZ6OUtBUStWd2plMWQ2TXZoZnNNV2pHOS9rUk15cnUrVXNRVmFy?=
 =?utf-8?B?RldqUERONU96MWduQWF1Q29McEZrRGpuUndUR0RWRTNFNHBVM21CdTdBQloz?=
 =?utf-8?B?eUE9PQ==?=
X-Microsoft-Antispam-Message-Info: gYDYkqR348rs1mcvQDpOBKpSoT27uoEF1lx534RQQXeGHkdZKDJJTr00KCPqHrktrSRc/6exkaJfRlDxGpUvGi9G86imaMaItv5jszPUU8E8MHOFPwKm9aVEXmmmW+cBX2VkBYV7zIt3YmYtukTaMqL1CECw+RuxQ2hyM72/m3xMPixKmYw6nXSvjGPwPXV4
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2991;6:JWRjrS8NIMPfOXjCoVDUhChN7LNBp9qupNrUlFwVBJfIb9isYfTiFJBOdR6et+kkSYWvcgVKwJkqhC6MQyfcdcTcbIHsc0WZ1RoP798134J22NUBzW75nDbJ5p4PqxI6BZGZRcAZbbRCDOlo2FNWJYDb5qHAskNgDqn3py75s4aCjp69WSA3pzUsaYx4GA7SqCxBwVCuNzjNauHrzjIeRFbHmVSOHM+cPep61OiPEHyGm382ryNWRkdDsvgS+54d3B1YtaxxwNjRjoCUVlCS7pw0LUnGmML+DOsW2qa2KdvbQdz296N2hOJzEmpTwrxgNrww+zZZ8RzZCP0eX33wR+eKzzboVi1GHFKLgGTM5sWcIG5kGXYNOTSGLxTOuVjHNB1ABTsxQs5jX4F3krWhFKlVILEOjun5e1lSalyRro5YAhzdW89xHYQ3h3T6JcWUJ73oW+dY+c5fmOsWD9FI0g==;5:lLkXLhTLVi3BVNev/dV4o+25NtfWwdqnm55QxyFIcecNeGRFIxa11jbdF6cZ1JlJlRgUGc6jjke5RwoSXX+rBFDsIDA2x2KGmcUnaVyFBLxsB4bHT27/AeatVDib8sHociYEKzZzor8Io7U9pe5UYVobMu+JeWygNCGDqxyvnZs=;24:EB/3PnihjU+t4+u5jTA7vsbabQ0mqzNE5p3OPFTUWI7bDMWWjqSOp8DRUJlOlC/1JAOh6LeZnjoqi5Vb6J//E/2AGiDQyONlKDNwkPdBoEc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2991;7:CJZiWfwNzn5IJVRI608cerzD5W3zwATZl5qXS15mL+/Jqq77wcd4oDoEY3rCC48ijk8zCw3qriheB6aMQkqnqgeKTXJQ5LWe14ZKoLgz5rUOZLzwmIBOmMGJ9YsHdiAdB5cMz5ip+/xGRnfUHIpJx/NYgsObeuuc/89Glas6rJNENNzlDcOBf6iZy+0Q5TKFmLwoIbgDcT6VjUlo3ooYdKCO11akGKcYhh9WEvC1ihH2qNRvlErRK3vGWD9PrzGq;20:OGiHFgZVdIat8YocsG1Lr98fDVi2r4w6jM0e8oB8r4DUyjb7AbEfYXu2KzK71JrMwRyT+JYC9+lOnB4LhJId/q4qkE2g3gPj2EzdDomFzDX1oFaPxGaq0jkhK+Kbd15acLNFEJK/+DxcGo/ggIOttqngNqgAspUPW2zO2eHe164=
X-MS-Office365-Filtering-Correlation-Id: 0e3e565b-b58a-4e73-b722-08d5c168f1ab
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 11:24:41.1396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3e565b-b58a-4e73-b722-08d5c168f1ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2991
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/2018 10:42 AM, Mike Rapoport wrote:
> If a process monitored with userfaultfd changes it's memory mappings or
> forks() at the same time as uffd monitor fills the process memory with
> UFFDIO_COPY, the actual creation of page table entries and copying of the
> data in mcopy_atomic may happen either before of after the memory mapping
> modifications and there is no way for the uffd monitor to maintain
> consistent view of the process memory layout.
> 
> For instance, let's consider fork() running in parallel with
> userfaultfd_copy():
> 
> process        		         |	uffd monitor
> ---------------------------------+------------------------------
> fork()        		         | userfaultfd_copy()
> ...        		         | ...
>     dup_mmap()        	         |     down_read(mmap_sem)
>     down_write(mmap_sem)         |     /* create PTEs, copy data */
>         dup_uffd()               |     up_read(mmap_sem)
>         copy_page_range()        |
>         up_write(mmap_sem)       |
>         dup_uffd_complete()      |
>             /* notify monitor */ |
> 
> If the userfaultfd_copy() takes the mmap_sem first, the new page(s) will be
> present by the time copy_page_range() is called and they will appear in the
> child's memory mappings. However, if the fork() is the first to take the
> mmap_sem, the new pages won't be mapped in the child's address space.

But in this case child should get an entry, that emits a message to uffd when step upon!
And uffd will just userfaultfd_copy() it again. No?

-- Pavel

> Since userfaultfd monitor has no way to determine what was the order, let's
> disallow userfaultfd_copy in parallel with the non-cooperative events. In
> such case we return -EAGAIN and the uffd monitor can understand that
> userfaultfd_copy() clashed with a non-cooperative event and take an
> appropriate action.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Pavel Emelyanov <xemul@virtuozzo.com>
> Cc: Andrei Vagin <avagin@virtuozzo.com>
> ---
>  fs/userfaultfd.c              | 22 ++++++++++++++++++++--
>  include/linux/userfaultfd_k.h |  6 ++++--
>  mm/userfaultfd.c              | 22 +++++++++++++++++-----
>  3 files changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index cec550c8468f..123bf7d516fc 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -62,6 +62,8 @@ struct userfaultfd_ctx {
>  	enum userfaultfd_state state;
>  	/* released */
>  	bool released;
> +	/* memory mappings are changing because of non-cooperative event */
> +	bool mmap_changing;
>  	/* mm with one ore more vmas attached to this userfaultfd_ctx */
>  	struct mm_struct *mm;
>  };
> @@ -641,6 +643,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
>  	 * already released.
>  	 */
>  out:
> +	WRITE_ONCE(ctx->mmap_changing, false);
>  	userfaultfd_ctx_put(ctx);
>  }
>  
> @@ -686,10 +689,12 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
>  		ctx->state = UFFD_STATE_RUNNING;
>  		ctx->features = octx->features;
>  		ctx->released = false;
> +		ctx->mmap_changing = false;
>  		ctx->mm = vma->vm_mm;
>  		mmgrab(ctx->mm);
>  
>  		userfaultfd_ctx_get(octx);
> +		WRITE_ONCE(octx->mmap_changing, true);
>  		fctx->orig = octx;
>  		fctx->new = ctx;
>  		list_add_tail(&fctx->list, fcs);
> @@ -732,6 +737,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
>  	if (ctx && (ctx->features & UFFD_FEATURE_EVENT_REMAP)) {
>  		vm_ctx->ctx = ctx;
>  		userfaultfd_ctx_get(ctx);
> +		WRITE_ONCE(ctx->mmap_changing, true);
>  	}
>  }
>  
> @@ -772,6 +778,7 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
>  		return true;
>  
>  	userfaultfd_ctx_get(ctx);
> +	WRITE_ONCE(ctx->mmap_changing, true);
>  	up_read(&mm->mmap_sem);
>  
>  	msg_init(&ewq.msg);
> @@ -815,6 +822,7 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma,
>  			return -ENOMEM;
>  
>  		userfaultfd_ctx_get(ctx);
> +		WRITE_ONCE(ctx->mmap_changing, true);
>  		unmap_ctx->ctx = ctx;
>  		unmap_ctx->start = start;
>  		unmap_ctx->end = end;
> @@ -1653,6 +1661,10 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
>  
>  	user_uffdio_copy = (struct uffdio_copy __user *) arg;
>  
> +	ret = -EAGAIN;
> +	if (READ_ONCE(ctx->mmap_changing))
> +		goto out;
> +
>  	ret = -EFAULT;
>  	if (copy_from_user(&uffdio_copy, user_uffdio_copy,
>  			   /* don't copy "copy" last field */
> @@ -1674,7 +1686,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
>  		goto out;
>  	if (mmget_not_zero(ctx->mm)) {
>  		ret = mcopy_atomic(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
> -				   uffdio_copy.len);
> +				   uffdio_copy.len, &ctx->mmap_changing);
>  		mmput(ctx->mm);
>  	} else {
>  		return -ESRCH;
> @@ -1705,6 +1717,10 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
>  
>  	user_uffdio_zeropage = (struct uffdio_zeropage __user *) arg;
>  
> +	ret = -EAGAIN;
> +	if (READ_ONCE(ctx->mmap_changing))
> +		goto out;
> +
>  	ret = -EFAULT;
>  	if (copy_from_user(&uffdio_zeropage, user_uffdio_zeropage,
>  			   /* don't copy "zeropage" last field */
> @@ -1721,7 +1737,8 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
>  
>  	if (mmget_not_zero(ctx->mm)) {
>  		ret = mfill_zeropage(ctx->mm, uffdio_zeropage.range.start,
> -				     uffdio_zeropage.range.len);
> +				     uffdio_zeropage.range.len,
> +				     &ctx->mmap_changing);
>  		mmput(ctx->mm);
>  	} else {
>  		return -ESRCH;
> @@ -1900,6 +1917,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  	ctx->features = 0;
>  	ctx->state = UFFD_STATE_WAIT_API;
>  	ctx->released = false;
> +	ctx->mmap_changing = false;
>  	ctx->mm = current->mm;
>  	/* prevent the mm struct to be freed */
>  	mmgrab(ctx->mm);
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index f2f3b68ba910..e091f0a11b11 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -31,10 +31,12 @@
>  extern int handle_userfault(struct vm_fault *vmf, unsigned long reason);
>  
>  extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
> -			    unsigned long src_start, unsigned long len);
> +			    unsigned long src_start, unsigned long len,
> +			    bool *mmap_changing);
>  extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
>  			      unsigned long dst_start,
> -			      unsigned long len);
> +			      unsigned long len,
> +			      bool *mmap_changing);
>  
>  /* mm helpers */
>  static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 39791b81ede7..5029f241908f 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -404,7 +404,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>  					      unsigned long dst_start,
>  					      unsigned long src_start,
>  					      unsigned long len,
> -					      bool zeropage)
> +					      bool zeropage,
> +					      bool *mmap_changing)
>  {
>  	struct vm_area_struct *dst_vma;
>  	ssize_t err;
> @@ -431,6 +432,15 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>  	down_read(&dst_mm->mmap_sem);
>  
>  	/*
> +	 * If memory mappings are changing because of non-cooperative
> +	 * operation (e.g. mremap) running in parallel, bail out and
> +	 * request the user to retry later
> +	 */
> +	err = -EAGAIN;
> +	if (mmap_changing && READ_ONCE(*mmap_changing))
> +		goto out_unlock;
> +
> +	/*
>  	 * Make sure the vma is not shared, that the dst range is
>  	 * both valid and fully within a single existing vma.
>  	 */
> @@ -563,13 +573,15 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>  }
>  
>  ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
> -		     unsigned long src_start, unsigned long len)
> +		     unsigned long src_start, unsigned long len,
> +		     bool *mmap_changing)
>  {
> -	return __mcopy_atomic(dst_mm, dst_start, src_start, len, false);
> +	return __mcopy_atomic(dst_mm, dst_start, src_start, len, false,
> +			      mmap_changing);
>  }
>  
>  ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
> -		       unsigned long len)
> +		       unsigned long len, bool *mmap_changing)
>  {
> -	return __mcopy_atomic(dst_mm, start, 0, len, true);
> +	return __mcopy_atomic(dst_mm, start, 0, len, true, mmap_changing);
>  }
> 
