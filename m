Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6222C46465
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9887820825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9887820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbeKFH6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:58:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388206AbeKFH6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:58:07 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA5MYSlK122452
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 17:36:09 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nju4t9ntw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 17:36:09 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Mon, 5 Nov 2018 22:36:08 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 5 Nov 2018 22:36:05 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA5Ma4Ar53805060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Nov 2018 22:36:04 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48A21124053;
        Mon,  5 Nov 2018 22:36:04 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 105C7124058;
        Mon,  5 Nov 2018 22:36:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  5 Nov 2018 22:36:04 +0000 (GMT)
Subject: Re: [PATCH v3 08/16] tpm: move tpm_validate_commmand() to
 tpm2-space.c
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181105014552.20262-1-jarkko.sakkinen@linux.intel.com>
 <20181105014552.20262-9-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 5 Nov 2018 17:36:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181105014552.20262-9-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18110522-0060-0000-0000-000002CDBEEF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009993; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113201; UDB=6.00577041; IPR=6.00893301;
 MB=3.00024037; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-05 22:36:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110522-0061-0000-0000-0000471967DC
Message-Id: <4d71e3e5-67b6-d9b3-0561-a1221b5d6bbf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/18 8:45 PM, Jarkko Sakkinen wrote:
> Move tpm_validate_command() to tpm2-space.c and make it part of the
> tpm2_prepare_space() flow. Make cc resolution as part of the TPM space
> functionality in order to detach it from rest of the tpm_transmit()
> flow.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/tpm-interface.c | 72 +++++++-------------------------
>   drivers/char/tpm/tpm.h           |  9 ++--
>   drivers/char/tpm/tpm2-space.c    | 54 +++++++++++++++++++++---
>   3 files changed, 68 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 422e3bb0bd3d..3bf0c51b7b4f 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -62,47 +62,6 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>   }
>   EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
>
> -static int tpm_validate_command(struct tpm_chip *chip,
> -				 struct tpm_space *space,
> -				 const u8 *cmd,
> -				 size_t len)
> -{
> -	const struct tpm_input_header *header = (const void *)cmd;
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
> -			dev_dbg(&chip->dev, "0x%04X is an invalid command\n",
> -				cc);
> -			return -EOPNOTSUPP;
> -		}
> -
> -		attrs = chip->cc_attrs_tbl[i];
> -		nr_handles =
> -			4 * ((attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0));
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
>   static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
>   {
>   	int rc;
> @@ -172,20 +131,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>   	u32 count, ordinal;
>   	unsigned long stop;
>
> -	rc = tpm_validate_command(chip, space, buf, bufsiz);
> -	if (rc == -EINVAL)
> -		return rc;
> -	/*
> -	 * If the command is not implemented by the TPM, synthesize a
> -	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
> -	 */
> -	if (rc == -EOPNOTSUPP) {
> -		header->length = cpu_to_be32(sizeof(*header));
> -		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> -		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
> -						  TSS2_RESMGR_TPM_RC_LAYER);
> -		return sizeof(*header);
> -	}
> +	if (bufsiz < TPM_HEADER_SIZE)
> +		return -EINVAL;
>
>   	if (bufsiz > TPM_BUFSIZE)
>   		bufsiz = TPM_BUFSIZE;
> @@ -200,7 +147,18 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>   		return -E2BIG;
>   	}
>
> -	rc = tpm2_prepare_space(chip, space, ordinal, buf);
> +	rc = tpm2_prepare_space(chip, space, buf, bufsiz);
> +	/*
> +	 * If the command is not implemented by the TPM, synthesize a
> +	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
> +	 */
> +	if (rc == -EOPNOTSUPP) {
> +		header->length = cpu_to_be32(sizeof(*header));
> +		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> +		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
> +						  TSS2_RESMGR_TPM_RC_LAYER);
> +		return sizeof(*header);
> +	}
>   	if (rc)
>   		return rc;
>
> @@ -251,7 +209,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>   	if (rc)
>   		tpm2_flush_space(chip);
>   	else
> -		rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> +		rc = tpm2_commit_space(chip, space, buf, &len);
>
>   	return rc ? rc : len;
>   }
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 229ac42b644e..8503dd261897 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -264,6 +264,7 @@ struct tpm_chip {
>   #endif /* CONFIG_ACPI */
>
>   	struct tpm_space work_space;
> +	u32 last_cc;
>   	u32 nr_commands;
>   	u32 *cc_attrs_tbl;
>
> @@ -580,10 +581,10 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
>   int tpm2_init_space(struct tpm_space *space);
>   void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
>   void tpm2_flush_space(struct tpm_chip *chip);
> -int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
> -		       u8 *cmd);
> -int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
> -		      u32 cc, u8 *buf, size_t *bufsiz);
> +int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
> +		       size_t cmdsiz);
> +int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, u8 *buf,
> +		       size_t *bufsiz);
>
>   int tpm_bios_log_setup(struct tpm_chip *chip);
>   void tpm_bios_log_teardown(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 3d5f9577e5de..20c295fadd50 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -264,14 +264,55 @@ static int tpm2_map_command(struct tpm_chip *chip, u32 cc, u8 *cmd)
>   	return 0;
>   }
>
> -int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
> -		       u8 *cmd)
> +static int tpm_validate_command(struct tpm_chip *chip, struct tpm_space *space,
> +				const u8 *cmd, size_t len)


Nit: len -> cmdsiz (like below)


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
> +
> +		i = tpm2_find_cc(chip, cc);
> +		if (i < 0) {
> +			dev_dbg(&chip->dev, "0x%04X is an invalid command\n",
> +				cc);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		attrs = chip->cc_attrs_tbl[i];
> +		nr_handles =
> +			4 * ((attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0));
> +		if (len < TPM_HEADER_SIZE + 4 * nr_handles)
> +			goto err_len;
> +	}
> +
> +	return cc;
> +err_len:
> +	dev_dbg(&chip->dev, "%s: insufficient command length %zu", __func__,
> +		len);
> +	return -EINVAL;
> +}
> +
> +int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
> +		       size_t cmdsiz)
>   {
>   	int rc;
> +	int cc;
>
>   	if (!space)
>   		return 0;
>
> +	cc = tpm_validate_command(chip, space, cmd, cmdsiz);
> +	if (cc < 0)
> +		return cc;
> +
>   	memcpy(&chip->work_space.context_tbl, &space->context_tbl,
>   	       sizeof(space->context_tbl));
>   	memcpy(&chip->work_space.session_tbl, &space->session_tbl,
> @@ -291,6 +332,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
>   		return rc;
>   	}
>
> +	chip->last_cc = cc;
>   	return 0;
>   }
>
> @@ -489,8 +531,8 @@ static int tpm2_save_space(struct tpm_chip *chip)
>   	return 0;
>   }
>
> -int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
> -		      u32 cc, u8 *buf, size_t *bufsiz)
> +int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, u8 *buf,
> +		      size_t *bufsiz)
>   {
>   	struct tpm_output_header *header = (void *)buf;
>   	int rc;
> @@ -498,13 +540,13 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
>   	if (!space)
>   		return 0;
>
> -	rc = tpm2_map_response_header(chip, cc, buf, *bufsiz);
> +	rc = tpm2_map_response_header(chip, chip->last_cc, buf, *bufsiz);
>   	if (rc) {
>   		tpm2_flush_space(chip);
>   		goto out;
>   	}
>
> -	rc = tpm2_map_response_body(chip, cc, buf, *bufsiz);
> +	rc = tpm2_map_response_body(chip, chip->last_cc, buf, *bufsiz);
>   	if (rc) {
>   		tpm2_flush_space(chip);
>   		goto out;

Rest looks good.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

