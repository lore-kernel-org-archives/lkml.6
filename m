Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282E7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03D820881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03D820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754611AbeGITdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:33:32 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:42961 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1754520AbeGITda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:33:30 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id E92B35C0090; Mon,  9 Jul 2018 19:31:57 +0000 (UTC)
Date:   Mon, 9 Jul 2018 19:31:57 +0000
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wolfram Sang <w.sang@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: mpc5xxx_can: check of_iomap return before use
Message-ID: <20180709193157.GB17865@osadl.at>
References: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
 <CAOMZO5CPVx_3kj5xKaoNbYP14cgPk9aSniyu44oWF-0jbSx91g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CPVx_3kj5xKaoNbYP14cgPk9aSniyu44oWF-0jbSx91g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:28:41PM -0300, Fabio Estevam wrote:
> On Mon, Jul 9, 2018 at 4:16 PM, Nicholas Mc Guire <hofrat@osadl.org> wrote:
> >  of_iompa() can return NULL so that return needs to be checked and NULL
> 
> s/of_iompa/of_iomap/

sorry -  thats a stupid one.

> 
> > treated as failure. While at it also take care of the missing
> > of_node_put() in the error path.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: commit afa17a500a36 ("net/can: add driver for mscan family & mpc52xx_mscan")
> > ---
> >
> > Problem was found by an experimental coccinelle script
> >
> > Patch was compiletested with: mpc5200_defconfig + CONFIG_CAN=y,
> > CONFIG_CAN_MSCAN=y, CONFIG_CAN_MPC5XXX=y
> > (with a number of sparse warnings not related to the proposed change)
> >
> > Patch is against 4.18-rc3 (localversion-next is next-20180706)
> >
> >  drivers/net/can/mscan/mpc5xxx_can.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
> > index c7427bd..2949a38 100644
> > --- a/drivers/net/can/mscan/mpc5xxx_can.c
> > +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> > @@ -86,6 +86,11 @@ static u32 mpc52xx_can_get_clock(struct platform_device *ofdev,
> >                 return 0;
> >         }
> >         cdm = of_iomap(np_cdm, 0);
> > +       if (!cdm) {
> > +               of_node_put(np_cdm);
> > +               dev_err(&ofdev->dev, "can't map clock node!\n");
> > +               return 0;
> 
> I think you should return an error code here. -ENOMEM maybe?

I don´t think so the code above this part return 0 on error and a
valid frequency on success so returning -ENOMEM would probably be
mistaken as a frequency !

thx!
hofrat
