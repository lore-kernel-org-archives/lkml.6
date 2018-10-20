Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E45C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD3521557
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD3521557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeJTWtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:49:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:59804 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbeJTWtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:49:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2018 07:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,404,1534834800"; 
   d="scan'208";a="96937606"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2018 07:38:58 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id DD53C300FE1; Sat, 20 Oct 2018 07:38:57 -0700 (PDT)
Date:   Sat, 20 Oct 2018 07:38:57 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <andi@firstfloor.org>, peterz@infradead.org,
        x86@kernel.org, eranian@google.com, kan.liang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/cpufeature: Add facility to match microcode
 revisions
Message-ID: <20181020143857.GC27951@tassilo.jf.intel.com>
References: <20181010162608.23899-1-andi@firstfloor.org>
 <alpine.DEB.2.21.1810171151010.6000@nanos.tec.linutronix.de>
 <20181019234743.GA27951@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1810201017070.1651@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810201017070.1651@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 10:19:37AM +0200, Thomas Gleixner wrote:
> On Fri, 19 Oct 2018, Andi Kleen wrote:
> 
> > > > +	u32 min_ucode;
> > > > +};
> > > > +
> > > > +const struct x86_ucode_id *x86_match_ucode(const struct x86_ucode_id *match)
> > > 
> > > What's the point of returning the struct pointer? Shouldn't it be enough to
> > > make it return bool? Also the function name really should reflect that this
> > > checks whether the minimal required microcode revision is active.
> > 
> > This allows the user to find the table entry to tie something to it
> > (e.g. use the index to match some other table)
> > 
> > Same pattern as pci discovery etc. use.
> > 
> > Given the current caller doesn't need it, but we still follow standard
> > conventions.
> 
> There is no point to return the pointer because it's not a compound
> structure. If you want to provide the possibility to use the index then
> return the index and an error code if it does not match.

It will be useful with the driver_data pointer, which you short sightedly
forced me to remove, and likely will need to be readded at some point
anyways if this gets more widely used. At least with the pointer not
all callers will need to be changed then. 

Also it's symmetric with how the PCI and USB and the existing x86 match
discovery interfaces work.

> > > VENDOR_INTEL = 0, so this check is obscure to begin with. Either you chose
> > > a explicit condition to put at the end of the table, e.g. vendor = U8_MAX
> > > or you hand in the array size to the function.
> > 
> > That would both be awkward. It's the same as match_cpu, and 0 terminators
> > are standard practice in practical all similar code. I removed
> > the or with the family.
> 
> That's debatable because it's more easy to miss the terminator than getting
> the ARRAY_SIZE() argument wrong. But it doesn't matter much.

Ok then please apply it. 

-Andi

