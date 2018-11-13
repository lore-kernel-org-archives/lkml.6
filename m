Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCAFC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8D720871
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8D720871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbeKNHRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:17:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725748AbeKNHRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 02:17:50 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wADLE6er044738
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 16:17:50 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nr3jgqfhe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 16:17:50 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Tue, 13 Nov 2018 21:17:49 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 13 Nov 2018 21:17:45 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wADLHiIY25559242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Nov 2018 21:17:44 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05F88AC05B;
        Tue, 13 Nov 2018 21:17:44 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC9F0AC059;
        Tue, 13 Nov 2018 21:17:43 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Nov 2018 21:17:43 +0000 (GMT)
Subject: Re: [PATCH v7 15/17] tpm: introduce tpm_chip_start() and
 tpm_chip_stop()
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
References: <20181113183620.27447-1-jarkko.sakkinen@linux.intel.com>
 <20181113183620.27447-16-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Tue, 13 Nov 2018 16:17:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181113183620.27447-16-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18111321-2213-0000-0000-00000316F22F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010043; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01117002; UDB=6.00579327; IPR=6.00897110;
 MB=3.00024147; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-13 21:17:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111321-2214-0000-0000-00005C3E31DF
Message-Id: <14090900-a72f-826a-60cb-166846aa3f22@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=983 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811130191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/18 1:36 PM, Jarkko Sakkinen wrote:
> Encapsulate power gating and locality functionality to tpm_chip_start()
> and tpm_chip_stop() in order to clean up the branching mess in
> tpm_transmit().
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   drivers/char/tpm/tpm-chip.c      | 110 +++++++++++++++++++++++++++++++
>   drivers/char/tpm/tpm-interface.c |  87 +-----------------------
>   drivers/char/tpm/tpm.h           |   2 +
>   3 files changed, 115 insertions(+), 84 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 157505b0f755..65f1561eba81 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -37,6 +37,116 @@ struct class *tpm_class;
>   struct class *tpmrm_class;
>   dev_t tpm_devt;
>
> +static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
> +{
> +	int rc;
> +
> +	if (flags & TPM_TRANSMIT_NESTED)
> +		return 0;
> +
> +	if (!chip->ops->request_locality)
> +		return 0;
> +
> +	rc = chip->ops->request_locality(chip, 0);
> +	if (rc < 0)
> +		return rc;
> +
> +	chip->locality = rc;
> +	return 0;
> +}
> +
> +static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
> +{
> +	int rc;
> +
> +	if (flags & TPM_TRANSMIT_NESTED)
> +		return;
> +
> +	if (!chip->ops->relinquish_locality)
> +		return;
> +
> +	rc = chip->ops->relinquish_locality(chip, chip->locality);
> +	if (rc)
> +		dev_err(&chip->dev, "%s: : error %d\n", __func__, rc);
> +
> +	chip->locality = -1;
> +}
> +
> +static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
> +{
> +	if (flags & TPM_TRANSMIT_NESTED)
> +		return 0;
> +
> +	if (!chip->ops->cmd_ready)
> +		return 0;
> +
> +	return chip->ops->cmd_ready(chip);
> +}
> +
> +static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)
> +{
> +	if (flags & TPM_TRANSMIT_NESTED)
> +		return 0;
> +
> +	if (!chip->ops->go_idle)
> +		return 0;
> +
> +	return chip->ops->go_idle(chip);
> +}
> +
> +/**
> + * tpm_chip_start() - power on the TPM
> + * @chip:	a TPM chip to use
> + * @flags:	TPM transmit flags
> + *
> + * Return:
> + * * The response length	- OK
> + * * -errno			- A system error
> + */
> +int tpm_chip_start(struct tpm_chip *chip, unsigned int flags)
> +{
> +	int ret;
> +
> +	if (chip->ops->clk_enable)
> +		chip->ops->clk_enable(chip, true);
> +
> +	if (chip->locality == -1) {
> +		ret = tpm_request_locality(chip, flags);
> +		if (ret) {
> +			chip->ops->clk_enable(chip, false);
> +			return ret;
> +		}
> +	}
> +
> +	ret = tpm_cmd_ready(chip, flags);
> +	if (ret) {
> +		tpm_relinquish_locality(chip, flags);
> +		if (chip->ops->clk_enable)
> +			chip->ops->clk_enable(chip, false);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * tpm_chip_stop() - power off the TPM
> + * @chip:	a TPM chip to use
> + * @flags:	TPM transmit flags
> + *
> + * Return:
> + * * The response length	- OK
> + * * -errno			- A system error
> + */
> +void tpm_chip_stop(struct tpm_chip *chip, unsigned int flags)
> +{
> +	tpm_go_idle(chip, flags);
> +	tpm_relinquish_locality(chip, flags);
> +	if (chip->ops->clk_enable)
> +		chip->ops->clk_enable(chip, false);
> +}
> +
> +
>   /**
>    * tpm_try_get_ops() - Get a ref to the tpm_chip
>    * @chip: Chip to ref
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 5865b9671d20..888c9923fca1 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -62,64 +62,6 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>   }
>   EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
>
> -static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
> -{
> -	int rc;
> -
> -	if (flags & TPM_TRANSMIT_NESTED)
> -		return 0;
> -
> -	if (!chip->ops->request_locality)
> -		return 0;
> -
> -	rc = chip->ops->request_locality(chip, 0);
> -	if (rc < 0)
> -		return rc;
> -
> -	chip->locality = rc;
> -
> -	return 0;
> -}
> -
> -static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
> -{
> -	int rc;
> -
> -	if (flags & TPM_TRANSMIT_NESTED)
> -		return;
> -
> -	if (!chip->ops->relinquish_locality)
> -		return;
> -
> -	rc = chip->ops->relinquish_locality(chip, chip->locality);
> -	if (rc)
> -		dev_err(&chip->dev, "%s: : error %d\n", __func__, rc);
> -
> -	chip->locality = -1;
> -}
> -
> -static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
> -{
> -	if (flags & TPM_TRANSMIT_NESTED)
> -		return 0;
> -
> -	if (!chip->ops->cmd_ready)
> -		return 0;
> -
> -	return chip->ops->cmd_ready(chip);
> -}
> -
> -static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)
> -{
> -	if (flags & TPM_TRANSMIT_NESTED)
> -		return 0;
> -
> -	if (!chip->ops->go_idle)
> -		return 0;
> -
> -	return chip->ops->go_idle(chip);
> -}
> -
>   static ssize_t tpm_try_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>   				unsigned int flags)
>   {
> @@ -212,7 +154,6 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>   	/* space for header and handles */
>   	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
>   	unsigned int delay_msec = TPM2_DURATION_SHORT;
> -	bool has_locality = false;
>   	u32 rc = 0;
>   	ssize_t ret;
>   	const size_t save_size = min(sizeof(save), bufsiz);
> @@ -227,34 +168,12 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>   	memcpy(save, buf, save_size);
>
>   	for (;;) {
> -		if (chip->ops->clk_enable != NULL)
> -			chip->ops->clk_enable(chip, true);
> -
> -		if (chip->locality == -1) {
> -			ret = tpm_request_locality(chip, flags);
> -			if (ret)
> -				goto out_locality;
> -			has_locality = true;
> -		}
> -
> -		ret = tpm_cmd_ready(chip, flags);
> +		ret = tpm_chip_start(chip, flags);
>   		if (ret)
> -			goto out_locality;
> -
> +			return ret;
>   		ret = tpm_try_transmit(chip, buf, bufsiz, flags);
> +		tpm_chip_stop(chip, flags);
>
> -		/* This may fail but do not override ret. */
> -		tpm_go_idle(chip, flags);
> -
> -out_locality:
> -		if (has_locality)
> -			tpm_relinquish_locality(chip, flags);
> -
> -		if (chip->ops->clk_enable != NULL)
> -			chip->ops->clk_enable(chip, false);
> -
> -		if (ret < 0)
> -			break;
>   		rc = be32_to_cpu(header->return_code);
>   		if (rc != TPM2_RC_RETRY && rc != TPM2_RC_TESTING)
>   			break;
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index c7c06de651a0..c42a75710b70 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -523,6 +523,8 @@ static inline void tpm_msleep(unsigned int delay_msec)
>   		     delay_msec * 1000);
>   };
>
> +int tpm_chip_start(struct tpm_chip *chip, unsigned int flags);
> +void tpm_chip_stop(struct tpm_chip *chip, unsigned int flags);
>   struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
>   __must_check int tpm_try_get_ops(struct tpm_chip *chip);
>   void tpm_put_ops(struct tpm_chip *chip);


