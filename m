Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B46C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC4B20870
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC4B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeKZEGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 23:06:02 -0500
Received: from muru.com ([72.249.23.125]:55132 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbeKZEGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 23:06:02 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BDDA2809C;
        Sun, 25 Nov 2018 17:14:32 +0000 (UTC)
Date:   Sun, 25 Nov 2018 09:14:28 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181125171428.GL53235@atomide.com>
References: <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <6ed280af-edb6-4be7-82f4-7fc00378103e@ti.com>
 <20181123185215.GH12912@darkstar.musicnaut.iki.fi>
 <20181124200942.GS6920@n2100.armlinux.org.uk>
 <20181125010717.GJ53235@atomide.com>
 <20181125111105.GT6920@n2100.armlinux.org.uk>
 <20181125165830.GC3416@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125165830.GC3416@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181125 16:58]:
> Below changes get traffic going with DMA & g_ether...

Oh cool, if you have dma and g_ether working, you should
test it with a variable size ping test loop :) That should
expose any issues within few minutes.

Below is the test script I was using earlier, the
tusb6010 comment there is probably no longer valid.

Regards,

Tony

8< ----------------
#!/bin/bash

#
# At least tusb6010 dma needs 32-bit aligned buffers.
# That can be done by setting no_skb_reserve with:
# musb->g.quirk_avoids_skb_reserve = 1;
#

device=$1
size=$2
wraps=0

while [ 1 ]; do
	#echo "Pinging with size $size"
	if ! ping -w0 -c1 -s$size $device > /dev/null 2>&1; then
		break;
	fi
	size=$(expr $size + 1)

	if [ $size -gt 8192 ]; then
		wraps=$(expr $wraps + 1)
		echo "wrapping ($wraps) at $size"
		size=1
	fi
done
echo "Test ran up to $size"
