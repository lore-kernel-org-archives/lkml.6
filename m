Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeERHEO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:04:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:54223 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbeERHEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:04:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="229679429"
Date: Fri, 18 May 2018 10:04:08 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com
Subject: Re: [PATCH v3] tpm: check selftest status before retrying full
 selftest
Message-ID: <20180518070408.GA9461@linux.intel.com>
References: <20180515071712.9331-1-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515071712.9331-1-nayna@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 12:47:12PM +0530, Nayna Jain wrote:
> TPM 2.0 supports TPM2_GetTestResult[1], which can be used to check the
> selftest status. This patch implements the tpm2_get_selftest_result()
> function to check the selftest status before trying full selftest.
> 
> [1] As per TCG Specification, Trusted Platform Module Library,
> Part 2 - Commands, Section 10.4:
> 
> "This command(TPM2_GetTestResult) returns manufacturer-specific information
> regarding the results of a self-test and an indication of the test status.
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> Tested-by: Mimi Zohar <zohar@linux.vnet.ibm.com> (on Pi with TPM 2.0)
> Tested-by: Stefan Berger <stefanb@linux.vnet.ibm.com> (With QEMU with
> swtpm TPM 2.0)
> ---
> 
> Changelog:
> 
> v3:
> * modified to check the selftest status before full selftest command is run
> * fixed the patch description
> * includes Jarkko's feedbacks
> 
> v2:
> * changed the subject and updated patch description
> * removed the logs
> 
>  drivers/char/tpm/tpm.h      |  2 ++
>  drivers/char/tpm/tpm2-cmd.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index af3bb87d3ea1..1de4240b52c4 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -114,6 +114,7 @@ enum tpm2_return_codes {
>  	TPM2_RC_FAILURE		= 0x0101,
>  	TPM2_RC_DISABLED	= 0x0120,
>  	TPM2_RC_COMMAND_CODE    = 0x0143,
> +	TPM2_RC_NEEDS_TEST      = 0x0153,
>  	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
>  	TPM2_RC_REFERENCE_H0	= 0x0910,
>  	TPM2_RC_RETRY		= 0x0922,
> @@ -144,6 +145,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_FLUSH_CONTEXT	= 0x0165,
>  	TPM2_CC_GET_CAPABILITY	= 0x017A,
>  	TPM2_CC_GET_RANDOM	= 0x017B,
> +	TPM2_CC_GET_TEST_RESULT = 0x017C,
>  	TPM2_CC_PCR_READ	= 0x017E,
>  	TPM2_CC_PCR_EXTEND	= 0x0182,
>  	TPM2_CC_LAST		= 0x018F,
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 96c77c8e7f40..811bcf221208 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -825,6 +825,43 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>  EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
>  
>  /**
> + * tpm2_get_selftest_result() - get the status of selftest
> + * @chip: TPM chip to use
> + *
> + * Return: TPM return code, errno otherwise

* Return:
*  TPM return code,
*  -errno otherwise

> + */
> +static int tpm2_get_selftest_result(struct tpm_chip *chip)
> +{
> +	struct tpm_buf buf;
> +	int rc;
> +	int test_result;
> +	uint16_t data_size;
> +	int len;
> +	const struct tpm_output_header *header;
> +
> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_TEST_RESULT);
> +	if (rc)
> +		return rc;
> +
> +	len = tpm_transmit(chip, NULL, buf.data, PAGE_SIZE, 0);
> +	if (len <  0)
> +		return len;
> +
> +	header = (struct tpm_output_header *)buf.data;
> +
> +	rc = be32_to_cpu(header->return_code);
> +	if (rc)
> +		return rc;
> +
> +	data_size = be16_to_cpup((__be16 *)&buf.data[TPM_HEADER_SIZE]);
> +
> +	test_result = be32_to_cpup((__be32 *)
> +			(&buf.data[TPM_HEADER_SIZE + 2 + data_size]));

Why you can't just use rc here like is done in every other function?
Sorry, did missed this in the previous review.

> +
> +	return test_result;
> +}
> +
> +/**
>   * tpm2_do_selftest() - ensure that all self tests have passed
>   *
>   * @chip: TPM chip to use
> @@ -857,6 +894,13 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
>  			rc = TPM2_RC_SUCCESS;
>  		if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS)
>  			return rc;
> +
> +		rc = tpm2_get_selftest_result(chip);
> +		dev_dbg(&chip->dev, "self test result is %04x\n", rc);

Please remove this dev_dbg() (also this one).

> +
> +		if (rc == TPM2_RC_TESTING || rc == TPM2_RC_SUCCESS)
> +			return TPM2_RC_SUCCESS;
> +
>  	}
>  
>  	return rc;
> -- 
> 2.13.6
> 

/Jarkko
