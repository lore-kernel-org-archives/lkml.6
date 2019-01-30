Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DE0C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF9E20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VECr5WqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfA3F7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:59:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44106 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfA3F7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:59:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so10890532pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 21:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HlqPkWRicV9BOj0h7GSFdFM+t2KAK/T/3R7673j2NLg=;
        b=VECr5WqPbfw8w43Ly2MhUA5agL0OXJDwOCwlKyKwVzgS134IfRzrAf/O4fSolT4hZX
         eIStVsu2RBzbBZNVWaWaH6DmYwzZWKevpvilFlAx3Z7FdRjo6NAmjXj3SVAChgMhOq3v
         SSylbVcihT/vSCAq7mBWPGYGVSa00HkODgg00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HlqPkWRicV9BOj0h7GSFdFM+t2KAK/T/3R7673j2NLg=;
        b=H4jY+whfU/cQojWe705AUoMrNR4IyOMPMiV9m5MDK1VjZRl5BxX6D3kV7+OEFw1ci5
         qSDKWwfNl2Dj8Tl6X48wysh5XHKWOxH9OgNY17kI5+4ZqxL0MtzA0yWXXKzbmgWGn5WY
         ZG/jOv5rkME2iShkYH8OauCm7AzMmI6Vm7ykN8/BoUuItDi/WnTXpQmyr5V+oLQPpCs6
         LhG+wrZKLmuqM1Y+Hyq15w3/lPw4gP0YbQ/HFRgR4bXXd4Xf5cY1RAUKqSXu9ZwuoEbm
         4BgVDgc34kB3bkPVRloAylBdufSQbWg+vjsG5Ev+G3LKs95uarjeQ23+mJ7y/8a7c/4c
         NeBw==
X-Gm-Message-State: AJcUukfu85bqguRyL9hCZbN97K0ROveoZUEWJrD/vN3MZNRmWn+O0D2L
        CGYiO/531RoWggPoAp4zdbWw1Q==
X-Google-Smtp-Source: ALg8bN6W3WgkVXMV9e3mjQxX/hEuiG3E8VBXzEYhpqp+JLOFAZ35AnbEivgODr5j0j0zjLhtsfELbQ==
X-Received: by 2002:a63:d50f:: with SMTP id c15mr26409996pgg.287.1548827964113;
        Tue, 29 Jan 2019 21:59:24 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.gmail.com with ESMTPSA id x186sm787141pfb.59.2019.01.29.21.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 21:59:23 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Subject: Re: [PATCH 03/10] soc: mediatek: move the CMDQ_IRQ_MASK into cmdq
 driver data
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
Cc:     devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        srv_heupstream@mediatek.com,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        kendrick.hsu@mediatek.com, linux-mediatek@lists.infradead.org,
        Houlong Wei <houlong.wei@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Frederic Chen <Frederic.Chen@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, ginny.chen@mediatek.com
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
 <1548747128-60136-4-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <e5cffd3f-5b65-b3f3-80d8-b0567bd4baf3@chromium.org>
Date:   Wed, 30 Jan 2019 13:59:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1548747128-60136-4-git-send-email-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29/2019 03:32 PM, Bibby Hsieh wrote:
> The interrupt mask and thread number has positive correlation,
> so we move the CMDQ_IRQ_MASK into cmdq driver data and calculate
> it by thread number.
>
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c 
b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 909eb23..f6174ca 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -17,7 +17,6 @@
>   #include <linux/of_device.h>
>
>   #define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
> -#define CMDQ_IRQ_MASK			0xffff
>   #define CMDQ_NUM_CMD(t)			(t->cmd_buf_size / CMDQ_INST_SIZE)
>
>   #define CMDQ_CURR_IRQ_STATUS		0x10
> @@ -71,6 +70,7 @@ struct cmdq {
>   	void __iomem		*base;
>   	u32			irq;
>   	u32			thread_nr;
> +	u32			irq_mask;
>   	struct cmdq_thread	*thread;
>   	struct clk		*clock;
>   	bool			suspended;
> @@ -284,11 +284,11 @@ static irqreturn_t cmdq_irq_handler(int irq, 
void *dev)
>   	unsigned long irq_status, flags = 0L;
>   	int bit;
>
> -	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS) & CMDQ_IRQ_MASK;
> -	if (!(irq_status ^ CMDQ_IRQ_MASK))
> +	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS) & cmdq->irq_mask;
> +	if (!(irq_status ^ cmdq->irq_mask))
>   		return IRQ_NONE;
>
> -	for_each_clear_bit(bit, &irq_status, fls(CMDQ_IRQ_MASK)) {
> +	for_each_clear_bit(bit, &irq_status, fls(cmdq->irq_mask)) {
>   		struct cmdq_thread *thread = &cmdq->thread[bit];
>
>   		spin_lock_irqsave(&thread->chan->lock, flags);
> @@ -472,6 +472,9 @@ static int cmdq_probe(struct platform_device *pdev)
>   		dev_err(dev, "failed to get irq\n");
>   		return -EINVAL;
>   	}
> +
> +	cmdq->thread_nr = (u32)(unsigned long)of_device_get_match_data(dev);
> +	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
>   	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
>   			       "mtk_cmdq", cmdq);
>   	if (err < 0) {
> @@ -489,6 +492,7 @@ static int cmdq_probe(struct platform_device *pdev)
>   	}
>
>   	cmdq->thread_nr = (u32)(unsigned long)of_device_get_match_data(dev);
> +	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);

The cmdq->thread_nr and cmdq->irq_mask are already set above, so these 
two lines can be removed.

>   	cmdq->mbox.dev = dev;
>   	cmdq->mbox.chans = devm_kcalloc(dev, cmdq->thread_nr,
>   					sizeof(*cmdq->mbox.chans), GFP_KERNEL);
>
