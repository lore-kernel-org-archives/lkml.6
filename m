Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4D5C04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A4D2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A4D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390216AbeKQDTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:19:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728628AbeKQDTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:19:32 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAGGxDub065277
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 12:06:20 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nt0qm3mxh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 12:06:19 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Fri, 16 Nov 2018 17:06:18 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Nov 2018 17:06:15 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAGH6E6S27394268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Nov 2018 17:06:14 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28AA3AC060;
        Fri, 16 Nov 2018 17:06:14 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01797AC05E;
        Fri, 16 Nov 2018 17:06:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Nov 2018 17:06:13 +0000 (GMT)
Subject: Re: [PATCH v8 11/17] tpm: move TPM space code out of tpm_transmit()
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
References: <20181116123845.15705-1-jarkko.sakkinen@linux.intel.com>
 <20181116123845.15705-12-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 16 Nov 2018 12:06:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181116123845.15705-12-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18111617-0052-0000-0000-000003575764
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010062; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01118356; UDB=6.00580141; IPR=6.00898465;
 MB=3.00024196; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-16 17:06:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111617-0053-0000-0000-00005EC91A52
Message-Id: <3c344e37-e256-0dee-4751-e58c598dd76c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/18 7:38 AM, Jarkko Sakkinen wrote:
> Prepare and commit TPM space before and after calling tpm_transmit()
> instead of doing that inside tpm_transmit(). After this change we can
> remove TPM_TRANSMIT_NESTED flag from tpm2_prepare_space() and
> tpm2_commit_space() and replace it with TPM_TRANSMIT_UNLOCKED.
>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   drivers/char/tpm/tpm-dev-common.c | 30 ++++++++++++++++++++++++++----
>   drivers/char/tpm/tpm-interface.c  | 29 +++--------------------------
>   drivers/char/tpm/tpm2-space.c     | 12 ++++++------
>   3 files changed, 35 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index cbb0ee30b511..40c1cb09ebd2 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -30,13 +30,35 @@ static DEFINE_MUTEX(tpm_dev_wq_lock);
>   static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
>   				u8 *buf, size_t bufsiz)
>   {
> -	ssize_t ret;
> +	struct tpm_header *header = (void *)buf;
> +	ssize_t ret, len;
>
>   	mutex_lock(&chip->tpm_mutex);
> -	ret = tpm_transmit(chip, space, buf, bufsiz, TPM_TRANSMIT_UNLOCKED);
> -	mutex_unlock(&chip->tpm_mutex);
> +	ret = tpm2_prepare_space(chip, space, buf, bufsiz);
> +	/* If the command is not implemented by the TPM, synthesize a
> +	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
> +	 */
> +	if (ret == -EOPNOTSUPP) {
> +		header->length = cpu_to_be32(sizeof(*header));
> +		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> +		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
> +						  TSS2_RESMGR_TPM_RC_LAYER);
> +		ret = sizeof(*header);
> +	}
> +	if (ret)
> +		goto out_lock;
>
> -	return ret;
> +	len = tpm_transmit(chip, space, buf, bufsiz, TPM_TRANSMIT_UNLOCKED);
> +	if (len < 0)
> +		ret = len;
> +
> +	if (ret)
> +		tpm2_flush_space(chip);
> +	else
> +		ret = tpm2_commit_space(chip, space, buf, &len);
> +out_lock:
> +	mutex_unlock(&chip->tpm_mutex);
> +	return ret ? ret : len;
>   }
>
>   static void tpm_dev_async_work(struct work_struct *work)
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index a6ffd0960ae5..7bec03e46043 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -147,27 +147,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>   		return -E2BIG;
>   	}
>
> -	rc = tpm2_prepare_space(chip, space, buf, bufsiz);
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
> -	if (rc)
> -		return rc;
> -
>   	rc = chip->ops->send(chip, buf, count);
>   	if (rc < 0) {
>   		if (rc != -EPIPE)
>   			dev_err(&chip->dev,
>   				"%s: tpm_send: error %d\n", __func__, rc);
> -		goto out_space;
> +		return rc;
>   	}
>
>   	if (chip->flags & TPM_CHIP_FLAG_IRQ)
> @@ -182,8 +167,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>
>   		if (chip->ops->req_canceled(chip, status)) {
>   			dev_err(&chip->dev, "Operation Canceled\n");
> -			rc = -ECANCELED;
> -			goto out_space;
> +			return -ECANCELED;
>   		}
>
>   		tpm_msleep(TPM_TIMEOUT_POLL);
> @@ -192,8 +176,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>
>   	chip->ops->cancel(chip);
>   	dev_err(&chip->dev, "Operation Timed out\n");
> -	rc = -ETIME;
> -	goto out_space;
> +	return -ETIME;
>
>   out_recv:
>   	len = chip->ops->recv(chip, buf, bufsiz);
> @@ -203,12 +186,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>   	} else if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
>   		rc = -EFAULT;
>
> -out_space:
> -	if (rc)
> -		tpm2_flush_space(chip);
> -	else
> -		rc = tpm2_commit_space(chip, space, buf, &len);
> -
>   	return rc ? rc : len;
>   }
>
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 172c9f9d4c29..995c8b963d65 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -39,7 +39,7 @@ static void tpm2_flush_sessions(struct tpm_chip *chip, struct tpm_space *space)
>   	for (i = 0; i < ARRAY_SIZE(space->session_tbl); i++) {
>   		if (space->session_tbl[i])
>   			tpm2_flush_context_cmd(chip, space->session_tbl[i],
> -					       TPM_TRANSMIT_NESTED);
> +					       TPM_TRANSMIT_UNLOCKED);
>   	}
>   }
>
> @@ -84,7 +84,7 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
>   	tpm_buf_append(&tbuf, &buf[*offset], body_size);
>
>   	rc = tpm_transmit_cmd(chip, NULL, &tbuf, 4,
> -			      TPM_TRANSMIT_NESTED, NULL);
> +			      TPM_TRANSMIT_UNLOCKED, NULL);
>   	if (rc < 0) {
>   		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
>   			 __func__, rc);
> @@ -133,7 +133,7 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
>   	tpm_buf_append_u32(&tbuf, handle);
>
>   	rc = tpm_transmit_cmd(chip, NULL, &tbuf, 0,
> -			      TPM_TRANSMIT_NESTED, NULL);
> +			      TPM_TRANSMIT_UNLOCKED, NULL);
>   	if (rc < 0) {
>   		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
>   			 __func__, rc);
> @@ -170,7 +170,7 @@ void tpm2_flush_space(struct tpm_chip *chip)
>   	for (i = 0; i < ARRAY_SIZE(space->context_tbl); i++)
>   		if (space->context_tbl[i] && ~space->context_tbl[i])
>   			tpm2_flush_context_cmd(chip, space->context_tbl[i],
> -					       TPM_TRANSMIT_NESTED);
> +					       TPM_TRANSMIT_UNLOCKED);
>
>   	tpm2_flush_sessions(chip, space);
>   }
> @@ -419,7 +419,7 @@ static int tpm2_map_response_header(struct tpm_chip *chip, u32 cc, u8 *rsp,
>
>   	return 0;
>   out_no_slots:
> -	tpm2_flush_context_cmd(chip, phandle, TPM_TRANSMIT_NESTED);
> +	tpm2_flush_context_cmd(chip, phandle, TPM_TRANSMIT_UNLOCKED);
>   	dev_warn(&chip->dev, "%s: out of slots for 0x%08X\n", __func__,
>   		 phandle);
>   	return -ENOMEM;
> @@ -507,7 +507,7 @@ static int tpm2_save_space(struct tpm_chip *chip)
>   			return rc;
>
>   		tpm2_flush_context_cmd(chip, space->context_tbl[i],
> -				       TPM_TRANSMIT_NESTED);
> +				       TPM_TRANSMIT_UNLOCKED);
>   		space->context_tbl[i] = ~0;
>   	}
>

