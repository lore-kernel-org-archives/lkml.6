Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D2AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C04C204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C04C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757069AbeFSN3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:29:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:27006 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750917AbeFSN3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:29:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 06:29:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="48888310"
Received: from aluisell-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.128])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jun 2018 06:29:25 -0700
Date:   Tue, 19 Jun 2018 16:29:23 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Subject: Re: [PATCH v11 10/13] intel_sgx: driver for Intel Software Guard
 Extensions
Message-ID: <20180619132923.GF5609@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-11-jarkko.sakkinen@linux.intel.com>
 <b4403cf7-ddfa-284a-d61f-ad93b895b097@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4403cf7-ddfa-284a-d61f-ad93b895b097@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 12:35:51PM -0700, Dave Hansen wrote:
> > +#define sgx_pr_ratelimited(level, encl, fmt, ...)			\
> > +	pr_ ## level ## _ratelimited("[%d:0x%p] " fmt,			\
> > +				     pid_nr((encl)->tgid),		\
> > +				     (void *)(encl)->base, ##__VA_ARGS__)
> > +
> > +#define sgx_dbg(encl, fmt, ...) \
> > +	sgx_pr_ratelimited(debug, encl, fmt, ##__VA_ARGS__)
> > +#define sgx_info(encl, fmt, ...) \
> > +	sgx_pr_ratelimited(info, encl, fmt, ##__VA_ARGS__)
> > +#define sgx_warn(encl, fmt, ...) \
> > +	sgx_pr_ratelimited(warn, encl, fmt, ##__VA_ARGS__)
> > +#define sgx_err(encl, fmt, ...) \
> > +	sgx_pr_ratelimited(err, encl, fmt, ##__VA_ARGS__)
> > +#define sgx_crit(encl, fmt, ...) \
> > +	sgx_pr_ratelimited(crit, encl, fmt, ##__VA_ARGS__)
> 
> I thought the pr_* thingies were to keep everyone from having to do this
> in each driver.  Why did you need this?

Prefixing with the enclave information.

> Can you do any better than a 2,000-line patch?  For instance, could you
> break out the memory management portion into its own part and have that
> reviewed by mm folks?  Or the ioctl()'s by device driver folks?

I'll see if this could be broken down into two i.e. driver without
swapping callbacks and one for the callbacks.

/Jarkko
