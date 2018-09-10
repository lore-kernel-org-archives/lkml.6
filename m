Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ACDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A84820658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A84820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeIKBjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:39:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:54885 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeIKBjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:39:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 13:43:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,357,1531810800"; 
   d="scan'208";a="73150820"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.20])
  by orsmga006.jf.intel.com with ESMTP; 10 Sep 2018 13:43:17 -0700
Message-ID: <1536612197.3236.13.camel@intel.com>
Subject: Re: [RFC][PATCH 5/8] x86/mm: fix exception table comments
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
        luto@kernel.org
Date:   Mon, 10 Sep 2018 13:43:17 -0700
In-Reply-To: <bc50acea-ebc9-5be8-0fcc-9b96031a7348@linux.intel.com>
References: <20180907194852.3C351B82@viggo.jf.intel.com>
         <20180907194900.DF3B41C0@viggo.jf.intel.com>
         <1536354280.11460.28.camel@intel.com>
         <bc50acea-ebc9-5be8-0fcc-9b96031a7348@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-07 at 14:51 -0700, Dave Hansen wrote:
> > 
> > > 
> > > +	 * Only do the expensive exception table search when we might be at
> > > +	 * risk of a deadlock:
> > > +	 * 1. We failed to acquire mmap_sem, and
> > > +	 * 2. The access was an explicit kernel-mode access
> > > +	 *    (X86_PF_USER=0).
> > Might be worth reminding the reader that X86_PF_USER will be set in
> > sw_error_code for implicit accesses.  I saw "explicit" and my mind
> > immediately jumped to hw_error_code for whatever reason.  E.g.:
> > 
> > 	* 2. The access was an explicit kernel-mode access (we set X86_PF_USER
> > 	*    in sw_error_code for implicit kernel-mode accesses).
> Yeah, that was not worded well.  Is this better?
> 
> > 
> >          * Only do the expensive exception table search when we might be at
> >          * risk of a deadlock:
> >          * 1. We failed to acquire mmap_sem, and
> >          * 2. The access was an explicit kernel-mode access.  An access
> >          *    from user-mode will X86_PF_USER=1 set via hw_error_code or
> >          *    set in sw_error_code if it were an implicit kernel-mode
> >          *    access that originated in user mode.

For me, mentioning hw_error_code just muddies the waters, e.g. why is
hw_error_code mentioned when it's not checked in the code?  Comments
alone won't help someone that's reading this code and doesn't understand
that hardware sets X86_PF_USER for user-mode accesses.  Maybe this?

	 * 2. The access was an explicit kernel-mode access.  X86_PF_USER
	 *    is set in sw_error_code for both user-mode accesses and
	 *    implicit kernel-mode accesses that originated in user mode.
