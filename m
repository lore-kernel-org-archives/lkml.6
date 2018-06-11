Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YJw0JPaOHluVAgAAmS7hNA
	; Mon, 11 Jun 2018 15:02:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 82B2060791; Mon, 11 Jun 2018 15:02:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0E1F060351;
	Mon, 11 Jun 2018 15:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E1F060351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeFKPCM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:02:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:43617 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbeFKPCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:02:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 08:02:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,502,1520924400";
   d="scan'208";a="63614978"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.135])
  by orsmga001.jf.intel.com with ESMTP; 11 Jun 2018 08:02:09 -0700
Message-ID: <1528729329.9779.28.camel@intel.com>
Subject: Re: [PATCH v11 11/13] intel_sgx: ptrace() support
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc: nhorman@redhat.com, npmccallum@redhat.com,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Mon, 11 Jun 2018 08:02:09 -0700
In-Reply-To: <91e35b3e-b42d-b3d5-752c-031973e69273@intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
         <20180608171216.26521-12-jarkko.sakkinen@linux.intel.com>
         <91e35b3e-b42d-b3d5-752c-031973e69273@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-08 at 11:34 -0700, Dave Hansen wrote:
> On 06/08/2018 10:09 AM, Jarkko Sakkinen wrote:
> > 
> > +		ret = sgx_edbgrd(encl, entry, align, data);
> > +		if (ret)
> > +			break;
> > +		if (write) {
> > +			memcpy(data + offset, buf + i, cnt);
> > +			ret = sgx_edbgwr(encl, entry, align, data);
> > +			if (ret)
> > +				break;
> > +		}
> > +		else
> > +			memcpy(buf + i,data + offset, cnt);
> > +	}
> The SGX instructions like "edbgrd" be great to put on a license plat,
> but we can do better in the kernel.  Can you give these reasonable
> english names, please?  sgx_debug_write(), maybe?

IMO the function names for ENCLS leafs are appropriate.  The real
issue is the lack of documentation of the ENCLS helpers and their
naming conventions.

The sgx_<leaf> functions, e.g. sgx_edbgrd(), are essentially direct
invocations of the specific leaf, i.e. they are dumb wrappers to
the lower level leaf functions, e.g. __edbgrd().  The wrappers exist
primarily to deal with the boilerplate necessary to access a page in
the EPC.  sgx_<leaf> conveys that the function contains the preamble
and/or postamble needed to execute its leaf, but otherwise does not
contain any logic.

Functions with actual logic do have English names, e.g.
sgx_encl_init(), sgx_encl_add_page(), sgx_encl_modify_pages() etc...

> Note that we have plenty of incomprehensible instruction names in the
> kernel like "wrpkru", but we do our best to keep them as confined as
> possible and make sure they don't hurt code readability.
