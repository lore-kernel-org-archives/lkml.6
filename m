Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1CAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF0221721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBGXhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:37:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbfBGXhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:37:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x17NSphq126110
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 18:37:06 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qgvekn2w9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 18:37:05 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Thu, 7 Feb 2019 23:37:05 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Feb 2019 23:37:01 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x17Nb00B28246100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Feb 2019 23:37:00 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE5B77805E;
        Thu,  7 Feb 2019 23:37:00 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D5627805F;
        Thu,  7 Feb 2019 23:36:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  7 Feb 2019 23:36:59 +0000 (GMT)
Subject: Re: [PATCH v11 08/16] tpm: clean up tpm_try_transmit() error handling
 flow
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
 <20190205224723.19671-9-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 7 Feb 2019 18:36:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190205224723.19671-9-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19020723-0012-0000-0000-00001706CB6A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010556; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157811; UDB=6.00604070; IPR=6.00938342;
 MB=3.00025484; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-07 23:37:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020723-0013-0000-0000-0000561E826A
Message-Id: <5203f941-9516-0e91-7dc7-d5b9892c82ec@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 5:47 PM, Jarkko Sakkinen wrote:
> Move locking, locality handling and power management to tpm_transmit()
> in order to simplify the flow.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>   drivers/char/tpm/tpm-interface.c | 94 +++++++++++++++-----------------
>   drivers/char/tpm/tpm.h           |  1 +
>   drivers/char/tpm/tpm2-space.c    |  2 +-
>   3 files changed, 45 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index c28ffef92f1a..f5f5224f68b0 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -167,7 +167,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
>   	ssize_t len = 0;
>   	u32 count, ordinal;
>   	unsigned long stop;
> -	bool need_locality;
>
>   	rc = tpm_validate_command(chip, space, buf, bufsiz);
>   	if (rc == -EINVAL)
> @@ -197,37 +196,16 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
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
> -		goto out;
> +		return rc;
>
>   	rc = chip->ops->send(chip, buf, count);
>   	if (rc < 0) {
>   		if (rc != -EPIPE)
>   			dev_err(&chip->dev,
>   				"%s: tpm_send: error %d\n", __func__, rc);
> -		goto out;
> +		goto out_rc;
>   	}
>
>   	if (chip->flags & TPM_CHIP_FLAG_IRQ)
> @@ -243,7 +221,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
>   		if (chip->ops->req_canceled(chip, status)) {
>   			dev_err(&chip->dev, "Operation Canceled\n");
>   			rc = -ECANCELED;
> -			goto out;
> +			goto out_rc;
>   		}
>
>   		tpm_msleep(TPM_TIMEOUT_POLL);
> @@ -253,40 +231,20 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
>   	chip->ops->cancel(chip);
>   	dev_err(&chip->dev, "Operation Timed out\n");
>   	rc = -ETIME;
> -	goto out;
> +	goto out_rc;
>
>   out_recv:
>   	len = chip->ops->recv(chip, buf, bufsiz);
>   	if (len < 0) {
>   		rc = len;
> -		dev_err(&chip->dev,
> -			"tpm_transmit: tpm_recv: error %d\n", rc);
> -		goto out;
> -	} else if (len < TPM_HEADER_SIZE) {
> +		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
> +	} else if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
>   		rc = -EFAULT;
> -		goto out;
> -	}


Add an else branch here for 'rc = 0' because it is otherwise set from 
'rc = chip->ops->send(chip, buf, count);'. Or add it further above...


