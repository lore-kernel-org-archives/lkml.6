Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39324C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87AB20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87AB20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935759AbeFRK7e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:59:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:15938 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933605AbeFRK7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:59:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 03:59:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="60094810"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 18 Jun 2018 03:59:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 604ED124; Mon, 18 Jun 2018 13:59:29 +0300 (EEST)
Date:   Mon, 18 Jun 2018 13:59:29 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 12/17] x86/mm: Allow to disable MKTME after enumeration
Message-ID: <20180618105928.oblisvtr2cpitilj@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-13-kirill.shutemov@linux.intel.com>
 <13ba89bb-9df3-6272-96ea-005200c3198f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13ba89bb-9df3-6272-96ea-005200c3198f@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 06:30:02PM +0000, Dave Hansen wrote:
> On 06/12/2018 07:39 AM, Kirill A. Shutemov wrote:
> > Separate MKTME enumaration from enabling. We need to postpone enabling
> > until initialization is complete.
> 
> 	         ^ enumeration

Nope.

I want to differentiate enumeration in detect_tme() and the point where
MKTME is usable: after mktme_init().

> > The new helper mktme_disable() allows to disable MKTME even if it's
> 
> s/to disable/disabling/

> > enumerated successfully. MKTME initialization may fail and this
> > functionallity allows system to boot regardless of the failure.
> 
> What can make it fail?

I'll add this to commit message:

MKTME needs per-KeyID direct mapping. It requires a lot more virtual
address space which may be a problem in 4-level paging mode. If the
system has more physical memory than we can handle with MKTME.
The feature allows to fail MKTME, but boot the system successfully.

-- 
 Kirill A. Shutemov
