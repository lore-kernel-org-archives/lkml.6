Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE2AECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783E22081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783E22081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeKIAf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:35:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45553 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbeKIAf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:35:56 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8ExMwC060318
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 10:00:03 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmqb1g71b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 10:00:02 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Thu, 8 Nov 2018 15:00:01 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 14:59:57 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8ExuXL46137436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 14:59:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E8E2B2064;
        Thu,  8 Nov 2018 14:59:56 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED8A9B205F;
        Thu,  8 Nov 2018 14:59:55 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 14:59:55 +0000 (GMT)
Subject: Re: [PATCH v5 06/17] tpm: clean up tpm_try_transmit() error handling
 flow
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
References: <20181108141541.12832-1-jarkko.sakkinen@linux.intel.com>
 <20181108141541.12832-7-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 8 Nov 2018 09:59:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181108141541.12832-7-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18110814-0040-0000-0000-0000048F2079
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010008; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114488; UDB=6.00577119; IPR=6.00894587;
 MB=3.00024076; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 14:59:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110814-0041-0000-0000-0000089826B4
Message-Id: <8eb47b50-d94f-b7dd-f500-83640d88f427@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/18 9:15 AM, Jarkko Sakkinen wrote:
> Move locking, locality handling and power management to tpm_transmit()
> in order to simplify the flow.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   drivers/char/tpm/tpm-interface.c | 71 ++++++++++++++++----------------
>   1 file changed, 35 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 7ffb16edab6f..28d48799b044 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -171,7 +171,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>   	ssize_t len = 0;
>   	u32 count, ordinal;
>   	unsigned long stop;
> -	bool need_locality;
>
>   	rc = tpm_validate_command(chip, space, buf, bufsiz);
>   	if (rc == -EINVAL)
> @@ -201,30 +200,9 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>   		return -E2BIG;
>   	}
>
> -	if (!(flags & TPM_TRANSMIT_UNLOCKED) && !(flags & TPM_TRANSMIT_NESTED))
> -		mutex_lock(&chip->tpm_mutex);
> -
> -	if (chip->ops->clk_enable != NULL)
> -		chip->ops->clk_enable(chip, true);
> -
> -	/* Store the decision as chip->locality will be changed. */
> -	need_locality = chip->locality == -1;
> -
> -	if (need_locality) {
> -		rc = tpm_request_locality(chip, flags);
> -		if (rc < 0) {
> -			need_locality = false;
> -			goto out_locality;
> -		}
> -	}
> -
> -	rc = tpm_cmd_ready(chip, flags);
> -	if (rc)
> -		goto out_locality;
> -
>   	rc = tpm2_prepare_space(chip, space, ordinal, buf);
>   	if (rc)
> -		goto out_idle;
> +		return rc;
>
>   	rc = chip->ops->send(chip, buf, count);
>   	if (rc < 0) {
> @@ -273,19 +251,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>   	else
>   		rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
>
> -out_idle:
> -	/* may fail but do not override previous error value in rc */
> -	tpm_go_idle(chip, flags);
> -
> -out_locality:
> -	if (need_locality)
> -		tpm_relinquish_locality(chip, flags);
> -
> -	if (chip->ops->clk_enable != NULL)
> -		chip->ops->clk_enable(chip, false);
> -
> -	if (!(flags & TPM_TRANSMIT_UNLOCKED) && !(flags & TPM_TRANSMIT_NESTED))
> -		mutex_unlock(&chip->tpm_mutex);
>   	return rc ? rc : len;
>   }
>
> @@ -315,6 +280,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>   	/* space for header and handles */
>   	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
>   	unsigned int delay_msec = TPM2_DURATION_SHORT;
> +	bool has_locality = false;
>   	u32 rc = 0;
>   	ssize_t ret;
>   	const size_t save_size = min(space ? sizeof(save) : TPM_HEADER_SIZE,
> @@ -330,7 +296,40 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>   	memcpy(save, buf, save_size);
>
>   	for (;;) {
> +		if (!(flags & TPM_TRANSMIT_UNLOCKED) &&
> +		    !(flags & TPM_TRANSMIT_NESTED))
> +			mutex_lock(&chip->tpm_mutex);
> +
> +		if (chip->ops->clk_enable != NULL)
> +			chip->ops->clk_enable(chip, true);
> +
> +		if (chip->locality == -1) {
> +			ret = tpm_request_locality(chip, flags);
> +			if (ret)
> +				goto out_locality;
> +			has_locality = true;
> +		}
> +
> +		ret = tpm_cmd_ready(chip, flags);
> +		if (ret)
> +			goto out_locality;
> +
>   		ret = tpm_try_transmit(chip, space, buf, bufsiz, flags);
> +
> +		/* This may fail but do not override ret. */
> +		tpm_go_idle(chip, flags);
> +
> +out_locality:
> +		if (has_locality)
> +			tpm_relinquish_locality(chip, flags);
> +
> +		if (chip->ops->clk_enable != NULL)
> +			chip->ops->clk_enable(chip, false);
> +
> +		if (!(flags & TPM_TRANSMIT_UNLOCKED) &&
> +		    !(flags & TPM_TRANSMIT_NESTED))
> +			mutex_unlock(&chip->tpm_mutex);
> +
>   		if (ret < 0)
>   			break;
>   		rc = be32_to_cpu(header->return_code);


