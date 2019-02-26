Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3453C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6536E217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="N0L7Vk4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfBZOHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:07:07 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38616 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfBZOHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:07:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id s1so14950189qte.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Zdu2vWdMHrv2nSrZEsia91nIs7+NdhrmtkPG0CpB+o=;
        b=N0L7Vk4pdLAsZ3WN2dWq3VPTKI7Bg/Mk3huBgpmwMvn5pNNH1A2bNEzobOQ1hRGws2
         NOypDz4SO2TKiP9E3NXjVpgeW0qaWLe3RIT8P+K3pmLBL1sF7GSZujLwa61C5y58VHsJ
         yUVGMohPDHV9VGVwALikGmZHNO4blazqquqHPnxPwxbuV9npf0IvRXRncpz/KjD5+wBN
         CEuP8oT8dws989euCtvT3WJk4cutgo+Un02ufXsvSs6ZPuKUrHLw0ifxp2x+Ws2867cr
         4DY8R8awAfw41Im1Tip+6AUU56ItYRElAg3mdYD+x1ttiB2YsmVnhZioubGpnEo9qpm4
         X36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Zdu2vWdMHrv2nSrZEsia91nIs7+NdhrmtkPG0CpB+o=;
        b=hOE7/LJ9SqLIWux9arBe6/SktWzcy3S/5vwc+QjqMfw20idDyYWmpjM2pZbPKUHb+I
         NwVlV2fsSx6r7faeTkJF83YsYGcu5LIUW7s1wOZISYmxBZpIM4QWckYMoY8vxAB13au3
         T6If7VveXNITjSMhAaT8X+5ppUzp79cU1IHM1sQpj+fsVUu+hYIQF3B5hbANsHflxsnG
         yF/ljGSbwV3cMuHMmos0/rYqbOeZmq++dS84rK50IWV28Aa/eb8IbKkw/Z5GLkSd4Oot
         BP/YNo0nSUuw2rOp2p/dcLt5ON0siJXUT6YPrYi/g0lYoqN0jj6+oJT479x8wrty2eYO
         qxkw==
X-Gm-Message-State: AHQUAua7tN/OqhiI4Vb7CkHtMbnBGiRMcE5W6bMO/EL9XFtEsU53Me89
        tW4uHvw47+HJvk1CftKKrGokieVG3d8=
X-Google-Smtp-Source: AHgI3IaqeY35XxBGJIDG0ibwy+ykYZIQGLi2BYHPy1bVpdNIOEPYMqBNVL9WB75ifXD/oM+irYr9sA==
X-Received: by 2002:ac8:19f5:: with SMTP id s50mr17912029qtk.25.1551190024945;
        Tue, 26 Feb 2019 06:07:04 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b83sm7310359qkg.12.2019.02.26.06.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:07:04 -0800 (PST)
Subject: Re: [PATCH] mm/hotplug: fix an imbalance with DEBUG_PAGEALLOC
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <20190225191710.48131-1-cai@lca.pw>
 <CAFqt6zYjf=KnXhkmbr78RR3ZkzRmTaERJMNOn7CXrrYYxrV-Pg@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <509cbfb1-d10e-0078-0722-766bbec5460e@lca.pw>
Date:   Tue, 26 Feb 2019 09:07:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYjf=KnXhkmbr78RR3ZkzRmTaERJMNOn7CXrrYYxrV-Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/19 7:13 AM, Souptick Joarder wrote:
> On Tue, Feb 26, 2019 at 12:47 AM Qian Cai <cai@lca.pw> wrote:
>>
>> When onlining memory pages, it calls kernel_unmap_linear_page(),
>> However, it does not call kernel_map_linear_page() while offlining
>> memory pages. As the result, it triggers a panic below while onlining on
>> ppc64le as it checks if the pages are mapped before unmapping,
>> Therefore, let it call kernel_map_linear_page() when setting all pages
>> as reserved.
>>
>> kernel BUG at arch/powerpc/mm/hash_utils_64.c:1815!
>> Oops: Exception in kernel mode, sig: 5 [#1]
>> LE SMP NR_CPUS=256 DEBUG_PAGEALLOC NUMA pSeries
>> CPU: 2 PID: 4298 Comm: bash Not tainted 5.0.0-rc7+ #15
>> NIP:  c000000000062670 LR: c00000000006265c CTR: 0000000000000000
>> REGS: c0000005bf8a75b0 TRAP: 0700   Not tainted  (5.0.0-rc7+)
>> MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28422842  XER: 00000000
>> CFAR: c000000000804f44 IRQMASK: 1
>> GPR00: c00000000006265c c0000005bf8a7840 c000000001518200 c0000000013cbcc8
>> GPR04: 0000000000080004 0000000000000000 00000000ccc457e0 c0000005c4e341d8
>> GPR08: 0000000000000000 0000000000000001 c000000007f4f800 0000000000000001
>> GPR12: 0000000000002200 c000000007f4e100 0000000000000000 0000000139c29710
>> GPR16: 0000000139c29714 0000000139c29788 c0000000013cbcc8 0000000000000000
>> GPR20: 0000000000034000 c0000000016e05e8 0000000000000000 0000000000000001
>> GPR24: 0000000000bf50d9 800000000000018e 0000000000000000 c0000000016e04b8
>> GPR28: f000000000d00040 0000006420a2f217 f000000000d00000 00ea1b2170340000
>> NIP [c000000000062670] __kernel_map_pages+0x2e0/0x4f0
>> LR [c00000000006265c] __kernel_map_pages+0x2cc/0x4f0
>> Call Trace:
>> [c0000005bf8a7840] [c00000000006265c] __kernel_map_pages+0x2cc/0x4f0 (unreliable)
>> [c0000005bf8a78d0] [c00000000028c4a0] free_unref_page_prepare+0x2f0/0x4d0
>> [c0000005bf8a7930] [c000000000293144] free_unref_page+0x44/0x90
>> [c0000005bf8a7970] [c00000000037af24] __online_page_free+0x84/0x110
>> [c0000005bf8a79a0] [c00000000037b6e0] online_pages_range+0xc0/0x150
>> [c0000005bf8a7a00] [c00000000005aaa8] walk_system_ram_range+0xc8/0x120
>> [c0000005bf8a7a50] [c00000000037e710] online_pages+0x280/0x5a0
>> [c0000005bf8a7b40] [c0000000006419e4] memory_subsys_online+0x1b4/0x270
>> [c0000005bf8a7bb0] [c000000000616720] device_online+0xc0/0xf0
>> [c0000005bf8a7bf0] [c000000000642570] state_store+0xc0/0x180
>> [c0000005bf8a7c30] [c000000000610b2c] dev_attr_store+0x3c/0x60
>> [c0000005bf8a7c50] [c0000000004c0a50] sysfs_kf_write+0x70/0xb0
>> [c0000005bf8a7c90] [c0000000004bf40c] kernfs_fop_write+0x10c/0x250
>> [c0000005bf8a7ce0] [c0000000003e4b18] __vfs_write+0x48/0x240
>> [c0000005bf8a7d80] [c0000000003e4f68] vfs_write+0xd8/0x210
>> [c0000005bf8a7dd0] [c0000000003e52f0] ksys_write+0x70/0x120
>> [c0000005bf8a7e20] [c00000000000b000] system_call+0x5c/0x70
>> Instruction dump:
>> 7fbd5278 7fbd4a78 3e42ffeb 7bbd0640 3a523ac8 7e439378 487a2881 60000000
>> e95505f0 7e6aa0ae 6a690080 7929c9c2 <0b090000> 7f4aa1ae 7e439378 487a28dd
>>
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>>  mm/page_alloc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 10d0f2ed9f69..025fc93d1518 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8349,6 +8349,7 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>>                 for (i = 0; i < (1 << order); i++)
>>                         SetPageReserved((page+i));
>>                 pfn += (1 << order);
>> +               kernel_map_pages(page, 1 << order, 1);
> 
> Doubt , Not sure, but does this change will have any impact on
> drivers/base/memory.c#L249
> memory_block_action() ->  offline_pages() ?

Yes, it does.
