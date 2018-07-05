Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1808C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7655724080
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7655724080
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeGEUJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:09:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:25878 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753983AbeGEUJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:09:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 13:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,313,1526367600"; 
   d="scan'208";a="69970018"
Received: from dmorlich-mobl.amr.corp.intel.com (HELO localhost) ([10.252.36.24])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2018 13:09:14 -0700
Date:   Thu, 5 Jul 2018 23:09:12 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 05/13] x86/sgx: architectural structures
Message-ID: <20180705200912.GA10701@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
 <20180703182118.15024-6-jarkko.sakkinen@linux.intel.com>
 <f9fe78ca-0ff4-814c-3681-a2366be01337@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9fe78ca-0ff4-814c-3681-a2366be01337@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 08:31:42AM -0700, Dave Hansen wrote:
> On 07/03/2018 11:19 AM, Jarkko Sakkinen wrote:
> > +struct sgx_secs {
> > +	uint64_t size;
> > +	uint64_t base;
> > +	uint32_t ssaframesize;
> > +	uint32_t miscselect;
> > +	uint8_t reserved1[SGX_SECS_RESERVED1_SIZE];
> > +	uint64_t attributes;
> > +	uint64_t xfrm;
> > +	uint32_t mrenclave[8];
> > +	uint8_t reserved2[SGX_SECS_RESERVED2_SIZE];
> > +	uint32_t mrsigner[8];
> > +	uint8_t	reserved3[SGX_SECS_RESERVED3_SIZE];
> > +	uint16_t isvvprodid;
> > +	uint16_t isvsvn;
> > +	uint8_t reserved4[SGX_SECS_RESERVED4_SIZE];
> > +} __packed __aligned(4096);
> 
> Why are the uint* versions in use here?  Those are for userspace ABI,
> but this is entirely for in-kernel-use, right?
> 
> We've used u8/16/32/64 in arch code in a bunch of places.  They're at
> least a bit more compact and easier to read.  It's this:
> 
> 	u8	foo;
> 	u64	bar;
> 
> vs. this:
> 
> 	uint8_t	 foo;
> 	uint64_t bar;

The reason was that with in-kernel LE these were in fact used by
user space code. Now they can be changed to those that you
suggested.

/Jarkko
