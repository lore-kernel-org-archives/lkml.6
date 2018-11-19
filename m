Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D110BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0EC2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0EC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390112AbeKTEEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:04:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54123 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388998AbeKTDN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:13:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C8B9420791; Mon, 19 Nov 2018 17:49:42 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4DF5120D27;
        Mon, 19 Nov 2018 17:49:26 +0100 (CET)
Date:   Mon, 19 Nov 2018 17:49:25 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     vitor <vitor.soares@synopsys.com>
Cc:     Colin King <colin.king@canonical.com>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][i3c-next] i3c: master: fix mask operation by using the
 correct operator
Message-ID: <20181119174925.0733862e@bbrezillon>
In-Reply-To: <7d569740-e5d3-b8a6-79cf-9885039e53de@synopsys.com>
References: <20181116184223.28240-1-colin.king@canonical.com>
        <7d569740-e5d3-b8a6-79cf-9885039e53de@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 12:41:10 +0000
vitor <vitor.soares@synopsys.com> wrote:

> Hi Coling,
> 
> 
> Thanks for your report.
> 
> On 16/11/18 18:42, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The masking operation on status is using a bitwise 'or' rather than
> > a bitwise 'and' operator, and hence the result is always non-zero
> > which is probably not what is intended. Fix this by using the correct
> > operator.
> >
> > Detected by CoverityScan, CID#1475523 ("Wrong operator used")
> >
> > Fixes: 88acc98a712a ("i3c: master: Add driver for Synopsys DesignWare IP")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >   drivers/i3c/master/dw-i3c-master.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> > index 0153e6e9de52..b532e2c9cf5c 100644
> > --- a/drivers/i3c/master/dw-i3c-master.c
> > +++ b/drivers/i3c/master/dw-i3c-master.c
> > @@ -1085,7 +1085,7 @@ static irqreturn_t dw_i3c_master_irq_handler(int irq, void *dev_id)
> >   
> >   	spin_lock(&master->xferqueue.lock);
> >   	dw_i3c_master_end_xfer_locked(master, status);
> > -	if (status | INTR_TRANSFER_ERR_STAT)
> > +	if (status & INTR_TRANSFER_ERR_STAT)
> >   		writel(INTR_TRANSFER_ERR_STAT, master->regs + INTR_STATUS);
> >   	spin_unlock(&master->xferqueue.lock);
> >     
> Acked-by: Vitor Soares <vitor.soares@synopsys.com>

Applied.

Thanks,

Boris
