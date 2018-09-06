Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E80FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9252075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9252075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbeIFUbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:31:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:19786 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730331AbeIFUbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:31:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 08:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="83617544"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by fmsmga002.fm.intel.com with ESMTP; 06 Sep 2018 08:54:52 -0700
Date:   Thu, 6 Sep 2018 08:54:52 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
Message-ID: <20180906155452.GC1522@linux.intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906122423.GA11144@zn.tnic>
 <20180906135041.GB32336@linux.intel.com>
 <20180906144342.GB11144@zn.tnic>
 <20180906145639.GA1522@linux.intel.com>
 <20180906151938.GD11144@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906151938.GD11144@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 05:19:38PM +0200, Borislav Petkov wrote:
> On Thu, Sep 06, 2018 at 07:56:40AM -0700, Sean Christopherson wrote:
> > Wouldn't that result in @hv_clock_boot being incorrectly freed in the
> > !SEV case?
> 
> Ok, maybe I'm missing something but why do we need 4K per CPU? Why can't
> we map all those pages which contain the clock variable, decrypted in
> all guests' page tables?
> 
> Basically
> 
> (NR_CPUS * sizeof(struct pvclock_vsyscall_time_info)) / 4096
> 
> pages.
> 
> For the !SEV case then nothing changes.

The 4k per CPU refers to the dynamic allocation in Brijesh's original
patch.   Currently, @hv_clock_boot is a single 4k page to limit the
amount of unused memory when 'nr_cpu_ids < NR_CPUS'.  In the SEV case,
dynamically allocating for 'cpu > HVC_BOOT_ARRAY_SIZE' one at a time
means that each CPU allocates a full 4k page to store a single 32-byte
variable.  My thought was that we could simply define a second array
for the SEV case to statically allocate for NR_CPUS since __decrypted
has a big chunk of memory that would be ununsed anyways[1].  And since
the second array is only used for SEV it can be freed if !SEV.

If we free the array explicitly then we don't need a second section or
attribute.  My comments about __decrypted_exclusive were that if we
did want to go with a second section/attribute, e.g. to have a generic
solution that can be used for other stuff, then we'd have more corner
cases to deal with.  I agree that simpler is better, i.e. I'd vote for
explicitly freeing the second array.  Apologies for not making that
clear from the get-go. 

[1] An alternative solution would be to batch the dynamic allocations,
    but that would probably require locking and be more complex.
