Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F77C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B31920855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUh1Fg+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B31920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeK0CoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:44:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41654 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0CoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:44:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so14066077plm.8;
        Mon, 26 Nov 2018 07:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ax80HaM0ngCv/Ch7DuWqHZSFXmVmaFHDGlJsWSE1iIE=;
        b=fUh1Fg+WaTi/kNtiaeZmMcMTzVKugtNQq9J4Q+pi34SRGPcgq8zUi9jO2OJAs0RXh9
         XhPFu50hhc0d7/w1163dvwHfvJwQUqPe69QP+72t3Z8ooVmYYl6h3nj0ugNe3EX3j+CZ
         L08XnpMi/p4FP74jlorK26WgZ6mP6dJPbaazmhcQvTLKcJEv9udo6Gz0CIXeBkg+gmx8
         P/xjq9KLfjL88+EGxuXjyFnK7pzg5rqxEVRFZDnMr5uOZ0o1yi2ip1FHWKpKREw0Ue26
         591tWrs+FXKZ3oUms4hfTpHCaGJVOw9NpdC5mShxBFvJQiHYPyzyhrUqeGEs22FxXkSg
         PUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ax80HaM0ngCv/Ch7DuWqHZSFXmVmaFHDGlJsWSE1iIE=;
        b=YiiJeAozNA0Kkeg0Y1LYs7bzHvhow/6ldtsRooSL1a/wS1rRZLbojsjXy/Pc7E2/88
         yfD6r+1Z44QVOwakk+rzi6fgyOSqSc9HtQxgIL388vX5m4PhXz9Andyo8GeOeCUMlLqr
         Oi67+4rikMfG5zMsxpnT2axFSx0YSNO0voQPlQK6Cb0b42ebwyB0mL0cKAliTvmlRty7
         6wm4o+2iAFxoR0U4XgIgPVF7AOcCjqo+xGjacwMi51zJ0Ka8SaiMqBwLouBvBQPppJDc
         8gdz3dKAJ74+EfC+zt+yAjaYtGv2062CVEUA7uPXpRpyFycMxwHtr8PwY+DGJ+E96lZJ
         kgQA==
X-Gm-Message-State: AA+aEWbnSUhTLFPycNc+XqVau9uAX4VUDRkuXySRi8cjOrzTc25Lr8Lq
        y8JGS1SY2y9G4J4mlGp0XAI=
X-Google-Smtp-Source: AFSGD/V0Ww2JPmW4ffMgRTotZbrbSyAs5oV9zkkWXrbVqhCpfy+vJ3atW8zQvrKp9Jb2s+22aOhS2w==
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr27541296plo.59.1543247374358;
        Mon, 26 Nov 2018 07:49:34 -0800 (PST)
Received: from pi ([12.219.193.5])
        by smtp.gmail.com with ESMTPSA id d16sm729997pgj.21.2018.11.26.07.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 07:49:33 -0800 (PST)
X-Google-Original-Sender: <johan@kernel.org>
Received: from johan by pi with local (Exim 4.91)
        (envelope-from <johan@pi>)
        id 1gRJ7Y-0000wa-IQ; Mon, 26 Nov 2018 07:48:24 -0800
Date:   Mon, 26 Nov 2018 07:48:24 -0800
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        nicolas.ferre@microchip.com, rainyfeeling@outlook.com,
        johan@kernel.org
Subject: Re: [PATCH 4.14 58/62] mtd: rawnand: atmel: fix OF child-node lookup
Message-ID: <20181126154824.GA2403@localhost>
References: <20181126105050.592727680@linuxfoundation.org>
 <20181126105054.941598787@linuxfoundation.org>
 <CA+G9fYsyM9VS8QkaEizQT_LSvZyT+h6zdoWZbhVQtd1n60Bniw@mail.gmail.com>
 <20181126160840.1c702e87@bbrezillon>
 <20181126151418.GA19698@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126151418.GA19698@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:14:18PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 26, 2018 at 04:08:40PM +0100, Boris Brezillon wrote:
> > On Mon, 26 Nov 2018 19:46:15 +0530
> > Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > 
> > > Do you see build failure arm x15 beagleboard on 4.14 due to this patch ?
> > > 
> > > On Mon, 26 Nov 2018 at 16:31, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > > >
> > > > ------------------
> > > >
> > > > From: Johan Hovold <johan@kernel.org>
> > > >
> > > > commit 5d1e9c2212ea6b4dd735e4fc3dd6279a365d5d10 upstream.
> > > >
> > > > Use the new of_get_compatible_child() helper to lookup the nfc child
> > > > node instead of using of_find_compatible_node(), which searches the
> > > > entire tree from a given start node and thus can return an unrelated
> > > > (i.e. non-child) node.
> > > >
> > > > This also addresses a potential use-after-free (e.g. after probe
> > > > deferral) as the tree-wide helper drops a reference to its first
> > > > argument (i.e. the node of the device being probed).
> > > >
> > > > While at it, also fix a related nfc-node reference leak.
> > > >
> > > > Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> > > > Cc: stable <stable@vger.kernel.org>     # 4.11
> > > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > > Cc: Josh Wu <rainyfeeling@outlook.com>
> > > > Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > ---
> > > >  drivers/mtd/nand/atmel/nand-controller.c |   11 +++++++----
> > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > >
> > > > --- a/drivers/mtd/nand/atmel/nand-controller.c
> > > > +++ b/drivers/mtd/nand/atmel/nand-controller.c
> > > > @@ -2077,8 +2077,7 @@ atmel_hsmc_nand_controller_legacy_init(s
> > > >         int ret;
> > > >
> > > >         nand_np = dev->of_node;
> > > > -       nfc_np = of_find_compatible_node(dev->of_node, NULL,
> > > > -                                        "atmel,sama5d3-nfc");
> > > > +       nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
> > > >         if (!nfc_np) {
> > > >                 dev_err(dev, "Could not find device node for sama5d3-nfc\n");
> > > >                 return -ENODEV;
> > > > @@ -2492,15 +2491,19 @@ static int atmel_nand_controller_probe(s
> > > >         }
> > > >
> > > >         if (caps->legacy_of_bindings) {
> > > > +               struct device_node *nfc_node;
> > > >                 u32 ale_offs = 21;
> > > >
> > > >                 /*
> > > >                  * If we are parsing legacy DT props and the DT contains a
> > > >                  * valid NFC node, forward the request to the sama5 logic.
> > > >                  */
> > > > -               if (of_find_compatible_node(pdev->dev.of_node, NULL,
> > > > -                                           "atmel,sama5d3-nfc"))
> > > > +               nfc_node = of_get_compatible_child(pdev->dev.of_node,
> > > > +                                                  "atmel,sama5d3-nfc");
> > > > +               if (nfc_node) {
> > > >                         caps = &atmel_sama5_nand_caps;
> > > > +                       of_node_put(nfc_node);
> > > > +               }
> > > >
> > > >                 /*
> > > >                  * Even if the compatible says we are dealing with an
> > > >
> > > >  
> > > 
> > > /drivers/mtd/nand/atmel/nand-controller.c: In function
> > > 'atmel_hsmc_nand_controller_legacy_init':
> > > /drivers/mtd/nand/atmel/nand-controller.c:2080:11: error: implicit
> > > declaration of function 'of_get_compatible_child'; did you mean
> > > 'of_get_next_available_child'? [-Werror=implicit-function-declaration]
> > >    nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
> > 
> > Looks like of_get_compatible_child() has been introduced in 4.18, hence
> > this error.
> > 
> > Greg, can you drop this patch from 4.14.y?
> 
> Yes, my fault, I fixed a number of these in the past, missed this one :(
> 
> Now dropped.

The intention here was that the helper should be backported along with
the fixes. I mentioned this in the cover letter to the series
introducing the helper and the fixes. As they were submitted together I
could not use the usual

	Cc: stable <stable@vger.kernel.org>	# 4.xx: 36156f9241cb

notation for this. I realise I should still have mentioned this in each
individual commit messages as well, sorry about that.

The dependency for all of these fixes is:

	36156f9241cb ("of: add helper to lookup compatible child node")

and the original thread can be found here:

	https://lkml.kernel.org/r/20180827082153.22537-1-johan@kernel.org
	
Johan
