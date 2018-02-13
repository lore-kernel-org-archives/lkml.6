Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966034AbeBMWeM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 17:34:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36970 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965942AbeBMWeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 17:34:11 -0500
Subject: Re: [PATCH v2] mm: hwpoison: disable memory error handling on 1GB
 hugepage
To: Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Punit Agrawal <punit.agrawal@arm.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20180130013919.GA19959@hori1.linux.bs1.fc.nec.co.jp>
 <1517284444-18149-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <87inbbjx2w.fsf@e105922-lin.cambridge.arm.com>
 <20180207011455.GA15214@hori1.linux.bs1.fc.nec.co.jp>
 <87fu6bfytm.fsf@e105922-lin.cambridge.arm.com>
 <20180208121749.0ac09af2b5a143106f339f55@linux-foundation.org>
 <87wozhvc49.fsf@concordia.ellerman.id.au>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e673f38a-9e5f-21f6-421b-b3cb4ff02e91@oracle.com>
Date: Tue, 13 Feb 2018 14:33:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87wozhvc49.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802130264
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 06:48 PM, Michael Ellerman wrote:
> Andrew Morton <akpm@linux-foundation.org> writes:
> 
>> On Thu, 08 Feb 2018 12:30:45 +0000 Punit Agrawal <punit.agrawal@arm.com> wrote:
>>
>>>>
>>>> So I don't think that the above test result means that errors are properly
>>>> handled, and the proposed patch should help for arm64.
>>>
>>> Although, the deviation of pud_huge() avoids a kernel crash the code
>>> would be easier to maintain and reason about if arm64 helpers are
>>> consistent with expectations by core code.
>>>
>>> I'll look to update the arm64 helpers once this patch gets merged. But
>>> it would be helpful if there was a clear expression of semantics for
>>> pud_huge() for various cases. Is there any version that can be used as
>>> reference?
>>
>> Is that an ack or tested-by?
>>
>> Mike keeps plaintively asking the powerpc developers to take a look,
>> but they remain steadfastly in hiding.
> 
> Cc'ing linuxppc-dev is always a good idea :)
> 

Thanks Michael,

I was mostly concerned about use cases for soft/hard offline of huge pages
larger than PMD_SIZE on powerpc.  I know that powerpc supports PGD_SIZE
huge pages, and soft/hard offline support was specifically added for this.
See, 94310cbcaa3c "mm/madvise: enable (soft|hard) offline of HugeTLB pages
at PGD level"

This patch will disable that functionality.  So, at a minimum this is a
'heads up'.  If there are actual use cases that depend on this, then more
work/discussions will need to happen.  From the e-mail thread on PGD_SIZE
support, I can not tell if there is a real use case or this is just a
'nice to have'.

-- 
Mike Kravetz

>> Folks, this patch fixes a BUG and is marked for -stable.  Can we please
>> prioritize it?
> 
> It's not crashing for me (on 4.16-rc1):
> 
>   # ./huge-poison 
>   Poisoning page...once
>   Poisoning page...once again
>   madvise: Bad address
> 
> And I guess the above is the expected behaviour?
> 
> Looking at the function trace it looks like the 2nd madvise is going
> down reasonable code paths, but I don't know for sure:
> 
>   8)               |  SyS_madvise() {
>   8)               |    capable() {
>   8)               |      ns_capable_common() {
>   8)   0.094 us    |        cap_capable();
>   8)   0.516 us    |      }
>   8)   1.052 us    |    }
>   8)               |    get_user_pages_fast() {
>   8)   0.354 us    |      gup_pgd_range();
>   8)               |      get_user_pages_unlocked() {
>   8)   0.050 us    |        down_read();
>   8)               |        __get_user_pages() {
>   8)               |          find_extend_vma() {
>   8)               |            find_vma() {
>   8)   0.148 us    |              vmacache_find();
>   8)   0.622 us    |            }
>   8)   1.064 us    |          }
>   8)   0.028 us    |          arch_vma_access_permitted();
>   8)               |          follow_hugetlb_page() {
>   8)               |            huge_pte_offset() {
>   8)   0.128 us    |              __find_linux_pte();
>   8)   0.580 us    |            }
>   8)   0.048 us    |            _raw_spin_lock();
>   8)               |            hugetlb_fault() {
>   8)               |              huge_pte_offset() {
>   8)   0.034 us    |                __find_linux_pte();
>   8)   0.434 us    |              }
>   8)   0.028 us    |              is_hugetlb_entry_migration();
>   8)   0.032 us    |              is_hugetlb_entry_hwpoisoned();
>   8)   2.118 us    |            }
>   8)   4.940 us    |          }
>   8)   7.468 us    |        }
>   8)   0.056 us    |        up_read();
>   8)   8.722 us    |      }
>   8) + 10.264 us   |    }
>   8) + 12.212 us   |  }
> 
> 
> cheers
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> 
