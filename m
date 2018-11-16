Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A63AC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546762087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546762087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389666AbeKPXxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:53:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:51440 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeKPXxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:53:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 05:41:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,240,1539673200"; 
   d="scan'208";a="250265900"
Received: from unknown (HELO localhost) ([10.249.254.86])
  by orsmga004.jf.intel.com with ESMTP; 16 Nov 2018 05:41:13 -0800
Date:   Fri, 16 Nov 2018 15:41:12 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v5 4/7] tpm: modify tpm_pcr_read() definition to pass a
 TPM hash algorithm
Message-ID: <20181116134112.GC4163@linux.intel.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-5-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114153108.12907-5-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 04:31:05PM +0100, Roberto Sassu wrote:
> Currently the TPM driver allows other kernel subsystems to read only the
> SHA1 PCR bank. This patch modifies the parameters of tpm_pcr_read() and
> tpm2_pcr_read() to pass a tpm_digest structure, which contains the desired
> hash algorithm. Also, since commit 125a22105410 ("tpm: React correctly to
> RC_TESTING from TPM 2.0 self tests") removed the call to tpm2_pcr_read(),
> the new parameter is expected to be always not NULL.
> 
> Due to the API change, IMA functions have been modified.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm-interface.c    |  9 +++++----
>  drivers/char/tpm/tpm.h              |  3 ++-
>  drivers/char/tpm/tpm2-cmd.c         | 23 ++++++++++++++++-------
>  include/linux/tpm.h                 |  6 ++++--
>  security/integrity/ima/ima_crypto.c | 10 +++++-----
>  5 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 96c8261d0f04..04aa39432f58 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -451,11 +451,12 @@ EXPORT_SYMBOL_GPL(tpm_is_tpm2);
>   * tpm_pcr_read - read a PCR value from SHA1 bank
>   * @chip:	a &struct tpm_chip instance, %NULL for the default chip
>   * @pcr_idx:	the PCR to be retrieved
> - * @res_buf:	the value of the PCR
> + * @digest_struct:	the PCR bank and buffer current PCR value is written to
>   *
>   * Return: same as with tpm_transmit_cmd()
>   */
> -int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
> +int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
> +		 struct tpm_digest *digest_struct)

Should be just struct tpm_digest *digest

/Jarkko
