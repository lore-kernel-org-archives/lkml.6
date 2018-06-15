Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B09C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C2B20693
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C2B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756444AbeFOUpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:45:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:3800 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752133AbeFOUpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:45:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 13:45:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="59586326"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2018 13:45:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0A903166; Fri, 15 Jun 2018 23:45:12 +0300 (EEST)
Date:   Fri, 15 Jun 2018 23:45:12 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 07/17] x86/mm: Preserve KeyID on pte_modify() and
 pgprot_modify()
Message-ID: <20180615204512.axt2avr4ysc2iyrp@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-8-kirill.shutemov@linux.intel.com>
 <8c31f6d2-6512-2726-763e-6dd1cbb0350a@intel.com>
 <20180615125720.r755xaegvfcqfr6x@black.fi.intel.com>
 <645a4ca8-ae77-dcdd-0cbc-0da467fc210d@intel.com>
 <20180615152731.3y6rre7g66rmncxr@black.fi.intel.com>
 <cbca7e78-d70b-3eae-1c73-6ad859661b8a@intel.com>
 <20180615160613.arntdivl5gdpfwfw@black.fi.intel.com>
 <445af5b3-eaca-0589-8899-88a3b26fb509@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445af5b3-eaca-0589-8899-88a3b26fb509@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 04:58:24PM +0000, Dave Hansen wrote:
> On 06/15/2018 09:06 AM, Kirill A. Shutemov wrote:
> > I have no idea what such concept should be called. I cannot come with
> > anything better than PTE_PFN_MASK_MAX. Do you?
> 
> PTE_PRESERVE_MASK
> 
> Or maybe:
> 
> PTE_MODIFY_PRESERVE_MASK

It just replacing one confusion with another. Preserve what? How does it
differ from _PAGE_CHG_MASK?

I frankly think my name proposal convey more meaning.

> Maybe a comment to go along with it:
> 
> /*
>  * These are the bits that must be preserved during when doing a
>  * PTE permission modification operation, like taking a PTE from
>  * R/W->R/O.  They include the physical address and the memory
>  * encryption keyID.  The paddr and the keyID never occupy the same
>  * bits at the same time.  But, a given bit might be used for the keyID
>  * on one system and used for the physical address on another.  As an
>  * optimization, we manage them in one unit here since their combination
>  * always occupies the same hardware bits.
>  */

Thanks, this is useful.

-- 
 Kirill A. Shutemov
