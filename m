Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 86AD9C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4588E208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4588E208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936015AbeFMO7K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:59:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935703AbeFMO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:59:07 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5DEsA2F054683
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:59:07 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jk2m91ar7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:59:07 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 13 Jun 2018 08:59:06 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Jun 2018 08:59:03 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5DEx2lR52822228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jun 2018 07:59:02 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AFEE6E056;
        Wed, 13 Jun 2018 08:59:02 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22D196E050;
        Wed, 13 Jun 2018 08:59:02 -0600 (MDT)
Received: from [9.41.102.69] (unknown [9.41.102.69])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jun 2018 08:59:02 -0600 (MDT)
Subject: Re: [RFC PATCH 1/5] fsi/scom: Add mutex around FSI2PIB accesses
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        openbmc@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20180612051911.20690-1-benh@kernel.crashing.org>
 <20180612051911.20690-2-benh@kernel.crashing.org>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Wed, 13 Jun 2018 09:59:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612051911.20690-2-benh@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18061314-0020-0000-0000-00000E2D0601
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009183; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01046401; UDB=6.00535906; IPR=6.00825376;
 MB=3.00021625; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-13 14:59:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061314-0021-0000-0000-000061EC392E
Message-Id: <3f347b72-7be0-11a5-67ec-dc773ed96a46@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806130160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 12:19 AM, Benjamin Herrenschmidt wrote:
> Otherwise, multiple clients can open the driver and attempt
> to access the PIB at the same time, thus clobbering each other
> in the process.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Eddie James <eajames@linux.vnet.ibm.com>

> ---
>   drivers/fsi/fsi-scom.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> index c8eb5e5b94a7..3cba0eb645e1 100644
> --- a/drivers/fsi/fsi-scom.c
> +++ b/drivers/fsi/fsi-scom.c
> @@ -37,6 +37,7 @@ struct scom_device {
>   	struct list_head link;
>   	struct fsi_device *fsi_dev;
>   	struct miscdevice mdev;
> +	struct mutex lock;
>   	char	name[32];
>   	int idx;
>   };
> @@ -53,21 +54,26 @@ static int put_scom(struct scom_device *scom_dev, uint64_t value,
>   	int rc;
>   	uint32_t data;
>
> +	mutex_lock(&scom_dev->lock);
> +
>   	data = cpu_to_be32((value >> 32) & 0xffffffff);
>   	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_DATA0_REG, &data,
>   				sizeof(uint32_t));
>   	if (rc)
> -		return rc;
> +		goto bail;
>
>   	data = cpu_to_be32(value & 0xffffffff);
>   	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_DATA1_REG, &data,
>   				sizeof(uint32_t));
>   	if (rc)
> -		return rc;
> +		goto bail;
>
>   	data = cpu_to_be32(SCOM_WRITE_CMD | addr);
> -	return fsi_device_write(scom_dev->fsi_dev, SCOM_CMD_REG, &data,
> +	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_CMD_REG, &data,
>   				sizeof(uint32_t));
> + bail:
> +	mutex_unlock(&scom_dev->lock);
> +	return rc;
>   }
>
>   static int get_scom(struct scom_device *scom_dev, uint64_t *value,
> @@ -76,27 +82,31 @@ static int get_scom(struct scom_device *scom_dev, uint64_t *value,
>   	uint32_t result, data;
>   	int rc;
>
> +
> +	mutex_lock(&scom_dev->lock);
>   	*value = 0ULL;
>   	data = cpu_to_be32(addr);
>   	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_CMD_REG, &data,
>   				sizeof(uint32_t));
>   	if (rc)
> -		return rc;
> +		goto bail;
>
>   	rc = fsi_device_read(scom_dev->fsi_dev, SCOM_DATA0_REG, &result,
>   				sizeof(uint32_t));
>   	if (rc)
> -		return rc;
> +		goto bail;
>
>   	*value |= (uint64_t)cpu_to_be32(result) << 32;
>   	rc = fsi_device_read(scom_dev->fsi_dev, SCOM_DATA1_REG, &result,
>   				sizeof(uint32_t));
>   	if (rc)
> -		return rc;
> +		goto bail;
>
>   	*value |= cpu_to_be32(result);
>
> -	return 0;
> + bail:
> +	mutex_unlock(&scom_dev->lock);
> +	return rc;
>   }
>
>   static ssize_t scom_read(struct file *filep, char __user *buf, size_t len,
> @@ -183,6 +193,7 @@ static int scom_probe(struct device *dev)
>   	if (!scom)
>   		return -ENOMEM;
>
> +	mutex_init(&scom->lock);
>   	scom->idx = ida_simple_get(&scom_ida, 1, INT_MAX, GFP_KERNEL);
>   	snprintf(scom->name, sizeof(scom->name), "scom%d", scom->idx);
>   	scom->fsi_dev = fsi_dev;

