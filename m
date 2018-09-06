Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FE7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA11020876
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA11020876
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbeIFTcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:32:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:47835 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730082AbeIFTcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:32:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 07:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="88199096"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by orsmga001.jf.intel.com with ESMTP; 06 Sep 2018 07:56:40 -0700
Date:   Thu, 6 Sep 2018 07:56:40 -0700
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
Message-ID: <20180906145639.GA1522@linux.intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906122423.GA11144@zn.tnic>
 <20180906135041.GB32336@linux.intel.com>
 <20180906144342.GB11144@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906144342.GB11144@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 04:43:42PM +0200, Borislav Petkov wrote:
> On Thu, Sep 06, 2018 at 06:50:41AM -0700, Sean Christopherson wrote:
> > That would prevent adding __decrypted to existing declarations, e.g.
> > hv_clock_boot, which would be ugly in its own right.  A more generic
> > solution would be to add something like __decrypted_exclusive to mark
> 
> I still don't understand why can't there be only a single __decrypted
> section and to free that whole section on !SEV.

Wouldn't that result in @hv_clock_boot being incorrectly freed in the
!SEV case?
