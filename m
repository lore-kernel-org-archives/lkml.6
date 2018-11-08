Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DD6ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FBC20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FBC20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeKICkA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:40:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:24683 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbeKICkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:40:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 09:03:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="278214638"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga005.fm.intel.com with ESMTP; 08 Nov 2018 09:03:34 -0800
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 8 Nov 2018 09:03:33 -0800
Received: from HASMSX109.ger.corp.intel.com (10.184.198.21) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 8 Nov 2018 09:03:33 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.165]) by
 hasmsx109.ger.corp.intel.com ([169.254.3.7]) with mapi id 14.03.0415.000;
 Thu, 8 Nov 2018 19:03:30 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 09/17] tpm: move tpm_validate_commmand() to
 tpm2-space.c
Thread-Topic: [PATCH v5 09/17] tpm: move tpm_validate_commmand() to
 tpm2-space.c
Thread-Index: AQHUd22+oc6RxW5vx0q+z+0w19EPqqVGGrzA
Date:   Thu, 8 Nov 2018 17:03:29 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA18589@hasmsx108.ger.corp.intel.com>
References: <20181108141541.12832-1-jarkko.sakkinen@linux.intel.com>
 <20181108141541.12832-10-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20181108141541.12832-10-jarkko.sakkinen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjQ1YjBmMWEtZDRjMy00NDE3LTk5NzQtMmRlMTcyZTNkNDQ3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieDcrUXNNYVF2bHZSVEtaQkJcL2RLRzlweTNkRHBwSHVha0lld2ZTWDZZNlo0RFdGVHRNNEVUM3JNMDk4WFhFVlQifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.255.203.64]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Move tpm_validate_command() to tpm2-space.c and make it part of the
> tpm2_prepare_space() flow. Make cc resolution as part of the TPM space
> functionality in order to detach it from rest of the tpm_transmit() flow.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 72 +++++++-------------------------
>  drivers/char/tpm/tpm.h           |  9 ++--
>  drivers/char/tpm/tpm2-space.c    | 54 +++++++++++++++++++++---
>  3 files changed, 68 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index f2280bf15339..a6ffd0960ae5 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -62,47 +62,6 @@ unsigned long tpm_calc_ordinal_duration(struct
> tpm_chip *chip, u32 ordinal)  }
> EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
> 
> -static int tpm_validate_command(struct tpm_chip *chip,
> -				 struct tpm_space *space,
> -				 const u8 *cmd,
> -				 size_t len)
> -{
> -	const struct tpm_header *header = (const void *)cmd;
> -	int i;
> -	u32 cc;
> -	u32 attrs;
> -	unsigned int nr_handles;
> -
> -	if (len < TPM_HEADER_SIZE)
> -		return -EINVAL;
> -
> -	if (!space)
> -		return 0;
> -
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2 && chip->nr_commands) {
> -		cc = be32_to_cpu(header->ordinal);
> -
> -		i = tpm2_find_cc(chip, cc);
> -		if (i < 0) {
> -			dev_dbg(&chip->dev, "0x%04X is an invalid
> command\n",
> -				cc);
> -			return -EOPNOTSUPP;
> -		}
> -
> -		attrs = chip->cc_attrs_tbl[i];
> -		nr_handles =
> -			4 * ((attrs >> TPM2_CC_ATTR_CHANDLES) &
> GENMASK(2, 0));
> -		if (len < TPM_HEADER_SIZE + 4 * nr_handles)
> -			goto err_len;
> -	}
> -
> -	return 0;
> -err_len:
> -	dev_dbg(&chip->dev,
> -		"%s: insufficient command length %zu", __func__, len);
> -	return -EINVAL;
> -}
> -
>  static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)  {
>  	int rc;
> @@ -172,20 +131,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> *chip,
>  	u32 count, ordinal;
>  	unsigned long stop;
> 
> -	rc = tpm_validate_command(chip, space, buf, bufsiz);
> -	if (rc == -EINVAL)
> -		return rc;
> -	/*
> -	 * If the command is not implemented by the TPM, synthesize a
> -	 * response with a TPM2_RC_COMMAND_CODE return for user-
> space.
> -	 */
> -	if (rc == -EOPNOTSUPP) {
> -		header->length = cpu_to_be32(sizeof(*header));
> -		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> -		header->return_code =
> cpu_to_be32(TPM2_RC_COMMAND_CODE |
> -
> TSS2_RESMGR_TPM_RC_LAYER);
> -		return sizeof(*header);
> -	}
> +	if (bufsiz < TPM_HEADER_SIZE)
> +		return -EINVAL;
> 
>  	if (bufsiz > TPM_BUFSIZE)
>  		bufsiz = TPM_BUFSIZE;
> @@ -200,7 +147,18 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> *chip,
>  		return -E2BIG;
>  	}
> 
> -	rc = tpm2_prepare_space(chip, space, ordinal, buf);
> +	rc = tpm2_prepare_space(chip, space, buf, bufsiz);
> +	/*
> +	 * If the command is not implemented by the TPM, synthesize a
> +	 * response with a TPM2_RC_COMMAND_CODE return for user-
> space.
> +	 */
> +	if (rc == -EOPNOTSUPP) {
> +		header->length = cpu_to_be32(sizeof(*header));
> +		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> +		header->return_code =
> cpu_to_be32(TPM2_RC_COMMAND_CODE |
> +
> TSS2_RESMGR_TPM_RC_LAYER);
> +		return sizeof(*header);
> +	}
>  	if (rc)
>  		return rc;
> 
> @@ -249,7 +207,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> *chip,
>  	if (rc)
>  		tpm2_flush_space(chip);
>  	else
> -		rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> +		rc = tpm2_commit_space(chip, space, buf, &len);
> 
>  	return rc ? rc : len;
>  }
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h index
> 92638ec6ec97..68d78ebba032 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -264,6 +264,7 @@ struct tpm_chip {
>  #endif /* CONFIG_ACPI */
> 
>  	struct tpm_space work_space;
> +	u32 last_cc;
>  	u32 nr_commands;
>  	u32 *cc_attrs_tbl;
> 
> @@ -577,10 +578,10 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
> int tpm2_init_space(struct tpm_space *space);  void tpm2_del_space(struct
> tpm_chip *chip, struct tpm_space *space);  void tpm2_flush_space(struct
> tpm_chip *chip); -int tpm2_prepare_space(struct tpm_chip *chip, struct
> tpm_space *space, u32 cc,
> -		       u8 *cmd);
> -int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
> -		      u32 cc, u8 *buf, size_t *bufsiz);
> +int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space,
> u8 *cmd,
> +		       size_t cmdsiz);
> +int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
> u8 *buf,
> +		       size_t *bufsiz);
> 
>  int tpm_bios_log_setup(struct tpm_chip *chip);  void
> tpm_bios_log_teardown(struct tpm_chip *chip); diff --git
> a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c index
> 393d9aadadce..f35ac941c3a4 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -264,14 +264,55 @@ static int tpm2_map_command(struct tpm_chip
> *chip, u32 cc, u8 *cmd)
>  	return 0;
>  }
> 
> -int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space,
> u32 cc,
> -		       u8 *cmd)
> +static int tpm_validate_command(struct tpm_chip *chip, struct tpm_space
> *space,
> +				const u8 *cmd, size_t len)
> +{
> +	const struct tpm_input_header *header = (const void *)cmd;
> +	int i;
> +	u32 cc;
> +	u32 attrs;
> +	unsigned int nr_handles;
> +
> +	if (len < TPM_HEADER_SIZE)
> +		return -EINVAL;
> +
> +	if (chip->nr_commands) {
> +		cc = be32_to_cpu(header->ordinal);
You initialized cc under if only 
> +
> +		i = tpm2_find_cc(chip, cc);
> +		if (i < 0) {
> +			dev_dbg(&chip->dev, "0x%04X is an invalid
> command\n",
> +				cc);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		attrs = chip->cc_attrs_tbl[i];
> +		nr_handles =
> +			4 * ((attrs >> TPM2_CC_ATTR_CHANDLES) &
> GENMASK(2, 0));
> +		if (len < TPM_HEADER_SIZE + 4 * nr_handles)
> +			goto err_len;
> +	}
> +
> +	return cc;
You can return uninitialized cc here.

> +err_len:
> +	dev_dbg(&chip->dev, "%s: insufficient command length %zu",
> __func__,
> +		len);
> +	return -EINVAL;
> +}
> +
> +int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space,
> u8 *cmd,
> +		       size_t cmdsiz)
>  {
>  	int rc;
> +	int cc;
> 
>  	if (!space)
>  		return 0;
> 
> +	cc = tpm_validate_command(chip, space, cmd, cmdsiz);
> +	if (cc < 0)
> +		return cc;
> +
>  	memcpy(&chip->work_space.context_tbl, &space->context_tbl,
>  	       sizeof(space->context_tbl));
>  	memcpy(&chip->work_space.session_tbl, &space->session_tbl, @@ -
> 291,6 +332,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct
> tpm_space *space, u32 cc,
>  		return rc;
>  	}
> 
> +	chip->last_cc = cc;
>  	return 0;
>  }
> 
> @@ -489,8 +531,8 @@ static int tpm2_save_space(struct tpm_chip *chip)
>  	return 0;
>  }
> 
> -int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
> -		      u32 cc, u8 *buf, size_t *bufsiz)
> +int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
> u8 *buf,
> +		      size_t *bufsiz)
>  {
>  	struct tpm_header *header = (void *)buf;
>  	int rc;
> @@ -498,13 +540,13 @@ int tpm2_commit_space(struct tpm_chip *chip,
> struct tpm_space *space,
>  	if (!space)
>  		return 0;
> 
> -	rc = tpm2_map_response_header(chip, cc, buf, *bufsiz);
> +	rc = tpm2_map_response_header(chip, chip->last_cc, buf, *bufsiz);
>  	if (rc) {
>  		tpm2_flush_space(chip);
>  		goto out;
>  	}
> 
> -	rc = tpm2_map_response_body(chip, cc, buf, *bufsiz);
> +	rc = tpm2_map_response_body(chip, chip->last_cc, buf, *bufsiz);
>  	if (rc) {
>  		tpm2_flush_space(chip);
>  		goto out;
> --
> 2.19.1

