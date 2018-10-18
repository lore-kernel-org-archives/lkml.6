Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2329CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D653121479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D653121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJRQPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:15:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727376AbeJRQPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:15:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 488B5AFD1;
        Thu, 18 Oct 2018 08:15:57 +0000 (UTC)
Date:   Thu, 18 Oct 2018 10:15:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Kuo-Hsin Yang <vovoy@chromium.org>, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, peterz@infradead.org,
        dave.hansen@intel.com, corbet@lwn.net, hughd@google.com,
        joonas.lahtinen@linux.intel.com, marcheu@chromium.org,
        hoegsberg@chromium.org
Subject: Re: [PATCH 2/2] drm/i915: Mark pinned shmemfs pages as unevictable
Message-ID: <20181018081552.GZ18839@dhcp22.suse.cz>
References: <20181016174300.197906-1-vovoy@chromium.org>
 <20181016174300.197906-3-vovoy@chromium.org>
 <20181016182155.GW18839@dhcp22.suse.cz>
 <153971466599.22931.16793398326492316920@skylake-alporthouse-com>
 <153984580501.19935.11456945882099910977@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153984580501.19935.11456945882099910977@skylake-alporthouse-com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-10-18 07:56:45, Chris Wilson wrote:
> Quoting Chris Wilson (2018-10-16 19:31:06)
> > Fwiw, the shmem_unlock_mapping() call feels quite expensive, almost
> > nullifying the advantage gained from not walking the lists in reclaim.
> > I'll have better numbers in a couple of days.
> 
> Using a test ("igt/benchmarks/gem_syslatency -t 120 -b -m" on kbl)
> consisting of cycletest with a background load of trying to allocate +
> populate 2MiB (to hit thp) while catting all files to /dev/null, the
> result of using mapping_set_unevictable is mixed.

I haven't really read through your report completely yet but I wanted to
point out that the above test scenario is unlikely show the real effect of
the LRU scanning overhead because shmem pages do live on the anonymous
LRU list. With a plenty of file page cache available we do not even scan
anonymous LRU lists. You would have to generate a swapout workload to
test this properly.

On the other hand if mapping_set_unevictable has really a measurably bad
performance impact then this is probably not worth much because most
workloads are swap modest.
-- 
Michal Hocko
SUSE Labs
