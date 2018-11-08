Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB8ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6B920825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6B920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeKIEmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:42:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:7392 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbeKIEmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:42:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 11:05:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="279498180"
Received: from smartikx-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.135])
  by fmsmga006.fm.intel.com with ESMTP; 08 Nov 2018 11:05:24 -0800
Date:   Thu, 8 Nov 2018 21:05:23 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v4 2/6] tpm: remove definition of TPM2_ACTIVE_PCR_BANKS
Message-ID: <20181108190523.GE20608@linux.intel.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-3-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106150159.1136-3-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 04:01:55PM +0100, Roberto Sassu wrote:
> tcg_efi_specid_event and tcg_pcr_event2 declaration contains static arrays
> for a list of hash algorithms used for event logs and event log digests.
> However, according to TCG EFI Protocol Specification, these arrays have
> variable sizes and are not suitable for parsing events with type casting.
> 
> Since declaring static arrays with hard-coded sizes does not help to parse
> data after these arrays, this patch removes the declaration of
> TPM2_ACTIVE_PCR_BANKS and sets the size of the arrays above to zero.
> 
> Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware
> event log")
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
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

I somehow lost your response but what you must do is to explain why is
it OK for last two fields to overlap.

/Jarkko
