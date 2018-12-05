Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E954DC07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D6C2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D6C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeLEAV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:21:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:42057 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbeLEAV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:21:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 16:21:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,316,1539673200"; 
   d="scan'208";a="107334755"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.24.8.183])
  by orsmga003.jf.intel.com with ESMTP; 04 Dec 2018 16:21:56 -0800
Date:   Tue, 4 Dec 2018 16:21:55 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v6 0/7] tpm: retrieve digest size of unknown algorithms
 from TPM
Message-ID: <20181205002155.GA12210@linux.intel.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204082138.24600-1-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 09:21:31AM +0100, Roberto Sassu wrote:
> Update
> 
> This version of the patch set includes an additional patch (7/7) which
> modifies the definition of tpm_pcr_extend() and tpm2_pcr_extend(). The new
> patch has been included to facilitate the review of the changes to support
> TPM 2.0 crypto agility for reading/extending PCRs.
> 
> 
> Original patch set description
> 
> The TPM driver currently relies on the crypto subsystem to determine the
> digest size of supported TPM algorithms. In the future, TPM vendors might
> implement new algorithms in their chips, and those algorithms might not
> be supported by the crypto subsystem.
> 
> Usually, vendors provide patches for the new hardware, and likely
> the crypto subsystem will be updated before the new algorithm is
> introduced. However, old kernels might be updated later, after patches
> are included in the mainline kernel. This would leave the opportunity
> for attackers to misuse PCRs, as PCR banks with an unknown algorithm
> are not extended.
> 
> This patch set provides a long term solution for this issue. If a TPM
> algorithm is not known by the crypto subsystem, the TPM driver retrieves
> the digest size from the TPM with a PCR read. All the PCR banks are
> extended, even if the algorithm is not yet supported by the crypto
> subsystem.
> 
> PCR bank information (TPM algorithm ID, digest size, crypto subsystem ID)
> is stored in the tpm_chip structure and available for users of the TPM
> driver.
> 
> Changelog
> 
> v5:
> - rename digest_struct variable to digest
> - add _head suffix to tcg_efi_specid_event and tcg_pcr_event2
> - rename digest_size member of tpm_bank_list to extend_size
> - change type of alg_id member of tpm_bank list from u8 to u16
> - add missing semi-colon in pcrlock()
> 
> v4:
> - rename active_banks to allocated_banks
> - replace kmalloc_array() with kcalloc()
> - increment nr_allocated_banks if at least one PCR in the bank is selected
> - pass multiple digests to tpm_pcr_extend()
> 
> v3:
> - remove end marker change
> - replace active_banks static array with pointer to dynamic array
> - remove TPM2_ACTIVE_PCR_BANKS
> 
> v2:
> - change the end marker of the active_banks array
> - check digest size from output of PCR read command
> - remove count parameter from tpm_pcr_read() and tpm2_pcr_read()
> 
> v1:
> - modify definition of tpm_pcr_read()
> - move hash algorithms and definition of tpm2_digest to include/linux/tpm.h
> 
> Roberto Sassu (7):
>   tpm: dynamically allocate the allocated_banks array
>   tpm: add _head suffix to tcg_efi_specid_event and tcg_pcr_event2
>   tpm: rename and export tpm2_digest and tpm2_algorithms
>   tpm: modify tpm_pcr_read() definition to pass a TPM hash algorithm
>   tpm: retrieve digest size of unknown algorithms with PCR read
>   tpm: ensure that the output of PCR read contains the correct digest
>     size
>   tpm: pass an array of tpm_bank_list structures to tpm_pcr_extend()
> 
>  drivers/char/tpm/eventlog/tpm2.c    |  12 +--
>  drivers/char/tpm/tpm-chip.c         |   1 +
>  drivers/char/tpm/tpm-interface.c    |  36 +++----
>  drivers/char/tpm/tpm.h              |  23 ++---
>  drivers/char/tpm/tpm1-cmd.c         |  26 ++++-
>  drivers/char/tpm/tpm2-cmd.c         | 154 +++++++++++++++++++++-------
>  include/linux/tpm.h                 |  43 +++++++-
>  include/linux/tpm_eventlog.h        |  19 +---
>  security/integrity/ima/ima_crypto.c |  10 +-
>  security/integrity/ima/ima_queue.c  |   5 +-
>  security/keys/trusted.c             |   5 +-
>  11 files changed, 220 insertions(+), 114 deletions(-)
> 
> -- 
> 2.17.1
> 

Some generic stuff I noticed:

* Use SHA1_DIGEST_SIZE, not TPM_DIGEST_SIZE. The latter is just
  uninforming constant that we want to get rid off.

/Jarkko
