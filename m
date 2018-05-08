Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932683AbeEHOpb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:45:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47016 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932141AbeEHOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:45:29 -0400
X-Google-Smtp-Source: AB8JxZrCwQW3PzvJ4X/dukPkBaF3au/jKEsaEIIA5hd0szua9IrIiOPELxqB+L97uvuh0vija3JFYapfjWWaBNTQmiE=
MIME-Version: 1.0
References: <20180426202619.2768-1-pasha.tatashin@oracle.com> <20180430162658.598dd5dcdd0c67e36953281c@linux-foundation.org>
In-Reply-To: <20180430162658.598dd5dcdd0c67e36953281c@linux-foundation.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 08 May 2018 14:44:51 +0000
X-Gmail-Original-Message-ID: <CAGM2reauOET_PUPA94WXhjKgL1cUHcKyY+R+auxvTfd4srhaFw@mail.gmail.com>
Message-ID: <CAGM2reauOET_PUPA94WXhjKgL1cUHcKyY+R+auxvTfd4srhaFw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: access to uninitialized struct page
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Dennis Zhou <dennisszhou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=458
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gulp.  Let's hope that nothing in mm_init() requires that trap_init()
> has been run.  What happens if something goes wrong during mm_init()
> and the architecture attempts to raise a software exception, hits a bus
> error, div-by-zero, etc, etc?  Might there be hard-to-discover
> dependencies in such a case?

Hi Andrew,

Unfortunately, mm_init() requires trap_init(). And, because trap_init() is
arch specific, I do not see a way to simply fix  trap_init(). So, we need
to find a different fix for the above problem. And, the current fix needs
to be removed from mm.

BTW, the bug was not introduced by:
c9e97a1997fb ("mm: initialize pages on demand during boot")

Fengguang Wu, reproduced this bug with builds prior to when this patch was
added. So, I think that while my patch may make this problem happen more
frequently, the problem itself is older. Basically, it depends on value of
KASLR.

One way to quickly fix this issue is to disable deferred struct pages when
the following combination is true:
CONFIG_RANDOMIZE_BASE && CONFIG_SPARSEMEM && !CONFIG_SPARSEMEM_VMEMMAP

RANDOMIZE_BASE means we do not know from what PFN struct pages are going to
be required before mm_init().
CONFIG_SPARSEMEM && !CONFIG_SPARSEMEM_VMEMMAP means that page_to_pfn() will
use information from page->flags to get section number, and thus require
accessing "struct pages"

Pavel
