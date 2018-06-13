Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 53DC7C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D57208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D57208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935576AbeFMUOE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:14:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:31605 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935335AbeFMUOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:14:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 13:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,220,1526367600"; 
   d="scan'208";a="49670053"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 13 Jun 2018 13:13:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 027D2166; Wed, 13 Jun 2018 23:13:56 +0300 (EEST)
Date:   Wed, 13 Jun 2018 23:13:56 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 01/17] mm: Do no merge VMAs with different encryption
 KeyIDs
Message-ID: <20180613201356.cupmlkfllo4ql7hq@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-2-kirill.shutemov@linux.intel.com>
 <090170d5-44a7-9bd6-2287-c1f9f87f536f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <090170d5-44a7-9bd6-2287-c1f9f87f536f@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 05:45:24PM +0000, Dave Hansen wrote:
> On 06/12/2018 07:38 AM, Kirill A. Shutemov wrote:
> > VMAs with different KeyID do not mix together. Only VMAs with the same
> > KeyID are compatible.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  include/linux/mm.h | 7 +++++++
> >  mm/mmap.c          | 3 ++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 02a616e2f17d..1c3c15f37ed6 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1492,6 +1492,13 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
> >  	return !vma->vm_ops;
> >  }
> >  
> > +#ifndef vma_keyid
> > +static inline int vma_keyid(struct vm_area_struct *vma)
> > +{
> > +	return 0;
> > +}
> > +#endif
> 
> I'm generally not a fan of this #ifdef'ing method.  It makes it hard to
> figure out who is supposed to define it, and it's also substantially
> more fragile in the face of #include ordering.
> 
> I'd much rather see some Kconfig involvement, like
> CONFIG_ARCH_HAS_MEM_ENCRYPTION or something.

Well, it's matter of taste, I guess. I do prefer per-function #ifdef'ing.
It seems more flexible to me.

I can rework it if maintainers prefer to see config option instead.

-- 
 Kirill A. Shutemov
