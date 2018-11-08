Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5A5ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B200620827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B200620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeKIBC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:02:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726860AbeKIBC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:02:26 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8FFKwk113906
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 10:26:25 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmqfxh0g1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 10:26:25 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Thu, 8 Nov 2018 15:26:23 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 15:26:19 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8FQIeA28835860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 15:26:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB926B2064;
        Thu,  8 Nov 2018 15:26:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1D9CB205F;
        Thu,  8 Nov 2018 15:26:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 15:26:18 +0000 (GMT)
Subject: Re: [PATCH v5 13/17] tpm: use tpm_try_get_ops() in tpm-sysfs.c.
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
 <20181108141541.12832-14-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 8 Nov 2018 10:26:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181108141541.12832-14-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18110815-0068-0000-0000-0000035CD6A6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010008; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114497; UDB=6.00577819; IPR=6.00894595;
 MB=3.00024076; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 15:26:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110815-0069-0000-0000-0000465BF5F4
Message-Id: <cece04be-14f0-bbb4-db74-5e286f7b2b48@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/18 9:15 AM, Jarkko Sakkinen wrote:
> Use tpm_try_get_ops() in tpm-sysfs.c so that we can consider moving
> other decorations (locking, localities, power management for example)
> inside it. This direction can be of course taken only after other call
> sites for tpm_transmit() have been treated in the same way.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   drivers/char/tpm/tpm-sysfs.c | 123 ++++++++++++++++++++++-------------
>   1 file changed, 78 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index 03e704f99ed6..3733491671ca 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -39,7 +39,6 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
>   {
>   	struct tpm_buf tpm_buf;
>   	struct tpm_readpubek_out *out;
> -	ssize_t rc;
>   	int i;
>   	char *str = buf;
>   	struct tpm_chip *chip = to_tpm_chip(dev);
> @@ -47,17 +46,17 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
>
>   	memset(&anti_replay, 0, sizeof(anti_replay));
>
> -	if (tpm_buf_init(&tpm_buf, TPM_TAG_RQU_COMMAND, TPM_ORD_READPUBEK))
> +	if (tpm_try_get_ops(chip))
>   		return 0;
>
> +	if (tpm_buf_init(&tpm_buf, TPM_TAG_RQU_COMMAND, TPM_ORD_READPUBEK))
> +		goto out_ops;
> +
>   	tpm_buf_append(&tpm_buf, anti_replay, sizeof(anti_replay));
>
> -	rc = tpm_transmit_cmd(chip, &tpm_buf, READ_PUBEK_RESULT_MIN_BODY_SIZE,
> -			      0, "attempting to read the PUBEK");
> -	if (rc) {
> -		tpm_buf_destroy(&tpm_buf);
> -		return 0;
> -	}
> +	if (tpm_transmit_cmd(chip, &tpm_buf, READ_PUBEK_RESULT_MIN_BODY_SIZE,
> +			      0, "attempting to read the PUBEK"))
> +		goto out_buf;
>
>   	out = (struct tpm_readpubek_out *)&tpm_buf.data[10];
>   	str +=
> @@ -88,9 +87,11 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
>   			str += sprintf(str, "\n");
>   	}
>
> -	rc = str - buf;
> +out_buf:
>   	tpm_buf_destroy(&tpm_buf);
> -	return rc;
> +out_ops:
> +	tpm_put_ops(chip);
> +	return str - buf;
>   }
>   static DEVICE_ATTR_RO(pubek);
>
> @@ -103,10 +104,15 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
>   	char *str = buf;
>   	struct tpm_chip *chip = to_tpm_chip(dev);
>
> +	if (tpm_try_get_ops(chip))
> +		return 0;
> +
>   	if (tpm1_getcap(chip, TPM_CAP_PROP_PCR, &cap,
>   			"attempting to determine the number of PCRS",
> -			sizeof(cap.num_pcrs)))
> +			sizeof(cap.num_pcrs))) {
> +		tpm_put_ops(chip);
>   		return 0;
> +	}
>
>   	num_pcrs = be32_to_cpu(cap.num_pcrs);
>   	for (i = 0; i < num_pcrs; i++) {
> @@ -119,6 +125,7 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
>   			str += sprintf(str, "%02X ", digest[j]);
>   		str += sprintf(str, "\n");
>   	}
> +	tpm_put_ops(chip);
>   	return str - buf;
>   }
>   static DEVICE_ATTR_RO(pcrs);
> @@ -126,16 +133,21 @@ static DEVICE_ATTR_RO(pcrs);
>   static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
>   		     char *buf)
>   {
> +	struct tpm_chip *chip = to_tpm_chip(dev);
> +	ssize_t rc = 0;
>   	cap_t cap;
> -	ssize_t rc;
>
> -	rc = tpm1_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_PERM, &cap,
> -			 "attempting to determine the permanent enabled state",
> -			 sizeof(cap.perm_flags));
> -	if (rc)
> +	if (tpm_try_get_ops(chip))
>   		return 0;
>
> +	if (tpm1_getcap(chip, TPM_CAP_FLAG_PERM, &cap,
> +			"attempting to determine the permanent enabled state",
> +			sizeof(cap.perm_flags)))
> +		goto out_ops;
> +
>   	rc = sprintf(buf, "%d\n", !cap.perm_flags.disable);
> +out_ops:
> +	tpm_put_ops(chip);
>   	return rc;
>   }
>   static DEVICE_ATTR_RO(enabled);
> @@ -143,16 +155,21 @@ static DEVICE_ATTR_RO(enabled);
>   static ssize_t active_show(struct device *dev, struct device_attribute *attr,
>   		    char *buf)
>   {
> +	struct tpm_chip *chip = to_tpm_chip(dev);
> +	ssize_t rc = 0;
>   	cap_t cap;
> -	ssize_t rc;
>
> -	rc = tpm1_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_PERM, &cap,
> -			 "attempting to determine the permanent active state",
> -			 sizeof(cap.perm_flags));
> -	if (rc)
> +	if (tpm_try_get_ops(chip))
>   		return 0;
>
> +	if (tpm1_getcap(chip, TPM_CAP_FLAG_PERM, &cap,
> +			"attempting to determine the permanent active state",
> +			sizeof(cap.perm_flags)))
> +		goto out_ops;
> +
>   	rc = sprintf(buf, "%d\n", !cap.perm_flags.deactivated);
> +out_ops:
> +	tpm_put_ops(chip);
>   	return rc;
>   }
>   static DEVICE_ATTR_RO(active);
> @@ -160,16 +177,21 @@ static DEVICE_ATTR_RO(active);
>   static ssize_t owned_show(struct device *dev, struct device_attribute *attr,
>   			  char *buf)
>   {
> +	struct tpm_chip *chip = to_tpm_chip(dev);
> +	ssize_t rc = 0;
>   	cap_t cap;
> -	ssize_t rc;
>
> -	rc = tpm1_getcap(to_tpm_chip(dev), TPM_CAP_PROP_OWNER, &cap,
> -			 "attempting to determine the owner state",
> -			 sizeof(cap.owned));
> -	if (rc)
> +	if (tpm_try_get_ops(chip))
>   		return 0;
>
> +	if (tpm1_getcap(to_tpm_chip(dev), TPM_CAP_PROP_OWNER, &cap,
> +			"attempting to determine the owner state",
> +			sizeof(cap.owned)))
> +		goto out_ops;
> +
>   	rc = sprintf(buf, "%d\n", cap.owned);
> +out_ops:
> +	tpm_put_ops(chip);
>   	return rc;
>   }
>   static DEVICE_ATTR_RO(owned);
> @@ -177,16 +199,21 @@ static DEVICE_ATTR_RO(owned);
>   static ssize_t temp_deactivated_show(struct device *dev,
>   				     struct device_attribute *attr, char *buf)
>   {
> +	struct tpm_chip *chip = to_tpm_chip(dev);
> +	ssize_t rc = 0;
>   	cap_t cap;
> -	ssize_t rc;
>
> -	rc = tpm1_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_VOL, &cap,
> -			 "attempting to determine the temporary state",
> -			 sizeof(cap.stclear_flags));
> -	if (rc)
> +	if (tpm_try_get_ops(chip))
>   		return 0;
>
> +	if (tpm1_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_VOL, &cap,
> +			"attempting to determine the temporary state",
> +			sizeof(cap.stclear_flags)))
> +		goto out_ops;
> +
>   	rc = sprintf(buf, "%d\n", cap.stclear_flags.deactivated);
> +out_ops:
> +	tpm_put_ops(chip);
>   	return rc;
>   }
>   static DEVICE_ATTR_RO(temp_deactivated);
> @@ -195,15 +222,18 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
>   			 char *buf)
>   {
>   	struct tpm_chip *chip = to_tpm_chip(dev);
> -	cap_t cap;
> -	ssize_t rc;
> +	ssize_t rc = 0;
>   	char *str = buf;
> +	cap_t cap;
>
> -	rc = tpm1_getcap(chip, TPM_CAP_PROP_MANUFACTURER, &cap,
> -			 "attempting to determine the manufacturer",
> -			 sizeof(cap.manufacturer_id));
> -	if (rc)
> +	if (tpm_try_get_ops(chip))
>   		return 0;
> +
> +	if (tpm1_getcap(chip, TPM_CAP_PROP_MANUFACTURER, &cap,
> +			"attempting to determine the manufacturer",
> +			sizeof(cap.manufacturer_id)))
> +		goto out_ops;
> +
>   	str += sprintf(str, "Manufacturer: 0x%x\n",
>   		       be32_to_cpu(cap.manufacturer_id));
>
> @@ -220,11 +250,10 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
>   			       cap.tpm_version_1_2.revMinor);
>   	} else {
>   		/* Otherwise just use TPM_STRUCT_VER */
> -		rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
> -				 "attempting to determine the 1.1 version",
> -				 sizeof(cap.tpm_version));
> -		if (rc)
> -			return 0;
> +		if (tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
> +				"attempting to determine the 1.1 version",
> +				sizeof(cap.tpm_version)))
> +			goto out_ops;
>   		str += sprintf(str,
>   			       "TCG version: %d.%d\nFirmware version: %d.%d\n",
>   			       cap.tpm_version.Major,
> @@ -232,8 +261,10 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
>   			       cap.tpm_version.revMajor,
>   			       cap.tpm_version.revMinor);
>   	}
> -
> -	return str - buf;
> +	rc = str - buf;
> +out_ops:
> +	tpm_put_ops(chip);
> +	return rc;
>   }
>   static DEVICE_ATTR_RO(caps);
>
> @@ -241,10 +272,12 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
>   			    const char *buf, size_t count)
>   {
>   	struct tpm_chip *chip = to_tpm_chip(dev);
> -	if (chip == NULL)
> +
> +	if (tpm_try_get_ops(chip))
>   		return 0;
>
>   	chip->ops->cancel(chip);
> +	tpm_put_ops(chip);
>   	return count;
>   }
>   static DEVICE_ATTR_WO(cancel);


