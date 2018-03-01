Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966044AbeCAFXH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 00:23:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966016AbeCAFXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 00:23:06 -0500
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [RFC 2/4] Uprobe: Export few functions / data structures
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, oleg@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180228075345.674-3-ravi.bangoria@linux.vnet.ibm.com>
 <20180228122440.GC63063@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 10:55:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228122440.GC63063@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18030105-0040-0000-0000-00000439461C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030105-0041-0000-0000-000020DC4893
Message-Id: <dfd4c3ee-bd27-bc33-9b77-f10fac363a7e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/28/2018 05:54 PM, Srikar Dronamraju wrote:
>> @@ -149,6 +155,11 @@ struct uprobes_state {
>>  extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
>>  extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>>  					 void *src, unsigned long len);
>> +unsigned long offset_to_vaddr(struct vm_area_struct *vma, loff_t offset);
>> +void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
>> +void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len);
>> +struct uprobe_map_info *free_uprobe_map_info(struct uprobe_map_info *info);
>> +
>>  #else /* !CONFIG_UPROBES */
> If we have to export the above, we might have to work with mm maintainers and
> see if we can move them there.

Adding
    linux-mm@kvack.org
    Michal Hocko <mhocko@kernel.org>
    Andrew Morton <akpm@linux-foundation.org>
in the cc.

>> -static inline struct uprobe_map_info *
>> -free_uprobe_map_info(struct uprobe_map_info *info)
>> +struct uprobe_map_info *free_uprobe_map_info(struct uprobe_map_info *info)
>>  {
>>  	struct uprobe_map_info *next = info->next;
>>  	kfree(info);
>>  	return next;
>>  }
>>
>> -static struct uprobe_map_info *
>> -build_uprobe_map_info(struct address_space *mapping, loff_t offset,
>> -		      bool is_register)
>> +struct uprobe_map_info *build_uprobe_map_info(struct address_space *mapping,
>> +					      loff_t offset, bool is_register)
>>  {
>>  	unsigned long pgoff = offset >> PAGE_SHIFT;
>>  	struct vm_area_struct *vma;
> Instead of exporting, did you look at extending the uprobe consumer with
> ops. i.e if the consumer detects that a probe is a semaphore and exports
> a set of callbacks which can them be called from uprobe
> insertion/deletion time. With such a thing, incrementing/decrementing
> the semaphore and the insertion/deletion of the breakpoint can be done
> at one shot. No?

Yes, we tried that approach as well. Basically, when install_breakpoint() get called,
notify consumer about that. We can either use consumer_filter function or add a
new callback into uprobe_consumer which will get called if install_breakpoint()
succeeds. something like:

     if (install_breakpoint()) {
         /* Notify consumers right after patching instruction. */
         consumer->post_prepare();
     }

There are different problem with that approach. install_breakpoint() gets called in
very early stage of binary loading and vma that holds the semaphore won't be
present in the mm yet. I also tried to solve this by creating a task_work in
consumer callback. task_work handler will get called when process virtual memory
map is fully prepared and we are going back to userspace. But it will make design
quite complicated. Also, there is no way to know if mm_struct we got in task_work
handler is _still_ valid.

With unregister also, we first remove the "caller" consumer and then re-patch
original instruction. i.e.

     __uprobe_unregister()
     {
         if (WARN_ON(!consumer_del(uprobe, uc)))
             return;
         err = register_for_each_vma(uprobe, NULL);

We don't callback "caller" consumer at unregistration.

Our idea is to make changes in core uprobe as less as possible. And IMHO,
exporting build_map_info() helps to simplifies the implementation.

Let me know if I'm missing something.

Thanks for the review,
Ravi
