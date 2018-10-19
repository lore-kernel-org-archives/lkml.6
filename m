Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C4FECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ED421476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67ED421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJTHz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:55:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:50443 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbeJTHz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:55:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 16:47:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,401,1534834800"; 
   d="scan'208";a="267219026"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2018 16:47:43 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 13755300FC1; Fri, 19 Oct 2018 16:47:43 -0700 (PDT)
Date:   Fri, 19 Oct 2018 16:47:43 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <andi@firstfloor.org>, peterz@infradead.org,
        x86@kernel.org, eranian@google.com, kan.liang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/cpufeature: Add facility to match microcode
 revisions
Message-ID: <20181019234743.GA27951@tassilo.jf.intel.com>
References: <20181010162608.23899-1-andi@firstfloor.org>
 <alpine.DEB.2.21.1810171151010.6000@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810171151010.6000@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	u32 min_ucode;
> > +};
> > +
> > +const struct x86_ucode_id *x86_match_ucode(const struct x86_ucode_id *match)
> 
> What's the point of returning the struct pointer? Shouldn't it be enough to
> make it return bool? Also the function name really should reflect that this
> checks whether the minimal required microcode revision is active.

This allows the user to find the table entry to tie something to it
(e.g. use the index to match some other table)

Same pattern as pci discovery etc. use.

Given the current caller doesn't need it, but we still follow standard
conventions.

> 
> > +{
> > +	struct cpuinfo_x86 *c = &boot_cpu_data;
> > +	const struct x86_ucode_id *m;
> > +
> > +	for (m = match; m->vendor | m->family | m->model; m++) {
> 
> VENDOR_INTEL = 0, so this check is obscure to begin with. Either you chose
> a explicit condition to put at the end of the table, e.g. vendor = U8_MAX
> or you hand in the array size to the function.

That would both be awkward. It's the same as match_cpu, and 0 terminators
are standard practice in practical all similar code. I removed
the or with the family.

-Andi
