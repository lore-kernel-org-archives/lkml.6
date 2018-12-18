Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F528C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187B02145D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeLRCuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:50:18 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56404 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726285AbeLRCuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:50:18 -0500
X-IronPort-AV: E=Sophos;i="5.56,367,1539619200"; 
   d="scan'208";a="50027160"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2018 10:50:16 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 344DD4B75BD3;
        Tue, 18 Dec 2018 10:50:15 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 10:50:21 +0800
Date:   Tue, 18 Dec 2018 10:49:52 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v14 5/5] x86/boot/KASLR: Limit KASLR to extracting kernel
 in immovable memory
Message-ID: <20181218024951.GA10386@localhost.localdomain>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-6-fanc.fnst@cn.fujitsu.com>
 <20181217174324.GE90818@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181217174324.GE90818@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 344DD4B75BD3.AB722
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 06:43:24PM +0100, Ingo Molnar wrote:
>
>* Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
>> KASLR randomly chooses some positions which may locate in movable
>> memory regions. It will break memory hotplug feature and make the
>> movable memory chosen by KASLR practically immovable.
>> 
>> The solution is to limit KASLR to choose memory regions in immovable
>> node according to SRAT tables.
>> When CONFIG_EARLY_PARSE_RSDP is enabled, walk through SRAT to get the
>> information of immovable memory so that KASLR knows where should be
>> chosen for randomization.
>> 
>> Rename process_mem_region() as __process_mem_region() and name new
>> function as process_mem_region().
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/kaslr.c | 75 +++++++++++++++++++++++++++-----
>>  1 file changed, 64 insertions(+), 11 deletions(-)
>
>Ok, I like this basic approach of automatically detecing memory areas we 
>should not KASLR into - it's far better than earlier iterations.

Thanks,

>
>> +++ b/arch/x86/boot/compressed/kaslr.c
>> @@ -97,6 +97,11 @@ static bool memmap_too_large;
>>  /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
>>  static unsigned long long mem_limit = ULLONG_MAX;
>>  
>> +#ifdef CONFIG_EARLY_SRAT_PARSE
>> +/* The immovable memory regions */
>> +extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
>> +#endif
>
>What logic is the maximum size of this array based on?
>

Oh, sorry for that, I ever explained for that, I would add
more comments in next PATCH.

See arch/x86/mm/numa_internal.h:
struct numa_meminfo {
        int                     nr_blks;
        struct numa_memblk      blk[NR_NODE_MEMBLKS];
};

In arch/x86/include/asm/numa.h:
#define NR_NODE_MEMBLKS         (MAX_NUMNODES*2)

That means the memory in one node may be devided into 1 or 2 memory
regions(Also I saw that in the dmesg).
So think about how many regions we need to store the immovable memory.
The worst condition is:
1. There are MAX_NUMANODES nodes on this machine.
2. In SRAT table, every node is devided into 2 memory regions.
3. All of them are immovable.
So MAX_NUMNODES*2 is the biggest amount.

Thanks,
Chao Fan

>Thanks,
>
>	Ingo
>
>


