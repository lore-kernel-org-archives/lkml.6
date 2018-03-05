Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934264AbeCEKui (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:50:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933579AbeCEKug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:50:36 -0500
Subject: Re: [PATCH v8 18/24] mm: Provide speculative fault infrastructure
To: Daniel Jordan <daniel.m.jordan@oracle.com>, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org, akpm@linux-foundation.org, kirill@shutemov.name,
        ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
References: <1518794738-4186-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1518794738-4186-19-git-send-email-ldufour@linux.vnet.ibm.com>
 <5b16d6ce-6b62-e4ca-2d78-c25bb008e27e@oracle.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 5 Mar 2018 11:50:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5b16d6ce-6b62-e4ca-2d78-c25bb008e27e@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030510-0040-0000-0000-0000043ADA72
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030510-0041-0000-0000-000020DDEB85
Message-Id: <1d6c1ea9-6488-5e25-68b7-6f4aa07d1945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803050130
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jordan,

Thanks for reporting this.

On 26/02/2018 18:16, Daniel Jordan wrote:
> Hi Laurent,
> 
> This series doesn't build for me[*] when CONFIG_TRANSPARENT_HUGEPAGE is unset.
> 
> The problem seems to be that the BUILD_BUG() version of pmd_same is called in
> pte_map_lock:
> 
> On 02/16/2018 10:25 AM, Laurent Dufour wrote:
>> +static bool pte_map_lock(struct vm_fault *vmf)
>> +{
> ...snip...
>> +    if (!pmd_same(pmdval, vmf->orig_pmd))
>> +        goto out;
> 
> Since SPF can now call pmd_same without THP, maybe the way to fix it is just
> 
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 2cfa3075d148..e130692db24a 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -375,7 +375,8 @@ static inline int pte_unused(pte_t pte)
>  #endif
>  
>  #ifndef __HAVE_ARCH_PMD_SAME
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || \
> +    defined(CONFIG_SPECULATIVE_PAGE_FAULT)
>  static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
>  {
>         return pmd_val(pmd_a) == pmd_val(pmd_b);

We can't fix that this way because some architectures define their own
pmd_same() function (like ppc64), thus forcing the define here will be useless
since __HAVE_ARCH_PMD_SAME is set in that case.

The right way to fix that is to _not check_ for the PMD value in pte_spinlock()
when CONFIG_TRANSPARENT_HUGEPAGE is not set since there is no risk of
collapsing operation in our back if THP are disabled.

I'll fix that in the next version.

Laurent.

> ?
> 
> Daniel
> 
> 
> [*]  The errors are:
> 
> In file included from /home/dmjordan/src/linux/include/linux/kernel.h:10:0,
>                  from /home/dmjordan/src/linux/include/linux/list.h:9,
>                  from /home/dmjordan/src/linux/include/linux/smp.h:12,
>                  from /home/dmjordan/src/linux/include/linux/kernel_stat.h:5,
>                  from /home/dmjordan/src/linux/mm/memory.c:41:
> In function ‘pmd_same.isra.104’,
>     inlined from ‘pte_map_lock’ at /home/dmjordan/src/linux/mm/memory.c:2380:7:
> /home/dmjordan/src/linux/include/linux/compiler.h:324:38: error: call to
> ‘__compiletime_assert_391’ declared with attribute error: BUILD_BUG failed
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                       ^
> /home/dmjordan/src/linux/include/linux/compiler.h:304:4: note: in definition of
> macro ‘__compiletime_assert’
>     prefix ## suffix();    \
>     ^~~~~~
> /home/dmjordan/src/linux/include/linux/compiler.h:324:2: note: in expansion of
> macro ‘_compiletime_assert’
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>   ^~~~~~~~~~~~~~~~~~~
> /home/dmjordan/src/linux/include/linux/build_bug.h:45:37: note: in expansion of
> macro ‘compiletime_assert’
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> /home/dmjordan/src/linux/include/linux/build_bug.h:79:21: note: in expansion of
> macro ‘BUILD_BUG_ON_MSG’
>  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                      ^~~~~~~~~~~~~~~~
> /home/dmjordan/src/linux/include/asm-generic/pgtable.h:391:2: note: in
> expansion of macro ‘BUILD_BUG’
>   BUILD_BUG();
>   ^~~~~~~~~
>   CC      block/elevator.o
>   CC      crypto/crypto_wq.o
> In function ‘pmd_same.isra.104’,
>     inlined from ‘pte_spinlock’ at /home/dmjordan/src/linux/mm/memory.c:2326:7,
>     inlined from ‘handle_pte_fault’ at
> /home/dmjordan/src/linux/mm/memory.c:4181:7:
> /home/dmjordan/src/linux/include/linux/compiler.h:324:38: error: call to
> ‘__compiletime_assert_391’ declared with attribute error: BUILD_BUG failed
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                       ^
> /home/dmjordan/src/linux/include/linux/compiler.h:304:4: note: in definition of
> macro ‘__compiletime_assert’
>     prefix ## suffix();    \
>     ^~~~~~
> /home/dmjordan/src/linux/include/linux/compiler.h:324:2: note: in expansion of
> macro ‘_compiletime_assert’
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>   ^~~~~~~~~~~~~~~~~~~
> /home/dmjordan/src/linux/include/linux/build_bug.h:45:37: note: in expansion of
> macro ‘compiletime_assert’
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> /home/dmjordan/src/linux/include/linux/build_bug.h:79:21: note: in expansion of
> macro ‘BUILD_BUG_ON_MSG’
>  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                      ^~~~~~~~~~~~~~~~
> /home/dmjordan/src/linux/include/asm-generic/pgtable.h:391:2: note: in
> expansion of macro ‘BUILD_BUG’
>   BUILD_BUG();
>   ^~~~~~~~~
> ...
> make[2]: *** [/home/dmjordan/src/linux/scripts/Makefile.build:316: mm/memory.o]
> Error 1
> make[1]: *** [/home/dmjordan/src/linux/Makefile:1047: mm] Error 2
> 
