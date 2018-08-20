Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA74C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7225D21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7225D21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeHTRn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:43:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:48070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbeHTRn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:43:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05A21AE4F;
        Mon, 20 Aug 2018 14:27:34 +0000 (UTC)
Date:   Mon, 20 Aug 2018 16:27:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org,
        Adrian Schroeter <adrian@suse.de>,
        Dominique Leuenberger <dimstar@suse.de>
Subject: Re: [PATCH] x86/speculation/l1tf: fix overflow on l1tf_pfn_limit()
 on 32bit
Message-ID: <20180820142734.GN29735@dhcp22.suse.cz>
References: <20180820095835.5298-1-vbabka@suse.cz>
 <20180820104932.GI29735@dhcp22.suse.cz>
 <4580aed9-b0fa-4d07-9aac-3cfa49a26fce@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4580aed9-b0fa-4d07-9aac-3cfa49a26fce@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-08-18 13:41:03, Vlastimil Babka wrote:
> On 08/20/2018 12:49 PM, Michal Hocko wrote:
> > On Mon 20-08-18 11:58:35, Vlastimil Babka wrote:
> >> On 32bit PAE kernels on 64bit hardware with enough physical bits,
> >> l1tf_pfn_limit() will overflow unsigned long. This in turn affects
> >> max_swapfile_size() and can lead to swapon returning -EINVAL. This has been
> >> observed in a 32bit guest with 42 bits physical address size, where
> >> max_swapfile_size() overflows exactly to 1 << 32, thus zero, and produces the
> >> following warning to dmesg:
> >>
> >> [    6.396845] Truncating oversized swap area, only using 0k out of 2047996k
> >>
> >> Fix this by using unsigned long long instead.
> >>
> >> Reported-by: Dominique Leuenberger <dimstar@suse.de>
> >> Reported-by: Adrian Schroeter <adrian@suse.de>
> >> Fixes: 17dbca119312 ("x86/speculation/l1tf: Add sysfs reporting for l1tf")
> >> Fixes: 377eeaa8e11f ("x86/speculation/l1tf: Limit swap file size to MAX_PA/2")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> > Looks good to me. I would probably use phys_addr_t which would be more
> > descriptive but this is just minor thing.
> 
> Hmm phys_addr_t is still 32bit on !PAE so there the overflow could still
> happen. I guess max_swapfile_size() should skip the whole L1TF part for
> !PAE since there is no pte inverting done anyway.

Yeah, I misremembered that we are already doing that.

> Also the value is "number of pages" which is not the same as "physical
> address" so the phys_addr_t could be misleading anyway?

right

-- 
Michal Hocko
SUSE Labs
