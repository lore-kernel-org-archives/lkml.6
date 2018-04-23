Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbeDWD30 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:29:26 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48295 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753911AbeDWD3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:29:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0T.hvL9w_1524454140;
Subject: Re: [RFC v2 PATCH] mm: shmem: make stat.st_blksize return huge page
 size if THP is on
To: Michal Hocko <mhocko@kernel.org>
Cc: kirill.shutemov@linux.intel.com, hughd@google.com, hch@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1524242039-64997-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180423004748.GP17484@dhcp22.suse.cz>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3c59a1d1-dc66-ae5f-452c-dd0adb047433@linux.alibaba.com>
Date: Sun, 22 Apr 2018 21:28:59 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423004748.GP17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/18 6:47 PM, Michal Hocko wrote:
> On Sat 21-04-18 00:33:59, Yang Shi wrote:
>> Since tmpfs THP was supported in 4.8, hugetlbfs is not the only
>> filesystem with huge page support anymore. tmpfs can use huge page via
>> THP when mounting by "huge=" mount option.
>>
>> When applications use huge page on hugetlbfs, it just need check the
>> filesystem magic number, but it is not enough for tmpfs. Make
>> stat.st_blksize return huge page size if it is mounted by appropriate
>> "huge=" option.
>>
>> Some applications could benefit from this change, for example QEMU.
>> When use mmap file as guest VM backend memory, QEMU typically mmap the
>> file size plus one extra page. If the file is on hugetlbfs the extra
>> page is huge page size (i.e. 2MB), but it is still 4KB on tmpfs even
>> though THP is enabled. tmpfs THP requires VMA is huge page aligned, so
>> if 4KB page is used THP will not be used at all. The below /proc/meminfo
>> fragment shows the THP use of QEMU with 4K page:
>>
>> ShmemHugePages:   679936 kB
>> ShmemPmdMapped:        0 kB
>>
>> By reading st_blksize, tmpfs can use huge page, then /proc/meminfo looks
>> like:
>>
>> ShmemHugePages:    77824 kB
>> ShmemPmdMapped:     6144 kB
>>
>> statfs.f_bsize still returns 4KB for tmpfs since THP could be split, and it
>> also may fallback to 4KB page silently if there is not enough huge page.
>> Furthermore, different f_bsize makes max_blocks and free_blocks
>> calculation harder but without too much benefit. Returning huge page
>> size via stat.st_blksize sounds good enough.
> I am not sure I understand the above. So does QEMU or other tmpfs users
> rely on f_bsize to do mmap alignment tricks? Also I thought that THP

QEMU doesn't. It just check filesystem magic number now, if it is 
hugetlbfs, then it do mmap on huge page size alignment.

> will be used on the first aligned address even when the initial/last
> portion of the mapping is not THP aligned.

No, my test shows it is not. And, transhuge_vma_suitable() does check 
the virtual address alignment. If it is not huge page size aligned, it 
will not set PMD for huge page.

>
> And more importantly
> [...]
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -39,6 +39,7 @@
>>   #include <asm/tlbflush.h> /* for arch/microblaze update_mmu_cache() */
>>   
>>   static struct vfsmount *shm_mnt;
>> +static bool is_huge = false;
>>   
>>   #ifdef CONFIG_SHMEM
>>   /*
>> @@ -995,6 +996,8 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
>>   		spin_unlock_irq(&info->lock);
>>   	}
>>   	generic_fillattr(inode, stat);
>> +	if (is_huge)
>> +		stat->blksize = HPAGE_PMD_SIZE;
>>   	return 0;
>>   }
>>   
>> @@ -3574,6 +3577,7 @@ static int shmem_parse_options(char *options, struct shmem_sb_info *sbinfo,
>>   					huge != SHMEM_HUGE_NEVER)
>>   				goto bad_val;
>>   			sbinfo->huge = huge;
>> +			is_huge = true;
> Huh! How come this is a global flag. What if we have multiple shmem
> mounts some with huge pages enabled and some without? Btw. we seem to
> already have that information stored in the supperblock
> 		} else if (!strcmp(this_char, "huge")) {
> 			int huge;
> 			huge = shmem_parse_huge(value);
> 			if (huge < 0)
> 				goto bad_val;
> 			if (!has_transparent_hugepage() &&
> 					huge != SHMEM_HUGE_NEVER)
> 				goto bad_val;
> 			sbinfo->huge = huge;

Aha, my bad. I should used SHMEM_SB(inode->i_sb) to get shmem_sb_info 
then check the huge. Thanks a lot for catching this. Will fix in new 
version.

Yang
