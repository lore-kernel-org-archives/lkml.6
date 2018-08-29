Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EC9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4B020652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKDpvJl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4B020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeH2WlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbeH2WlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:41:14 -0400
Received: from mail-qt0-f177.google.com (mail-qt0-f177.google.com [209.85.216.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23B6220652;
        Wed, 29 Aug 2018 18:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535568183;
        bh=56r5KIRezoWLE57HXbPwoX55wETt4iHkCeCnNjabyS8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MKDpvJl6f+Vq4y/Akywln8lCiy/unoa1HqvGD9hyiM7v6Cb9ZrLcUEWtoHxLP5Tm/
         GnnEXyWuIk8cqA3Jf2hkPilJRNj0KeY1YvJKYoiXQn1BiUCQNokvrbDqvc+GxhffLT
         /TikkdWUpcipfTF0ijYw/BS2CDeAVYAr8VZTzkOg=
Received: by mail-qt0-f177.google.com with SMTP id j7-v6so6973104qtp.2;
        Wed, 29 Aug 2018 11:43:03 -0700 (PDT)
X-Gm-Message-State: APzg51ABtxuSYMbXo+ZGwi2TvWwSFJUFSZWIqHX69U+7OMXqNSqDog0l
        HlP1sDbkv0xiF/13TB5qMJAgA5AlR4P85sHrXw==
X-Google-Smtp-Source: ANB0VdZ7ZT5uf11FbLt81RGbSicLmcnThySm045r7UHhHeDHQci1uCjbrRoK+yt8OdY3lzW4Ug+qFklsuI35OIaSE40=
X-Received: by 2002:a0c:db87:: with SMTP id m7-v6mr7853785qvk.90.1535568182327;
 Wed, 29 Aug 2018 11:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-21-robh@kernel.org>
 <3fa33583-f748-1708-2274-0a6f4e81004b@axentia.se>
In-Reply-To: <3fa33583-f748-1708-2274-0a6f4e81004b@axentia.se>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Aug 2018 13:42:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJcDdntsi3D=neU=Dhx0Xku_XPFC_OCLRb8V==HTtviBQ@mail.gmail.com>
Message-ID: <CAL_JsqJcDdntsi3D=neU=Dhx0Xku_XPFC_OCLRb8V==HTtviBQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: Convert to using %pOFn instead of device_node.name
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 1:03 PM Peter Rosin <peda@axentia.se> wrote:
>
> On 2018-08-28 03:52, Rob Herring wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Peter Rosin <peda@axentia.se>
> > Cc: linux-i2c@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/i2c/busses/i2c-powermac.c | 15 ++++++++-------
> >  drivers/i2c/muxes/i2c-mux-gpmux.c |  4 ++--
> >  2 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
> > index f2a2067525ef..b706fd136ca5 100644
> > --- a/drivers/i2c/busses/i2c-powermac.c
> > +++ b/drivers/i2c/busses/i2c-powermac.c
> > @@ -390,7 +390,6 @@ static int i2c_powermac_probe(struct platform_device *dev)
> >       struct pmac_i2c_bus *bus = dev_get_platdata(&dev->dev);
> >       struct device_node *parent = NULL;
>
> Lose the initializer...

That's pretty much unrelated though. I'd have to write "Also, remove
the unnecessary parent pointer init" in the commit message and we all
know "Also" is a clue for belongs in a separate patch.

Rob
