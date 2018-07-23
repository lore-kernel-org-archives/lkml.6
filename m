Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0ECECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BE720875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BE720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbeGWS1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:27:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:59052 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387981AbeGWS1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:27:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 10:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,394,1526367600"; 
   d="scan'208";a="57215986"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jul 2018 10:25:01 -0700
Date:   Mon, 23 Jul 2018 10:22:49 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 10/19] x86/mm: Implement page_keyid() using page_ext
Message-ID: <20180723172249.GA13530@alison-desk.jf.intel.com>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-11-kirill.shutemov@linux.intel.com>
 <2166be55-3491-f620-5eb0-6f671a53645f@intel.com>
 <20180723094517.7sxt62p3h75htppw@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723094517.7sxt62p3h75htppw@kshutemo-mobl1>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 12:45:17PM +0300, Kirill A. Shutemov wrote:
> On Wed, Jul 18, 2018 at 04:38:02PM -0700, Dave Hansen wrote:
> > On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> > > Store KeyID in bits 31:16 of extended page flags. These bits are unused.
> > 
> > I'd love a two sentence remind of what page_ext is and why you chose to
> > use it.  Yes, you need this.  No, not everybody that you want to review
> > this patch set knows what it is or why you chose it.
> 
> Okay.
> 
> > > page_keyid() returns zero until page_ext is ready.
> > 
> > Is there any implication of this?  Or does it not matter because we
> > don't run userspace until after page_ext initialization is done?
> 
> It matters in sense that we shouldn't reference page_ext before it's
> initialized otherwise we will get garbage and crash.
> 
> > > page_ext initializer enables static branch to indicate that
> > 
> > 			"enables a static branch"
> > 
> > > page_keyid() can use page_ext. The same static branch will gate MKTME
> > > readiness in general.
> > 
> > Can you elaborate on this a bit?  It would also be a nice place to hint
> > to the folks working hard on the APIs to ensure she checks this.
> 
> Okay.

At API init time we can check if (MKTME_ENABLED &&  mktme_nr_keyids > 0)
Sounds like this is another dependency we need to check and 'wait' on?
It happens after MKTME_ENABLED is set?  Let me know.

> 
> > > We don't yet set KeyID for the page. It will come in the following
> > > patch that implements prep_encrypted_page(). All pages have KeyID-0 for
> > > now.
> > 
> > It also wouldn't hurt to mention why you don't use an X86_FEATURE_* for
> > this rather than an explicit static branch.  I'm sure the x86
> > maintainers will be curious.
> 
> Sure.
> 
> -- 
>  Kirill A. Shutemov
