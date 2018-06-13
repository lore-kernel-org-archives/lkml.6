Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 68B37C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E34208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E34208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935590AbeFMUbM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:31:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:28657 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935503AbeFMUbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:31:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 13:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,220,1526367600"; 
   d="scan'208";a="46904426"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2018 13:31:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 94EDD166; Wed, 13 Jun 2018 23:31:08 +0300 (EEST)
Date:   Wed, 13 Jun 2018 23:31:08 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 03/17] mm/ksm: Do not merge pages with different KeyIDs
Message-ID: <20180613203108.k63fda4hvsqyczw7@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-4-kirill.shutemov@linux.intel.com>
 <63b7e88f-33d6-c5c1-f6cb-1bbb780e2cc4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63b7e88f-33d6-c5c1-f6cb-1bbb780e2cc4@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 05:51:50PM +0000, Dave Hansen wrote:
> On 06/12/2018 07:39 AM, Kirill A. Shutemov wrote:
> > Pages encrypted with different encryption keys are not subject to KSM
> > merge. Otherwise it would cross security boundary.
> 
> This needs a much stronger explanation.

Okay, fair enough.

> Which KeyID would be used for access in the new direct mappings?

New direct mapping?

Pages would be compared using direct mappings relevant for their KeyID.
They will be threated as identical if they plain-text is identical.

> What actually happens without this patch in place?

One of processes would get the page mapped with wrong KeyID and see
garbage. We setup mapping according to KeyID in vma->vm_page_prot.

-- 
 Kirill A. Shutemov
