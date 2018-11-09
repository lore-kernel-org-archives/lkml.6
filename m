Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C088CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B1C20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B1C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeKIMDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:03:31 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44131 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727390AbeKIMDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:03:30 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EAD669998938;
        Fri,  9 Nov 2018 10:25:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 9 Nov 2018
 10:24:59 +0800
Message-ID: <5BE4EFFA.80608@huawei.com>
Date:   Fri, 9 Nov 2018 10:24:58 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "'Kirill A . Shutemov'" <kirill.shutemov@linux.intel.com>
CC:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] There is a thp count left when the process exits
References: <5BE44FDB.6040303@huawei.com>
In-Reply-To: <5BE44FDB.6040303@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+LKML

I can not find the possibility when I check the code. because the mmap_sem and spin_lock will
protect the concurrence.

I will be appreciated if anyone has some clue.

Thanks,
zhong jiang


On 2018/11/8 23:01, zhong jiang wrote:
> Hi, 
>
> Recently,  I hit  the following issue in linux 3.10 stable.  and hard to recur.
>
> bad pmd ffff880c13ecea80(80000017b16000e7)
>
> Call Trace:
>   [<ffffffff8164195f>] dump_stack+0x19/0x1b
>   [<ffffffff8107b230>] warn_slowpath_common+0x70/0xb0
>   [<ffffffff8107b37a>] warn_slowpath_null+0x1a/0x20
>   [<ffffffff811a2b86>] exit_mmap+0x196/0x1a0
>   [<ffffffff810782e7>] mmput+0x67/0xf0
>   [<ffffffff81081b2c>] do_exit+0x28c/0xa60
>   [<ffffffff810a9dc0>] ? hrtimer_get_res+0x50/0x50
>   [<ffffffff8108237f>] do_group_exit+0x3f/0xa0
>   [<ffffffff81093240>] get_signal_to_deliver+0x1d0/0x6d0
>   [<ffffffff81014427>] do_signal+0x57/0x6b0
>   [<ffffffff810e4f92>] ? futex_wait_queue_me+0xa2/0x120
>   [<ffffffff8164d323>] ? __do_page_fault+0x183/0x470
>   [<ffffffff81014adf>] do_notify_resume+0x5f/0xb0
>   [<ffffffff816520bd>] int_signal+0x12/0x17
>
> BUG: Bad rss-counter state mm:ffff8820136b5dc0 idx:1 val:512
>
> The pmd entry show that it is still a thp. but It fails to check and clear the pmd.
> hence,   page fault will produce a new page for pmd when accessing the page,
> which thp count will reduplicative increase.
>
> Thanks,
> zhong jiang


