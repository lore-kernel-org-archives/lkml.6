Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933087AbeBLJCy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:02:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932953AbeBLJCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:02:48 -0500
Subject: Re: [PATCH] tpm: migrate tpm2_do_selftest() to use struct tpm_buf
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
References: <20180209131820.23718-1-jarkko.sakkinen@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 14:31:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180209131820.23718-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18021209-0036-0000-0000-000002BCD914
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008520; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000251; SDB=6.00988560; UDB=6.00501883; IPR=6.00767914;
 BA=6.00005825; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019503; XFM=3.00000015;
 UTC=2018-02-12 09:02:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021209-0037-0000-0000-0000434EC944
Message-Id: <f2cace35-b460-08d8-798b-9fb6b5acbcea@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802120116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/2018 06:48 PM, Jarkko Sakkinen wrote:
> As part of an ongoing effort to encapsulate TPM commands to struct
> tpm_buf instead of using clunky union of structs, migrated
> tpm2_do_selft_test() to use struct tpm_buf.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> I wish this would be included as part of patch set that fixes the timing
> issue.
>   drivers/char/tpm/tpm2-cmd.c | 32 ++++++++++----------------------
>   1 file changed, 10 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index c17e75348a99..a91a2c6f03a7 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -31,10 +31,6 @@ struct tpm2_startup_in {
>   	__be16	startup_type;
>   } __packed;
>
> -struct tpm2_self_test_in {
> -	u8	full_test;
> -} __packed;
> -
>   struct tpm2_get_tpm_pt_in {
>   	__be32	cap_id;
>   	__be32	property_id;
> @@ -60,7 +56,6 @@ struct tpm2_get_random_out {
>
>   union tpm2_cmd_params {
>   	struct	tpm2_startup_in		startup_in;
> -	struct	tpm2_self_test_in	selftest_in;
>   	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
>   	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
>   	struct	tpm2_get_random_in	getrandom_in;
> @@ -823,16 +818,6 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>   }
>   EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
>
> -#define TPM2_SELF_TEST_IN_SIZE \
> -	(sizeof(struct tpm_input_header) + \
> -	 sizeof(struct tpm2_self_test_in))
> -
> -static const struct tpm_input_header tpm2_selftest_header = {
> -	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
> -	.length = cpu_to_be32(TPM2_SELF_TEST_IN_SIZE),
> -	.ordinal = cpu_to_be32(TPM2_CC_SELF_TEST)
> -};
> -
>   /**
>    * tpm2_do_selftest() - ensure that all self tests have passed
>    *
> @@ -851,18 +836,21 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
>   	int rc;
>   	unsigned int delay_msec = 10;
>   	long duration;
> -	struct tpm2_cmd cmd;
> +	struct tpm_buf buf;
>
>   	duration = jiffies_to_msecs(
>   		tpm2_calc_ordinal_duration(chip, TPM2_CC_SELF_TEST));
>
> -	while (1) {
> -		cmd.header.in = tpm2_selftest_header;
> -		cmd.params.selftest_in.full_test = 0;
> -
> -		rc = tpm_transmit_cmd(chip, NULL, &cmd, TPM2_SELF_TEST_IN_SIZE,
> -				      0, 0, "continue selftest");
> +	for (;;) {
> +		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
> +		if (rc)
> +			return rc;
>
> +		/* Perform tests in the background. */
> +		tpm_buf_append_u8(&buf, 0);
> +		rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
> +				      "continue selftest");
> +		tpm_buf_destroy(&buf);
>   		if (rc != TPM2_RC_TESTING || delay_msec >= duration)
>   			break;
>
Tested-By: Nayna Jain <nayna@linux.vnet.ibm.com>

Thanks & Regards,
      - Nayna
