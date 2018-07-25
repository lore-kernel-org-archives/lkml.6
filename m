Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04259C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3C020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rfyflpKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3C020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbeGYPIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:08:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48356 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbeGYPIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gSEPg1+zrsXZZPg4TfZPOZaPqDwvkvFVMHHHD6bgDng=; b=rfyflpKSSwsNlR24hBdnOgHLV
        GRE791sWSduPbCPf2eHYJjkYuWB/jNz9rjIiV23lG680ZvzEZ7osrp0UhgssYvkyBozD/fkfiUWLc
        G8sx+OeCqP/PgvSVhbqtPGaKyh5jZUB/QEzKAM1TnYwPW6gjjK9FIXMCkO+NKLHSM56JkbjD8cmSm
        C4lcbvDarsdFAOK9LHtBOxoUwUHUhRezHxQ+wIb51RnJFJX6HFIIuMqLU1F9eKGKYsPAWpOm2vZYU
        Fugs+CAqH5PRZgjYs89aA/PJCB2WLJnUfBCrEQoSzB7r/GgX/iDdYnSSgBmKFvonD58i8H4DWsHWI
        T43buP6tg==;
Received: from [179.95.19.99] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiKHq-0006z7-09; Wed, 25 Jul 2018 13:57:06 +0000
Date:   Wed, 25 Jul 2018 10:57:01 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Akihiro TSUKADA <tskd08@gmail.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-media@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mika.batsman@gmail.com
Subject: Re: media: dvb-usb-v2/gl861: ensure USB message buffers DMA'able
Message-ID: <20180725105701.4f3b429b@coco.lan>
In-Reply-To: <d2465376-4b3e-7d3d-86d2-0cd8d7543520@gmail.com>
References: <8308d9f0-2257-101c-69e3-8fe165de9348@canonical.com>
        <d2465376-4b3e-7d3d-86d2-0cd8d7543520@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 3 Jul 2018 21:07:07 +0900
Akihiro TSUKADA <tskd08@gmail.com> escreveu:

> Hi,
> thanks for the report.
> 
> >  47        buf = NULL;
> > 
> > Condition rlen > 0, taking false branch.
> > 
> >  48        if (rlen > 0) {
> >  49                buf = kmalloc(rlen, GFP_KERNEL);
> >  50                if (!buf)
> >  51                        return -ENOMEM;
> >  52        }
> > 
> >  53        usleep_range(1000, 2000); /* avoid I2C errors */
> >  54
> >    CID 1470241 (#1 of 1): Explicit null dereferenced (FORWARD_NULL).
> > var_deref_model: Passing null pointer buf to usb_control_msg, which
> > dereferences it.
> > 
> >  55        ret = usb_control_msg(d->udev, usb_rcvctrlpipe(d->udev, 0),
> > req, type,
> >  56                              value, index, buf, rlen, 2000);
> > 
> > 
> > The assignment of buf = NULL means a null buffer is passed down the usb
> > control message stack until it eventually gets dereferenced. This only
> > occurs when rlen <= 0.   I was unsure how to fix this for the case when
> > rlen <= 0, so I am flagging this up as an issue that needs fixing.
> >   
> 
> Since rlen is an u16, null pointer is passed only when rlen == 0,
> so I think it is not a problem,
> but I am OK to add a guard in order to make scan result clean.

There was another patch proposed to fix this issue with does the
right thing when rlen == 0. I rebased it on the top of the current
tree:
	https://git.linuxtv.org/media_tree.git/commit/?id=0b666e1c8120c0b17a8a68aaed58e22011f06ab3

That should cover both cases.

Thanks,
Mauro
