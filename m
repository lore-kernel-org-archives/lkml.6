Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078F4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE8720880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE8720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbeIYUZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:25:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:12461 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbeIYUZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:25:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 07:17:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="235784040"
Received: from thomasvo-mobl2.ger.corp.intel.com ([10.252.53.212])
  by orsmga004.jf.intel.com with ESMTP; 25 Sep 2018 07:17:21 -0700
Message-ID: <bd97842627400edc59f7691000b8f2895be977f7.camel@linux.intel.com>
Subject: Re: [PATCH v4 03/21] tpm: factor out tpm 1.x duration calculation
 to tpm1-cmd.c
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Sep 2018 17:17:20 +0300
In-Reply-To: <20180921135820.20549-4-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
         <20180921135820.20549-4-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-21 at 16:58 +0300, Tomas Winkler wrote:
> Factor out TPM 1.x commands calculation into tpm1-cmd.c file.
> and change the prefix from tpm_ to tpm1_.
> No functional change is done here.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> V2-V3: Rebase
> V4: 1. Remove the licence statement it's already covered by SPDX.
>     2. Add kdoc to tpm1_calc_ordinal_duration().
> 
>  drivers/char/tpm/Makefile            |   1 +
>  drivers/char/tpm/st33zp24/st33zp24.c |   2 +-
>  drivers/char/tpm/tpm-interface.c     | 284 +-------------------------------
>  drivers/char/tpm/tpm.h               |   2 +-
>  drivers/char/tpm/tpm1-cmd.c          | 310
> +++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm_i2c_nuvoton.c   |  10 +-
>  drivers/char/tpm/tpm_tis_core.c      |   2 +-
>  drivers/char/tpm/xen-tpmfront.c      |   2 +-
>  8 files changed, 322 insertions(+), 291 deletions(-)
>  create mode 100644 drivers/char/tpm/tpm1-cmd.c
> 
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index efc785053627..a01c4cab902a 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -7,6 +7,7 @@ tpm-y := tpm-chip.o
>  tpm-y += tpm-dev-common.o
>  tpm-y += tpm-dev.o
>  tpm-y += tpm-interface.o
> +tpm-y += tpm1-cmd.o
>  tpm-y += tpm2-cmd.o
>  tpm-y += tpmrm-dev.o
>  tpm-y += tpm2-space.o
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c
> b/drivers/char/tpm/st33zp24/st33zp24.c
> index abd675bec88c..16be974955ea 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.c
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -430,7 +430,7 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned
> char *buf,
>  		ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
>  
>  		ret = wait_for_stat(chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> -				tpm_calc_ordinal_duration(chip, ordinal),
> +				tpm1_calc_ordinal_duration(chip, ordinal),
>  				&tpm_dev->read_queue, false);
>  		if (ret < 0)
>  			goto out_err;
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index 129f640424b7..bb3eed907c72 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -33,7 +33,6 @@
>  
>  #include "tpm.h"
>  
> -#define TPM_MAX_ORDINAL 243
>  #define TSC_MAX_ORDINAL 12
>  #define TPM_PROTECTED_COMMAND 0x00
>  #define TPM_CONNECTION_COMMAND 0x40
> @@ -48,285 +47,6 @@ module_param_named(suspend_pcr, tpm_suspend_pcr, uint,
> 0644);
>  MODULE_PARM_DESC(suspend_pcr,
>  		 "PCR to use for dummy writes to facilitate flush on
> suspend.");
>  
> -/*
> - * Array with one entry per ordinal defining the maximum amount
> - * of time the chip could take to return the result.  The ordinal
> - * designation of short, medium or long is defined in a table in
> - * TCG Specification TPM Main Part 2 TPM Structures Section 17. The
> - * values of the SHORT, MEDIUM, and LONG durations are retrieved
> - * from the chip during initialization with a call to tpm_get_timeouts.
> - */
> -static const u8 tpm_ordinal_duration[TPM_MAX_ORDINAL] = {
> -	TPM_UNDEFINED,		/* 0 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,		/* 5 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,		/* 10 */
> -	TPM_SHORT,
> -	TPM_MEDIUM,
> -	TPM_LONG,
> -	TPM_LONG,
> -	TPM_MEDIUM,		/* 15 */
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_MEDIUM,
> -	TPM_LONG,
> -	TPM_SHORT,		/* 20 */
> -	TPM_SHORT,
> -	TPM_MEDIUM,
> -	TPM_MEDIUM,
> -	TPM_MEDIUM,
> -	TPM_SHORT,		/* 25 */
> -	TPM_SHORT,
> -	TPM_MEDIUM,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_MEDIUM,		/* 30 */
> -	TPM_LONG,
> -	TPM_MEDIUM,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,		/* 35 */
> -	TPM_MEDIUM,
> -	TPM_MEDIUM,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_MEDIUM,		/* 40 */
> -	TPM_LONG,
> -	TPM_MEDIUM,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,		/* 45 */
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_LONG,
> -	TPM_MEDIUM,		/* 50 */
> -	TPM_MEDIUM,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,		/* 55 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_MEDIUM,		/* 60 */
> -	TPM_MEDIUM,
> -	TPM_MEDIUM,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_MEDIUM,		/* 65 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,		/* 70 */
> -	TPM_SHORT,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,		/* 75 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_LONG,		/* 80 */
> -	TPM_UNDEFINED,
> -	TPM_MEDIUM,
> -	TPM_LONG,
> -	TPM_SHORT,
> -	TPM_UNDEFINED,		/* 85 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,		/* 90 */
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_UNDEFINED,		/* 95 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_MEDIUM,		/* 100 */
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,		/* 105 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,		/* 110 */
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,		/* 115 */
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_LONG,		/* 120 */
> -	TPM_LONG,
> -	TPM_MEDIUM,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,
> -	TPM_SHORT,		/* 125 */
> -	TPM_SHORT,
> -	TPM_LONG,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,		/* 130 */
> -	TPM_MEDIUM,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,
> -	TPM_MEDIUM,
> -	TPM_UNDEFINED,		/* 135 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,		/* 140 */
> -	TPM_SHORT,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,		/* 145 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,		/* 150 */
> -	TPM_MEDIUM,
> -	TPM_MEDIUM,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_UNDEFINED,		/* 155 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,		/* 160 */
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,		/* 165 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_LONG,		/* 170 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,		/* 175 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_MEDIUM,		/* 180 */
> -	TPM_SHORT,
> -	TPM_MEDIUM,
> -	TPM_MEDIUM,
> -	TPM_MEDIUM,
> -	TPM_MEDIUM,		/* 185 */
> -	TPM_SHORT,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,		/* 190 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,		/* 195 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,		/* 200 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,
> -	TPM_SHORT,		/* 205 */
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_MEDIUM,		/* 210 */
> -	TPM_UNDEFINED,
> -	TPM_MEDIUM,
> -	TPM_MEDIUM,
> -	TPM_MEDIUM,
> -	TPM_UNDEFINED,		/* 215 */
> -	TPM_MEDIUM,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,
> -	TPM_SHORT,		/* 220 */
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_SHORT,
> -	TPM_UNDEFINED,		/* 225 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,		/* 230 */
> -	TPM_LONG,
> -	TPM_MEDIUM,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,		/* 235 */
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_UNDEFINED,
> -	TPM_SHORT,		/* 240 */
> -	TPM_UNDEFINED,
> -	TPM_MEDIUM,
> -};
> -
> -/*
> - * Returns max number of jiffies to wait
> - */
> -unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip,
> -					   u32 ordinal)
> -{
> -	int duration_idx = TPM_UNDEFINED;
> -	int duration = 0;
> -
> -	/*
> -	 * We only have a duration table for protected commands, where the
> upper
> -	 * 16 bits are 0. For the few other ordinals the fallback will be
> used.
> -	 */
> -	if (ordinal < TPM_MAX_ORDINAL)
> -		duration_idx = tpm_ordinal_duration[ordinal];
> -
> -	if (duration_idx != TPM_UNDEFINED)
> -		duration = chip->duration[duration_idx];
> -	if (duration <= 0)
> -		return 2 * 60 * HZ;
> -	else
> -		return duration;
> -}
> -EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
> -
>  static int tpm_validate_command(struct tpm_chip *chip,
>  				 struct tpm_space *space,
>  				 const u8 *cmd,
> @@ -503,7 +223,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		stop = jiffies + tpm2_calc_ordinal_duration(chip, ordinal);
>  	else
> -		stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
> +		stop = jiffies + tpm1_calc_ordinal_duration(chip, ordinal);
>  	do {
>  		u8 status = chip->ops->status(chip);
>  		if ((status & chip->ops->req_complete_mask) ==
> @@ -1086,7 +806,7 @@ int tpm_do_selftest(struct tpm_chip *chip)
>  	unsigned long duration;
>  	u8 dummy[TPM_DIGEST_SIZE];
>  
> -	duration = tpm_calc_ordinal_duration(chip,
> TPM_ORD_CONTINUE_SELFTEST);
> +	duration = tpm1_calc_ordinal_duration(chip,
> TPM_ORD_CONTINUE_SELFTEST);
>  
>  	loops = jiffies_to_msecs(duration) / delay_msec;
>  
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 0f08518b525d..c59d2c20c339 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -546,7 +546,7 @@ ssize_t tpm_getcap(struct tpm_chip *chip, u32 subcap_id,
> cap_t *cap,
>  int tpm_get_timeouts(struct tpm_chip *);
>  int tpm1_auto_startup(struct tpm_chip *chip);
>  int tpm_do_selftest(struct tpm_chip *chip);
> -unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> +unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>  int tpm_pm_suspend(struct device *dev);
>  int tpm_pm_resume(struct device *dev);
>  
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> new file mode 100644
> index 000000000000..7d14196de6eb
> --- /dev/null
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2004 IBM Corporation
> + * Copyright (C) 2014 Intel Corporation
> + *
> + * Authors:
> + * Leendert van Doorn <leendert@watson.ibm.com>
> + * Dave Safford <safford@watson.ibm.com>
> + * Reiner Sailer <sailer@watson.ibm.com>
> + * Kylene Hall <kjhall@us.ibm.com>
> + *
> + * Device driver for TCG/TCPA TPM (trusted platform module).
> + * Specifications at www.trustedcomputinggroup.org
> + */
> +
> +#include <linux/poll.h>
> +#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +#include <linux/freezer.h>
> +#include <linux/tpm_eventlog.h>
> +
> +#include "tpm.h"
> +
> +#define TPM_MAX_ORDINAL 243
> +
> +/*
> + * Array with one entry per ordinal defining the maximum amount
> + * of time the chip could take to return the result.  The ordinal
> + * designation of short, medium or long is defined in a table in
> + * TCG Specification TPM Main Part 2 TPM Structures Section 17. The
> + * values of the SHORT, MEDIUM, and LONG durations are retrieved
> + * from the chip during initialization with a call to tpm_get_timeouts.
> + */
> +static const u8 tpm1_ordinal_duration[TPM_MAX_ORDINAL] = {
> +	TPM_UNDEFINED,		/* 0 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,		/* 5 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,		/* 10 */
> +	TPM_SHORT,
> +	TPM_MEDIUM,
> +	TPM_LONG,
> +	TPM_LONG,
> +	TPM_MEDIUM,		/* 15 */
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_MEDIUM,
> +	TPM_LONG,
> +	TPM_SHORT,		/* 20 */
> +	TPM_SHORT,
> +	TPM_MEDIUM,
> +	TPM_MEDIUM,
> +	TPM_MEDIUM,
> +	TPM_SHORT,		/* 25 */
> +	TPM_SHORT,
> +	TPM_MEDIUM,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_MEDIUM,		/* 30 */
> +	TPM_LONG,
> +	TPM_MEDIUM,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,		/* 35 */
> +	TPM_MEDIUM,
> +	TPM_MEDIUM,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_MEDIUM,		/* 40 */
> +	TPM_LONG,
> +	TPM_MEDIUM,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,		/* 45 */
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_LONG,
> +	TPM_MEDIUM,		/* 50 */
> +	TPM_MEDIUM,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,		/* 55 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_MEDIUM,		/* 60 */
> +	TPM_MEDIUM,
> +	TPM_MEDIUM,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_MEDIUM,		/* 65 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,		/* 70 */
> +	TPM_SHORT,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,		/* 75 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_LONG,		/* 80 */
> +	TPM_UNDEFINED,
> +	TPM_MEDIUM,
> +	TPM_LONG,
> +	TPM_SHORT,
> +	TPM_UNDEFINED,		/* 85 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,		/* 90 */
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_UNDEFINED,		/* 95 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_MEDIUM,		/* 100 */
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,		/* 105 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,		/* 110 */
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,		/* 115 */
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_LONG,		/* 120 */
> +	TPM_LONG,
> +	TPM_MEDIUM,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,
> +	TPM_SHORT,		/* 125 */
> +	TPM_SHORT,
> +	TPM_LONG,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,		/* 130 */
> +	TPM_MEDIUM,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,
> +	TPM_MEDIUM,
> +	TPM_UNDEFINED,		/* 135 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,		/* 140 */
> +	TPM_SHORT,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,		/* 145 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,		/* 150 */
> +	TPM_MEDIUM,
> +	TPM_MEDIUM,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_UNDEFINED,		/* 155 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,		/* 160 */
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,		/* 165 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_LONG,		/* 170 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,		/* 175 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_MEDIUM,		/* 180 */
> +	TPM_SHORT,
> +	TPM_MEDIUM,
> +	TPM_MEDIUM,
> +	TPM_MEDIUM,
> +	TPM_MEDIUM,		/* 185 */
> +	TPM_SHORT,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,		/* 190 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,		/* 195 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,		/* 200 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,
> +	TPM_SHORT,		/* 205 */
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_MEDIUM,		/* 210 */
> +	TPM_UNDEFINED,
> +	TPM_MEDIUM,
> +	TPM_MEDIUM,
> +	TPM_MEDIUM,
> +	TPM_UNDEFINED,		/* 215 */
> +	TPM_MEDIUM,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,
> +	TPM_SHORT,		/* 220 */
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_SHORT,
> +	TPM_UNDEFINED,		/* 225 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,		/* 230 */
> +	TPM_LONG,
> +	TPM_MEDIUM,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,		/* 235 */
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_UNDEFINED,
> +	TPM_SHORT,		/* 240 */
> +	TPM_UNDEFINED,
> +	TPM_MEDIUM,
> +};
> +
> +/**
> + * tpm1_calc_ordinal_duration() - returns the maximum amount of time
> + * the chip could take to return the result for a particular ordinal
> + * in jiffies.
> + *
> + * @chip:    TPM chip to use.
> + * @ordinal: TPM command ordinal.
> + *
> + * Return: A maxiaml duration time for an ordinal in jiffies.
> + */
> +unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
> +{
> +	int duration_idx = TPM_UNDEFINED;
> +	int duration = 0;
> +
> +	/*
> +	 * We only have a duration table for protected commands, where the
> upper
> +	 * 16 bits are 0. For the few other ordinals the fallback will be
> used.
> +	 */
> +	if (ordinal < TPM_MAX_ORDINAL)
> +		duration_idx = tpm1_ordinal_duration[ordinal];
> +
> +	if (duration_idx != TPM_UNDEFINED)
> +		duration = chip->duration[duration_idx];
> +	if (duration <= 0)
> +		return 2 * 60 * HZ;
> +	else
> +		return duration;
> +}
> +EXPORT_SYMBOL_GPL(tpm1_calc_ordinal_duration);
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c
> b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index caa86b19c76d..5d20e98b844f 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -370,6 +370,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8
> *buf, size_t len)
>  	struct i2c_client *client = to_i2c_client(dev);
>  	u32 ordinal;
>  	size_t count = 0;
> +	unsigned long duration;
>  	int burst_count, bytes2write, retries, rc = -EIO;
>  
>  	for (retries = 0; retries < TPM_RETRY; retries++) {
> @@ -455,12 +456,11 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8
> *buf, size_t len)
>  		return rc;
>  	}
>  	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
> -	rc = i2c_nuvoton_wait_for_data_avail(chip,
> -					     tpm_calc_ordinal_duration(chip,
> -								       ordina
> l),
> -					     &priv->read_queue);
> +	duration = tpm1_calc_ordinal_duration(chip, ordinal);
> +	rc = i2c_nuvoton_wait_for_data_avail(chip, duration, &priv-
> >read_queue);
>  	if (rc) {
> -		dev_err(dev, "%s() timeout command duration\n", __func__);
> +		dev_err(dev, "%s() timeout command duration %ld\n",
> +			__func__, duration);
>  		i2c_nuvoton_ready(chip);
>  		return rc;
>  	}
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index d2345d9fd7b5..14c332104de4 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -476,7 +476,7 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const
> u8 *buf, size_t len)
>  		if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  			dur = tpm2_calc_ordinal_duration(chip, ordinal);
>  		else
> -			dur = tpm_calc_ordinal_duration(chip, ordinal);
> +			dur = tpm1_calc_ordinal_duration(chip, ordinal);
>  
>  		if (wait_for_tpm_stat
>  		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
> index b150f87f38f5..77097229bf49 100644
> --- a/drivers/char/tpm/xen-tpmfront.c
> +++ b/drivers/char/tpm/xen-tpmfront.c
> @@ -164,7 +164,7 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf,
> size_t count)
>  	notify_remote_via_evtchn(priv->evtchn);
>  
>  	ordinal = be32_to_cpu(((struct tpm_input_header*)buf)->ordinal);
> -	duration = tpm_calc_ordinal_duration(chip, ordinal);
> +	duration = tpm1_calc_ordinal_duration(chip, ordinal);
>  
>  	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, duration,
>  			&priv->read_queue, true) < 0) {

The stuff that I said about function header comments applies also here.
Other than that I do not see anything alarming.

/Jarkko
