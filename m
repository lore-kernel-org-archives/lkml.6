Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E110AECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA8B20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA8B20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeKHXWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:22:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:22951 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeKHXWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:22:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 05:46:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="272413498"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.75])
  by orsmga005.jf.intel.com with ESMTP; 08 Nov 2018 05:46:53 -0800
Date:   Thu, 8 Nov 2018 15:46:51 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v4 1/6] tpm: dynamically allocate active_banks array
Message-ID: <20181108134651.GA8922@linux.intel.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-2-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106150159.1136-2-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orrayn Tue, Nov 06, 2018 at 04:01:54PM +0100, Roberto Sassu wrote:
> This patch removes the hard-coded limit of the active_banks array size.
> It stores in the tpm_chip structure the number of active PCR banks,
> determined in tpm2_get_pcr_allocation(), and replaces the static array
> with a pointer to a dynamically allocated array.
> 
> As a consequence of the introduction of nr_active_banks, tpm_pcr_extend()
> does not check anymore if the algorithm stored in tpm_chip is equal to
> zero. The active_banks array always contains valid algorithms.
> 
> Fixes: 1db15344f874 ("tpm: implement TPM 2.0 capability to get active
> PCR banks")
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  drivers/char/tpm/tpm-chip.c      |  1 +
>  drivers/char/tpm/tpm-interface.c | 19 ++++++++++++-------
>  drivers/char/tpm/tpm.h           |  3 ++-
>  drivers/char/tpm/tpm2-cmd.c      | 17 ++++++++---------
>  4 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 46caadca916a..2a9e8b744436 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -160,6 +160,7 @@ static void tpm_dev_release(struct device *dev)
>  	kfree(chip->log.bios_event_log);
>  	kfree(chip->work_space.context_buf);
>  	kfree(chip->work_space.session_buf);
> +	kfree(chip->active_banks);
>  	kfree(chip);
>  }
>  
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1a803b0cf980..ba7ca6b3e664 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -1039,8 +1039,7 @@ static int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
>  int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
>  {
>  	int rc;
> -	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
> -	u32 count = 0;
> +	struct tpm2_digest *digest_list;
>  	int i;
>  
>  	chip = tpm_find_get_ops(chip);
> @@ -1048,16 +1047,22 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
>  		return -ENODEV;

Should take digest_list as input. Probably callers could re-use the
same digest_list array multiple times?

Move struct tpm_chip to include/linux/tpm.h so that the caller can query
nr_active_banks and active_banks and can create the digest array by
itself. Lets do this right at once now that this is being restructured.

>  
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -		memset(digest_list, 0, sizeof(digest_list));
> +		digest_list = kmalloc_array(chip->nr_active_banks,
> +					    sizeof(*digest_list), GFP_KERNEL);
> +		if (!digest_list)
> +			return -ENOMEM;
>  
> -		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
> -			    chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
> +		memset(digest_list, 0,
> +		       chip->nr_active_banks * sizeof(*digest_list));

You should use kcalloc() to allocate digest_list.

> +
> +		for (i = 0; i < chip->nr_active_banks; i++) {
>  			digest_list[i].alg_id = chip->active_banks[i];
>  			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
> -			count++;
>  		}
>  
> -		rc = tpm2_pcr_extend(chip, pcr_idx, count, digest_list);
> +		rc = tpm2_pcr_extend(chip, pcr_idx, chip->nr_active_banks,
> +				     digest_list);
> +		kfree(digest_list);
>  		tpm_put_ops(chip);
>  		return rc;
>  	}
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index f3501d05264f..98368c3a6ff7 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -248,7 +248,8 @@ struct tpm_chip {
>  	const struct attribute_group *groups[3];
>  	unsigned int groups_cnt;
>  
> -	u16 active_banks[7];
> +	u32 nr_active_banks;
> +	u16 *active_banks;
>  #ifdef CONFIG_ACPI
>  	acpi_handle acpi_dev_handle;
>  	char ppi_version[TPM_PPI_VERSION_LEN + 1];
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index c31b490bd41d..533089cede07 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -242,7 +242,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
>  	int i;
>  	int j;
>  
> -	if (count > ARRAY_SIZE(chip->active_banks))
> +	if (count > chip->nr_active_banks)
>  		return -EINVAL;
>  
>  	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> @@ -859,7 +859,6 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>  	void *marker;
>  	void *end;
>  	void *pcr_select_offset;
> -	unsigned int count;
>  	u32 sizeof_pcr_selection;
>  	u32 rsp_len;
>  	int rc;
> @@ -878,11 +877,14 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>  	if (rc)
>  		goto out;
>  
> -	count = be32_to_cpup(
> +	chip->nr_active_banks = be32_to_cpup(
>  		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
>  
> -	if (count > ARRAY_SIZE(chip->active_banks)) {
> -		rc = -ENODEV;
> +	chip->active_banks = kmalloc_array(chip->nr_active_banks,
> +					   sizeof(*chip->active_banks),
> +					   GFP_KERNEL);
> +	if (!chip->active_banks) {
> +		rc = -ENOMEM;
>  		goto out;
>  	}
>  
> @@ -891,7 +893,7 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>  	rsp_len = be32_to_cpup((__be32 *)&buf.data[2]);
>  	end = &buf.data[rsp_len];
>  
> -	for (i = 0; i < count; i++) {
> +	for (i = 0; i < chip->nr_active_banks; i++) {
>  		pcr_select_offset = marker +
>  			offsetof(struct tpm2_pcr_selection, size_of_select);
>  		if (pcr_select_offset >= end) {
> @@ -908,9 +910,6 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>  	}
>  
>  out:
> -	if (i < ARRAY_SIZE(chip->active_banks))
> -		chip->active_banks[i] = TPM2_ALG_ERROR;
> -
>  	tpm_buf_destroy(&buf);
>  
>  	return rc;
> -- 
> 2.17.1
> 

/Jarkko

