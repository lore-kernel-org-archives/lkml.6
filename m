Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933057AbeCNA7t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 20:59:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57350 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbeCNA7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 20:59:47 -0400
X-Google-Smtp-Source: AG47ELtjrVPnVbN9BHZ2/pRWbsfcqUg5LmrFXr7+QUY9L5HluNUEZqldl2bTH6njyzAsto7TVKJr0KR7hSk/LnfeBOo=
MIME-Version: 1.0
In-Reply-To: <20180313142412.d373318b81164c4cb4b864b3@linux-foundation.org>
References: <20180309220807.24961-1-pasha.tatashin@oracle.com>
 <20180309220807.24961-2-pasha.tatashin@oracle.com> <20180312130410.e2fce8e5e38bc2086c7fd924@linux-foundation.org>
 <20180313160430.hbjnyiazadt3jwa6@xakep.localdomain> <20180313115549.7badec1c6b85eb5a1cf21eb6@linux-foundation.org>
 <20180313194546.k62tni4g4gnds2nx@xakep.localdomain> <20180313131156.f156abe1822a79ec01c4800a@linux-foundation.org>
 <ff16234e-eb45-ca99-bfec-6d33967e9c8f@oracle.com> <20180313142412.d373318b81164c4cb4b864b3@linux-foundation.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 13 Mar 2018 20:59:04 -0400
X-Gmail-Original-Message-ID: <CAGM2reZb4ZCxhENGCwuxpUYe6TfiDFbMxsrS8eCfiU_=thOJKg@mail.gmail.com>
Message-ID: <CAGM2reZb4ZCxhENGCwuxpUYe6TfiDFbMxsrS8eCfiU_=thOJKg@mail.gmail.com>
Subject: Re: [v5 1/2] mm: disable interrupts while initializing deferred pages
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Miles Chen <miles.chen@mediatek.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803140007
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2E0xsFR012991

> hm, maybe.  But I'm not sure that touch_nmi_watchdog() will hold off a
> soft lockup warning.  Maybe it will.

It should:

124static inline void touch_nmi_watchdog(void)
125{
126 arch_touch_nmi_watchdog();
127 touch_softlockup_watchdog();
128}

>
> And please let's get the above thoughts into the changlog.

OK

>
>> >
>> > I'm not sure what to suggest, really.  Your changelog isn't the best:
>> > "Vlastimil Babka reported about a window issue during which when
>> > deferred pages are initialized, and the current version of on-demand
>> > initialization is finished, allocations may fail".  Well...  where is
>> > ths mysterious window?  Without such detail it's hard for others to
>> > suggest alternative approaches.
>>
>> Here is hopefully a better description of the problem:
>>
>> Currently, during boot we preinitialize some number of struct pages to satisfy all boot allocations. Even if these allocations happen when we initialize the reset of deferred pages in page_alloc_init_late(). The problem is that we do not know how much kernel will need, and it also depends on various options.
>>
>> So, with this work, we are changing this behavior to initialize struct pages on-demand, only when allocations happen.
>>
>> During boot, when we try to allocate memory, the on-demand struct page initialization code takes care of it. But, once the deferred pages are initializing in:
>>
>> page_alloc_init_late()
>>    for_each_node_state(nid, N_MEMORY)
>>       kthread_run(deferred_init_memmap())
>>
>> We cannot use on-demand initialization, as these threads resize pgdat.
>>
>> This whole thing is to take care of this time.
>>
>> My first version of on-demand deferred page initialization would simply fail to allocate memory during this period of time. But, this new version waits for threads to finish initializing deferred memory, and successfully perform the allocation.
>>
>> Because interrupt handler would wait for pgdat resize lock.
>
> OK, thanks.  Please also add to changelog.

OK, I will send an updated patch, with changelog changes.
