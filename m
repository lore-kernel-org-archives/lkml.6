Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BC4C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C35218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549566686;
	bh=sJsPckalazkIS4IGKvtzn/jtY3hQdoalwxbpODOgaaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KgRdWl35Hva8sLaEZxHHaJw54VRvSgXq23g9QLatCojgFOIkW5JKzsu/0jp9aUlBl
	 +jNXjksei3caV6qRqwmRBinv83cXWMla9GKyybA4+B2glCpGVuMOf5Bi8JYmuVe/oy
	 j2MRV15JLLb73H5yWn1t5dO873tohfLx7gWW0VOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfBGTLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:11:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33608 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfBGTLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:11:22 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so1794724otl.0;
        Thu, 07 Feb 2019 11:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJG72g6Kf3jio022jxa9wuXY7Jt/DK1D0lRKNRKikTg=;
        b=AwnStN8V6Yw68od8fAETmyqO9IQSLi51IaB/Ql2EuIJ7s/pNtbb+GtV/3d0wT/8z4J
         W44WHx8u4Wy9snNI85wY641+HjL05qEN1Iz/hbOU2W32yBR+X8PvPsX4jfP4QIM6r1q9
         qQnnNR56hq4vSRbBxo2QCM8TK5fGpG6kkeNdYShdZ2RMsrzSijfH4dmZicfh6ElEqX7A
         qPN0l97Kaevt7dLJqGV6OZfN2a/6Kd7qc9o/1OBWe8Q4USuhYMyeNduDrgQSgpDpn+7K
         DsIe8DN9nRy7QglRrx4XeJpmnNiMZBMyKBB1nD9xIXD1DUfwOzR5fRCpcLygPsygsEYI
         CHdA==
X-Gm-Message-State: AHQUAubcBVHPK0Z5Q7OUaapgjHcGDh9CDmlRW/YO0X+bUXYuzrID8N3j
        FKxrrfivIt8ABgl/6gGTfUDJkr+rrl6zsmb4GV8=
X-Google-Smtp-Source: AHgI3IZBXlhouFpqlqHSvhXgYmeVI7bxzFiMjv0iqoUL6RgoHMAMTAcK1eWa9PZanalBFzaNrAdCwc2JE7FMemvpHds=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr1175161oia.95.1549566681008;
 Thu, 07 Feb 2019 11:11:21 -0800 (PST)
MIME-Version: 1.0
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <2222273.ydJmd408XJ@aspire.rjw.lan>
 <20190207190326.wjxnzo4ja62t3mt6@wunner.de>
In-Reply-To: <20190207190326.wjxnzo4ja62t3mt6@wunner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Feb 2019 20:11:10 +0100
Message-ID: <CAJZ5v0i9rpac5JyOxuT2dS9Bn2G1YPtWXRvRpU299_yFmhifnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] driver core: Avoid careless re-use of existing
 device links
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 8:03 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> Sorry, late to the party.
>
> On Fri, Feb 01, 2019 at 01:46:54AM +0100, Rafael J. Wysocki wrote:
> > After commit ead18c23c263 ("driver core: Introduce device links
> > reference counting"), if there is a link between the given supplier
> > and the given consumer already, device_link_add() will refcount it
> > and return it unconditionally.  However, if the flags passed to
> > it on the second (or any subsequent) attempt to create a device
> > link between the same consumer-supplier pair are not compatible with
> > the existing link's flags, that is incorrect.
>
> Prior to ead18c23c263, a second invocation of device_link_add() also
> returned the existing device link without checking for incompatible
> flags.  Hence this issue was not introduced by ead18c23c263, but
> rather by 9ed9895370ae ("driver core: Functional dependencies tracking
> support"), i.e. it was present all along.  (Unless I'm missing something.)
>
>
> > Moreover, if the DL_FLAG_AUTOREMOVE_CONSUMER flag is passed to
> > device_link_add(), its caller will expect its reference to the link
> > to be dropped automatically on consumer driver removal, which will
> > not happen if that flag is not set in the link's flags (and
> > analogously for DL_FLAG_AUTOREMOVE_SUPPLIER).  For this reason, make
> > device_link_add() update the existing link's flags accordingly
> > before returning it to the caller.
>
> Same here.
>
>
> > Fixes: ead18c23c263 ("driver core: Introduce device links reference counting")
>
> Should rather be
> Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
>
> (Again, unless I'm missing something.)

I haven't checked far enough into the past, sorry about that.

You are right, but actually I think that

Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")

should be there in addition to the other Fixes: tag, because the issue
is still present after that commit and the patch does not apply
directly on top of 9ed9895370ae.
