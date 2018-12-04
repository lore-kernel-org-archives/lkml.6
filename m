Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C1FC65BB0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45132081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45132081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeLDXSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:18:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:14341 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeLDXSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:18:50 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 15:18:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,316,1539673200"; 
   d="scan'208";a="116067975"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.24.8.183])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2018 15:18:48 -0800
Date:   Tue, 4 Dec 2018 15:18:48 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v6 1/7] tpm: dynamically allocate the allocated_banks
 array
Message-ID: <20181204231848.GA1233@linux.intel.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-2-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204082138.24600-2-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 09:21:32AM +0100, Roberto Sassu wrote:
> tpm2_get_pcr_allocation() determines if a PCR bank is allocated by checking
> the mask in the TPML_PCR_SELECTION structure returned by the TPM for
> TPM2_Get_Capability(). One PCR bank with algorithm set to SHA1 is always
> allocated for TPM 1.x.

...

> +		for (j = 0; j < pcr_selection.size_of_select; j++)
> +			if (pcr_selection.pcr_select[j])
> +				break;
> +
> +		if (j < pcr_selection.size_of_select) {
> +			chip->allocated_banks[nr_alloc_banks] = hash_alg;
> +			nr_alloc_banks++;
> +		}
> +

Why was this needed? Can CAP_PCRS return completely unallocated banks?

Kind of out-of-context for the rest of the changes.

Should this be a bug fix of its own because it looks like as this is a
bug fix for existing code, and not a new feature? Just asking because
I don't yet fully understand this change.

Anyway, I believe that you can streamline this by:

/* Check that at least some of the PCRs have been allocated. This is
 * required because CAP_PCRS ...
 */
if (memchr_inv(pcr_selection.pcr_select, 0, pcr_selection.size_of_select))
	nr_allocated_banks++;

[yeah, comment would be awesome about CAP_PCRS. Did not finish up the
comment because I don't know the answer]

In addition, it would be consistent to call the local variable also
nr_allocated_banks (not nr_alloc_banks).

/Jarkko
