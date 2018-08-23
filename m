Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72547C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 22:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1992150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 22:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1992150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeHXBjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 21:39:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:9133 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbeHXBjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 21:39:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 15:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,279,1531810800"; 
   d="scan'208";a="256759959"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2018 15:07:53 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 3429E301B8F; Thu, 23 Aug 2018 15:07:53 -0700 (PDT)
Date:   Thu, 23 Aug 2018 15:07:53 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/speculation/l1tf: suggest what to do on systems with
 too much RAM
Message-ID: <20180823220753.GG12066@tassilo.jf.intel.com>
References: <20180823134418.17008-1-vbabka@suse.cz>
 <20180823142812.7363-1-vbabka@suse.cz>
 <20180823154648.GD12066@tassilo.jf.intel.com>
 <20180823192547.GS29735@dhcp22.suse.cz>
 <20180823193833.GE12066@tassilo.jf.intel.com>
 <20180823200520.GW29735@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823200520.GW29735@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 10:05:20PM +0200, Michal Hocko wrote:
> On Thu 23-08-18 12:38:33, Andi Kleen wrote:
> > > There are people who care about L1TF mitigations. I am not going to
> > > question their motivation. In any case a hint how to make the mitigation
> > > active again sounds more useful than something that sounds as scary as
> > > "you are vulnerable".
> > 
> > FWIW an early version of these patches automatically limited the available
> > memory, but Linus pointed out that people likely prefer their memory.
> 
> Nobody is questioning that. The point is to give them a hint on how to
> make the mitigation active again without going to call for help. The
> message does tell them how to _enable_ it and point them to the
> documentation on how to _decide_.

On the message I guess there are two cases:

- either it's very little memory that is lost like in the 32GB + memory
hole case. In this case maybe it's better if we just limit automatically
if the overlap is small enough (<2GB perhaps?)

- Or it's a lot of memory then people are unlikely to want to lose their
memory and I don't think we really need the message either.

Also I checked the bug again and it looks like the reporter has an IvyBridge.
There is actually a better solution for those (anything Nehalem and newer)
because they internally have at least 44 bits in the cache, which
is good enough for the mitigation. Just need a quirk to override
the bit width in this case (will submit a patch)

-Andi
