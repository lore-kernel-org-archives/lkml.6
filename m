Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AF1ECDE46
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3352F20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3352F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeJaEkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:40:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:22884 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbeJaEkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:40:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 12:45:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="85436253"
Received: from anumodth-mobl.gar.corp.intel.com ([10.249.254.57])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2018 12:45:25 -0700
Date:   Tue, 30 Oct 2018 21:45:23 +0200 (EET)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     Roberto Sassu <roberto.sassu@huawei.com>
cc:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v3 1/5] tpm: change the end marker of the active_banks
 array to zero
In-Reply-To: <20181030154711.2782-2-roberto.sassu@huawei.com>
Message-ID: <alpine.DEB.2.21.1810302144590.5058@jsakkine-mobl1>
References: <20181030154711.2782-1-roberto.sassu@huawei.com> <20181030154711.2782-2-roberto.sassu@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018, Roberto Sassu wrote:
> This patch changes the end marker of the active_banks array from
> TPM2_ALG_ERROR to zero.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
> drivers/char/tpm/tpm-interface.c | 2 +-
> drivers/char/tpm/tpm2-cmd.c      | 3 ---
> 2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1a803b0cf980..f7fc4b5ee239 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -1051,7 +1051,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
> 		memset(digest_list, 0, sizeof(digest_list));
>
> 		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
> -			    chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
> +			    chip->active_banks[i]; i++) {
> 			digest_list[i].alg_id = chip->active_banks[i];
> 			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
> 			count++;
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index c31b490bd41d..046c9d8f3c1e 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -908,9 +908,6 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
> 	}
>
> out:
> -	if (i < ARRAY_SIZE(chip->active_banks))
> -		chip->active_banks[i] = TPM2_ALG_ERROR;
> -
> 	tpm_buf_destroy(&buf);
>
> 	return rc;
> -- 
> 2.17.1
>
>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
