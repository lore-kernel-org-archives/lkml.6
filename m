Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D06C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0D420658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0D420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeHaPUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:20:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:18597 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeHaPUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:20:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 04:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="84964652"
Received: from ssirohi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.112])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2018 04:13:35 -0700
Date:   Fri, 31 Aug 2018 14:13:34 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Serge Ayoun <serge.ayoun@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 07/13] x86/sgx: Add data structures for tracking the
 EPC pages
Message-ID: <20180831111334.GB16827@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-8-jarkko.sakkinen@linux.intel.com>
 <4666cae8-c711-8dd5-cbce-3d97cc19a9e5@intel.com>
 <20180828103040.GA21326@linux.intel.com>
 <68d730bc-898c-973f-9506-648fd8a7c610@intel.com>
 <20180828213432.GB29488@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828213432.GB29488@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 02:34:32PM -0700, Sean Christopherson wrote:
> On Tue, Aug 28, 2018 at 09:53:11AM -0700, Dave Hansen wrote:
> > >>> +		sgx_nr_epc_banks++;
> > >>> +	}
> > >>> +
> > >>> +	if (!sgx_nr_epc_banks) {
> > >>> +		pr_err("There are zero EPC banks.\n");
> > >>> +		return -ENODEV;
> > >>> +	}
> > >>> +
> > >>> +	return 0;
> > >>> +}
> > >>
> > >> Does this support hot-addition of a bank?  If not, why not?
> > ...
> > > I'm not aware that we would have an ACPI specification for SGX so this
> > > is all I have at the moment (does not show any ACPI event for
> > > hotplugging).
> > 
> > So you're saying the one platform you looked at don't support hotplug.
> > I was looking for a more broad statement about SGX.
> 
> Hardware doesn't support hotplug of EPC as the EPC size and location
> is locked during activation of SGX.  And IIRC, activation of SGX must
> be synchronized across all CPUs in a multi-socket platform, e.g. you
> can't late-enable SGX on a socket and due hotplugging that way.

Makes me wonder how on a multisocket platform would this work anyway
given that they have different fused keys?

> In a virtualized environment there are no such restrictions.  I am not
> aware of any explicit requirements or use cases for supporting hotplug
> of EPC, but that's probably only because virtualization of SGX is
> fairly nascent.

/Jarkko
