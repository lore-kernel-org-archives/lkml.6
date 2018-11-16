Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E930C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EF82087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EF82087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389923AbeKPXvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:51:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:13251 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbeKPXvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:51:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 05:38:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,240,1539673200"; 
   d="scan'208";a="250265459"
Received: from unknown (HELO localhost) ([10.249.254.86])
  by orsmga004.jf.intel.com with ESMTP; 16 Nov 2018 05:38:52 -0800
Date:   Fri, 16 Nov 2018 15:38:51 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v5 2/7] tpm: remove definition of TPM2_ACTIVE_PCR_BANKS
Message-ID: <20181116133851.GB4163@linux.intel.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-3-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114153108.12907-3-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 04:31:03PM +0100, Roberto Sassu wrote:
> tcg_efi_specid_event and tcg_pcr_event2 declaration contains static arrays
> for a list of hash algorithms used for event logs and event log digests.
> 
> However, according to TCG EFI Protocol Specification, these arrays have
> variable sizes. Setting the array size to zero or 3 does not make any
> difference, because the parser has to adjust the offset depending on the
> actual array size to access structure members after the static arrays.
> 
> Thus, this patch removes the declaration of TPM2_ACTIVE_PCR_BANKS and sets
> the array size to zero.
> 
> Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware
> event log")
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/tpm_eventlog.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 20d9da77fc11..3d5d162f09cc 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -8,7 +8,6 @@
>  #define TCG_EVENT_NAME_LEN_MAX	255
>  #define MAX_TEXT_EVENT		1000	/* Max event string length */
>  #define ACPI_TCPA_SIG		"TCPA"	/* 0x41504354 /'TCPA' */
> -#define TPM2_ACTIVE_PCR_BANKS	3
>  
>  #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2 0x1
>  #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_2   0x2
> @@ -90,7 +89,7 @@ struct tcg_efi_specid_event {
>  	u8 spec_errata;
>  	u8 uintnsize;
>  	u32 num_algs;
> -	struct tcg_efi_specid_event_algs digest_sizes[TPM2_ACTIVE_PCR_BANKS];
> +	struct tcg_efi_specid_event_algs digest_sizes[0];
>  	u8 vendor_info_size;
>  	u8 vendor_info[0];
>  } __packed;
> @@ -117,7 +116,7 @@ struct tcg_pcr_event2 {
>  	u32 pcr_idx;
>  	u32 event_type;
>  	u32 count;
> -	struct tpm2_digest digests[TPM2_ACTIVE_PCR_BANKS];
> +	struct tpm2_digest digests[0];
>  	struct tcg_event_field event;
>  } __packed;
>  
> -- 
> 2.17.1
> 

NAK for the same reason as last time.

/Jarkko
