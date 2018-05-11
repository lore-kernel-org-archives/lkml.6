Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeEKOSj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:18:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43312 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752983AbeEKOSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:18:38 -0400
X-Google-Smtp-Source: AB8JxZrEC883GglclCPhhLzMPyRDpJJ3MMvu70SZcRSfg4X40cenfbcoozgNSJkq66AvAjxIIYNa2rd/vCZsr9IPRWI=
MIME-Version: 1.0
References: <20180510115356.31164-1-pasha.tatashin@oracle.com> <20180510123039.GF5325@dhcp22.suse.cz>
In-Reply-To: <20180510123039.GF5325@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 11 May 2018 10:17:55 -0400
X-Gmail-Original-Message-ID: <CAGM2reZbYR96_uv-SB=5eL6tt0OSq9yXhtA-B2TGHbRQtfGU6g@mail.gmail.com>
Message-ID: <CAGM2reZbYR96_uv-SB=5eL6tt0OSq9yXhtA-B2TGHbRQtfGU6g@mail.gmail.com>
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
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8889 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=964
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805110135
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks that helped me to see the problem. On the other hand isn't this a
> bit of an overkill? AFAICS this affects only NEED_PER_CPU_KM which is !SMP
> and DEFERRED_STRUCT_PAGE_INIT makes only very limited sense on UP,
> right?

> Or do we have more such places?

I do not know other places, but my worry is that trap_init() is arch
specific and we cannot guarantee that arches won't do virt to phys in
trap_init() in other places. Therefore, I think a proper fix is simply
allow DEFERRED_STRUCT_PAGE_INIT when it is safe to do virt to phys without
accessing struct pages, which is with SPARSEMEM_VMEMMAP.
