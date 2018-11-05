Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA0EC46465
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8117F2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8117F2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388113AbeKFHXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:23:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387441AbeKFHXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:23:41 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA5LxF01011584
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 17:01:52 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2njvwvukgj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 17:01:51 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Mon, 5 Nov 2018 22:01:51 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 5 Nov 2018 22:01:47 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA5M1kXY44302474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Nov 2018 22:01:46 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D2D9124058;
        Mon,  5 Nov 2018 22:01:46 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 435FF124052;
        Mon,  5 Nov 2018 22:01:46 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  5 Nov 2018 22:01:46 +0000 (GMT)
Subject: Re: [PATCH v3 04/16] tpm: call tpm2_flush_space() on error in
 tpm_try_transmit()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181105014552.20262-1-jarkko.sakkinen@linux.intel.com>
 <20181105014552.20262-5-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 5 Nov 2018 17:01:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181105014552.20262-5-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18110522-2213-0000-0000-00000311C489
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009993; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113190; UDB=6.00577034; IPR=6.00893289;
 MB=3.00024037; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-05 22:01:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110522-2214-0000-0000-00005C2680F2
Message-Id: <c7d48e87-1660-b47b-0dfd-b5daabd1777f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/18 8:45 PM, Jarkko Sakkinen wrote:
> Always call tpm2_flush_space() on failure in tpm_try_transmit() so that
> the volatile memory of the TPM gets cleared. If /dev/tpm0 does not have
> sufficient permissions (usually it has), this could leak to the leakage

leak ->lead


> of TPM objects. Through /dev/tpmrm0 this issue does not raise new
> security concerns.
>
> Cc: stable@vger.kernel.org
> Fixes: 745b361e989a ("tpm:tpm: infrastructure for TPM spaces")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/tpm-interface.c | 28 +++++++++++++++++-----------
>   drivers/char/tpm/tpm.h           |  1 +
>   drivers/char/tpm/tpm2-space.c    |  2 +-
>   3 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 64510ed81b46..ecda6f96cde0 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -224,14 +224,14 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>
>   	rc = tpm2_prepare_space(chip, space, ordinal, buf);
>   	if (rc)
> -		goto out;
> +		goto out_idle;
>
>   	rc = chip->ops->send(chip, buf, count);
>   	if (rc < 0) {
>   		if (rc != -EPIPE)
>   			dev_err(&chip->dev,
>   				"%s: tpm_send: error %d\n", __func__, rc);
> -		goto out;
> +		goto out_space;
>   	}
>
>   	if (chip->flags & TPM_CHIP_FLAG_IRQ)
> @@ -247,7 +247,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>   		if (chip->ops->req_canceled(chip, status)) {
>   			dev_err(&chip->dev, "Operation Canceled\n");
>   			rc = -ECANCELED;
> -			goto out;
> +			goto out_space;
>   		}
>
>   		tpm_msleep(TPM_TIMEOUT_POLL);
> @@ -257,7 +257,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>   	chip->ops->cancel(chip);
>   	dev_err(&chip->dev, "Operation Timed out\n");
>   	rc = -ETIME;
> -	goto out;
> +	goto out_space;
>
>   out_recv:
>   	len = chip->ops->recv(chip, buf, bufsiz);
> @@ -265,22 +265,28 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>   		rc = len;
>   		dev_err(&chip->dev,
>   			"tpm_transmit: tpm_recv: error %d\n", rc);
> -		goto out;
> +		goto out_idle;

Why not jump to out_space here and in 2 instances below?


>   	} else if (len < TPM_HEADER_SIZE) {
>   		rc = -EFAULT;
> -		goto out;
> +		goto out_idle;
>   	}
>
>   	if (len != be32_to_cpu(header->length)) {
>   		rc = -EFAULT;
> -		goto out;
> +		goto out_idle;
>   	}
>
> -	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> -	if (rc)
> -		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
> +out_space:
> +	if (rc) {
> +		tpm2_flush_space(chip);
> +	} else {
> +		rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> +		if (rc)
> +			dev_err(&chip->dev, "tpm2_commit_space: error %d\n",
> +				rc);
> +	}
>
> -out:
> +out_idle:
>   	/* may fail but do not override previous error value in rc */
>   	tpm_go_idle(chip, flags);
>
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 49bca4d1e786..229ac42b644e 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -579,6 +579,7 @@ int tpm2_probe(struct tpm_chip *chip);
>   int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
>   int tpm2_init_space(struct tpm_space *space);
>   void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
> +void tpm2_flush_space(struct tpm_chip *chip);
>   int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
>   		       u8 *cmd);
>   int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 1131a8e7b79b..d53c882268ff 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -162,7 +162,7 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
>   	return 0;
>   }
>
> -static void tpm2_flush_space(struct tpm_chip *chip)
> +void tpm2_flush_space(struct tpm_chip *chip)
>   {
>   	struct tpm_space *space = &chip->work_space;
>   	int i;


