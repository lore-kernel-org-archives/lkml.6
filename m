Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D32C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7B6256A1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7B6256A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754933AbeFYJWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:22:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:58857 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754537AbeFYJV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:21:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 02:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,269,1526367600"; 
   d="scan'208";a="210901333"
Received: from jsakkine-mobl1.tm.intel.com (HELO sfriis-mobl.ger.corp.intel.com) ([10.237.50.42])
  by orsmga004.jf.intel.com with ESMTP; 25 Jun 2018 02:21:55 -0700
Message-ID: <b024272a9f0318b188025f679928ff9cbffd71e4.camel@linux.intel.com>
Subject: Re: [PATCH v11 09/13] x86, sgx: basic routines for enclave page
 cache
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Date:   Mon, 25 Jun 2018 12:21:55 +0300
In-Reply-To: <1529508365.9779.63.camel@intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
         <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
         <1529508365.9779.63.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 08:26 -0700, Sean Christopherson wrote:
> >  bool sgx_enabled __ro_after_init = false;
> >  EXPORT_SYMBOL(sgx_enabled);
> > +bool sgx_lc_enabled __ro_after_init;
> > +EXPORT_SYMBOL(sgx_lc_enabled);
> > +atomic_t sgx_nr_free_pages = ATOMIC_INIT(0);
> > +EXPORT_SYMBOL(sgx_nr_free_pages);
> > +struct sgx_epc_bank sgx_epc_banks[SGX_MAX_EPC_BANKS];
> > +EXPORT_SYMBOL(sgx_epc_banks);
> > +int sgx_nr_epc_banks;
> > +EXPORT_SYMBOL(sgx_nr_epc_banks);
> > +LIST_HEAD(sgx_active_page_list);
> > +EXPORT_SYMBOL(sgx_active_page_list);
> > +DEFINE_SPINLOCK(sgx_active_page_list_lock);
> > +EXPORT_SYMBOL(sgx_active_page_list_lock);
> 
> I don't think we should be exporting anything other than sgx_enabled
> and sgx_lc_enabled.  The only external use of a symbol that can't be
> trivially (re)moved is in the driver's sgx_pm_suspend() in sgx_main.c,
> which uses the sgx_active_page_list to invalidate enclaves.  And that
> behavior seems unsafe, e.g. an enclave could theoretically have zero
> pages on the active list and so could be missed in the suspend flow.

Fully agreed. Just forgotten cruft...

/Jarkko
