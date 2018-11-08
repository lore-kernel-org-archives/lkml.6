Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57AAECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7442A20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7442A20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeKHXn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:43:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:39216 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbeKHXn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:43:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 06:08:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="94661856"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.75])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Nov 2018 06:08:15 -0800
Date:   Thu, 8 Nov 2018 16:08:14 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v4 6/6] tpm: ensure that the output of PCR read contains
 the correct digest size
Message-ID: <20181108140814.GF8922@linux.intel.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-7-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106150159.1136-7-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 04:01:59PM +0100, Roberto Sassu wrote:
> This patch protects against data corruption that could happen in the bus,
> by checking that that the digest size returned by the TPM during a PCR read
> matches the size of the algorithm passed as argument to tpm2_pcr_read().
> 
> This check is performed after information about the PCR banks has been
> retrieved.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index e2d5b84286a7..3b0b5b032901 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -187,15 +187,28 @@ struct tpm2_pcr_read_out {
>  int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
>  		  struct tpm_digest *digest_struct, u16 *digest_size_ptr)
>  {
> +	int i;
>  	int rc;
>  	struct tpm_buf buf;
>  	struct tpm2_pcr_read_out *out;
>  	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
>  	u16 digest_size;
> +	u16 expected_digest_size = 0;
>  
>  	if (pcr_idx >= TPM2_PLATFORM_PCR)
>  		return -EINVAL;
>  
> +	if (!digest_size_ptr) {
> +		for (i = 0; i < chip->nr_active_banks &&
> +		     chip->active_banks[i].alg_id != digest_struct->alg_id; i++)
> +			;

Not sure if the semicolon should be in its own line.
`
> +
> +		if (i == chip->nr_active_banks)
> +			return -EINVAL;
> +
> +		expected_digest_size = chip->active_banks[i].digest_size;
> +	}
> +
>  	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
>  	if (rc)
>  		return rc;
> @@ -215,7 +228,8 @@ int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
>  
>  	out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
>  	digest_size = be16_to_cpu(out->digest_size);
> -	if (digest_size > sizeof(digest_struct->digest)) {
> +	if (digest_size > sizeof(digest_struct->digest) ||
> +	    (!digest_size_ptr && digest_size != expected_digest_size)) {
>  		rc = -EINVAL;
>  		goto out;
>  	}
> -- 
> 2.17.1
> 

Please add

Cc: stable@vger.kernel.org.

/Jarkko
