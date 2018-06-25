Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E827C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ECB24150
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0ECB24150
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933870AbeFYRAl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:00:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:16047 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933140AbeFYRAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:00:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 10:00:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,270,1526367600"; 
   d="scan'208";a="240483745"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jun 2018 10:00:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9E38AC5; Mon, 25 Jun 2018 20:00:39 +0300 (EEST)
Date:   Mon, 25 Jun 2018 20:00:39 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 15/17] x86/mm: Implement sync_direct_mapping()
Message-ID: <20180625170039.5klcdiczdswtlvwj@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-16-kirill.shutemov@linux.intel.com>
 <848a6836-1f54-4775-0b87-e926d7b7991d@intel.com>
 <20180625092937.gmu6m7kwet5s5w6m@black.fi.intel.com>
 <0ac027dd-ca4b-316e-ee2c-64305e633b1b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ac027dd-ca4b-316e-ee2c-64305e633b1b@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 04:36:43PM +0000, Dave Hansen wrote:
> On 06/25/2018 02:29 AM, Kirill A. Shutemov wrote:
> > On Mon, Jun 18, 2018 at 04:28:27PM +0000, Dave Hansen wrote:
> >>>  
> >>>  	remove_pagetable(start, end, true, NULL);
> >>> +	ret = sync_direct_mapping();
> >>> +	WARN_ON(ret);
> >>>  }
> >>
> >> I understand why you implemented it this way, I really do.  It's
> >> certainly the quickest way to hack something together and make a
> >> standalone piece of code.  But, I don't think it's maintainable.
> >>
> >> For instance, this call to sync_direct_mapping() could be entirely
> >> replaced by a call to:
> >>
> >> 	for_each_keyid(k)...
> >> 		remove_pagetable(start + offset_per_keyid * k,
> >> 			         end   + offset_per_keyid * k,
> >> 				 true, NULL);
> >>
> >> No?
> > 
> > Yes. But what's the point if we need to have the sync routine anyway for
> > the add path?
> 
> Because you are working to remove the sync routine and make an effort to
> share more code with the regular direct map manipulation.  Right?

We need sync operation for the reason I've described before: we cannot
keep it in sync from very start due to limited pool of memory to allocate
page tables from.

If sync operation covers remove too, why do we need to handle it in a
special way?

> My point is that this patch did not even make an _effort_ to reuse code
> where it would have been quite trivial to do so.  I think such an effort
> needs to be put forth before we add 400 more lines of page table
> manipulation.

The fact that I didn't reuse code here doesn't mean I have not tried.

I hope I've explain my reasoning clear enough.

> >>>  int __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> >>> @@ -1290,6 +1295,7 @@ void mark_rodata_ro(void)
> >>>  			(unsigned long) __va(__pa_symbol(rodata_end)),
> >>>  			(unsigned long) __va(__pa_symbol(_sdata)));
> >>>  
> >>> +	sync_direct_mapping();
> >>>  	debug_checkwx();
> >>
> >> Huh, checking the return code in some cases and not others.  Curious.
> >> Why is it that way?
> > 
> > There's no sensible way to handle failure in any of these path. But in
> > remove path we don't expect the failure -- no allocation required.
> > It can only happen if we missed sync_direct_mapping() somewhere else.
> 
> So, should we just silently drop the error?  Or, would it be sensible to
> make this a WARN_ON_ONCE()?

Ignoring errors is in style for this code :P

I'll add WARN_ON_ONCE() there.

-- 
 Kirill A. Shutemov
