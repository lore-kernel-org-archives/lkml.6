Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B98C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5996521A52
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5996521A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbeHGHS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 03:18:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35953 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeHGHS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 03:18:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id h12-v6so7243921pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 22:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+7Kj4msq/Re9YUxsSmVtWqMkl7DJFdvmKsixW9lADjQ=;
        b=Yqs5jh0l7tF2XdlnM3QIrSmRDvcmeBXRTJTK1zJNS+6o0gZJHaZFJTLTU+5LxmuBhv
         Sna27ne09gEv4q4oEM8uSlh7ZXkxMbl+MT7NywnWhvYnDskC6B5sJ6fWIJpc2hpMac23
         pcHSU5i1qSSMPXtmzCjWBqR0mTtWS5b4q+M0hXwxO2wEK7vzC8+ZHPudyAg0TLKhg//Y
         Q4iT+Vj6RBV627Pv4Wkz8reRfW39WgA1VuPjIhdScX5fMIZ0QqCCaR5y4JnaH22zCNzC
         g0isBy+ik3T8tupPvZW56aq2GI/6okGOgJNNWUzMWkbxY9lGo6TqTvAKLTNuIHr6fGw9
         JqUA==
X-Gm-Message-State: AOUpUlGk4bnihfdpyrLozY5hRWK/2h0aiJh47uWAD4Sh+q5EPH0UGHcJ
        VWmq2e1hrG/ytp9E6wfJQ5WeIg==
X-Google-Smtp-Source: AAOMgpcp0C5eFB3jZHMcflI4nB0WhE7em1nDJp9H53vN9tbd3YGOc3dtCT8QQMfsPIw45A8OpY/RaA==
X-Received: by 2002:a62:9f85:: with SMTP id v5-v6mr20113674pfk.27.1533618357667;
        Mon, 06 Aug 2018 22:05:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:1389:d093:8331:9188:8ab0:fd0])
        by smtp.gmail.com with ESMTPSA id j71-v6sm555911pgd.23.2018.08.06.22.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 22:05:56 -0700 (PDT)
Subject: Re: [PATCH v4 1/9] proc/kcore: don't grab lock for kclist_add()
To:     Omar Sandoval <osandov@osandov.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>, kernel-team@fb.com
References: <cover.1532563124.git.osandov@fb.com>
 <12f4b3dc5254547d12cb6669c45c533e647511fb.1532563124.git.osandov@fb.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <610a930d-5afa-68a9-72a9-4afed5b83e95@redhat.com>
Date:   Tue, 7 Aug 2018 10:35:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <12f4b3dc5254547d12cb6669c45c533e647511fb.1532563124.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Omar,

On 07/26/2018 05:29 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> kclist_add() is only called at init time, so there's no point in
> grabbing any locks. We're also going to replace the rwlock with a rwsem,
> which we don't want to try grabbing during early boot.
> 
> While we're here, mark kclist_add() with __init so that we'll get a
> warning if it's called from non-init code.
> 
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>   fs/proc/kcore.c       | 7 +++----
>   include/linux/kcore.h | 2 +-
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 66c373230e60..b0b9a76f28d6 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -62,16 +62,15 @@ static LIST_HEAD(kclist_head);
>   static DEFINE_RWLOCK(kclist_lock);
>   static int kcore_need_update = 1;
>   
> -void
> -kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
> +/* This doesn't grab kclist_lock, so it should only be used at init time. */
> +void __init kclist_add(struct kcore_list *new, void *addr, size_t size,
> +		       int type)
>   {
>   	new->addr = (unsigned long)addr;
>   	new->size = size;
>   	new->type = type;
>   
> -	write_lock(&kclist_lock);
>   	list_add_tail(&new->list, &kclist_head);
> -	write_unlock(&kclist_lock);
>   }
>   
>   static size_t get_kcore_size(int *nphdr, size_t *elf_buflen)
> diff --git a/include/linux/kcore.h b/include/linux/kcore.h
> index 8de55e4b5ee9..c20f296438fb 100644
> --- a/include/linux/kcore.h
> +++ b/include/linux/kcore.h
> @@ -35,7 +35,7 @@ struct vmcoredd_node {
>   };
>   
>   #ifdef CONFIG_PROC_KCORE
> -extern void kclist_add(struct kcore_list *, void *, size_t, int type);
> +void __init kclist_add(struct kcore_list *, void *, size_t, int type);
>   #else
>   static inline
>   void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
> 

I have been looking at a problem on arm64 platforms where we are trying 
to get access to PHYS_OFFSET symbol (which indicates the start of 
physical RAM) in user-space for determining the start of physical RAM in 
user-space utilities like 'kexec-tools' (please see [1] and [2] for 
details).

Now, I have a 'kexec-tools' implementation available which can read the 
PHYS_OFFSET from the VMCOREINFO inside '/proc/kcore', which I plan to 
publish soon on my github tree.

I also see that 'readelf' and 'crash' can read the VMCOREINFO from the 
'/proc/kcore' properly after this patch:

# readelf -a --wide /proc/kcore

Displaying notes found at file offset 0x00000778 with length 0x000019b4:
   Owner                 Data size	Description
   CORE                 0x00000188	NT_PRSTATUS (prstatus structure)	
   CORE                 0x00000088	NT_PRPSINFO (prpsinfo structure)	
   CORE                 0x00001040	NT_TASKSTRUCT (task structure)	
   VMCOREINFO           0x00000710	Unknown note type: (0x00000000)	
<..snip..>

# crash /root/git/linux/vmlinux vmcore -d31

Elf64_Nhdr:
                n_namesz: 11 ("VMCOREINFO")
                n_descsz: 1829
                  n_type: 0 (unused)
                          OSRELEASE=4.18.0-rc7+
                          PAGESIZE=65536
                          SYMBOL(init_uts_ns)=ffff5493078a5428
                          SYMBOL(node_online_map)=ffff54930789d1c8
                          SYMBOL(swapper_pg_dir)=ffff549308380000
                          SYMBOL(_stext)=ffff549306681000
                          SYMBOL(vmap_area_list)=ffff549307944ee0
                          SYMBOL(mem_section)=ffff92047fffe400
                          LENGTH(mem_section)=64
                          SIZE(mem_section)=16
                          OFFSET(mem_section.section_mem_map)=0
                          SIZE(page)=64
                          SIZE(pglist_data)=6656
                          SIZE(zone)=1728
                          SIZE(free_area)=88
                          SIZE(list_head)=16
                          SIZE(nodemask_t)=8
                          OFFSET(page.flags)=0
                          OFFSET(page._refcount)=52
                          OFFSET(page.mapping)=24
                          OFFSET(page.lru)=8
                          OFFSET(page._mapcount)=48
                          OFFSET(page.private)=40
                          OFFSET(page.compound_dtor)=16
                          OFFSET(page.compound_order)=17
                          OFFSET(page.compound_head)=8
                          OFFSET(pglist_data.node_zones)=0
                          OFFSET(pglist_data.nr_zones)=5984
                          OFFSET(pglist_data.node_start_pfn)=5992
                          OFFSET(pglist_data.node_spanned_pages)=6008
                          OFFSET(pglist_data.node_id)=6016
                          OFFSET(zone.free_area)=192
                          OFFSET(zone.vm_stat)=1536
                          OFFSET(zone.spanned_pages)=96
                          OFFSET(free_area.free_list)=0
                          OFFSET(list_head.next)=0
                          OFFSET(list_head.prev)=8
                          OFFSET(vmap_area.va_start)=0
                          OFFSET(vmap_area.list)=48
                          LENGTH(zone.free_area)=14
                          SYMBOL(log_buf)=ffff5493078ddc30
                          SYMBOL(log_buf_len)=ffff5493078ddc28
                          SYMBOL(log_first_idx)=ffff5493081054ac
                          SYMBOL(clear_idx)=ffff5493081054b8
                          SYMBOL(log_next_idx)=ffff5493081054a8
                          SIZE(printk_log)=16
                          OFFSET(printk_log.ts_nsec)=0
                          OFFSET(printk_log.len)=8
                          OFFSET(printk_log.text_len)=10
                          OFFSET(printk_log.dict_len)=12
                          LENGTH(free_area.free_list)=5
                          NUMBER(NR_FREE_PAGES)=0
                          NUMBER(PG_lru)=5
                          NUMBER(PG_private)=12
                          NUMBER(PG_swapcache)=9
                          NUMBER(PG_swapbacked)=18
                          NUMBER(PG_slab)=8
                          NUMBER(PG_hwpoison)=21
                          NUMBER(PG_head_mask)=32768
                          NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)=-129
                          NUMBER(HUGETLB_PAGE_DTOR)=2
                          NUMBER(VA_BITS)=48
                          NUMBER(kimage_voffset)=0xffff5492f5c00000
                          NUMBER(PHYS_OFFSET)=0xffffee1380000000
                          CRASHTIME=1532965574


So, for what it is worth:

Reviewed-by and Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks,
Bhupesh

[1] https://www.spinics.net/lists/kexec/msg20842.html
[2] https://www.spinics.net/lists/kexec/msg20618.html
