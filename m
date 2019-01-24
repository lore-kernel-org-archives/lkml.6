Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3EBC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583FA2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfAXJNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:13:45 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:54963 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfAXJNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:13:45 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id A4B942800BDA8;
        Thu, 24 Jan 2019 10:13:42 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6249310629; Thu, 24 Jan 2019 10:13:42 +0100 (CET)
Date:   Thu, 24 Jan 2019 10:13:42 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     ronald@innovation.ch,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: sil_sii8620: depend on INPUT instead of
 selecting it.
Message-ID: <20190124091342.i4g3hwzpnt5uwwxf@wunner.de>
References: <20190122141311.10445-1-ronald@innovation.ch>
 <20190123084556.gsospl6joh53qnzs@wunner.de>
 <20190123220342.GC179701@dtor-ws>
 <20190123221735.GE4675@pendragon.ideasonboard.com>
 <20190123222105.GF179701@dtor-ws>
 <20190123222200.GF4675@pendragon.ideasonboard.com>
 <20190124072125.GA28127@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124072125.GA28127@innovation.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:21:25PM -0800, Life is hard, and then you die wrote:
> Since the two changes (the change here + the new driver) seem to be
> best submitted through different trees, I'm trying to figure out how
> best to handle this. I suppose I could temporarily change the driver
> Kconfig to not trigger the conflict, and then once the change here has
> been upstreamed (not sure at what point exactly that would be
> considered the case, e.g. if in linux-next is sufficient, or has to
> wait for Linus' merge, or something else) submit another change to
> change the driver's Kconfig to the desired one.

If a series touches multiple subsystems and its patches are interdependent,
the pull requests sent to Linus would have to be merged in a specific order.

In practice that's too cumbersome, so either the series is split in multiple
parts and merged across multiple releases (which obviously can take a long
time) or, if the change to other subsystems is smallish (as is the case
here), the entire series is merged through a single subsystem tree and
those patches touching other subsystems need to have an Acked-by or
Reviewed-by tag from a maintainer of those other subsystems.

If a case can be made that the change to the other subsystem (e.g. DRM) is
actually a bug fix, then that change can go in immediately and will appear
in one of Linus' next -rc releases.  The rest of the series can then go
through the appropriate subsystem (e.g. input) and will land in Linus' tree
in the next merge window.

Either way, the correct patch order is preserved and it's guaranteed that
the build is not broken for someone ending up on an in-between commit while
bisecting.

HTH,

Lukas
