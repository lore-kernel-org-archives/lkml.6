Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09695C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89A321480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89A321480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbeIYQdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:33:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727075AbeIYQdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:33:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PAODcW047673
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 06:26:57 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mqjf4j8jk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 06:26:57 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 25 Sep 2018 04:26:56 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 04:26:54 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PAQrJh52035670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 03:26:53 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33B40136055;
        Tue, 25 Sep 2018 04:26:53 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7BF5136053;
        Tue, 25 Sep 2018 04:26:50 -0600 (MDT)
Received: from [9.124.31.41] (unknown [9.124.31.41])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 Sep 2018 04:26:50 -0600 (MDT)
Subject: Re: [PATCH v4 20/21] tpm1: reimplement tpm1_continue_selftest() using
 tpm_buf
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180921135820.20549-1-tomas.winkler@intel.com>
 <20180921135820.20549-21-tomas.winkler@intel.com>
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
Date:   Tue, 25 Sep 2018 15:53:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180921135820.20549-21-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18092510-0004-0000-0000-00001491526F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009768; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093385; UDB=6.00565112; IPR=6.00873422;
 MB=3.00023495; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-25 10:26:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092510-0005-0000-0000-000088EEAAC4
Message-Id: <5f142a3b-15b8-368b-19e5-5926b20addfd@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809250108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/21/2018 07:28 PM, Tomas Winkler wrote:
> Reimplement tpm1_continue_selftest() using tpm_buf structure.
> This is the last command using the old tpm_cmd_t structure
> and now the structure can be removed.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> V3: New in the series.
> V4: Resend.
>
>   drivers/char/tpm/tpm.h      |  9 ---------
>   drivers/char/tpm/tpm1-cmd.c | 21 ++++++++++-----------
>   2 files changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2f06740f993d..7ada00f067f1 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -377,15 +377,6 @@ enum tpm_sub_capabilities {
>   	TPM_CAP_PROP_TIS_DURATION = 0x120,
>   };
>
> -typedef union {
> -	struct	tpm_input_header in;
> -	struct	tpm_output_header out;
> -} tpm_cmd_header;
> -
> -struct tpm_cmd_t {
> -	tpm_cmd_header	header;
> -} __packed;
> -
>
>   /* 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
>    * bytes, but 128 is still a relatively large number of random bytes and
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index cde9a01ad31f..6d7d70b0d130 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -604,15 +604,8 @@ int tpm1_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
>   }
>
>   #define TPM_ORD_CONTINUE_SELFTEST 83
> -#define CONTINUE_SELFTEST_RESULT_SIZE 10
> -static const struct tpm_input_header continue_selftest_header = {
> -	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
> -	.length = cpu_to_be32(10),
> -	.ordinal = cpu_to_be32(TPM_ORD_CONTINUE_SELFTEST),
> -};
> -
>   /**
> - * tpm_continue_selftest -- run TPM's selftest
> + * tpm_continue_selftest() - run TPM's selftest
>    * @chip: TPM chip to use
>    *
>    * Returns 0 on success, < 0 in case of fatal error or a value > 0 representing
> @@ -620,12 +613,18 @@ static const struct tpm_input_header continue_selftest_header = {
>    */
>   static int tpm1_continue_selftest(struct tpm_chip *chip)
>   {
> +	struct tpm_buf buf;
>   	int rc;
> -	struct tpm_cmd_t cmd;
>
> -	cmd.header.in = continue_selftest_header;
> -	rc = tpm_transmit_cmd(chip, NULL, &cmd, CONTINUE_SELFTEST_RESULT_SIZE,
> +	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_CONTINUE_SELFTEST);
> +	if (rc)
> +		return rc;
> +
> +	rc = tpm_transmit_cmd(chip, NULL, &buf.data, PAGE_SIZE,
I think this needs to buf.data instead of &buf.data

Thanks & Regards,
      - Nayna

>   			      0, 0, "continue selftest");
> +
> +	tpm_buf_destroy(&buf);
> +
>   	return rc;
>   }
>

