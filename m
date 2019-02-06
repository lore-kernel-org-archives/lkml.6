Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD1FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE542073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfBFM5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:57:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:25196 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbfBFM5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:57:32 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 04:57:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="272925957"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga004.jf.intel.com with ESMTP; 06 Feb 2019 04:57:26 -0800
Date:   Wed, 6 Feb 2019 14:57:25 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        matthewgarrett@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v10 0/6] tpm: retrieve digest size of unknown algorithms
 from TPM
Message-ID: <20190206125725.GA9257@linux.intel.com>
References: <20190206105724.14495-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206105724.14495-1-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:57:18AM +0100, Roberto Sassu wrote:
> Update
> 
> This version of the patch set includes three additional patches (5-7/7)
> that allow users of the TPM driver to provide a digest for each PCR bank to
> tpm_pcr_extend(). The new patches have been included to facilitate the
> review of all the changes to support TPM 2.0 crypto agility for reading and
> extending PCRs.
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
> v9:
> - add comment for ima_load_kexec_buffer() in ima_init()
> - move 'digests' and ima_init_digests() to ima_queue.c
> - remove comment for TPM_RETRY
> 
> v8:
> - set digest array length in tpm_digest to new constant TPM_MAX_DIGEST_SIZE
> - replace enum tpm_const with #define
> - rename labels in init_trusted()
> - allocate tpm_digest array after retrieving random data in init_digests()
> 
> v7:
> - use memchr_inv() in tpm2_get_pcr_allocation()
> - add patch to move tpm_chip to include/linux/tpm.h
> - add patch to set the tpm_chip argument in trusted.c to a pointer from
>   tpm_default_chip()
> - remove definition of tpm_extend_digest
> - remove code in tpm2_pcr_extend() to extend unused PCR banks with the
>   first digest passed by the caller of tpm_pcr_extend()
> - remove count parameter from tpm_pcr_extend() and tpm2_pcr_extend()
> - remove padding of SHA1 digest in tpm_pcr_extend()
> - pre-allocate and initialize array of tpm_digest structures in
>   security/keys/trusted.c and security/integrity/ima/ima_init.c 
> 
> v6:
> - squash patches 4-6
> - rename tpm_bank_list to tpm_extend_digest, extend_size and extend_data
>   members to size and data
> - add comment in tpm2_init_bank_info()
> 
> v5:
> - rename digest_struct variable to digest
> - add _head suffix to tcg_efi_specid_event and tcg_pcr_event2
> - rename digest_size member of tpm_bank_list to extend_size
> - change type of alg_id member of tpm_bank_list from u8 to u16
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
> 
> Roberto Sassu (6):
>   tpm: dynamically allocate the allocated_banks array
>   tpm: rename and export tpm2_digest and tpm2_algorithms
>   tpm: retrieve digest size of unknown algorithms with PCR read
>   tpm: move tpm_chip definition to include/linux/tpm.h
>   KEYS: trusted: explicitly use tpm_chip structure from
>     tpm_default_chip()
>   tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()
> 
>  drivers/char/tpm/tpm-chip.c         |   1 +
>  drivers/char/tpm/tpm-interface.c    |  38 ++++----
>  drivers/char/tpm/tpm.h              | 117 ++---------------------
>  drivers/char/tpm/tpm1-cmd.c         |  12 +++
>  drivers/char/tpm/tpm2-cmd.c         | 139 ++++++++++++++++++++--------
>  include/linux/tpm.h                 | 126 ++++++++++++++++++++++++-
>  include/linux/tpm_eventlog.h        |   9 +-
>  security/integrity/ima/ima.h        |   1 +
>  security/integrity/ima/ima_crypto.c |  10 +-
>  security/integrity/ima/ima_init.c   |   4 +
>  security/integrity/ima/ima_queue.c  |  27 +++++-
>  security/keys/trusted.c             |  73 +++++++++++----
>  12 files changed, 349 insertions(+), 208 deletions(-)
> 
> -- 
> 2.17.1
> 

Can you do two things:

1. Check the v3: https://patchwork.kernel.org/patch/10797181/. Needs
to be applied first.
2. Check that this does not cause merge conflicts with the current
   imaster? If it does, fix them, and use --subject-prefix="RESEND,PATCH v10".

Thanks.

/Jarkko
