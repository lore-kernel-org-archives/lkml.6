Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E87AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0550F2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfBGTD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:03:29 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:55439 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfBGTD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:03:29 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 82463100B07E1;
        Thu,  7 Feb 2019 20:03:26 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 39E8F8372B; Thu,  7 Feb 2019 20:03:26 +0100 (CET)
Date:   Thu, 7 Feb 2019 20:03:26 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v2 2/9] driver core: Avoid careless re-use of existing
 device links
Message-ID: <20190207190326.wjxnzo4ja62t3mt6@wunner.de>
References: <1952449.TVsm6CJCTy@aspire.rjw.lan>
 <2222273.ydJmd408XJ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2222273.ydJmd408XJ@aspire.rjw.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, late to the party.

On Fri, Feb 01, 2019 at 01:46:54AM +0100, Rafael J. Wysocki wrote:
> After commit ead18c23c263 ("driver core: Introduce device links
> reference counting"), if there is a link between the given supplier
> and the given consumer already, device_link_add() will refcount it
> and return it unconditionally.  However, if the flags passed to
> it on the second (or any subsequent) attempt to create a device
> link between the same consumer-supplier pair are not compatible with
> the existing link's flags, that is incorrect.

Prior to ead18c23c263, a second invocation of device_link_add() also
returned the existing device link without checking for incompatible
flags.  Hence this issue was not introduced by ead18c23c263, but
rather by 9ed9895370ae ("driver core: Functional dependencies tracking
support"), i.e. it was present all along.  (Unless I'm missing something.)


> Moreover, if the DL_FLAG_AUTOREMOVE_CONSUMER flag is passed to
> device_link_add(), its caller will expect its reference to the link
> to be dropped automatically on consumer driver removal, which will
> not happen if that flag is not set in the link's flags (and
> analogously for DL_FLAG_AUTOREMOVE_SUPPLIER).  For this reason, make
> device_link_add() update the existing link's flags accordingly
> before returning it to the caller.

Same here.


> Fixes: ead18c23c263 ("driver core: Introduce device links reference counting")

Should rather be
Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")

(Again, unless I'm missing something.)

Thanks,

Lukas
