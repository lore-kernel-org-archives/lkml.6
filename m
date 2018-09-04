Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B119C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EEC206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EEC206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeIDUD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:03:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:17348 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbeIDUD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:03:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 08:38:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="230119759"
Received: from schoebin-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.35.203])
  by orsmga004.jf.intel.com with ESMTP; 04 Sep 2018 08:38:05 -0700
Date:   Tue, 4 Sep 2018 18:38:03 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, suresh.b.siddha@intel.com,
        serge.ayoun@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 09/13] x86/sgx: Enclave Page Cache (EPC) memory
 manager
Message-ID: <20180904153803.GC8344@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-10-jarkko.sakkinen@linux.intel.com>
 <CAHp75Vf39J8U3VnmxP+BBYi7rqzidxdD58Yx_fdnLXRro_QBgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf39J8U3VnmxP+BBYi7rqzidxdD58Yx_fdnLXRro_QBgg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 10:02:16PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 27, 2018 at 9:58 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > Add a Enclave Page Cache (EPC) memory manager that can be used to
> > allocate and free EPC pages. The swapper thread ksgxswapd reclaims pages
> > on the event when the number of free EPC pages goes below
> > %SGX_NR_LOW_PAGES up until it reaches %SGX_NR_HIGH_PAGES.
> >
> > Pages are reclaimed in LRU fashion from a global list. The consumers
> > take care of calling EBLOCK (block page from new accesses), ETRACK
> > (restart counting the entering hardware threads) and EWB (write page to
> > the regular memory) because executing these operations usually (if not
> > always) requires to do some subsystem-internal locking operations.
> 
> > +                       list_del(&page->list);
> 
> Is this page will be completely gone? Otherwise it might be needed to
> reinit list head here as well.

The swapper cannot access the page once it has been removed from the
list of active pages so it does not matter whether this is list_del()
or list_del_init().

> > +       WARN(ret < 0, "sgx: cannot free page, reclaim in-progress");
> > +       WARN(ret > 0, "sgx: EREMOVE returned %d (0x%x)", ret, ret);
> 
> I'm not sure (though it's easy to check) that you need sgx: prefix
> here. WARN() might take pr_fmt() if defined.

Sean, you took care of this one. Was it so that WARN() does not respect
pr_fmt?

/Jarkko
