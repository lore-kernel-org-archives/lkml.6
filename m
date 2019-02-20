Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0451C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650C22089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550699414;
	bh=APcw3UC/L2cNh1JeEqIOl/GQ4cSVycgsS5tNpPzBikg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K11LhViB+QjzYeSGgAw5ExX1pCdvi/4JwA3/ashdDI9z5B2iZ3PB7nBQLkXMDI/mo
	 KfRZ3kYXQhm5QfkH7sYwmQLnB8vi9ogTcFsqw9KOZPNj9TN3bTnreQLp7ppN6htDxt
	 Wgk6Av27o5SPR0/tM6V51an3rXCyrz+/6LpaSWXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfBTVuM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:50:12 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43206 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBTVuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:50:12 -0500
Received: by mail-ot1-f68.google.com with SMTP id n71so42824571ota.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 13:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qt/JjFPGTIgip7nwHCwFSU4hARZBSGfjL/+6z7+lSC4=;
        b=BMLOzd152GeivXtWWIxvT07w0jmp5DfUSu+sTob/YaEXBPe+itPaK0O7MNKEfbSrXs
         i+0A446ZFMSkLqoCxTShBJp/WEEWBBIo7j7g6AWpy3XteiykK3zBZWQbTxyhuYmp0lrA
         MvkWS39+QYOXEyZcf0h2nc9npEcIc/EdU5gaHJfy2fxrJzE+qhmczYqqRoLMoFsn21Up
         Ua2J9PRFelNbYNogRExtSmdUCPFh2ZfQkeruAMOWPGIfHwocNHmtjJcw8xGWh3cihWVF
         daSjJDJcse3PUpjJGUd8SKkTbkrh8TSEgx60ajCiogp+0cSqvKDZdJlxBc7FAvOlcf8Y
         GIFQ==
X-Gm-Message-State: AHQUAuYUDL6aHHgL2GkPJ6FlXT0409bbl1ZcPBuswplGj2iuPyc9NqDi
        NmVhmbyN35PSz9QMZ0BQN9gPdDtDRii15S64zcU=
X-Google-Smtp-Source: AHgI3Iapt0EtjcFI1uilDv6pqknPXYugz1woA4KC+0B88dt9jga4uNZcooEv9ZY5hakFJzsjtD6OJKe0jTACs6rV7tY=
X-Received: by 2002:a9d:5a0b:: with SMTP id v11mr21097092oth.124.1550699411168;
 Wed, 20 Feb 2019 13:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20190216164512.9525-1-mans@mansr.com> <20190220113506.11009-1-mans@mansr.com>
 <20190220115117.GK4072@localhost> <yw1ximxewte5.fsf@mansr.com>
 <CAJZ5v0jTxeVrDSA8RMVZ+U7-TvPN72ZcF+J4r66-dhngaWpiAw@mail.gmail.com> <yw1xef82wsqh.fsf@mansr.com>
In-Reply-To: <yw1xef82wsqh.fsf@mansr.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 22:50:00 +0100
Message-ID: <CAJZ5v0gXfCO_u0moXRAMOdNJztxYUwdy2FVUef3QX7LjKGb-Zg@mail.gmail.com>
Subject: Re: [PATCH] platform: set of_node in platform_device_register_full()
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 1:26 PM Måns Rullgård <mans@mansr.com> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Wed, Feb 20, 2019 at 1:12 PM Måns Rullgård <mans@mansr.com> wrote:
> >>
> >> Johan Hovold <johan@kernel.org> writes:
> >>
> >> > On Wed, Feb 20, 2019 at 11:35:06AM +0000, Mans Rullgard wrote:
> >> >> If the provided fwnode is an OF node, set dev.of_node as well.
> >> >>
> >> >> Some drivers are just shims that create extra "glue" devices with the
> >> >> DT device as parent and have the real driver bind to these.  In these
> >> >> cases, the glue device needs to get a reference to the original DT node
> >> >> in order for the main driver to access properties and child nodes.
> >> >>
> >> >> For example, the sunxi-musb driver creates such a glue device using
> >> >> platform_device_register_full().  Consequently, devices attached to
> >> >> this USB interface don't get associated with DT nodes, if present,
> >> >> the way they do with EHCI.
> >> >>
> >> >> This change will allow sunxi-musb and similar driver to easily
> >> >> propagate the DT node to child devices as required.
> >> >
> >> > Just a drive-by comment, didn't look to closely at this patch, but this
> >> > all sounds familiar.
> >> >
> >> > Note that if both platform devices are bound to drivers you may end up
> >> > with some resources like pinctrl which are handled automatically by
> >> > driver core at probe time to be requested twice (and failing the second
> >> > time).
> >> >
> >> > Take a look at 4e75e1d7dac9 ("driver core: add helper to reuse a
> >> > device-tree node"), which provides a means to avoid this, and
> >> > 49484abd93ab ("USB: musb: dsps: propagate device-tree node").
> >>
> >> Thanks, and ugh.  So we should be setting the of_node_reused flag when
> >> this is the case.  It's easy for the musb-dsps driver since it doesn't
> >> use platform_device_register_full() and can do this before the
> >> device_add() call.  How can we convey that this flag needs to be set?
> >
> > Through pdevinfo I guess?
>
> Not without adding another field to it.  The most direct is of course to
> simply add an of_node_reused flag there too and copy it over.  Would
> that be OK, or is there a better way?

That's what I meant. :-)
