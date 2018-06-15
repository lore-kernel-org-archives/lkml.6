Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 32429C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9563208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9563208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965654AbeFONOU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:14:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:10375 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936209AbeFONOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:14:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 06:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,227,1526367600"; 
   d="scan'208";a="63487848"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2018 06:14:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 30ED3172; Fri, 15 Jun 2018 16:14:17 +0300 (EEST)
Date:   Fri, 15 Jun 2018 16:14:17 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 08/17] x86/mm: Implement vma_is_encrypted() and
 vma_keyid()
Message-ID: <20180615131416.sl7ib6kt2mg5ufya@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-9-kirill.shutemov@linux.intel.com>
 <cc63f92a-4020-79b5-9b49-4cdd5cb800d2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc63f92a-4020-79b5-9b49-4cdd5cb800d2@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 06:18:05PM +0000, Dave Hansen wrote:
> On 06/12/2018 07:39 AM, Kirill A. Shutemov wrote:
> > +bool vma_is_encrypted(struct vm_area_struct *vma)
> > +{
> > +	return pgprot_val(vma->vm_page_prot) & mktme_keyid_mask;
> > +}
> > +
> > +int vma_keyid(struct vm_area_struct *vma)
> > +{
> > +	pgprotval_t prot;
> > +
> > +	if (!vma_is_anonymous(vma))
> > +		return 0;
> > +
> > +	prot = pgprot_val(vma->vm_page_prot);
> > +	return (prot & mktme_keyid_mask) >> mktme_keyid_shift;
> > +}
> 
> Why do we have a vma_is_anonymous() in one of these but not the other?

It shouldn't be there. It's from earlier approach to the function.
I'll fix this.

And I'll drop vma_is_encrypted(). It is not very useful.

> While this reuse of ->vm_page_prot is cute, is there any downside?  It's
> the first place I know of that we can't derive ->vm_page_prot from
> ->vm_flags on non-VM_IO/PFNMAP VMAs.  Is that a problem?

I don't think so.

It need to be covered in pte_modify() and such, but it's about it.

That's relatively isolated change and we can move KeyID into a standalone
field, if this approach proves to be problematic.

-- 
 Kirill A. Shutemov
