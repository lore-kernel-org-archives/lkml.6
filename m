Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F6AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CA62087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CA62087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeIXU4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:56:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728264AbeIXU4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:56:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OEsInt020892
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:54:20 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mq202rawc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:54:18 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Mon, 24 Sep 2018 08:54:09 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Sep 2018 08:54:06 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8OEs5SO43843620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Sep 2018 07:54:05 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC33D6A047;
        Mon, 24 Sep 2018 08:54:05 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA57E6A054;
        Mon, 24 Sep 2018 08:54:00 -0600 (MDT)
Received: from [9.79.212.223] (unknown [9.79.212.223])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 24 Sep 2018 08:54:00 -0600 (MDT)
Subject: Re: [PATCH v4 11/21] tpm: factor out tpm_startup function
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180921135820.20549-1-tomas.winkler@intel.com>
 <20180921135820.20549-12-tomas.winkler@intel.com>
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
Date:   Mon, 24 Sep 2018 20:21:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180921135820.20549-12-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18092414-8235-0000-0000-00000E05CD0D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009763; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01092994; UDB=6.00564877; IPR=6.00873032;
 MB=3.00023482; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-24 14:54:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092414-8236-0000-0000-000042C1688F
Message-Id: <060a3dc0-046e-198c-f476-8c490140e9d6@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809240147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/21/2018 07:28 PM, Tomas Winkler wrote:
> TPM manual startup is used only from within TPM 1.x or TPM 2.x
> code, hence remove tpm_startup() function from tpm-interface.c
> and add two static functions implementations tpm1_startup()
> and tpm2_startup() into to tpm1-cmd.c and tpm2-cmd.c respectively.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Tested-by: Jarkko Sakkine <jarkko.sakkinen@linux.intel.com>

Typo in Jarkko's last name -  "Sakkinen"

Thanks & Regards,
     - Nayna

> ---
> V2-V3: Resend.
> V4: Fix the commit message.
>
>   drivers/char/tpm/tpm-interface.c | 41 ----------------------------------------
>   drivers/char/tpm/tpm.h           |  1 -
>   drivers/char/tpm/tpm1-cmd.c      | 37 +++++++++++++++++++++++++++++++++++-
>   drivers/char/tpm/tpm2-cmd.c      | 34 +++++++++++++++++++++++++++++++--
>   4 files changed, 68 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index dfa972bbdd81..686b5316dad5 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -413,47 +413,6 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
>   }
>   EXPORT_SYMBOL_GPL(tpm_transmit_cmd);
>
> -#define TPM_ORD_STARTUP 153
> -#define TPM_ST_CLEAR 1
> -
> -/**
> - * tpm_startup - turn on the TPM
> - * @chip: TPM chip to use
> - *
> - * Normally the firmware should start the TPM. This function is provided as a
> - * workaround if this does not happen. A legal case for this could be for
> - * example when a TPM emulator is used.
> - *
> - * Return: same as tpm_transmit_cmd()
> - */
> -int tpm_startup(struct tpm_chip *chip)
> -{
> -	struct tpm_buf buf;
> -	int rc;
> -
> -	dev_info(&chip->dev, "starting up the TPM manually\n");
> -
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
> -		if (rc < 0)
> -			return rc;
> -
> -		tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
> -	} else {
> -		rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
> -		if (rc < 0)
> -			return rc;
> -
> -		tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
> -	}
> -
> -	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
> -			      "attempting to start the TPM");
> -
> -	tpm_buf_destroy(&buf);
> -	return rc;
> -}
> -
>   int tpm_get_timeouts(struct tpm_chip *chip)
>   {
>   	if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 862c9262e037..fa88102a0cab 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -540,7 +540,6 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
>   			 void *buf, size_t bufsiz,
>   			 size_t min_rsp_body_length, unsigned int flags,
>   			 const char *desc);
> -int tpm_startup(struct tpm_chip *chip);
>   int tpm_get_timeouts(struct tpm_chip *);
>
>   int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index d118adbcd2a7..6deae4595277 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -308,6 +308,40 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>   		return duration;
>   }
>
> +#define TPM_ORD_STARTUP 153
> +#define TPM_ST_CLEAR 1
> +
> +/**
> + * tpm_startup - turn on the TPM
> + * @chip: TPM chip to use
> + *
> + * Normally the firmware should start the TPM. This function is provided as a
> + * workaround if this does not happen. A legal case for this could be for
> + * example when a TPM emulator is used.
> + *
> + * Return: same as tpm_transmit_cmd()
> + */
> +static int tpm1_startup(struct tpm_chip *chip)
> +{
> +	struct tpm_buf buf;
> +	int rc;
> +
> +	dev_info(&chip->dev, "starting up the TPM manually\n");
> +
> +	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
> +	if (rc < 0)
> +		return rc;
> +
> +	tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
> +
> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
> +			      "attempting to start the TPM");
> +
> +	tpm_buf_destroy(&buf);
> +
> +	return rc;
> +}
> +
>   int tpm1_get_timeouts(struct tpm_chip *chip)
>   {
>   	cap_t cap;
> @@ -317,7 +351,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
>   	rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, NULL,
>   			 sizeof(cap.timeout));
>   	if (rc == TPM_ERR_INVALID_POSTINIT) {
> -		if (tpm_startup(chip))
> +		if (tpm1_startup(chip))
>   			return rc;
>
>   		rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap,
> @@ -726,3 +760,4 @@ int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr)
>
>   	return rc;
>   }
> +
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 65ce463a6f92..8da5a16e7c8c 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -943,6 +943,36 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
>   	return rc;
>   }
>
> +/**
> + * tpm2_startup - turn on the TPM
> + * @chip: TPM chip to use
> + *
> + * Normally the firmware should start the TPM. This function is provided as a
> + * workaround if this does not happen. A legal case for this could be for
> + * example when a TPM emulator is used.
> + *
> + * Return: same as tpm_transmit_cmd()
> + */
> +
> +static int tpm2_startup(struct tpm_chip *chip)
> +{
> +	struct tpm_buf buf;
> +	int rc;
> +
> +	dev_info(&chip->dev, "starting up the TPM manually\n");
> +
> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
> +	if (rc < 0)
> +		return rc;
> +
> +	tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
> +			      "attempting to start the TPM");
> +	tpm_buf_destroy(&buf);
> +
> +	return rc;
> +}
> +
>   /**
>    * tpm2_auto_startup - Perform the standard automatic TPM initialization
>    *                     sequence
> @@ -954,7 +984,7 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>   {
>   	int rc;
>
> -	rc = tpm_get_timeouts(chip);
> +	rc = tpm2_get_timeouts(chip);
>   	if (rc)
>   		goto out;
>
> @@ -963,7 +993,7 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>   		goto out;
>
>   	if (rc == TPM2_RC_INITIALIZE) {
> -		rc = tpm_startup(chip);
> +		rc = tpm2_startup(chip);
>   		if (rc)
>   			goto out;
>

