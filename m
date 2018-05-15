Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbeEOMSH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:18:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55860 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeEOMSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:18:06 -0400
X-Google-Smtp-Source: AB8JxZrnhiJYmFzmL8qqCCFa6+47lgk15/UTvNe6ghzVru6djI8uWuPHjOTzoT547sxE12F4Gnro6q42p/KHMOYfZCw=
MIME-Version: 1.0
References: <20180510115356.31164-1-pasha.tatashin@oracle.com>
 <20180510123039.GF5325@dhcp22.suse.cz> <CAGM2reZbYR96_uv-SB=5eL6tt0OSq9yXhtA-B2TGHbRQtfGU6g@mail.gmail.com>
 <20180515091036.GC12670@dhcp22.suse.cz>
In-Reply-To: <20180515091036.GC12670@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 15 May 2018 08:17:27 -0400
X-Gmail-Original-Message-ID: <CAGM2reaQusBA-nmQ5xqH4u-EVxgJCnaHAZs=1AXFOpNWTh7VbQ@mail.gmail.com>
Message-ID: <CAGM2reaQusBA-nmQ5xqH4u-EVxgJCnaHAZs=1AXFOpNWTh7VbQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: allow deferred page init for vmemmap only
To: mhocko@kernel.org
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        Linux Memory Management List <linux-mm@kvack.org>,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Dennis Zhou <dennisszhou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8893 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=901
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150128
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for your reply, my comments below:

> You are now disabling a potentially useful feature to SPARSEMEM users
> without having any evidence that they do suffer from the issue which is
> kinda sad. Especially when the only known offender is a UP pcp allocator
> implementation.

True, but what is the use case for having SPARSEMEM without virtual mapping
and deferred struct page init together. Is it a common case to have
multiple gigabyte of memory and currently NUMA config to benefit from
deferred page init and yet not having a memory for virtual mapping of
struct pages? Or am I missing some common case here?

> I will not insist of course but it seems like your fix doesn't really
> prevent virt_to_page or other direct page access either.

I am not sure what do you mean, I do not prevent virt_to_page, but that is
OK for SPARSEMEM_VMEMMAP case, because we do not need to access "struct
page" for this operation, as translation is in page table. Yes, we do not
prohibit other struct page accesses before mm_init(), but we now have a
feature that checks for uninitialized struct page access, and if those will
happen, we will learn about them.

Thank you,
Pavel
