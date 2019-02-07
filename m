Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E9BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED63B218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549567264;
	bh=/cMSLj2VGJs5zQ38rwag4loQ8qgI57k6ab4pPdQhwO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IWBx/NUL39r66E0cYGmkMkgRh8+vkK+rwlHj0gEP3FHXQawU4yrWPXwMEPYLAAc1p
	 GknMl2GQD6uG4N8ui0CRjUzjZXCETtCpsuMJqtvZL7BTUabXqr8nuMb+frlMDFBqTS
	 3MwyCrz0UObIUlt3CnZI77KCsGd6J1l7pZmJvQDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfBGTVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:21:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45061 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGTVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:21:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so1700968ota.12;
        Thu, 07 Feb 2019 11:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gu3h9Vd/JDdqiaV7QYobe+QXyM9WZMKqdJeXpHh7bZg=;
        b=tOU8MJ0ymaF5kV3teaQwT5uaa7sEMICO5xhn0pvGAlXDfEPRq5oF82tLpgpyeuZVjI
         KXqTAsoVw0yRfEM9Q9ApqQmYUgkfRsEIpixcrIuPc65Q1HrdBVOB5KSpyjhTXCnWRvrl
         X3+++dkR6M+L3Fga5Kj7JsQnz8QDTGjiXH5nCG4BcUf/5TmLsJtDu8B/n4nWt5AsYElm
         plFtzSLnlm8uXZs+J+cn3HfNjlMYwKjaQjLzX+GZ53fu1gDCoM2vgO9JKvG4BPYiPmz7
         Vqs0oHEzDo1QfMxXJLZVjUNFYO1KWBn493ZSN8kGwsXS+R5VRrKNLELSmfVA929TkcrU
         Zceg==
X-Gm-Message-State: AHQUAuazarJt8l+1+PRtimUKQSIUZNLi2iVhifO0cmbTpoZlvjEVXHi8
        MX6/3XnS5y+RMAmPzvs+lThRjLbWBH/ckGGn4To=
X-Google-Smtp-Source: AHgI3IamBElddRo9RmM7XO1L1C1iD6+CKB84qqcUWlzMYTi1/WXcUZFQvI3p20BtGu30b7wz1q+2maeQYYLqSZMVFh0=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr9931355otg.139.1549567261207;
 Thu, 07 Feb 2019 11:21:01 -0800 (PST)
MIME-Version: 1.0
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <3655840.AXlINldeOc@aspire.rjw.lan>
 <20190207191508.pa7g5c2vhxksrtio@wunner.de>
In-Reply-To: <20190207191508.pa7g5c2vhxksrtio@wunner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Feb 2019 20:20:49 +0100
Message-ID: <CAJZ5v0jvSh7ArL8+z_5ywVzovBz1nqihExGf0VjcJSHsvBvqAQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] driver core: Fix handling of runtime PM flags in device_link_add()
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

On Thu, Feb 7, 2019 at 8:15 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Fri, Feb 01, 2019 at 01:49:14AM +0100, Rafael J. Wysocki wrote:
> > After commit ead18c23c263 ("driver core: Introduce device links
> > reference counting"), if there is a link between the given supplier
> > and the given consumer already, device_link_add() will refcount it
> > and return it unconditionally without updating its flags.  It is
> > possible, however, that the second (or any subsequent) caller of
> > device_link_add() for the same consumer-supplier pair will pass
> > DL_FLAG_PM_RUNTIME, possibly along with DL_FLAG_RPM_ACTIVE, in flags
> > to it and the existing link may not behave as expected then.
> [...]
> > Fixes: ead18c23c263 ("driver core: Introduce device links reference counting")
>
> I think this should be:
>
> Fixes: 21d5c57b3726 ("PM / runtime: Use device links")

Again, sorry for failing to look deeper into the past.

Yes, there should be

Fixes: 21d5c57b3726 ("PM / runtime: Use device links")

in the changelog of this patch, but again, I still would add the other
Fixes: tag too as the issue is still present after ead18c23c263 and
that commit is needed for the patch to apply.
