Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeBPFkC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 00:40:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42188 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbeBPFj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 00:39:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BCFD604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 10/12] i2c: qup: send NACK for last read sub transfers
To: Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-11-git-send-email-absahu@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <4cd52f4d-021d-fd62-a2e6-a414d1b94ac9@codeaurora.org>
Date: Fri, 16 Feb 2018 11:09:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517644697-30806-11-git-send-email-absahu@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
> According to I2c specification, “If a master-receiver sends a
> repeated START condition, it sends a not-acknowledge (A) just
> before the repeated START condition”. QUP v2 supports sending
> of NACK without stop with QUP_TAG_V2_DATARD_NACK so added the
> same.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index ba717bb..edea3b9 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -113,6 +113,7 @@
>  #define QUP_TAG_V2_DATAWR              0x82
>  #define QUP_TAG_V2_DATAWR_STOP         0x83
>  #define QUP_TAG_V2_DATARD              0x85
> +#define QUP_TAG_V2_DATARD_NACK         0x86
>  #define QUP_TAG_V2_DATARD_STOP         0x87
>  
>  /* Status, Error flags */
> @@ -609,7 +610,9 @@ static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
>  			tags[len++] = QUP_TAG_V2_DATAWR_STOP;
>  	} else {
>  		if (msg->flags & I2C_M_RD)
> -			tags[len++] = QUP_TAG_V2_DATARD;
> +			tags[len++] = qup->blk.pos == (qup->blk.count - 1) ?
> +				      QUP_TAG_V2_DATARD_NACK :
> +				      QUP_TAG_V2_DATARD;
>  		else
>  			tags[len++] = QUP_TAG_V2_DATAWR;

 good one. Thanks .

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
