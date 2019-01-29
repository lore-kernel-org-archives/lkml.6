Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31B5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD39E20881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfA2JXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:23:04 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:49419 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725298AbfA2JXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:23:04 -0500
X-UUID: 05fc5744be63431ea482d404dfafe204-20190129
X-UUID: 05fc5744be63431ea482d404dfafe204-20190129
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1945678748; Tue, 29 Jan 2019 17:22:57 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 17:22:55 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 17:22:56 +0800
Message-ID: <1548753776.11055.4.camel@mtksdaap41>
Subject: Re: [PATCH 03/10] soc: mediatek: move the CMDQ_IRQ_MASK into cmdq
 driver data
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "YT Shen" <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, <kendrick.hsu@mediatek.com>,
        Frederic Chen <Frederic.Chen@mediatek.com>
Date:   Tue, 29 Jan 2019 17:22:56 +0800
In-Reply-To: <1548747128-60136-4-git-send-email-bibby.hsieh@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
         <1548747128-60136-4-git-send-email-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Tue, 2019-01-29 at 15:32 +0800, Bibby Hsieh wrote:
> The interrupt mask and thread number has positive correlation,
> so we move the CMDQ_IRQ_MASK into cmdq driver data and calculate
> it by thread number.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 909eb23..f6174ca 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -17,7 +17,6 @@
>  #include <linux/of_device.h>
>  
>  #define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
> -#define CMDQ_IRQ_MASK			0xffff
>  #define CMDQ_NUM_CMD(t)			(t->cmd_buf_size / CMDQ_INST_SIZE)
>  
>  #define CMDQ_CURR_IRQ_STATUS		0x10
> @@ -71,6 +70,7 @@ struct cmdq {
>  	void __iomem		*base;
>  	u32			irq;
>  	u32			thread_nr;
> +	u32			irq_mask;
>  	struct cmdq_thread	*thread;
>  	struct clk		*clock;
>  	bool			suspended;
> @@ -284,11 +284,11 @@ static irqreturn_t cmdq_irq_handler(int irq, void *dev)
>  	unsigned long irq_status, flags = 0L;
>  	int bit;
>  
> -	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS) & CMDQ_IRQ_MASK;
> -	if (!(irq_status ^ CMDQ_IRQ_MASK))
> +	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS) & cmdq->irq_mask;
> +	if (!(irq_status ^ cmdq->irq_mask))
>  		return IRQ_NONE;
>  
> -	for_each_clear_bit(bit, &irq_status, fls(CMDQ_IRQ_MASK)) {
> +	for_each_clear_bit(bit, &irq_status, fls(cmdq->irq_mask)) {

for_each_clear_bit(bit, &irq_status, cmdq->thread_nr) {

Regards,
CK

>  		struct cmdq_thread *thread = &cmdq->thread[bit];
>  
>  		spin_lock_irqsave(&thread->chan->lock, flags);
> @@ -472,6 +472,9 @@ static int cmdq_probe(struct platform_device *pdev)
>  		dev_err(dev, "failed to get irq\n");
>  		return -EINVAL;
>  	}
> +
> +	cmdq->thread_nr = (u32)(unsigned long)of_device_get_match_data(dev);
> +	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
>  	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
>  			       "mtk_cmdq", cmdq);
>  	if (err < 0) {
> @@ -489,6 +492,7 @@ static int cmdq_probe(struct platform_device *pdev)
>  	}
>  
>  	cmdq->thread_nr = (u32)(unsigned long)of_device_get_match_data(dev);
> +	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
>  	cmdq->mbox.dev = dev;
>  	cmdq->mbox.chans = devm_kcalloc(dev, cmdq->thread_nr,
>  					sizeof(*cmdq->mbox.chans), GFP_KERNEL);


