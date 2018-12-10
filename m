Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D51C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05122082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05122082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeLJSbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:31:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60476 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbeLJSbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:31:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C4D715BF;
        Mon, 10 Dec 2018 10:31:50 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77E8F3F6A8;
        Mon, 10 Dec 2018 10:31:49 -0800 (PST)
Subject: Re: [PATCH v2] mailbox: Hi3660: Fixup mailbox state machine
 malfunction issue
To:     Kevin Wangtao <kevin.wangtao@hisilicon.com>,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        gengyanping@hisilicon.com, suzhuangluan@hisilicon.com
References: <1543809309-61169-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1543817588-82411-1-git-send-email-kevin.wangtao@hisilicon.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d3ede0ab-b635-344c-faba-a9b1531b7f05@arm.com>
Date:   Mon, 10 Dec 2018 18:31:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543817588-82411-1-git-send-email-kevin.wangtao@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/12/2018 06:13, Kevin Wangtao wrote:
> Current mailbox driver of Hi3660 release the mailbox directly
> before sending a new message which may cause last message lost
> and next message sending doesn't take effect actually.
> 
> This patch fixes this issue by following the right process below,
> each time before sending a message, mailbox driver will check
> whether the mailbox is in ready state, if last message has been
> acknowledged, mailbox driver will clear the ack state to turn
> the mailbox to ready state again.
> 
> Signed-off-by: Kevin Wangtao <kevin.wangtao@hisilicon.com>

Validated using sysbench at each OPP ([1]). Test passes with patch and fails
without:

| CPU  |     OPP | Base | Patch |
|------+---------+------+-------|
| CPU0 |  533000 |  104 |   104 |
| CPU0 |  999000 |  104 |   201 |
| CPU0 |  140200 |  285 |   285 |
| CPU0 | 1709000 |  285 |   349 |
| CPU0 | 1844000 |  377 |   377 |
|------+---------+------+-------|
| CPU4 |  903000 |  249 |   248 |
| CPU4 | 1421000 |  249 |   394 |
| CPU4 | 1805000 |  500 |   500 |
| CPU4 | 2112000 |  499 |   583 |
| CPU4 | 2362000 |  653 |   654 |

We need this pretty badly, otherwise frequency setting is a coin toss.

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks,
Valentin



[1]: https://github.com/ARM-software/lisa/blob/next/lisa/tests/kernel/cpufreq/sanity.py#L23

Ran the above with this script on each kernel:

----->8-----
#!/usr/bin/env python3

from lisa.env import TestEnv
from lisa.tests.kernel.cpufreq.sanity import UserspaceSanity

te = TestEnv.from_cli()

print(UserspaceSanity.from_testenv(te).test_performance_sanity())
-----8<-----


> ---
> Changes v1 -> v2:
>  - update commit message
> 
>  drivers/mailbox/hi3660-mailbox.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
> index 3eea6b6..035b71a 100644
> --- a/drivers/mailbox/hi3660-mailbox.c
> +++ b/drivers/mailbox/hi3660-mailbox.c
> @@ -38,6 +38,7 @@
>  #define MBOX_AUTOMATIC_ACK		1
>  
>  #define MBOX_STATE_IDLE			BIT(4)
> +#define MBOX_STATE_READY		BIT(5)
>  #define MBOX_STATE_ACK			BIT(7)
>  
>  #define MBOX_MSG_LEN			8
> @@ -91,8 +92,8 @@ static int hi3660_mbox_check_state(struct mbox_chan *chan)
>  	unsigned long val;
>  	unsigned int ret;
>  
> -	/* Mailbox is idle so directly bail out */
> -	if (readl(base + MBOX_MODE_REG) & MBOX_STATE_IDLE)
> +	/* Mailbox is ready to use */
> +	if (readl(base + MBOX_MODE_REG) & MBOX_STATE_READY)
>  		return 0;
>  
>  	/* Wait for acknowledge from remote */
> @@ -103,9 +104,9 @@ static int hi3660_mbox_check_state(struct mbox_chan *chan)
>  		return ret;
>  	}
>  
> -	/* Ensure channel is released */
> -	writel(0xffffffff, base + MBOX_IMASK_REG);
> -	writel(BIT(mchan->ack_irq), base + MBOX_SRC_REG);
> +	/* clear ack state, mailbox will get back to ready state */
> +	writel(BIT(mchan->ack_irq), base + MBOX_ICLR_REG);
> +
>  	return 0;
>  }
>  
> @@ -160,10 +161,6 @@ static int hi3660_mbox_startup(struct mbox_chan *chan)
>  {
>  	int ret;
>  
> -	ret = hi3660_mbox_check_state(chan);
> -	if (ret)
> -		return ret;
> -
>  	ret = hi3660_mbox_unlock(chan);
>  	if (ret)
>  		return ret;
> @@ -183,10 +180,11 @@ static int hi3660_mbox_send_data(struct mbox_chan *chan, void *msg)
>  	void __iomem *base = MBOX_BASE(mbox, ch);
>  	u32 *buf = msg;
>  	unsigned int i;
> +	int ret;
>  
> -	/* Ensure channel is released */
> -	writel_relaxed(0xffffffff, base + MBOX_IMASK_REG);
> -	writel_relaxed(BIT(mchan->ack_irq), base + MBOX_SRC_REG);
> +	ret = hi3660_mbox_check_state(chan);
> +	if (ret)
> +		return ret;
>  
>  	/* Clear mask for destination interrupt */
>  	writel_relaxed(~BIT(mchan->dst_irq), base + MBOX_IMASK_REG);
> 
