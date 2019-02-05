Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ECCC282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3192083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="W2vI/ele"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfBEBhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 20:37:23 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40216 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfBEBhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 20:37:23 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so2221677qtf.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 17:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WbUNf2iZpXNBC2bD/SfWq7+inLOG4GTS1xrSxTM5r7Y=;
        b=W2vI/elebESdXjQe/Y6JXrNhGmOc+HsNAp/2QdzzSRvptdqMUvutNAQcgof1jbCXeb
         8n0XJlg6BwOLj1hwhu/G2YtKsaoKYIpMRu0V9zx7HEN+M2c8eUxLfu1ztgSCpfuquE73
         DOa1t+nyD74ITMWrepdCIMWEsoE0BHpUzZZLGDOGw9rqx9u/ixBeJCL6zYbmP+mwR61T
         r1QZuR8AqtReLuLsoElqA+joMim4PD46se/acg3EDnuEHAhzzdA0l6DK66nK8aWKJMoe
         cDvmYGnwn+KlOww7Od/lvFSEJRTGmPgR46/IGoIWpMlgvSAmnC3pbyBDcAO84biTt5Aq
         FuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WbUNf2iZpXNBC2bD/SfWq7+inLOG4GTS1xrSxTM5r7Y=;
        b=IdAFi+6OLbWq5EoJtao0grE07T30wbgjWnqgErDW2G1Vgj16FzeKxb3C6lulvyDGRc
         +qnPwLCFkTWRurPEW59qqq0sMBXA27zD9oxU9O4qlXmy3PP+4ESE4GJJAkE13/DR1tD3
         syAQzCGquApJAA71537xwXQnJZ3sRsiOMEsrM2ffzSWm8ZfqKfCIr0C5x25pF52BT4jt
         9HQerfQ0LSYc3+pqEB7IOVlQNLGye+Fx6LcQAEFnOFzgTcGdI+exeI8w8HSVxgYLB/eG
         wuG3PTlBYORfqafOvamoqYFLnLO28WR8v28Uc92ED5eJXzH5Dd5D3IF6zatHKtTM5Ge1
         CVKg==
X-Gm-Message-State: AHQUAuaUQX0yS3+YjAUIzzXORbcpluSJR+MoVnbvT0L4prt5e1UZ7rKD
        UlXumTUOHFcSYxQB8o7uTI/K6w==
X-Google-Smtp-Source: AHgI3IarbONAZOUWB1Eg6zxz45AmckGayNSRBYZoKBkYsqsa0i0PvkPOpFwWFZy2r+7n9Q4wUacRWg==
X-Received: by 2002:aed:3622:: with SMTP id e31mr1742043qtb.5.1549330641672;
        Mon, 04 Feb 2019 17:37:21 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e49sm16101601qta.0.2019.02.04.17.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 17:37:21 -0800 (PST)
Subject: Re: mm: race in put_and_wait_on_page_locked()
To:     Hugh Dickins <hughd@google.com>, Artem Savkov <asavkov@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20190204091300.GB13536@shodan.usersys.redhat.com>
 <alpine.LSU.2.11.1902041201280.4441@eggly.anvils>
From:   Qian Cai <cai@lca.pw>
Message-ID: <fc11de02-9644-1087-9ab6-1537594b924b@lca.pw>
Date:   Mon, 4 Feb 2019 20:37:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1902041201280.4441@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/19 3:42 PM, Hugh Dickins wrote:
> On Mon, 4 Feb 2019, Artem Savkov wrote:
> 
>> Hi Hugh,
>>
>> Your recent patch 9a1ea439b16b "mm: put_and_wait_on_page_locked() while
>> page is migrated" seems to have introduced a race into page migration
>> process. I have a host that eagerly reproduces the following BUG under
>> stress:
>>
>> [  302.847402] page:f000000000021700 count:0 mapcount:0 mapping:c0000000b2710bb0 index:0x19
>> [  302.848096] xfs_address_space_operations [xfs] 
>> [  302.848100] name:"libc-2.28.so" 
>> [  302.848244] flags: 0x3ffff800000006(referenced|uptodate)
>> [  302.848521] raw: 003ffff800000006 5deadbeef0000100 5deadbeef0000200 0000000000000000
>> [  302.848724] raw: 0000000000000019 0000000000000000 00000001ffffffff c0000000bc0b1000
>> [  302.848919] page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
>> [  302.849076] page->mem_cgroup:c0000000bc0b1000
>> [  302.849269] ------------[ cut here ]------------
>> [  302.849397] kernel BUG at include/linux/mm.h:546!
>> [  302.849586] Oops: Exception in kernel mode, sig: 5 [#1]
>> [  302.849711] LE SMP NR_CPUS=2048 NUMA pSeries
>> [  302.849839] Modules linked in: pseries_rng sunrpc xts vmx_crypto virtio_balloon xfs libcrc32c virtio_net net_failover virtio_console failover virtio_blk
>> [  302.850400] CPU: 3 PID: 8759 Comm: cc1 Not tainted 5.0.0-rc4+ #36
>> [  302.850571] NIP:  c00000000039c8b8 LR: c00000000039c8b4 CTR: c00000000080a0e0
>> [  302.850758] REGS: c0000000b0d7f7e0 TRAP: 0700   Not tainted  (5.0.0-rc4+)
>> [  302.850952] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 48024422  XER: 00000000
>> [  302.851150] CFAR: c0000000003ff584 IRQMASK: 0 
>> [  302.851150] GPR00: c00000000039c8b4 c0000000b0d7fa70 c000000001bcca00 0000000000000021 
>> [  302.851150] GPR04: c0000000b044c628 0000000000000007 55555555555555a0 c000000001fc3760 
>> [  302.851150] GPR08: 0000000000000007 0000000000000000 c0000000b0d7c000 c0000000b0d7f5ff 
>> [  302.851150] GPR12: 0000000000004400 c00000003fffae80 0000000000000000 0000000000000000 
>> [  302.851150] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>> [  302.851150] GPR20: c0000000689f5aa8 c00000002a13ee48 0000000000000000 c000000001da29b0 
>> [  302.851150] GPR24: c000000001bf7d80 c0000000689f5a00 0000000000000000 0000000000000000 
>> [  302.851150] GPR28: c000000001bf9e80 c0000000b0d7fab8 0000000000000001 f000000000021700 
>> [  302.852914] NIP [c00000000039c8b8] put_and_wait_on_page_locked+0x398/0x3d0
>> [  302.853080] LR [c00000000039c8b4] put_and_wait_on_page_locked+0x394/0x3d0
>> [  302.853235] Call Trace:
>> [  302.853305] [c0000000b0d7fa70] [c00000000039c8b4] put_and_wait_on_page_locked+0x394/0x3d0 (unreliable)
>> [  302.853540] [c0000000b0d7fb10] [c00000000047b838] __migration_entry_wait+0x178/0x250
>> [  302.853738] [c0000000b0d7fb50] [c00000000040c928] do_swap_page+0xd78/0xf60
>> [  302.853997] [c0000000b0d7fbd0] [c000000000411078] __handle_mm_fault+0xbf8/0xe80
>> [  302.854187] [c0000000b0d7fcb0] [c000000000411548] handle_mm_fault+0x248/0x450
>> [  302.854379] [c0000000b0d7fd00] [c000000000078ca4] __do_page_fault+0x2d4/0xdf0
>> [  302.854877] [c0000000b0d7fde0] [c0000000000797f8] do_page_fault+0x38/0xf0
>> [  302.855057] [c0000000b0d7fe20] [c00000000000a7c4] handle_page_fault+0x18/0x38
>> [  302.855300] Instruction dump:
>> [  302.855432] 4bfffcf0 60000000 3948ffff 4bfffd20 60000000 60000000 3c82ff36 7fe3fb78 
>> [  302.855689] fb210068 38843b78 48062f09 60000000 <0fe00000> 60000000 3b400001 3b600001 
>> [  302.855950] ---[ end trace a52140e0f9751ae0 ]---
>>
>> What seems to be happening is migrate_page_move_mapping() calling
>> page_ref_freeze() on another cpu somewhere between __migration_entry_wait()
>> taking a reference and wait_on_page_bit_common() calling page_put().
> 
> Thank you for reporting, Artem.
> 
> And see the mm thread https://marc.info/?l=linux-mm&m=154821775401218&w=2
> 
> That was on arm64, you are on power I think: both point towards xfs
> (Cai could not reproduce it on ext4), but that should not be taken too
> seriously - it could just be easier to reproduce on one than the other.

Agree, although I have never been able to trigger it for ext4 running LTP
migrate_pages03 exclusively overnight (500+ iterations) and spontaneously for a
few weeks now. It might just be lucky.
