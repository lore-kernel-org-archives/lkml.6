Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57CDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA59F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA59F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeJLRGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:06:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728145AbeJLRGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:06:07 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9C9YSNx057422
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 05:34:33 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n2rmw967h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 05:34:33 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Fri, 12 Oct 2018 05:34:32 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Oct 2018 05:34:29 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9C9YSFF26083500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Oct 2018 09:34:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4BE0B2066;
        Fri, 12 Oct 2018 05:32:27 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1A3DB205F;
        Fri, 12 Oct 2018 05:32:25 -0400 (EDT)
Received: from [9.124.31.41] (unknown [9.124.31.41])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 12 Oct 2018 05:32:25 -0400 (EDT)
Subject: Re: [PATCH v5 06/21] tpm: move tpm1_pcr_extend to tpm1-cmd.c
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-7-tomas.winkler@intel.com>
From:   Nayna Jain <nayna@linux.ibm.com>
Date:   Fri, 12 Oct 2018 15:01:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180928223035.14471-7-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18101209-0068-0000-0000-0000034C11D8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009865; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01101513; UDB=6.00569998; IPR=6.00881558;
 MB=3.00023726; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-12 09:34:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101209-0069-0000-0000-0000460B88D7
Message-Id: <24b611f6-8080-3f99-56e5-818bd16ef4f8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810120097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/29/2018 04:00 AM, Tomas Winkler wrote:
> Move tpm1_pcr_extend to tpm1-cmd.c and remove
> unused pcrextend_header structure and
> EXTEND_PCR_RESULT_SIZE and EXTEND_PCR_RESULT_BODY_SIZE
> defines.
>
> Fixes warning:
> drivers/char/tpm/tpm-interface.c:609:38: warning: ‘pcrextend_header’ defined but not used [-Wunused-const-variable=]
>   static const struct tpm_input_header pcrextend_header = {
>                                        ^~~~~~~~~~~~~~~~
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>
> V2-V3: Rebase
> V4: Remove defines.
> V5: Resend.
>
>   drivers/char/tpm/tpm-interface.c | 28 ----------------------------
>   drivers/char/tpm/tpm.h           |  2 ++
>   drivers/char/tpm/tpm1-cmd.c      | 21 +++++++++++++++++++++
>   3 files changed, 23 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1fa0300f3829..ac73e6ac3d83 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -614,34 +614,6 @@ int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
>   }
>   EXPORT_SYMBOL_GPL(tpm_pcr_read);
>
> -#define TPM_ORD_PCR_EXTEND 20
> -#define EXTEND_PCR_RESULT_SIZE 34
> -#define EXTEND_PCR_RESULT_BODY_SIZE 20
> -static const struct tpm_input_header pcrextend_header = {
> -	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
> -	.length = cpu_to_be32(34),
> -	.ordinal = cpu_to_be32(TPM_ORD_PCR_EXTEND)
> -};
> -
> -static int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
> -			   char *log_msg)
> -{
> -	struct tpm_buf buf;
> -	int rc;
> -
> -	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
> -	if (rc)
> -		return rc;
> -
> -	tpm_buf_append_u32(&buf, pcr_idx);
> -	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
> -
> -	rc = tpm_transmit_cmd(chip, NULL, buf.data, EXTEND_PCR_RESULT_SIZE,
> -			      EXTEND_PCR_RESULT_BODY_SIZE, 0, log_msg);
> -	tpm_buf_destroy(&buf);
> -	return rc;
> -}
> -
>   /**
>    * tpm_pcr_extend - extend a PCR value in SHA1 bank.
>    * @chip:	a &struct tpm_chip instance, %NULL for the default chip
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index a97d72fcda5b..3fb268f43955 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -549,6 +549,8 @@ int tpm_do_selftest(struct tpm_chip *chip);
>   int tpm1_auto_startup(struct tpm_chip *chip);
>   int tpm1_get_timeouts(struct tpm_chip *chip);
>   unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> +int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
> +		    const char *log_msg);
>   unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>   int tpm_pm_suspend(struct device *dev);
>   int tpm_pm_resume(struct device *dev);
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 978946748ea3..ec242397e6dc 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -413,3 +413,24 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
>   	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
>   	return 0;
>   }
> +
> +#define TPM_ORD_PCR_EXTEND 20
> +int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
> +		    const char *log_msg)
> +{
> +	struct tpm_buf buf;
> +	int rc;
> +
> +	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
> +	if (rc)
> +		return rc;
> +
> +	tpm_buf_append_u32(&buf, pcr_idx);
> +	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
> +
> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
> +			      TPM_DIGEST_SIZE, 0, log_msg);
> +
> +	tpm_buf_destroy(&buf);
> +	return rc;
> +}


Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: Nayna Jain <nayna@linux.ibm.com>

Sorry for bit delay in testing.

Thanks & Regards,
    - Nayna




