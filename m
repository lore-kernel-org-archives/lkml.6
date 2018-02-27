Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeB0Vq6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:46:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeB0Vq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:46:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D51EA600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=austinwc@codeaurora.org
Subject: Re: [PATCH 01/12] i2c: qup: fixed releasing dma without flush
 operation completion
To: Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-2-git-send-email-absahu@codeaurora.org>
From: "Christ, Austin" <austinwc@codeaurora.org>
Message-ID: <789b2136-da54-b1d5-385d-71b36b368247@codeaurora.org>
Date: Tue, 27 Feb 2018 14:46:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517644697-30806-2-git-send-email-absahu@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on Centriq 2400

Reviewed-by: Austin Christ <austinwc@codeaurora.org>

On 2/3/2018 12:58 AM, Abhishek Sahu wrote:
> The QUP BSLP BAM generates the following error sometimes if the
> current I2C DMA transfer fails and the flush operation has been
> scheduled
> 
>      “bam-dma-engine 7884000.dma: Cannot free busy channel”
> 
> If any I2C error comes during BAM DMA transfer, then the QUP I2C
> interrupt will be generated and the flush operation will be
> carried out to make i2c consume all scheduled DMA transfer.
> Currently, the same completion structure is being used for BAM
> transfer which has already completed without reinit. It will make
> flush operation wait_for_completion_timeout completed immediately
> and will proceed for freeing the DMA resources where the
> descriptors are still in process.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>   drivers/i2c/busses/i2c-qup.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index 08f8e01..9faa26c41a 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -1,5 +1,5 @@
>   /*
> - * Copyright (c) 2009-2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2009-2013, 2016-2018, The Linux Foundation. All rights reserved.
>    * Copyright (c) 2014, Sony Mobile Communications AB.
>    *
>    *
> @@ -844,6 +844,8 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   	}
>   
>   	if (ret || qup->bus_err || qup->qup_err) {
> +		reinit_completion(&qup->xfer);
> +
>   		if (qup_i2c_change_state(qup, QUP_RUN_STATE)) {
>   			dev_err(qup->dev, "change to run state timed out");
>   			goto desc_err;
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
