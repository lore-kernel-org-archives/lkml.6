Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756531AbeDZW35 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:29:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43966 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754348AbeDZW3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:29:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2003660390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=clew@codeaurora.org
Subject: Re: [PATCH v2] net: qrtr: Expose tunneling endpoint to user space
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20180423214653.10016-1-bjorn.andersson@linaro.org>
From: Chris Lew <clew@codeaurora.org>
Message-ID: <46fe45d8-6f3a-5bed-c02c-6e61ba1175d2@codeaurora.org>
Date: Thu, 26 Apr 2018 15:29:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423214653.10016-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/23/2018 2:46 PM, Bjorn Andersson wrote:
> This implements a misc character device named "qrtr-tun" for the purpose
> of allowing user space applications to implement endpoints in the qrtr
> network.
> 
> This allows more advanced (and dynamic) testing of the qrtr code as well
> as opens up the ability of tunneling qrtr over a network or USB link.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Chris Lew <clew@codeaurora.org>

> +static ssize_t qrtr_tun_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	struct file *filp = iocb->ki_filp;
> +	struct qrtr_tun *tun = filp->private_data;
> +	struct sk_buff *skb;
> +	int count;
> +
> +	while (!(skb = skb_dequeue(&tun->queue))) {
> +		if (filp->f_flags & O_NONBLOCK)
> +			return -EAGAIN;
> +
> +		/* Wait until we get data or the endpoint goes away */
> +		if (wait_event_interruptible(tun->readq,
> +					     !skb_queue_empty(&tun->queue)))
> +			return -ERESTARTSYS;
> +	}
> +
> +	count = min_t(size_t, iov_iter_count(to), skb->len);
> +	if (copy_to_iter(skb->data, count, to) != count)
> +		count = -EFAULT;
> +
> +	kfree_skb(skb);

Is it better to use consume_skb() since this is the expected behavior path?

> +
> +	return count;
> +}
> +

Thanks,
Chris

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
