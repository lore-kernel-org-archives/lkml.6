Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE67CC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B1E207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfA2Hxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:53:55 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:5163 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725294AbfA2Hxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:53:55 -0500
X-UUID: e8a2e2ae80eb48a2b6588bf2cc31fd75-20190129
X-UUID: e8a2e2ae80eb48a2b6588bf2cc31fd75-20190129
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1798808927; Tue, 29 Jan 2019 15:53:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 15:53:44 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 15:53:44 +0800
Message-ID: <1548748424.18511.34.camel@mtkswgap22>
Subject: Re: [PATCH v2] mm/slub: introduce SLAB_WARN_ON_ERROR
From:   Miles Chen <miles.chen@mediatek.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 29 Jan 2019 15:53:44 +0800
In-Reply-To: <0100016898251824-359bbfae-e32b-43a6-8c58-8811a7b24520-000000@email.amazonses.com>
References: <1548313223-17114-1-git-send-email-miles.chen@mediatek.com>
         <20190128122954.949c2e6699d6e5ef060a325c@linux-foundation.org>
         <0100016898251824-359bbfae-e32b-43a6-8c58-8811a7b24520-000000@email.amazonses.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-29 at 05:46 +0000, Christopher Lameter wrote:
> On Mon, 28 Jan 2019, Andrew Morton wrote:
> 
> > > When debugging slab errors in slub.c, sometimes we have to trigger
> > > a panic in order to get the coredump file. Add a debug option
> > > SLAB_WARN_ON_ERROR to toggle WARN_ON() when the option is set.
> > >
> > > Change since v1:
> > > 1. Add a special debug option SLAB_WARN_ON_ERROR and toggle WARN_ON()
> > > if it is set.
> > > 2. SLAB_WARN_ON_ERROR can be set by kernel parameter slub_debug.
> > >
> >
> > Hopefully the slab developers will have an opinion on this.
> 
> Debugging slab itself is usually done in kvm or some other virtualized
> environment. Then gdb can be used to set breakpoints. Otherwise one may
> add printks and stuff to the allocators to figure out more or use perf.
> 
> 
> What you are changing here is the debugging for data corruption within
> objects managed by slub or the metadata. Slub currently outputs extensive
> data about the metadata corruption (typically caused by a user of
> slab allocation) which should allow you to set a proper
> breakpoint not in the allocator but in the subsystem where the corruption
> occurs.
> 
Thanks for your comments. The real problems the change can help are:

a) classic slub issue. e.g., use-after-free, redzone overwritten. It's
more efficient to report a issue as soon as slub detects it. (comparing
to monitor the log, set a breakpoint, and re-produce the issue). With
the coredump file, we can analyze the issue.

b) memory corruption issues caused by h/w write. e.g., memory
overwritten by a DMA engine. Memory corruptions may or may not related
to the slab cache that reports any error. For example: kmalloc-256 or
dentry may report the same errors. If we can preserve the the coredump
file without any restore/reset processing in slub, we could have more
information of this memory corruption.

c) memory corruption issues caused by unstable h/w. e.g., bit flipping
because of xxxx DRAM die or applying new power settings. It's hard to
re-produce this kind of issue and it much easier to tell this kind of
issue in the coredump file without any restore/reset processing.

Users can set the option by slub_debug. We can still have the original
behavior(keep the system alive) if the option is not set. We can turn on
the option when we need the coredump file. (with panic_on_warn is set,
of course).

