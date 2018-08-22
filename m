Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900A1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52331214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52331214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbeHVSZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:25:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:48705 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbeHVSZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:25:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2018 08:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,274,1531810800"; 
   d="scan'208";a="83997798"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.132])
  by orsmga001.jf.intel.com with ESMTP; 22 Aug 2018 08:00:34 -0700
Date:   Wed, 22 Aug 2018 08:00:34 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: SEV guest regression in 4.18
Message-ID: <20180822150033.GA14200@linux.intel.com>
References: <20ad6cd5-394c-d3ae-d99c-b656d7ef8293@amd.com>
 <20180821083911.GF24940@nazgul.tnic>
 <3d46f44c-dd78-8fa9-02ac-8206676ffde9@amd.com>
 <20180821151938.GA31212@nazgul.tnic>
 <92e2b80c-0dcc-94be-8d3a-5e11e5cf2370@amd.com>
 <20180822081417.GB4069@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180822081417.GB4069@nazgul.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 10:14:17AM +0200, Borislav Petkov wrote:
> Dropping Pavel as it bounces.
> 
> On Tue, Aug 21, 2018 at 11:07:38AM -0500, Brijesh Singh wrote:
> > The tsc_early_init() is called before setup_arch() -> init_mem_mapping.
> 
> Ok, I see it, thanks for explaining.
> 
> So back to your original ideas - I'm wondering whether we should define
> a chunk of memory which the hypervisor and guest can share and thus
> communicate over... Something ala SEV-ES also with strictly defined
> layout and put all those variables there. And then the guest can map
> decrypted.

What about creating a data section specifically for shared memory?
The section would be PMD aligned and sized so that it could be mapped
appropriately without having to fracture the page.  Then define a
macro to easily declare data in the new section, a la __read_mostly.
 
> There might be something similar though, I dunno.
> 
> Maybe Paolo has a better idea...
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> -- 
