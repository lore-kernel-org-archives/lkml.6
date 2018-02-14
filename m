Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030726AbeBNOTT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:19:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47806 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030288AbeBNOTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:19:15 -0500
X-Google-Smtp-Source: AH8x225YKVdzMZcVrE/GeSNdzSeea8MxqBVxiTA9MPyHc68hQC9cUd5bXEu7Ts+6fw+DdaqnrjVpvw4DhSt9TEGVD0s=
MIME-Version: 1.0
In-Reply-To: <20180214050843.GA2811@jagdpanzerIV>
References: <20180209192216.20509-1-pasha.tatashin@oracle.com>
 <20180209192216.20509-2-pasha.tatashin@oracle.com> <20180214050843.GA2811@jagdpanzerIV>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 14 Feb 2018 09:16:53 -0500
X-Gmail-Original-Message-ID: <CAOAebxuwn0hvp7Rwv5nFDy=POUJf81X=xVEjM6MBEy6nzaNYgQ@mail.gmail.com>
Message-ID: <CAOAebxuwn0hvp7Rwv5nFDy=POUJf81X=xVEjM6MBEy6nzaNYgQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mm: initialize pages on demand during boot
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, m.mizuma@jp.fujitsu.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        baiyaowei@cmss.chinamobile.com, Wei Yang <richard.weiyang@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Miles Chen <miles.chen@mediatek.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=8 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140170
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

Thank you for noticing this! I will send out an updated patch soon.

Pavel

On Wed, Feb 14, 2018 at 12:08 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (02/09/18 14:22), Pavel Tatashin wrote:
> [..]
>> +/*
>> + * If this zone has deferred pages, try to grow it by initializing enough
>> + * deferred pages to satisfy the allocation specified by order, rounded up to
>> + * the nearest PAGES_PER_SECTION boundary.  So we're adding memory in increments
>> + * of SECTION_SIZE bytes by initializing struct pages in increments of
>> + * PAGES_PER_SECTION * sizeof(struct page) bytes.
>> + *
>> + * Return true when zone was grown by at least number of pages specified by
>> + * order. Otherwise return false.
>> + *
>> + * Note: We use noinline because this function is needed only during boot, and
>> + * it is called from a __ref function _deferred_grow_zone. This way we are
>> + * making sure that it is not inlined into permanent text section.
>> + */
>> +static noinline bool __init
>> +deferred_grow_zone(struct zone *zone, unsigned int order)
>> +{
>> +     int zid = zone_idx(zone);
>> +     int nid = zone->node;
>
>                 ^^^^^^^^^
>
> Should be CONFIG_NUMA dependent
>
> struct zone {
> ...
> #ifdef CONFIG_NUMA
>         int node;
> #endif
> ...
>
>         -ss
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
