Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B126DECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2E32081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2E32081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeKIA2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:28:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbeKIA2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:28:14 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8EkCPY049938
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 09:52:22 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmnum4ebw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 09:52:22 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Thu, 8 Nov 2018 14:52:21 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 14:52:16 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8EqFQf20381832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 14:52:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B22A2B2065;
        Thu,  8 Nov 2018 14:52:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D657B205F;
        Thu,  8 Nov 2018 14:52:15 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 14:52:15 +0000 (GMT)
Subject: Re: [PATCH v5 03/17] tpm: return 0 from pcrs_show() when
 tpm1_pcr_read() fails
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
 <20181108141541.12832-4-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 8 Nov 2018 09:52:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181108141541.12832-4-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18110814-0040-0000-0000-0000048F1F75
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010008; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01114485; UDB=6.00577119; IPR=6.00894584;
 MB=3.00024075; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 14:52:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110814-0041-0000-0000-0000089825AC
Message-Id: <cfc87ece-d69f-3e14-d2bc-c3a9f350b48b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/18 9:15 AM, Jarkko Sakkinen wrote:
> Do not print partial list of PCRs when tpm1_pcr_read() fails but instead
> return 0 from pcrs_show(). This is consistent behavior with other sysfs
> functions.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   drivers/char/tpm/tpm-sysfs.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index 7ed7eb6f906a..928d4e839bb7 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -100,22 +100,21 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
>   {
>   	cap_t cap;
>   	u8 digest[TPM_DIGEST_SIZE];
> -	ssize_t rc;
>   	u32 i, j, num_pcrs;
>   	char *str = buf;
>   	struct tpm_chip *chip = to_tpm_chip(dev);
>
> -	rc = tpm1_getcap(chip, TPM_CAP_PROP_PCR, &cap,
> -			 "attempting to determine the number of PCRS",
> -			 sizeof(cap.num_pcrs));
> -	if (rc)
> +	if (tpm1_getcap(chip, TPM_CAP_PROP_PCR, &cap,
> +			"attempting to determine the number of PCRS",
> +			sizeof(cap.num_pcrs)))
>   		return 0;
>
>   	num_pcrs = be32_to_cpu(cap.num_pcrs);
>   	for (i = 0; i < num_pcrs; i++) {
> -		rc = tpm1_pcr_read(chip, i, digest);
> -		if (rc)
> +		if (tpm1_pcr_read(chip, i, digest)) {
> +			str = buf;
>   			break;
> +		}
>   		str += sprintf(str, "PCR-%02d: ", i);
>   		for (j = 0; j < TPM_DIGEST_SIZE; j++)
>   			str += sprintf(str, "%02X ", digest[j]);


