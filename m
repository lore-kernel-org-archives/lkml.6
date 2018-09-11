Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC05EC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819C62087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819C62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeIKUEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:04:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:29429 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbeIKUEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:04:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 08:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,360,1531810800"; 
   d="scan'208";a="89058413"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.20])
  by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2018 08:04:39 -0700
Message-ID: <1536678279.5992.9.camel@intel.com>
Subject: Re: [PATCH v13 09/13] x86/sgx: Enclave Page Cache (EPC) memory
 manager
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        Serge Ayoun <serge.ayoun@intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Date:   Tue, 11 Sep 2018 08:04:39 -0700
In-Reply-To: <20180827185507.17087-10-jarkko.sakkinen@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
         <20180827185507.17087-10-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 21:53 +0300, Jarkko Sakkinen wrote:
> Add a Enclave Page Cache (EPC) memory manager that can be used to
> allocate and free EPC pages. The swapper thread ksgxswapd reclaims pages
> on the event when the number of free EPC pages goes below
> %SGX_NR_LOW_PAGES up until it reaches %SGX_NR_HIGH_PAGES.
> 
> Pages are reclaimed in LRU fashion from a global list. The consumers
> take care of calling EBLOCK (block page from new accesses), ETRACK
> (restart counting the entering hardware threads) and EWB (write page to
> the regular memory) because executing these operations usually (if not
> always) requires to do some subsystem-internal locking operations.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/sgx.h      |  56 ++++--
>  arch/x86/kernel/cpu/intel_sgx.c | 322 ++++++++++++++++++++++++++++++++
>  2 files changed, 362 insertions(+), 16 deletions(-)

...

> +/**
> + * sgx_reclaim_pages - reclaim EPC pages from the consumers
> + *
> + * Takes a fixed chunk of pages from the global list of consumed EPC pages and
> + * tries to swap them. Only the pages that are either being freed by the
> + * consumer or actively used are skipped.
> + */
> +static void sgx_reclaim_pages(void)
> +{
> +	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN + 1];

The array size should simply be SGX_NR_TO_SCAN.  The +1 is a remnant
from the previous version that bounded the for-loops with "!chunk[i]"
check instead of "i < j".  No functional issue, essentially just an
unused variable.

> +	struct sgx_epc_page *epc_page;
> +	struct sgx_epc_bank *bank;
> +	int i, j;
> +
> +	spin_lock(&sgx_active_page_list_lock);
> +	for (i = 0, j = 0; i < SGX_NR_TO_SCAN; i++) {
> +		if (list_empty(&sgx_active_page_list))
> +			break;
> +
> +		epc_page = list_first_entry(&sgx_active_page_list,
> +					    struct sgx_epc_page, list);
> +		list_del_init(&epc_page->list);
> +
> +		if (epc_page->impl->ops->get(epc_page))
> +			chunk[j++] = epc_page;
> +		else
> +			epc_page->desc &= ~SGX_EPC_PAGE_RECLAIMABLE;
> +	}
> +	spin_unlock(&sgx_active_page_list_lock);
> +
> +	for (i = 0; i < j; i++) {
> +		epc_page = chunk[i];
> +		if (epc_page->impl->ops->reclaim(epc_page))
> +			continue;
> +
> +		spin_lock(&sgx_active_page_list_lock);
> +		list_add_tail(&epc_page->list, &sgx_active_page_list);
> +		spin_unlock(&sgx_active_page_list_lock);
> +
> +		epc_page->impl->ops->put(epc_page);
> +		chunk[i] = NULL;
> +	}
> +
> +	for (i = 0; i < j; i++) {
> +		epc_page = chunk[i];
> +		if (epc_page)
> +			epc_page->impl->ops->block(epc_page);
> +	}
> +
> +	for (i = 0; i < j; i++) {
> +		epc_page = chunk[i];
> +		if (epc_page) {
> +			epc_page->impl->ops->write(epc_page);
> +			epc_page->impl->ops->put(epc_page);
> +
> +			/*
> +			 * Put the page back on the free list only after we
> +			 * have put() our reference to the owner of the EPC
> +			 * page, otherwise the page could be re-allocated and
> +			 * we'd call put() on the wrong impl.
> +			 */
> +			epc_page->desc &= ~SGX_EPC_PAGE_RECLAIMABLE;
> +
> +			bank = sgx_epc_bank(epc_page);
> +			spin_lock(&bank->lock);
> +			bank->pages[bank->free_cnt++] = epc_page;
> +			spin_unlock(&bank->lock);
> +		}
> +	}
> +}

