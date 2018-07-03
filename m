Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9A9C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE5A24C8D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMVZHECo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE5A24C8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754414AbeGCGah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754253AbeGCGaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:30:35 -0400
Received: from dragon (unknown [104.237.91.44])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A196524C8D;
        Tue,  3 Jul 2018 06:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530599435;
        bh=km3rlboYrGwVkKYyptvTo6TWQCGCX+V6PGHU5lB6gVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bMVZHECoZZBtk/mw28QEeFDs5Dx7JpsZhxyhwvVfyvn4JU58K7haGsF8q9St8Hf/5
         WGXdMtKgyeaqHK5Ytd7CNiaYLeoMHmGLjRbGFs1/8HIiiEGCAx7aqmBW3Gk2HoYItT
         U0SHcq2Rz5n1skeYuqTMtCj9ON52+RUx6gETq0yU=
Date:   Tue, 3 Jul 2018 14:30:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] bus: imx-weim: Remove VLA usage
Message-ID: <20180703063019.GH4348@dragon>
References: <20180629185212.GA37517@beast>
 <CAL_JsqKKjcvLOxoWvqaZYJwEoc_s_B-0KnAfhZYEg9Cwytd4sA@mail.gmail.com>
 <CAGXu5jKstvoro4Gx=BKjVi6R4wYtWMsp=OfxJXsywSfKOehwWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKstvoro4Gx=BKjVi6R4wYtWMsp=OfxJXsywSfKOehwWA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 01:02:36PM -0700, Kees Cook wrote:
> On Fri, Jun 29, 2018 at 12:45 PM, Rob Herring <robh@kernel.org> wrote:
> > On Fri, Jun 29, 2018 at 12:52 PM Kees Cook <keescook@chromium.org> wrote:
> >>
> >> In the quest to remove all stack VLA usage from the kernel[1], this
> >> switches to using a maximum size and adds a sanity check.
> >>
> >> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> >>
> >> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Not sure how you came up with the CC list, but you should probably
> > have some i.MX folks CC'ed.
> 
> Automation for the lose, apparently. :) Looks like maybe the
> MAINTAINER entry for IMX needs a drivers/bus/imx* line added. :)
> 
> Adding more CCs...

Acked-by: Shawn Guo <shawnguo@kernel.org>
