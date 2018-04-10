Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeDJQoO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:44:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751367AbeDJQoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:44:12 -0400
Subject: Re: [PATCH v2 2/2] mm: remove odd HAVE_PTE_SPECIAL
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        mhocko@kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Rientjes <rientjes@google.com>
References: <1523373951-10981-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523373951-10981-3-git-send-email-ldufour@linux.vnet.ibm.com>
 <3f20ac8b-20b8-f052-bc44-dcc0316354ca@arm.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 18:44:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3f20ac8b-20b8-f052-bc44-dcc0316354ca@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041016-0044-0000-0000-00000545A849
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041016-0045-0000-0000-00002885D963
Message-Id: <1521dc0e-e9f8-d10f-e213-1b1552eb03fa@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804100159
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/04/2018 17:58, Robin Murphy wrote:
> On 10/04/18 16:25, Laurent Dufour wrote:
>> Remove the additional define HAVE_PTE_SPECIAL and rely directly on
>> CONFIG_ARCH_HAS_PTE_SPECIAL.
>>
>> There is no functional change introduced by this patch
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>   mm/memory.c | 23 ++++++++++-------------
>>   1 file changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 96910c625daa..53b6344a90d2 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -817,19 +817,13 @@ static void print_bad_pte(struct vm_area_struct *vma,
>> unsigned long addr,
>>    * PFNMAP mappings in order to support COWable mappings.
>>    *
>>    */
>> -#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>> -# define HAVE_PTE_SPECIAL 1
>> -#else
>> -# define HAVE_PTE_SPECIAL 0
>> -#endif
>>   struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>>                    pte_t pte, bool with_public_device)
>>   {
>>       unsigned long pfn = pte_pfn(pte);
>>   -    if (HAVE_PTE_SPECIAL) {
>> -        if (likely(!pte_special(pte)))
>> -            goto check_pfn;
>> +#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
> 
> Nit: Couldn't you use IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) within the
> existing code structure to avoid having to add these #ifdefs?

I agree, that would be better. I didn't thought about this option..
Thanks for reporting this.
