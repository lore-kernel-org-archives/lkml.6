Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeDDQ1D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:27:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751606AbeDDQ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:26:59 -0400
Subject: Re: [PATCH v9 15/24] mm: Introduce __vm_normal_page()
To: Jerome Glisse <jglisse@redhat.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
        mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1520963994-28477-16-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180403193927.GD5935@redhat.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 4 Apr 2018 18:26:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403193927.GD5935@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040416-0040-0000-0000-00000449B9A7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040416-0041-0000-0000-000020EDCA52
Message-Id: <a3446d86-8a29-a9f2-a1fe-b8cc1b748132@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040165
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/04/2018 21:39, Jerome Glisse wrote:
> On Tue, Mar 13, 2018 at 06:59:45PM +0100, Laurent Dufour wrote:
>> When dealing with the speculative fault path we should use the VMA's field
>> cached value stored in the vm_fault structure.
>>
>> Currently vm_normal_page() is using the pointer to the VMA to fetch the
>> vm_flags value. This patch provides a new __vm_normal_page() which is
>> receiving the vm_flags flags value as parameter.
>>
>> Note: The speculative path is turned on for architecture providing support
>> for special PTE flag. So only the first block of vm_normal_page is used
>> during the speculative path.
> 
> Might be a good idea to explicitly have SPECULATIVE Kconfig option depends
> on ARCH_PTE_SPECIAL and a comment for !HAVE_PTE_SPECIAL in the function
> explaining that speculative page fault should never reach that point.

Unfortunately there is no ARCH_PTE_SPECIAL in the config file, it is defined in
the per architecture header files.
So I can't do anything in the Kconfig file

However, I can check that at build time, and doing such a check in
__vm_normal_page sounds to be a good place, like that:

@@ -869,6 +870,14 @@ struct page *__vm_normal_page(struct vm_area_struct *vma,
unsigned long addr,

        /* !HAVE_PTE_SPECIAL case follows: */

+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+       /* This part should never get called when the speculative page fault
+        * handler is turned on. This is mainly because we can't rely on
+        * vm_start.
+        */
+#error CONFIG_SPECULATIVE_PAGE_FAULT requires HAVE_PTE_SPECIAL
+#endif
+
        if (unlikely(vma_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
                if (vma_flags & VM_MIXEDMAP) {
                        if (!pfn_valid(pfn))

Thanks,
Laurent.
