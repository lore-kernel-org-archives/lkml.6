Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D68C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D583220837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kiqbyUXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D583220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeLGGOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:14:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33483 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeLGGOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:14:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so2707461wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EFYSU6apxghl8rrftuKMJ1VhpXFh59I6CoksMqtvChg=;
        b=kiqbyUXRqiym2hHENUNHlP9gy4fwpjZbjdtiMIdQHUc90EALY/rVus6vWvpBWDaKlc
         crWe/m4soAryQtPMokzB92JxkvPXsGzS8UJwNhpuBj4mGbgn1VNZ/QbqIGwTI559iiI9
         64M54FW0e6bblGTiQV+J+aXd2LAyMeWVlThXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EFYSU6apxghl8rrftuKMJ1VhpXFh59I6CoksMqtvChg=;
        b=QG90J3HWZ/078Qw9GaFtYa/ChG6Es4sLfpj8PcEqZM/ep3+PcYtJNTNraCAt6xxQqN
         xykunmAIg2DV/RfITJW1EPdumea4yG7J/6ptf5EmwgZ2qfCH6riGQw+pXH5AnY5Ch9hh
         ddU+1rl9a8/J4HS0SQF9L1XEHY97ztwCvIpu6rXIdeYiigb4XPWYHDV6nvSyfR8sUkrh
         uuRcVJlXCivmC0wfjsYIUaOpKLh8xsK7CQqcuBhL2gSgM8a+JDLFmF9ol38FrINiPlO6
         vBS53mMjjHJeYzBmzRTH1aQF6S3PUqipvIT7xvG8M/I1kfC5NzGyMD3flN/RizqLbxwh
         wg0w==
X-Gm-Message-State: AA+aEWY7czAPjC8vpFa6zeBN9UnIGzbQ3KYCN5jg2RsyITzs/C/vgkOX
        gWjyMRGPcMCrRDl0X6FgomOgQQ==
X-Google-Smtp-Source: AFSGD/ULy5ZePRH8JeemNrZ/6tiv55zBw9nGdKQvH0XHQ48MNkIrRiTENegUCox1pLpfVCtgA0Tamg==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr742721wru.245.1544163275254;
        Thu, 06 Dec 2018 22:14:35 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id v187sm762084wme.0.2018.12.06.22.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 22:14:34 -0800 (PST)
Date:   Fri, 7 Dec 2018 14:14:27 +0800
From:   leo.yan@linaro.org
To:     Kevin Wangtao <kevin.wangtao@hisilicon.com>
Cc:     <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <gengyanping@hisilicon.com>, <suzhuangluan@hisilicon.com>,
        John Stultz <john.stultz@linaro.org>,
        Guodong Xu <guodong.xu@linaro.org>
Subject: Re: [PATCH v2] mailbox: Hi3660: Fixup mailbox state machine
 malfunction issue
Message-ID: <20181207061427.GB24211@leoy-ThinkPad-X240s>
References: <1543809309-61169-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1543817588-82411-1-git-send-email-kevin.wangtao@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543817588-82411-1-git-send-email-kevin.wangtao@hisilicon.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 02:13:08PM +0800, Kevin Wangtao wrote:
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

Thanks for sending out this patch, Kevin.

I tested this patch at my side with two cases (one is dhry2 for
performance testing for every OPPs, and another is stress test
two clusters frequency change concurrently), both of them can
pass after applied this patch.

Reviewed-and-tested-by: Leo Yan <leo.yan@linaro.org>

Jassi, please review and pick it up if it's okay for you.

Thanks,
Leo Yan

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
> -- 
> 2.8.1
> 
