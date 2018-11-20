Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5313CC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F2A20671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F2A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeKTWjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:39:45 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37258 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728432AbeKTWjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:39:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TDW17CZ_1542715850;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TDW17CZ_1542715850)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Nov 2018 20:10:51 +0800
Subject: Re: [LKP] dd2283f260 [ 97.263072]
 WARNING:at_kernel/locking/lockdep.c:#lock_downgrade
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20181115055443.GF18977@shao2-debian>
 <d9371abc-60f6-ce37-529f-d097464a1412@linux.alibaba.com>
 <20181120085749.lj7dzk52633oq42s@kshutemo-mobl1>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <9dec33d0-f408-8428-b004-fa63fc2e9091@linux.alibaba.com>
Date:   Tue, 20 Nov 2018 20:10:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181120085749.lj7dzk52633oq42s@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/18 4:57 PM, Kirill A. Shutemov wrote:
> On Fri, Nov 16, 2018 at 08:56:04AM -0800, Yang Shi wrote:
>>> a8dda165ec  vfree: add debug might_sleep()
>>> dd2283f260  mm: mmap: zap pages with read mmap_sem in munmap
>>> 5929a1f0ff  Merge tag 'riscv-for-linus-4.20-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux
>>> 0bc80e3cb0  Add linux-next specific files for 20181114
>>> +-----------------------------------------------------+------------+------------+------------+---------------+
>>> |                                                     | a8dda165ec | dd2283f260 | 5929a1f0ff | next-20181114 |
>>> +-----------------------------------------------------+------------+------------+------------+---------------+
>>> | boot_successes                                      | 314        | 178        | 190        | 168           |
>>> | boot_failures                                       | 393        | 27         | 21         | 40            |
>>> | WARNING:held_lock_freed                             | 383        | 23         | 17         | 39            |
>>> | is_freeing_memory#-#,with_a_lock_still_held_there   | 383        | 23         | 17         | 39            |
>>> | BUG:unable_to_handle_kernel                         | 5          | 2          | 4          | 1             |
>>> | Oops:#[##]                                          | 9          | 3          | 4          | 1             |
>>> | EIP:debug_check_no_locks_freed                      | 9          | 3          | 4          | 1             |
>>> | Kernel_panic-not_syncing:Fatal_exception            | 9          | 3          | 4          | 1             |
>>> | Mem-Info                                            | 4          | 1          |            |               |
>>> | invoked_oom-killer:gfp_mask=0x                      | 1          | 1          |            |               |
>>> | WARNING:at_kernel/locking/lockdep.c:#lock_downgrade | 0          | 6          | 4          | 7             |
>>> | EIP:lock_downgrade                                  | 0          | 6          | 4          | 7             |
>>> +-----------------------------------------------------+------------+------------+------------+---------------+
>>>
>>> [   96.288009] random: get_random_u32 called from arch_rnd+0x3c/0x70 with crng_init=0
>>> [   96.359626] input_id (331) used greatest stack depth: 6360 bytes left
>>> [   96.749228] grep (358) used greatest stack depth: 6336 bytes left
>>> [   96.921470] network.sh (341) used greatest stack depth: 6212 bytes left
>>> [   97.262340]
>>> [   97.262587] =========================
>>> [   97.263072] WARNING: held lock freed!
>>> [   97.263536] 4.19.0-06969-gdd2283f #1 Not tainted
>>> [   97.264110] -------------------------
>>> [   97.264575] udevd/198 is freeing memory 9c16c930-9c16c99b, with a lock still held there!
>>> [   97.265542] (ptrval) (&anon_vma->rwsem){....}, at: unlink_anon_vmas+0x14e/0x420
>>> [   97.266450] 1 lock held by udevd/198:
>>> [   97.266924]  #0: (ptrval) (&mm->mmap_sem){....}, at: __do_munmap+0x531/0x730
>> I have not figured out what this is caused by. But, the below warning looks
>> more confusing. This might be caused by the below one.
> I *think* we need to understand more about what detached VMAs mean for
> rmap. The anon_vma for these VMAs still reachable for the rmap and
> therefore VMA too. I don't quite grasp what is implications of this, but
> it doesn't look good.

I'm supposed before accessing anon_vma, VMA need to be found by 
find_vma() first, right? But, finding VMA need hold mmap_sem, once 
detach VMAs is called, others should not be able to find the VMAs 
anymore. So, the anon_vma should not be reachable except the munmap caller.

>
> I'll look into this more when I get some free cycles.

I'm still traveling, will definitely look into it further once I'm back.

Thanks,
Yang

>
> It's better to disable the optimization for now (by ignoring 'downgrade'
> in __do_munmap()). Before it hits release.
>

