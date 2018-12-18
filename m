Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923FEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6154021841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeLRI6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:58:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35762 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRI6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:58:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so13510246ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7KYEMhs44s2ebPt+ODy3itHlgyp/NSGEcdkxPyptwYw=;
        b=rVS7r1IMBR7rhJFZ4jSU7RkWzKLjdrnkgQOT90QPHqIzHpMxnyX181zQ6jjG2pZVM+
         RJ85kMNKr6hSWcLQhE9MTS8qkWxaLr/0uXH623gxGTetE9+Oc4VVseWc3/iABGwU69wO
         VvyVWbLAG3QFWw1FH/EXkmlLHiL9gNKW7t5zOpN5OBoOuqKpnuP60blB4kXd60JUS/Qm
         k/kChWAZ2evhY6DQvOdbLIatqA+/AbrsjPZmAoZs1jVH096AuhOifbKLegGyuCtBDAkf
         jOmwgOv0pmUszFLuPuCNrAR3L08yQAB0yQlhXlphcAwVTrOsX45kA00+rMMlM9aRCvFd
         yZpw==
X-Gm-Message-State: AA+aEWZ8fAqUbTQPrg16UF0e00YtGeXU3SXZRtL5BodLjeCGvgDwjBUZ
        v2/ZlswZwaKFTF08OGSrXG4=
X-Google-Smtp-Source: AFSGD/UJK8m/vx0UhBrwyMRtjsEBj6OqLhWy6xHLwQDIQfQXZQmtt5NV83q+TdKeKSXRn9QlcSasJw==
X-Received: by 2002:a2e:9e95:: with SMTP id f21-v6mr9480736ljk.128.1545123486508;
        Tue, 18 Dec 2018 00:58:06 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d82sm3178232lfd.82.2018.12.18.00.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 00:58:05 -0800 (PST)
Date:   Tue, 18 Dec 2018 10:58:03 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     mazziesaccount@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [RFC v2] regmap: regmap-irq: Add main status register support
Message-ID: <20181218085803.GD2477@localhost.localdomain>
References: <20181214140812.GA28723@localhost.localdomain>
 <20181217173244.GE27909@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217173244.GE27909@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 05:32:44PM +0000, Mark Brown wrote:
> On Fri, Dec 14, 2018 at 04:08:12PM +0200, Matti Vaittinen wrote:
> 
> > This is draft for approach proposed by Mark here:
> > http://lkml.iu.edu/hypermail/linux/kernel/1812.1/07117.html
> 
> > Pretty untested and diff is done against tree where the level active IRQ
> > support for regmap-irq was added. So please consider this just as a RFC
> > introducing the concept. I will format correct and better tested patch if
> > this is the preferred way to go.
> 
> Hrm, so the parsing code is indeed quite complicated.  I suspect it
> could be simplified if instead of trying to allocate just what's used it
> was a bit more wasteful and allocated the biggest arrays we might need
> but I'm not sure how much that'd really help so yeah, doing it the other
> way around might be better.

It might get a little bit simpler but not much I think. And the driver
interface could be a little bit simpler if we drop the support for
giving the "main bit mapping" as an array and only support giving the
main bits in the struct regmap_irqs. Then the num_main_status_bits,
num_main_regs and sub_reg_offsets could be made internal to regmap-irq.

OTOH dropping num_main_regs would add up one more thing requiring
dynamic allocation as we could not compute the number of main register
bits in advance.

I will proceed with the RFC v1 approach. Nothing prevents us from
implementing the v2 later if there is use-cases for that. But it will
take a while before I get this thing tested and user for it.
Additionally I guess we do need a bui-in from Lee as most of this kind
of devices with many sub blocks are likely to be represented as MFD
devices. I guess I should have included him in the recipient list for
the RFCs :/

Thanks for all the support this far!

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
