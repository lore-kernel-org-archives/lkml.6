Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC595C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F842084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F842084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeH2B2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:28:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:35055 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbeH2B2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:28:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 14:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,300,1531810800"; 
   d="scan'208";a="79103921"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.9])
  by orsmga003.jf.intel.com with ESMTP; 28 Aug 2018 14:34:32 -0700
Date:   Tue, 28 Aug 2018 14:34:32 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
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
Message-ID: <20180828213432.GB29488@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-8-jarkko.sakkinen@linux.intel.com>
 <4666cae8-c711-8dd5-cbce-3d97cc19a9e5@intel.com>
 <20180828103040.GA21326@linux.intel.com>
 <68d730bc-898c-973f-9506-648fd8a7c610@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d730bc-898c-973f-9506-648fd8a7c610@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 09:53:11AM -0700, Dave Hansen wrote:
> >>> +		sgx_nr_epc_banks++;
> >>> +	}
> >>> +
> >>> +	if (!sgx_nr_epc_banks) {
> >>> +		pr_err("There are zero EPC banks.\n");
> >>> +		return -ENODEV;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>
> >> Does this support hot-addition of a bank?  If not, why not?
> ...
> > I'm not aware that we would have an ACPI specification for SGX so this
> > is all I have at the moment (does not show any ACPI event for
> > hotplugging).
> 
> So you're saying the one platform you looked at don't support hotplug.
> I was looking for a more broad statement about SGX.

Hardware doesn't support hotplug of EPC as the EPC size and location
is locked during activation of SGX.  And IIRC, activation of SGX must
be synchronized across all CPUs in a multi-socket platform, e.g. you
can't late-enable SGX on a socket and due hotplugging that way.

In a virtualized environment there are no such restrictions.  I am not
aware of any explicit requirements or use cases for supporting hotplug
of EPC, but that's probably only because virtualization of SGX is
fairly nascent.
