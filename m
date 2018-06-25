Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866CCC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35940256C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35940256C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754958AbeFYJ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:29:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:43478 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752620AbeFYJ3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:29:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 02:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,269,1526367600"; 
   d="scan'208";a="49677778"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2018 02:29:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 77F652DF; Mon, 25 Jun 2018 12:29:38 +0300 (EEST)
Date:   Mon, 25 Jun 2018 12:29:38 +0300
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
Message-ID: <20180625092937.gmu6m7kwet5s5w6m@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-16-kirill.shutemov@linux.intel.com>
 <848a6836-1f54-4775-0b87-e926d7b7991d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848a6836-1f54-4775-0b87-e926d7b7991d@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 04:28:27PM +0000, Dave Hansen wrote:
> > index 17383f9677fa..032b9a1ba8e1 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -731,6 +731,8 @@ kernel_physical_mapping_init(unsigned long paddr_start,
> >  		pgd_changed = true;
> >  	}
> >  
> > +	sync_direct_mapping();
> > +
> >  	if (pgd_changed)
> >  		sync_global_pgds(vaddr_start, vaddr_end - 1);
> >  
> > @@ -1142,10 +1144,13 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
> >  static void __meminit
> >  kernel_physical_mapping_remove(unsigned long start, unsigned long end)
> >  {
> > +	int ret;
> >  	start = (unsigned long)__va(start);
> >  	end = (unsigned long)__va(end);
> >  
> >  	remove_pagetable(start, end, true, NULL);
> > +	ret = sync_direct_mapping();
> > +	WARN_ON(ret);
> >  }
> 
> I understand why you implemented it this way, I really do.  It's
> certainly the quickest way to hack something together and make a
> standalone piece of code.  But, I don't think it's maintainable.
> 
> For instance, this call to sync_direct_mapping() could be entirely
> replaced by a call to:
> 
> 	for_each_keyid(k)...
> 		remove_pagetable(start + offset_per_keyid * k,
> 			         end   + offset_per_keyid * k,
> 				 true, NULL);
> 
> No?

Yes. But what's the point if we need to have the sync routine anyway for
the add path?


> >  int __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> > @@ -1290,6 +1295,7 @@ void mark_rodata_ro(void)
> >  			(unsigned long) __va(__pa_symbol(rodata_end)),
> >  			(unsigned long) __va(__pa_symbol(_sdata)));
> >  
> > +	sync_direct_mapping();
> >  	debug_checkwx();
> 
> Huh, checking the return code in some cases and not others.  Curious.
> Why is it that way?

There's no sensible way to handle failure in any of these path. But in
remove path we don't expect the failure -- no allocation required.
It can only happen if we missed sync_direct_mapping() somewhere else.

-- 
 Kirill A. Shutemov
