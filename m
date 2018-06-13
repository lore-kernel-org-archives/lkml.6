Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 41A37C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD91208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD91208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935592AbeFMUSG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:18:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:28029 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935335AbeFMUSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:18:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 13:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,220,1526367600"; 
   d="scan'208";a="232373606"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 Jun 2018 13:18:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 735D1166; Wed, 13 Jun 2018 23:18:02 +0300 (EEST)
Date:   Wed, 13 Jun 2018 23:18:02 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 02/17] mm/khugepaged: Do not collapse pages in
 encrypted VMAs
Message-ID: <20180613201802.45m2745soztmkxmp@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-3-kirill.shutemov@linux.intel.com>
 <f0e4648f-a458-856e-8a06-d186c280530a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e4648f-a458-856e-8a06-d186c280530a@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 05:50:24PM +0000, Dave Hansen wrote:
> On 06/12/2018 07:39 AM, Kirill A. Shutemov wrote:
> > Pages for encrypted VMAs have to be allocated in a special way:
> > we would need to propagate down not only desired NUMA node but also
> > whether the page is encrypted.
> > 
> > It complicates not-so-trivial routine of huge page allocation in
> > khugepaged even more. It also puts more pressure on page allocator:
> > we cannot re-use pages allocated for encrypted VMA to collapse
> > page in unencrypted one or vice versa.
> > 
> > I think for now it worth skipping encrypted VMAs. We can return
> > to this topic later.
> 
> You're asking for this to be included, but without a major piece of THP
> support.  Is THP support unimportant for this feature?
> 
> Are we really asking the x86 maintainers to merge this feature with this
> restriction in place?

I gave it more thought after your comment and I think I see a way to get
khugepaged work with memory encryption.

Let me check it tomorrow.

-- 
 Kirill A. Shutemov
