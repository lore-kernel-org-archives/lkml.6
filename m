Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566F2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264F420659
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=p23q.org header.i=@p23q.org header.b="bax00iMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264F420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=p23q.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbeK1Edw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:33:52 -0500
Received: from mail.gnuzifer.de ([78.46.242.17]:33581 "EHLO mail.gnuzifer.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbeK1Edw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=p23q.org; s=20170531;
        h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date; bh=JuuLw8MTnSF+VbgGA6AE3nezuoFXrqLq7CumPTQqzAA=;
        b=bax00iMVS7dcip7eD+8lIN7pFevp0848v+y1Qng5FgZlrALjUJRaDdi9IkKLtzPOfuekJ2Ly/mLfR3zLgi7wkFhAr50jVxnE2vbQwkBosRabqSDXxfpQp/nyieQvw+qpW8owz2kodwcw2O53aFKPSkf+bM3UxtSU2J61aibk2qgm49J6z+R+mzGm1IYfFLWUDl+kzsfxF/xRxRObqtujAma6BMUZCCP+z4WU4f5QiVDblEQsrXI9I9I6gVOPkYStR3Ar9UY7MOSP1JCpopW2HSnS6CWTuY+iz9KOfYs4elkzoF4aL9SRm5Ff0KQ51BI0ztZKE3noFVtsY7BbKHzrGNV6mMnLS+ytgx2ZxDpv9Ko31zwhjtKeFpfAAkNzBA6n9FnHQ+4GHJbwHriaQp91UbKn17H/uzvxTch0Z52Ks/PIak4ufsymgBbaJOVYTHssKPz2pxOj7gZLQbCk4yQlbb4cyrARXdLy3u6zdoNBlYMGMZHZ4KcQ46aGacUVqAE0M8KztnYyo1Xgt3RX3lJQPkHkzBzweUoBpiatIOGZ8/mi2np6QX3S5TvdNsAbiYTsarUpriUQjafb6TOxU0R1FCULuB8zGojUlCtYYboJw6w9pGCnmkFPBn8FMWaP4CSemhsqD0hcbarN+29uI2EyMB6GqtUWEbvzm54OGAcKUuw=;
Received: from authenticated user
        by mail.gnuzifer.de with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.84_2)
        (envelope-from <lkml@p23q.org>)
        id 1gRgfg-0000Es-CF; Tue, 27 Nov 2018 17:57:14 +0100
Date:   Tue, 27 Nov 2018 16:57:05 +0000
From:   "David R. Piegdon" <lkml@p23q.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Kay Sievers <kay@vrfy.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, systemd-devel@lists.freedesktop.org
Subject: [RFC PATCH 0/2] USB: DTS: allow suggesting busnumber for platform
 USB bus via DTS alias
Message-ID: <20181127165705.GA13460@lagavulin.indurad.x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on our embedded systems we rely on systemd's persistent netdev names.
Those currently do not work for USB netdevs that are connected to a
platform USB bus.

In https://github.com/systemd/systemd/pull/7273 a systemd patch was
suggested that would allow exactly this, but it was (rightfully) said
that numbering of theses busses is not guaranteed. Internally we used
the patch for a while now, but exactly that has happened with one of our
platforms across different kernel revisions.

The following kernel patches allow suggesting a USB busnumber for each
USB platform bus via a DTS alias, as can be done similarly for many
other devices.
In combination with above systemd patch, these changes allow use of
persistent netdev names also on platform USB busses.

NOTE: this patch might change ordering of busses on devices that use
platform-busses, if aliases for these busses have already been defined!
In the current master there are a few platforms that contain such
aliases, e.g. am33xx, dm814x or imx6qdl

Yours,

David

David R. Piegdon (2):
  usb core: dts: allow suggesting usb bus number for platform busses
  dt-bindings: allow suggesting usb bus number for usb platform busses

 Documentation/devicetree/bindings/usb/usb-hcd.txt |  9 +++++++
 drivers/usb/core/hcd.c                            | 30 ++++++++++++++++++-----
 2 files changed, 33 insertions(+), 6 deletions(-)

-- 
2.11.0
