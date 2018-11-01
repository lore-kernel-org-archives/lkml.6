Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52125C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D002081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D002081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeKBB4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:56:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727561AbeKBB4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:56:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA1GmpBv115070
        for <linux-kernel@vger.kernel.org>; Thu, 1 Nov 2018 12:52:27 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ng5at8687-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:52:26 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 1 Nov 2018 16:52:25 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Nov 2018 16:52:23 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA1GqMfa52166768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 16:52:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BBCD4C044;
        Thu,  1 Nov 2018 16:52:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B65A4C058;
        Thu,  1 Nov 2018 16:52:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.26])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Nov 2018 16:52:21 +0000 (GMT)
Subject: Re: [PATCH v3 5/5] tpm: ensure that output of PCR read contains the
 correct digest size
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Thu, 01 Nov 2018 12:52:10 -0400
In-Reply-To: <20181030154711.2782-6-roberto.sassu@huawei.com>
References: <20181030154711.2782-1-roberto.sassu@huawei.com>
         <20181030154711.2782-6-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18110116-0016-0000-0000-0000021DB450
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110116-0017-0000-0000-00003275E5CE
Message-Id: <1541091130.4035.41.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811010143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-30 at 16:47 +0100, Roberto Sassu wrote:
> This patch ensures that the digest size returned by the TPM during a PCR
> read matches the size of the algorithm passed as argument to
> tpm2_pcr_read(). The check is performed after information about the PCR
> banks has been retrieved.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 8e821e7b4674..477dcc30fc53 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -187,15 +187,28 @@ struct tpm2_pcr_read_out {
>  int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
>  		  struct tpm_digest *digest_struct, u16 *digest_size_ptr)
>  {
> +	int i;
>  	int rc;
>  	struct tpm_buf buf;
>  	struct tpm2_pcr_read_out *out;
>  	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
>  	u16 digest_size;
> +	u16 expected_digest_size = 0;
>  
>  	if (pcr_idx >= TPM2_PLATFORM_PCR)
>  		return -EINVAL;
>  
> +	if (!digest_size_ptr) {
> +		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
> +		     chip->active_banks[i].alg_id != digest_struct->alg_id; i++)
> +			;
> +
> +		if (i == ARRAY_SIZE(chip->active_banks))
> +			return -EINVAL;
> +
> +		expected_digest_size = chip->active_banks[i].digest_size;
> +	}
> +
>  	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
>  	if (rc)
>  		return rc;
> @@ -215,7 +228,8 @@ int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
>  
>  	out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
>  	digest_size = be16_to_cpu(out->digest_size);
> -	if (digest_size > sizeof(digest_struct->digest)) {
> +	if ((digest_size_ptr && digest_size > sizeof(digest_struct->digest)) ||

The returned digest size should never be larger than the structure
field.  The digest_size_ptr test is unnecessary.

Mimi

> +	    (!digest_size_ptr && digest_size != expected_digest_size)) {
>  		rc = -EINVAL;
>  		goto out;
>  	}

