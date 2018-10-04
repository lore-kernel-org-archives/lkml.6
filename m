Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF77C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244472084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244472084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJEAzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:55:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:25490 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbeJEAzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:55:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 11:01:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,340,1534834800"; 
   d="scan'208";a="94678034"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.193])
  by fmsmga004.fm.intel.com with ESMTP; 04 Oct 2018 11:01:17 -0700
Message-ID: <1538676077.2562.6.camel@intel.com>
Subject: Re: [PATCH v14 15/19] platform/x86: Intel SGX driver
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
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
Date:   Thu, 04 Oct 2018 11:01:17 -0700
In-Reply-To: <20180925130845.9962-16-jarkko.sakkinen@linux.intel.com>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
         <20180925130845.9962-16-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 16:06 +0300, Jarkko Sakkinen wrote:
> Intel Software Guard eXtensions (SGX) is a set of CPU instructions that
> can be used by applications to set aside private regions of code and
> data. The code outside the enclave is disallowed to access the memory
> inside the enclave by the CPU access control.
> 
> SGX driver provides a ioctl API for loading and initializing enclaves.
> Address range for enclaves is reserved with mmap() and they are
> destroyed with munmap(). Enclave construction, measurement and
> initialization is done with the provided the ioctl API.

...

> +/**
> + * sgx_ioc_enclave_init - handler for %SGX_IOC_ENCLAVE_INIT
> + *
> + * @filep:	open file to /dev/sgx
> + * @cmd:	the command value
> + * @arg:	pointer to an &sgx_enclave_init instance
> + *
> + * Flushes the remaining enqueued EADD operations and performs EINIT. Does not
> + * allow the EINITTOKENKEY attribute for an enclave.
> + *
> + * Return:
> + *   0 on success,
> + *   SGX error code on EINIT failure,
> + *   -errno otherwise
> + */
> +static long sgx_ioc_enclave_init(struct file *filep, unsigned int cmd,
> +				 unsigned long arg)
> +{
> +	struct sgx_enclave_init *initp = (struct sgx_enclave_init *)arg;
> +	struct sgx_sigstruct *sigstruct;
> +	struct sgx_einittoken *einittoken;
> +	struct sgx_encl *encl;
> +	struct page *initp_page;
> +	int ret;
> +
> +	initp_page = alloc_page(GFP_HIGHUSER);
> +	if (!initp_page)
> +		return -ENOMEM;
> +
> +	sigstruct = kmap(initp_page);
> +	einittoken = (struct sgx_einittoken *)
> +		((unsigned long)sigstruct + PAGE_SIZE / 2);
> +	memset(einittoken, 0, sizeof(*einittoken));
> +
> +	ret = copy_from_user(sigstruct, (void __user *)initp->sigstruct,
> +			     sizeof(*sigstruct));
> +	if (ret)
> +		goto out;
> +	if (sigstruct->attributes & SGX_ATTR_EINITTOKENKEY) {
> +		ret = EINVAL;

This should be "ret = -EINVAL".

> +		goto out;
> +	}
> +
> +	ret = sgx_encl_get(initp->addr, &encl);
> +	if (ret)
> +		goto out;
> +
> +	ret = sgx_encl_init(encl, sigstruct, einittoken);
> +
> +	kref_put(&encl->refcount, sgx_encl_release);
> +
> +out:
> +	kunmap(initp_page);
> +	__free_page(initp_page);
> +	return ret;
> +}

