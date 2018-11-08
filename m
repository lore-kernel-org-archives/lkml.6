Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB614C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDFB20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtCf053f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDFB20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeKHQgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:36:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43961 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKHQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:36:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id g59-v6so9089394plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 23:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Sw4jBo2InR/ffQDIIO0JFa1jdmuvrxCT1nHHdEseh4=;
        b=QtCf053f/ab58V360ZYhfhKO0BjCLFQQB8w6ACdcbibBSwGUdrc9ZUAg7LjRZREXtf
         U5200u5jGRZBZL/1dvw4dqmHaApkxnJkkU3/ifCG33cdNcxsBi5tZ7fHEgKbtQQ00Mo6
         eQ/KPr0r6QOZkpW6+Guor6/axenST3+2advIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Sw4jBo2InR/ffQDIIO0JFa1jdmuvrxCT1nHHdEseh4=;
        b=RmieGT66HSo2L+2IUNv3bMeiNO4SMBx+H0wrWpQr9a6khCDvdbbr7COH2mZ+xvXRfq
         3IQ9lvyTbDrAEw5gFAzHa8unW1rofhZlASHqRFs6K5yeC7CcebZIyor4z8ukTm1FCtpi
         aM5GLwLGH6n/eXxJYbwhlwaJNX8K0nJMTi7qMcjXDjZvdwhlNsnStZb6/WzbUJ+0T7dW
         5Uh/HSnkRpu/b1IIjhjkaTSOusBXRVcZn4lOw0RnJus7xE9GHff8EsIg74wxxYtIFT/C
         D6WzqHYCb2FKoQILi3rU3zzRUgaTo+qA+Ru34kk0WVKvAiwleDrvMnnJnC8etsZbfWSK
         ALzQ==
X-Gm-Message-State: AGRZ1gKNs8H6zlSxhCbACtaqbVS7aBzyY3uI0y6Qmtv8w/fNtIz30Ys8
        BnsRWacVMrbUZVVVNHTda6SPnA==
X-Google-Smtp-Source: AJdET5e2GRKA7TTTDgNqA88EPhQQsKafQ+Up4xUPwTWBoDE5Yrzs/VsmTjikWl5ZYAx/o78ahE3TFQ==
X-Received: by 2002:a17:902:1681:: with SMTP id h1-v6mr3491788plh.88.1541660540376;
        Wed, 07 Nov 2018 23:02:20 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v84-v6sm3273522pfd.182.2018.11.07.23.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 23:02:19 -0800 (PST)
Date:   Wed, 7 Nov 2018 23:06:04 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 5/5] hwspinlock: Add test module
Message-ID: <20181108070604.GE12063@builder>
References: <20181031093032.20386-1-benjamin.gaignard@st.com>
 <20181031093032.20386-6-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031093032.20386-6-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31 Oct 02:30 PDT 2018, Benjamin Gaignard wrote:

> Create a test module to perform simple unitary tests on hwspinlock.
> It doesn't cover all the possibles cases but at least allow to test
> that very basic features are working.
> 

I like the idea of making these things testable, but I would like to
hear from others how useful this module would be to them before merging
it.

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/hwspinlock/Kconfig           |   9 +++
>  drivers/hwspinlock/Makefile          |   1 +
>  drivers/hwspinlock/hwspinlock_test.c | 132 +++++++++++++++++++++++++++++++++++
>  3 files changed, 142 insertions(+)
>  create mode 100644 drivers/hwspinlock/hwspinlock_test.c
> 
> diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
> index e1a20b460590..f340ebb4d1f7 100644
> --- a/drivers/hwspinlock/Kconfig
> +++ b/drivers/hwspinlock/Kconfig
> @@ -68,3 +68,12 @@ config HWSPINLOCK_STM32
>  	  Say y here to support the STM32 Hardware Spinlock device.
>  
>  	  If unsure, say N.
> +
> +config HWSPINLOCK_TEST
> +	tristate "hwspinlock test module"
> +	depends on HWSPINLOCK && m
> +	default n
> +	help
> +	  Select M here if you want to build hwspinlock test module
> +
> +	  If unsure, say N.
> diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
> index c0a9505b4dcf..e6b3d0212fe0 100644
> --- a/drivers/hwspinlock/Makefile
> +++ b/drivers/hwspinlock/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
>  obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
>  obj-$(CONFIG_HSEM_U8500)		+= u8500_hsem.o
>  obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o
> +obj-$(CONFIG_HWSPINLOCK_TEST) 		+= hwspinlock_test.o
> diff --git a/drivers/hwspinlock/hwspinlock_test.c b/drivers/hwspinlock/hwspinlock_test.c
> new file mode 100644
> index 000000000000..75819337e45a
> --- /dev/null
> +++ b/drivers/hwspinlock/hwspinlock_test.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) STMicroelectronics SA 2018
> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/hwspinlock.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#define TIMEOUT	50 /* ms */
> +
> +static void hwspin_lock_test_twice_request_specific(void)
> +{
> +	struct hwspinlock *lock0 = hwspin_lock_request_specific(0);
> +	struct hwspinlock *lock1 = hwspin_lock_request_specific(1);

In a platform with more than one hwspinlock this will test the
implementation that was first probed and it will assume that there's no
issues with messing with the first two locks from this provider.

> +
> +	int ret;
> +
> +	if (!lock0 || !lock1) {
> +		pr_warn("Can't request twice hwspin_lock\n");
> +		return;
> +	}
> +
> +	ret = hwspin_trylock(lock0);
> +	if (ret)
> +		pr_warn("Can't trylock requested hwspin_lock 0 (%d)\n", ret);
> +
> +	ret = hwspin_trylock(lock1);
> +	if (ret)
> +		pr_warn("Can't trylock requested hwspin_lock 1 (%d)\n", ret);
> +
> +	hwspin_unlock(lock0);
> +	hwspin_unlock(lock1);

As described in the kerneldoc for these it's a bug to attempt to unlock
a unlocked lock. I believe this should be interpreted as it being
invalid to unlock unless hwspin_trylock() returned successfully.

> +
> +	ret = hwspin_lock_free(lock0);
> +	if (ret)
> +		pr_warn("Can't free requested hwspin_lock 0\n");
> +
> +	ret = hwspin_lock_free(lock1);
> +	if (ret)
> +		pr_warn("Can't free requested hwspin_lock 0\n");
> +}
> +
> +static void hwspin_lock_test_trylock(void)
> +{
> +	struct hwspinlock *lock = hwspin_lock_request();
> +	int ret;
> +
> +	if (!lock) {
> +		pr_warn("Can't request hwspin_lock\n");
> +		return;
> +	}
> +
> +	ret = hwspin_trylock(lock);
> +	if (ret)
> +		pr_warn("Can't trylock requested hwspin_lock (%d)\n", ret);
> +
> +	/* Try to lock a second time, this should failed */
> +	ret = hwspin_trylock(lock);
> +	if (ret != -EBUSY)
> +		pr_warn("Getting twice the same lock ! (%d)\n", ret);

This shouldn't be a warning, as this is a test failure.

> +
> +	hwspin_unlock(lock);
> +	ret = hwspin_lock_free(lock);
> +	if (ret)
> +		pr_warn("Can't free requested hwspin_lock 0\n");
> +}
> +
> +static void hwspin_lock_test_request_specific(void)
> +{
> +	/*
> +	 * Let's assume that any hwspin_lock driver would at least have one
> +	 * lock at index 0
> +	 */
> +	struct hwspinlock *lock = hwspin_lock_request_specific(0);
> +	int ret;
> +
> +	if (!lock) {
> +		pr_warn("Can't request hwspin_lock 0\n");
> +		return;
> +	}
> +
> +	ret = hwspin_lock_timeout(lock, TIMEOUT);
> +	if (ret)
> +		pr_warn("Can't lock requested hwspin_lock 0 (%d)\n", ret);
> +
> +	hwspin_unlock(lock);
> +	ret = hwspin_lock_free(lock);
> +	if (ret)
> +		pr_warn("Can't free requested hwspin_lock 0\n");
> +}
> +
> +static void hwspin_lock_test_request(void)

I would suggest that your test cases test one thing each; so request and
request_specific should test just that.

> +{
> +	struct hwspinlock *lock = hwspin_lock_request();
> +	int ret;
> +
> +	if (!lock) {
> +		pr_warn("Can't request hwspin_lock\n");
> +		return;
> +	}
> +
> +	ret = hwspin_lock_timeout(lock, TIMEOUT);
> +	if (ret)
> +		pr_warn("Can't lock requested hwspin_lock (%d)\n", ret);

Testing lock-timeout seems useful, but you probably want to elaborate it
to ensure that it both can lock a lock but that it times out properly
when trying to grab a taken lock.

> +
> +	hwspin_unlock(lock);
> +	ret = hwspin_lock_free(lock);
> +	if (ret)
> +		pr_warn("Can't free requested hwspin_lock\n");
> +}
> +
> +/*
> + * Test hwspinlock user API when module is loaded
> + */
> +static int __init hwspin_lock_test_init(void)
> +{
> +	pr_warn("Loading hwspinlock test module\n");
> +	hwspin_lock_test_request();
> +	hwspin_lock_test_request_specific();
> +	hwspin_lock_test_trylock();
> +	hwspin_lock_test_twice_request_specific();
> +
> +	return 0;
> +}
> +

Regards,
Bjorn
