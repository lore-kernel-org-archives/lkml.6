Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4438FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0743320875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0743320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965783AbeFSNiq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:38:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:44155 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937544AbeFSNio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:38:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 06:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="48238732"
Received: from aluisell-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.128])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2018 06:38:38 -0700
Date:   Tue, 19 Jun 2018 16:38:37 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, nhorman@redhat.com,
        npmccallum@redhat.com, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 11/13] intel_sgx: ptrace() support
Message-ID: <20180619133837.GK5609@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-12-jarkko.sakkinen@linux.intel.com>
 <91e35b3e-b42d-b3d5-752c-031973e69273@intel.com>
 <1528729329.9779.28.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528729329.9779.28.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 08:02:09AM -0700, Sean Christopherson wrote:
> On Fri, 2018-06-08 at 11:34 -0700, Dave Hansen wrote:
> > On 06/08/2018 10:09 AM, Jarkko Sakkinen wrote:
> > > 
> > > +		ret = sgx_edbgrd(encl, entry, align, data);
> > > +		if (ret)
> > > +			break;
> > > +		if (write) {
> > > +			memcpy(data + offset, buf + i, cnt);
> > > +			ret = sgx_edbgwr(encl, entry, align, data);
> > > +			if (ret)
> > > +				break;
> > > +		}
> > > +		else
> > > +			memcpy(buf + i,data + offset, cnt);
> > > +	}
> > The SGX instructions like "edbgrd" be great to put on a license plat,
> > but we can do better in the kernel.  Can you give these reasonable
> > english names, please?  sgx_debug_write(), maybe?
> 
> IMO the function names for ENCLS leafs are appropriate.  The real
> issue is the lack of documentation of the ENCLS helpers and their
> naming conventions.
> 
> The sgx_<leaf> functions, e.g. sgx_edbgrd(), are essentially direct
> invocations of the specific leaf, i.e. they are dumb wrappers to
> the lower level leaf functions, e.g. __edbgrd().  The wrappers exist
> primarily to deal with the boilerplate necessary to access a page in
> the EPC.  sgx_<leaf> conveys that the function contains the preamble
> and/or postamble needed to execute its leaf, but otherwise does not
> contain any logic.
> 
> Functions with actual logic do have English names, e.g.
> sgx_encl_init(), sgx_encl_add_page(), sgx_encl_modify_pages() etc...

I agree with Sean on the naming and agree with Dave on his comments in
earlier patch in the series needs a better documentation.

/Jarkko
