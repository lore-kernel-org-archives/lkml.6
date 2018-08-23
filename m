Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6F8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A892206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A892206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeHWTQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:16:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:55949 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbeHWTQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:16:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 08:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,278,1531810800"; 
   d="scan'208";a="79522840"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2018 08:44:37 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 5B8E0301B91; Thu, 23 Aug 2018 08:44:37 -0700 (PDT)
Date:   Thu, 23 Aug 2018 08:44:37 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, stable@vger.kernel.org,
        Christopher Snowhill <kode54@gmail.com>,
        George Anchev <studio@anchev.net>
Subject: Re: [PATCH] x86/speculation/l1tf: fix off-by-one error when warning
 that system has too much RAM
Message-ID: <20180823154437.GC12066@tassilo.jf.intel.com>
References: <20180823134418.17008-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823134418.17008-1-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 03:44:18PM +0200, Vlastimil Babka wrote:
> Two users have reported [1] that they have an "extremely unlikely" system
> with more than MAX_PA/2 memory and L1TF mitigation is not effective. In fact
> it's a CPU with 36bits phys limit (64GB) and 32GB memory, but due to holes
> in the e820 map, the main region is almost 500MB over the 32GB limit:

Ah I see it's a client part with very large DIMMs and someone being
very brave and using that much memory without ECC.

> 
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000081effffff] usable
> 
> Suggestions to use 'mem=32G' to prefer L1TF mitigation while losing the 500MB
> revealed, that there's an off-by-one error in the check in
> l1tf_select_mitigation(). l1tf_pfn_limit() returns the last usable pfn
> (inclusive), but it's more common and hopefully less error-prone to return the
> first pfn that's over limit, so this patch changes that and updates the other
> callers.

I can see the off by one, but does it really cause the user's problem?

They will be still over the limit in any case, with or without off-by-one.

So the description has nothing to do with the fix. Or do I miss something?

-Andi

