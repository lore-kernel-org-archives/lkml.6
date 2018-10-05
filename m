Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66280C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3969F2064E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3969F2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeJESb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:31:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:21825 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbeJESb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:31:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 04:33:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,344,1534834800"; 
   d="scan'208";a="78718953"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.74])
  by orsmga007.jf.intel.com with ESMTP; 05 Oct 2018 04:32:44 -0700
Date:   Fri, 5 Oct 2018 14:32:44 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        serge.ayoun@intel.com, shay.katz-zamir@intel.com,
        linux-sgx@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 15/19] platform/x86: Intel SGX driver
Message-ID: <20181005113244.GB25985@linux.intel.com>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
 <20180925130845.9962-16-jarkko.sakkinen@linux.intel.com>
 <1538676077.2562.6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1538676077.2562.6.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 11:01:17AM -0700, Sean Christopherson wrote:
> On Tue, 2018-09-25 at 16:06 +0300, Jarkko Sakkinen wrote:
> > Intel Software Guard eXtensions (SGX) is a set of CPU instructions that
> > can be used by applications to set aside private regions of code and
> > data. The code outside the enclave is disallowed to access the memory
> > inside the enclave by the CPU access control.
> > 
> > SGX driver provides a ioctl API for loading and initializing enclaves.
> > Address range for enclaves is reserved with mmap() and they are
> > destroyed with munmap(). Enclave construction, measurement and
> > initialization is done with the provided the ioctl API.
> 
> ...
> 
> > +/**
> > + * sgx_ioc_enclave_init - handler for %SGX_IOC_ENCLAVE_INIT
> > + *
> > + * @filep:	open file to /dev/sgx
> > + * @cmd:	the command value
> > + * @arg:	pointer to an &sgx_enclave_init instance
> > + *
> > + * Flushes the remaining enqueued EADD operations and performs EINIT. Does not
> > + * allow the EINITTOKENKEY attribute for an enclave.
> > + *
> > + * Return:
> > + *   0 on success,
> > + *   SGX error code on EINIT failure,
> > + *   -errno otherwise
> > + */
> > +static long sgx_ioc_enclave_init(struct file *filep, unsigned int cmd,
> > +				 unsigned long arg)
> > +{
> > +	struct sgx_enclave_init *initp = (struct sgx_enclave_init *)arg;
> > +	struct sgx_sigstruct *sigstruct;
> > +	struct sgx_einittoken *einittoken;
> > +	struct sgx_encl *encl;
> > +	struct page *initp_page;
> > +	int ret;
> > +
> > +	initp_page = alloc_page(GFP_HIGHUSER);
> > +	if (!initp_page)
> > +		return -ENOMEM;
> > +
> > +	sigstruct = kmap(initp_page);
> > +	einittoken = (struct sgx_einittoken *)
> > +		((unsigned long)sigstruct + PAGE_SIZE / 2);
> > +	memset(einittoken, 0, sizeof(*einittoken));
> > +
> > +	ret = copy_from_user(sigstruct, (void __user *)initp->sigstruct,
> > +			     sizeof(*sigstruct));
> > +	if (ret)
> > +		goto out;
> > +	if (sigstruct->attributes & SGX_ATTR_EINITTOKENKEY) {
> > +		ret = EINVAL;
> 
> This should be "ret = -EINVAL".

Ouch :-( Thank you for spotting this out.

/Jarkko
