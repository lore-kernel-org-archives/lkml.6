Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971814AbeCSU5e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:57:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:41744 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971562AbeCSU5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:57:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,332,1517904000";
   d="scan'208";a="38821084"
Date: Mon, 19 Mar 2018 22:57:17 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com
Subject: Re: [PATCH] tpm: TPM 2.0 selftest performance improvement
Message-ID: <20180319205717.GC13178@linux.intel.com>
References: <20180316174528.21018-1-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316174528.21018-1-nayna@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, Mar 16, 2018 at 11:15:28PM +0530, Nayna Jain wrote:
> For selftest being run in the background, the TCG 2.0 Specification
> provides the command TPM2_GetTestResult to check the status of selftest
> completion.
> 
> When the partial selftest command is sent just after TPM initialization,
> it is observed that it returns RC_COMMAND_CODE error, which as per TPM 2.0

When does it return RC_COMMAND_COMMAND return code? Who is observing
this? Please, do not use passive form.

> Specification, indicates "the response code that is returned if the TPM is
> unmarshalling a value that it expects to be a TPM_CC and the input value is
> not in the table." This doesn't indicate the exact status of selftest
> command on TPM. But, it can be verified by sending the TPM2_GetTestResult.

Where did you draw the conclusion that it doesn not indicate the
exact status? What does RC_COMMAND_CODE anyway indicate then? Just
trying to understand.

Also, please check the grammar in last two sentences (the second one
should probably be a subordinate clause).

> This patch implements the TPM2_GetTestResult command and uses it to check
> the selftest status, before sending the full selftest command after partial
> selftest returns RC_COMMAND_CODE.

Isn't that command implemented inside the TPM? You are implementing
tpm2_get_selftest_result().

> With this change, dmesg shows the TPM selftest completed at 1.243864
> compared with the previous 1.939667 time.

These numbers mean *absolutely nothing* to me as they are not
connected to *anything*.




> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> Tested-by: Mimi Zohar <zohar@linux.vnet.ibm.com> (on Pi with TPM 2.0)
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  drivers/char/tpm/tpm.h      |  2 ++
>  drivers/char/tpm/tpm2-cmd.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 82ae7b722161..d95eeb7c002a 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -107,6 +107,7 @@ enum tpm2_return_codes {
>  	TPM2_RC_FAILURE		= 0x0101,
>  	TPM2_RC_DISABLED	= 0x0120,
>  	TPM2_RC_COMMAND_CODE    = 0x0143,
> +	TPM2_RC_NEEDS_TEST      = 0x0153,
>  	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
>  	TPM2_RC_REFERENCE_H0	= 0x0910,
>  };
> @@ -135,6 +136,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_FLUSH_CONTEXT	= 0x0165,
>  	TPM2_CC_GET_CAPABILITY	= 0x017A,
>  	TPM2_CC_GET_RANDOM	= 0x017B,
> +	TPM2_CC_GET_TEST_RESULT = 0x017C,
>  	TPM2_CC_PCR_READ	= 0x017E,
>  	TPM2_CC_PCR_EXTEND	= 0x0182,
>  	TPM2_CC_LAST		= 0x018F,
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 89a5397b18d2..494f6dfbc65d 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -823,6 +823,50 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>  EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
>  
>  /**
> + * tpm2_get_selftest_result() - get the status of self tests
> + *
> + * @chip: TPM chip to use
> + *
> + * Return: If error return rc, else return the result of the self tests.
> + * TPM_RC_NEEDS_TESTING: No self tests are done. Needs testing.
> + * TPM_RC_TESTING: Self tests are in progress.
> + * TPM_RC_SUCCESS: Self tests completed successfully.
> + * TPM_RC_FAILURE: Self tests completed failure.
> + *
> + * This function can be used to check the status of self tests on the TPM.
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
> +
> +	return test_result;
> +}
> +
> +/**
>   * tpm2_do_selftest() - ensure that all self tests have passed
>   *
>   * @chip: TPM chip to use
> @@ -851,10 +895,25 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
>  				      "attempting the self test");
>  		tpm_buf_destroy(&buf);
>  
> +		dev_dbg(&chip->dev, "tpm selftest command returned %04x\n", rc);
>  		if (rc == TPM2_RC_TESTING)
>  			rc = TPM2_RC_SUCCESS;
>  		if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS)
>  			return rc;
> +
> +		if (rc == TPM2_RC_COMMAND_CODE) {
> +
> +			dev_info(&chip->dev, "Check TPM Test Results\n");
> +			rc = tpm2_get_selftest_result(chip);
> +
> +			dev_info(&chip->dev, "tpm self test result is %04x\n",
> +					rc);
> +			if (rc == TPM2_RC_TESTING)
> +				rc = TPM2_RC_SUCCESS;
> +			if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS
> +					|| TPM2_RC_FAILURE)
> +				return rc;
> +		}
>  	}
>  
>  	return rc;
> -- 
> 2.13.6
> 

The log messages do not have consistent wording and they are
prefixed with "tpm" for no reason. I would advice to just remove
them.

You could probably measure the durations with ftrace by using
the function_graph tracer...

/Jarkko
