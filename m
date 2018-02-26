Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeBZNlO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:41:14 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50014 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeBZNlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:41:11 -0500
X-Google-Smtp-Source: AG47ELs8V/MeSzchs3b6TAgSj+Cjrp+Pojm7V2Z/kJIniwwJMUCUJnXn/P/EALSJTudaKUmnQWw+2fmlPNDYcsgQdF0=
MIME-Version: 1.0
In-Reply-To: <dda0457a-c16a-3440-a547-15f49e52ec95@suse.com>
References: <20180223232538.4314-1-pasha.tatashin@oracle.com>
 <20180223232538.4314-2-pasha.tatashin@oracle.com> <dda0457a-c16a-3440-a547-15f49e52ec95@suse.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 26 Feb 2018 08:39:54 -0500
X-Gmail-Original-Message-ID: <CAOAebxt6CtQYQ5MxOrpyrLdVapPnw3XePTWUAz1SGuRoukaNGA@mail.gmail.com>
Message-ID: <CAOAebxt6CtQYQ5MxOrpyrLdVapPnw3XePTWUAz1SGuRoukaNGA@mail.gmail.com>
Subject: Re: [v1 1/1] xen, mm: Allow deferred page initialization for xen pv domains
To: Juergen Gross <jgross@suse.com>
Cc: Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, akataria@vmware.com,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, boris.ostrovsky@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andy Lutomirski <luto@kernel.org>, labbott@redhat.com,
        kirill.shutemov@linux.intel.com, bp@suse.de, minipli@googlemail.com,
        jinb.park7@gmail.com, dan.j.williams@intel.com, bhe@redhat.com,
        zhang.jia@linux.alibaba.com, Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8815 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=893
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802260182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

Thank you for taking a look at this patch, I will address your
comments, and send out an updated patch.

>>  extern void default_banner(void);
>>
>> +static inline void paravirt_after_bootmem(void)
>> +{
>> +     pv_init_ops.after_bootmem();
>> +}
>> +
>
> Putting this in the paravirt framework is overkill IMO. There is no need
> to patch the callsites for optimal performance.
>
> I'd put it into struct x86_hyper_init and pre-init it with x86_init_noop

Sure, I will move it into x86_hyper_init.

>>
>> +/*
>> + * During early boot all pages are pinned, but we do not have struct pages,
>> + * so return true until struct pages are ready.
>> + */
>
> Uuh, this comment is just not true.
>
> The "pinned" state for Xen means it is a pv pagetable known to Xen. Such
> pages are read-only for the guest and can be modified via hypercalls
> only.
>
> So either the "pinned" state will be tested for page tables only, in
> which case the comment needs adjustment, or the code is wrong.

The comment should state: During early boot all _page table_ pages are pinned

Thank you,
Pavel
