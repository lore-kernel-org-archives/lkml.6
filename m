Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BD7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5AD21480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5AD21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbeHPSoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:44:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37958 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbeHPSoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:44:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BC1C7A9;
        Thu, 16 Aug 2018 08:44:49 -0700 (PDT)
Received: from [10.4.13.23] (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D408F3F5BD;
        Thu, 16 Aug 2018 08:44:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] coresight: etb10: Splitting function etb_enable()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
References: <1534284866-2523-1-git-send-email-mathieu.poirier@linaro.org>
 <1534284866-2523-2-git-send-email-mathieu.poirier@linaro.org>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <500292f8-d2ef-534d-9331-6a4ea7471c19@arm.com>
Date:   Thu, 16 Aug 2018 16:44:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534284866-2523-2-git-send-email-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/18 23:14, Mathieu Poirier wrote:
> Up until now the relative simplicity of enabling the ETB made it
> possible to accommodate processing for both sysFS and perf methods.
> But work on claimtags and CPU-wide trace scenarios is adding some
> complexity, making the current code messy and hard to maintain.
> 
> As such follow what has been done for ETF and ETR components and split
> function etb_enable() so that processing for both API can be done
> cleanly.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---

> +static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
> +{
> +	int ret;
> +	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	switch (mode) {
> +	case CS_MODE_SYSFS:
> +		ret = etb_enable_sysfs(csdev);
> +		break;
> +	case CS_MODE_PERF:
> +		ret = etb_enable_perf(csdev, data);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(drvdata->dev, "ETB enabled\n");
> +	return 0;
> +}
> +

Looks good.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
