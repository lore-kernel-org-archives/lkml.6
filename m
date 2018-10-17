Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21595ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB0F21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB0F21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeJQTxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:53:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbeJQTxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:53:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9HBnVD9100282
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:57:48 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n638dus1c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:57:48 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Wed, 17 Oct 2018 07:57:47 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Oct 2018 07:57:42 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9HBvfvw46137520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Oct 2018 11:57:41 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D6A8AC059;
        Wed, 17 Oct 2018 11:57:41 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79209AC05B;
        Wed, 17 Oct 2018 11:57:38 +0000 (GMT)
Received: from [9.79.213.117] (unknown [9.79.213.117])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 17 Oct 2018 11:57:38 +0000 (GMT)
Subject: Re: [PATCH v6 03/20] tpm: factor out tpm 1.x duration calculation to
 tpm1-cmd.c
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181017064613.19746-1-tomas.winkler@intel.com>
 <20181017064613.19746-4-tomas.winkler@intel.com>
From:   Nayna Jain <nayna@linux.ibm.com>
Date:   Wed, 17 Oct 2018 17:24:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181017064613.19746-4-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18101711-0072-0000-0000-000003B712FE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009891; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01103954; UDB=6.00571464; IPR=6.00884006;
 MB=3.00023791; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-17 11:57:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101711-0073-0000-0000-000049C96131
Message-Id: <05fea3e6-91a3-b508-83c0-d8f06d6bbd5c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810170105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2018 12:15 PM, Tomas Winkler wrote:
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index caa86b19c76d..5d20e98b844f 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -370,6 +370,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
>   	struct i2c_client *client = to_i2c_client(dev);
>   	u32 ordinal;
>   	size_t count = 0;
> +	unsigned long duration;
>   	int burst_count, bytes2write, retries, rc = -EIO;
>
>   	for (retries = 0; retries < TPM_RETRY; retries++) {
> @@ -455,12 +456,11 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
>   		return rc;
>   	}
>   	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
> -	rc = i2c_nuvoton_wait_for_data_avail(chip,
> -					     tpm_calc_ordinal_duration(chip,
> -								       ordinal),
> -					     &priv->read_queue);
> +	duration = tpm1_calc_ordinal_duration(chip, ordinal);


This version of the patch didn't address my previous comment -
"The original code in the nuvoton driver does not differentiate between 
TPM 1.2 and TPM 2.0 as it does in tpm_tis_core.c.
Before making any changes, I would first fix it, so that it could easily 
be backported. Only then do the refactoring."

Thanks & Regards,
    - Nayna


> +	rc = i2c_nuvoton_wait_for_data_avail(chip, duration, &priv->read_queue);
>   	if (rc) {
> -		dev_err(dev, "%s() timeout command duration\n", __func__);
> +		dev_err(dev, "%s() timeout command duration %ld\n",
> +			__func__, duration);
>   		i2c_nuvoton_ready(chip);
>   		return rc;
>   	}
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index d2345d9fd7b5..14c332104de4 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -476,7 +476,7 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>   		if (chip->flags & TPM_CHIP_FLAG_TPM2)
>   			dur = tpm2_calc_ordinal_duration(chip, ordinal);
>   		else
> -			dur = tpm_calc_ordinal_duration(chip, ordinal);
> +			dur = tpm1_calc_ordinal_duration(chip, ordinal);
>
>   		if (wait_for_tpm_stat
>   		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
> index b150f87f38f5..77097229bf49 100644
> --- a/drivers/char/tpm/xen-tpmfront.c
> +++ b/drivers/char/tpm/xen-tpmfront.c
> @@ -164,7 +164,7 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>   	notify_remote_via_evtchn(priv->evtchn);
>
>   	ordinal = be32_to_cpu(((struct tpm_input_header*)buf)->ordinal);
> -	duration = tpm_calc_ordinal_duration(chip, ordinal);
> +	duration = tpm1_calc_ordinal_duration(chip, ordinal);
>
>   	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, duration,
>   			&priv->read_queue, true) < 0) {

