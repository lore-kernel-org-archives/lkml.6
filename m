Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1B7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35581204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35581204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeHQRnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:43:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:44008 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbeHQRnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:43:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Aug 2018 07:39:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,251,1531810800"; 
   d="scan'208";a="76173972"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2018 07:39:35 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E4744301B7C; Fri, 17 Aug 2018 07:39:34 -0700 (PDT)
Date:   Fri, 17 Aug 2018 07:39:34 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] x86/speculation/l1tf: Exempt zeroed PTEs from XOR
 conversion
Message-ID: <20180817143934.GB12066@tassilo.jf.intel.com>
References: <20180816204638.4046-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816204638.4046-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 01:46:38PM -0700, Sean Christopherson wrote:
> clear_page() does not undergo the XOR logic to invert the address
> bits, i.e. PTE, PMD and PUD entries that have not been individually
> written will have val=0 and so will trigger __pte_needs_invert().
> As a result, {pte,pmd,pud}_pfn() will return the wrong PFN value,
> i.e. all ones (adjusted by the max PFN mask) instead of zero.
> A zeroed entry is ok because the page at physical address 0 is
> reserved early in boot specifically to mitigate L1TF, so explicitly
> exempt them from the inversion when reading the PFN.
> 
> Manifested as an unexpected mprotect(..., PROT_NONE) failure when
> called on a VMA that has VM_PFNMAP and was mmap'd to as something
> other than PROT_NONE but never used.  mprotect() sends the PROT_NONE
> request down prot_none_walk(), which walks the PTEs to check the PFNs.
> prot_none_pte_entry() gets the bogus PFN from pte_pfn() and returns
> -EACCES because it thinks mprotect() is trying to adjust a high MMIO
> address.

Looks good to me. You're right that case was missed.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

I think Thomas is still on vacation, copying Linus.

-Andi
