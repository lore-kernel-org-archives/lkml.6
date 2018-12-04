Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FE7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6522D20672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6522D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeLDOgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:36:41 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:37945 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeLDOgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:36:41 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 00E435C0FF8; Tue,  4 Dec 2018 14:36:00 +0000 (UTC)
Date:   Tue, 4 Dec 2018 15:36:00 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Peter Rosin <peda@axentia.se>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: handle failure case of
 devm_kstrdup()
Message-ID: <20181204143600.GB16001@osadl.at>
References: <1543658470-20887-1-git-send-email-hofrat@osadl.org>
 <37b8709c-0b58-7bc9-22c5-e01953593d06@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37b8709c-0b58-7bc9-22c5-e01953593d06@axentia.se>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:11:33PM +0000, Peter Rosin wrote:
> Ho hmm. Had another look at this patch, or rather, the context of the
> patch so not really related, but...
> 
> On 2018-12-01 11:01, Nicholas Mc Guire wrote:
> > devm_kstrdup() may return NULL if internal allocation failed.
> > Thus using  name, value  is unsafe without being checked. As
> > i2c_demux_pinctrl_probe() can return -ENOMEM in other cases
> > a dev_err() message is included to make the failure location
> > clear.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: e35478eac030 ("i2c: mux: demux-pinctrl: run properly with multiple instances")
> > ---
> > 
> > Problem located with experimental coccinelle script
> > 
> > Q: The use of devm_kstrdup() seems a bit odd while technically not wrong,
> >    personally I think devm_kasprintf() would be more suitable here.
> > 
> > Patch was compile tested with: multi_v7_defconfig 
> > (implies I2C_DEMUX_PINCTRL=y)
> > 
> > Patch is against 4.20-rc4 (localversion-next is next-20181130)
> > 
> >  drivers/i2c/muxes/i2c-demux-pinctrl.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> > index 035032e..c466999 100644
> > --- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
> > +++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> > @@ -244,6 +244,12 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
> >  
> >  		props[i].name = devm_kstrdup(&pdev->dev, "status", GFP_KERNEL);
> >  		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
> 
> It seemed very dubious to use devm_kstrdup here, since
>

yup - which is where the question in the initial pach came
from I felt that this should better be a devm_kasprint() - I
did not understand why it was kstrdup here in the first
place - technically it is not wrong though as the source is not RO
so it will allocate and copy the original string and thus
effectively it behaves like devm_kasprintf
 
> 1. if the consumer is not freeing the strings it would be sufficient with just
>   		props[i].name = "status";
>   		props[i].value = "ok";
> 
> 2. if the consumer is freeing the strings, it is very bad to free them twice
>    which is what happens with the devm_ prefix.

Why would it be freed twice ? the pointer returned is a seperately allocated objects ?
that needs to be indepdently freed (this is not the devm_kstrdup_const() case)

> 
> So, there is no case, AFAICT, where it is sane to use devm_kstrdup.

I think the only technical difference between devm_kstrdup and devm_kasprintf
is effectively a memcpy vs vsnprintf - so here I think devm_kasprintf would
also be the more suitable call to use.

thx!
hofrat

> 
> Therefore I had a look at the code, and to me it seems as if the consumer
> very much frees the strings, which means that we are in case 2, and that
> the above should be ordinary kstrdup calls.
> 
> Am I missing something?
> 
> Cheers,
> Peter
> 
> > +		if (!props[i].name || !props[i].value) {
> > +			dev_err(&pdev->dev,
> > +				"chan %d name, value allocation failed\n", i);
> > +			err = -ENOMEM;
> > +			goto err_rollback;
> > +		}
> >  		props[i].length = 3;
> >  
> >  		of_changeset_init(&priv->chan[i].chgset);
> > 
> 
