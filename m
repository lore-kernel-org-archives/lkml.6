Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81139C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5902220856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfAQIAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:00:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34414 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727491AbfAQIAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:00:39 -0500
X-UUID: ea431d14c2c54d268671b5d4f52924a8-20190117
X-UUID: ea431d14c2c54d268671b5d4f52924a8-20190117
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 153089909; Thu, 17 Jan 2019 16:00:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 16:00:32 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Jan 2019 16:00:32 +0800
Message-ID: <1547712032.5318.17.camel@mtksdaap41>
Subject: Re: [PATCH 1/3] mailbox: Add ability for clients to abort data in
 channel
From:   CK Hu <ck.hu@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Thu, 17 Jan 2019 16:00:32 +0800
In-Reply-To: <CABb+yY0JfRbdVb_3wqxve1pYH0ZpFNrA2Kr6qovBruzhbeFRuw@mail.gmail.com>
References: <20190116050435.11624-1-ck.hu@mediatek.com>
         <20190116050435.11624-2-ck.hu@mediatek.com>
         <CABb+yY0JfRbdVb_3wqxve1pYH0ZpFNrA2Kr6qovBruzhbeFRuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 0AE1DE8F454E571EC2C12497B1F87F8F86732474482BE7D983F49524CDF2F1912000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jassi:

On Wed, 2019-01-16 at 10:22 -0600, Jassi Brar wrote:
> On Tue, Jan 15, 2019 at 11:07 PM CK Hu <ck.hu@mediatek.com> wrote:
> >
> > This patch supplies a new framework API, mbox_abort_channel(), and
> > a new controller interface, abort_data().
> >
> > For some client's application, it need to clean up the data in channel
> > but keep the channel so it could send data to channel later.
> >
> > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > ---
> >  drivers/mailbox/mailbox.c          | 23 +++++++++++++++++++++++
> >  include/linux/mailbox_client.h     |  1 +
> >  include/linux/mailbox_controller.h |  4 ++++
> >  3 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > index c6a7d4582dc6..281647162c76 100644
> > --- a/drivers/mailbox/mailbox.c
> > +++ b/drivers/mailbox/mailbox.c
> > @@ -428,6 +428,29 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
> >  }
> >  EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
> >
> > +/**
> > + * mbox_abort_channel - The client abort all data in a mailbox
> > + *                     channel by this call.
> > + * @chan: The mailbox channel to be aborted.
> > + */
> > +void mbox_abort_channel(struct mbox_chan *chan)
> > +{
> > +       unsigned long flags;
> > +
> > +       if (!chan || !chan->cl)
> > +               return;
> > +
> > +       if (chan->mbox->ops->abort_data)
> > +               chan->mbox->ops->abort_data(chan);
> > +
> > +       /* The queued TX requests are simply aborted, no callbacks are made */
> > +       spin_lock_irqsave(&chan->lock, flags);
> > +       chan->cl = NULL;
> > +       chan->active_req = NULL;
> > +       spin_unlock_irqrestore(&chan->lock, flags);
> > +}
> >
> Why not just release and then request channel again ?
> mbox_abort_channel() is just a copy of mbox_free_channel() and if the
> abort can sleep, that is more reason to just do that.

The cursor may change position 300 times in one second, so I still
concern the processing time. Request and free channel looks too heavy to
do 300 times per second. Conceptually, I just want to clean up the
channel rather than free and request it, so they are somewhat different.
I say it may sleep because mbox_abort_channel() is a copy of
mbox_free_channel(). I could change it to 'must not sleep' because
Mediatek controller does not sleep in abort callback.

Regards,
CK

