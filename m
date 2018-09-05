Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5870C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD4D206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD4D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeIERqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:46:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725868AbeIERqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:46:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85DEI0o058413
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 09:16:07 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mae68w8f5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 09:16:06 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 09:16:06 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 09:16:02 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85DG1iV22872318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 13:16:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE570B205F;
        Wed,  5 Sep 2018 09:14:48 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7CD8B2064;
        Wed,  5 Sep 2018 09:14:48 -0400 (EDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  5 Sep 2018 09:14:48 -0400 (EDT)
Subject: Re: [PATCH] tpm: fix response size validation in tpm_get_random()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180903011004.12161-1-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
Date:   Wed, 5 Sep 2018 09:16:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180903011004.12161-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18090513-0040-0000-0000-0000046A9A99
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01083898; UDB=6.00559398; IPR=6.00863899;
 MB=3.00023125; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-05 13:16:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090513-0041-0000-0000-00000871BC15
Message-Id: <b3fdb8d4-0e50-389b-86e1-d74761ca325e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2018 09:10 PM, Jarkko Sakkinen wrote:
> When checking whether the response is large enough to be able to contain
> the received random bytes in tpm_get_random() and tpm2_get_random(),
> they fail to take account the header size, which should be added to the
> minimum size. This commit fixes this issue.
>
> Cc: stable@vger.kernel.org
> Fixes: c659af78eb7b ("tpm: Check size of response before accessing data")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/tpm-interface.c | 3 ++-
>   drivers/char/tpm/tpm2-cmd.c      | 4 +++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1a803b0cf980..318a7078b2ba 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -1321,7 +1321,8 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
>   		}
>
>   		rlength = be32_to_cpu(tpm_cmd.header.out.length);
> -		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
> +		if (rlength < TPM_HEADER_SIZE +
> +			      offsetof(struct tpm_getrandom_out, rng_data) +
>   			      recd) {
>   			total = -EFAULT;
>   			break;
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index c31b490bd41d..3acf4fd4e5a5 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -329,7 +329,9 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>   			&buf.data[TPM_HEADER_SIZE];
>   		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
>   		if (tpm_buf_length(&buf) <
> -		    offsetof(struct tpm2_get_random_out, buffer) + recd) {
> +		    TPM_HEADER_SIZE +
> +		    offsetof(struct tpm2_get_random_out, buffer) +
> +		    recd) {
>   			err = -EFAULT;
>   			goto out;
>   		}

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


