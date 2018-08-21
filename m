Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62C7C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9ED217B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9ED217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeHUS0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:26:54 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55701 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbeHUS0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:26:54 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fs8EU-0000CF-UV; Tue, 21 Aug 2018 17:06:10 +0200
Message-ID: <1534863967.5009.7.camel@pengutronix.de>
Subject: Re: [PATCH] mailbox: mediatek: Add check for possible failure of
 kzalloc
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Houlong Wei <houlong.wei@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Monica Wang <monica.wang@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Sascha Hauer <kernel@pengutronix.de>, enzhu.wang@mediatek.com,
        CK HU <ck.hu@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, ginny.chen@mediatek.com
Date:   Tue, 21 Aug 2018 17:06:07 +0200
In-Reply-To: <1534846964-13224-1-git-send-email-houlong.wei@mediatek.com>
References: <1534846964-13224-1-git-send-email-houlong.wei@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-21 at 18:22 +0800, Houlong Wei wrote:
> The patch 623a6143a845("mailbox: mediatek: Add Mediatek CMDQ driver")
> introduce the following static checker warning:
>   drivers/mailbox/mtk-cmdq-mailbox.c:366 cmdq_mbox_send_data()
>   error: potential null dereference 'task'.  (kzalloc returns null)
> 
> Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index aec46d5..f7cc29c 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -363,6 +363,9 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
>  	WARN_ON(cmdq->suspended);
>  
>  	task = kzalloc(sizeof(*task), GFP_ATOMIC);
> +	if (!task)
> +		return -ENOMEM;
> +
>  	task->cmdq = cmdq;
>  	INIT_LIST_HEAD(&task->list_entry);
>  	task->pa_base = pkt->pa_base;

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
