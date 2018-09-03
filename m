Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E44DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA29A20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jwq+Ybit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA29A20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeIDA1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:27:45 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:51113 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbeIDA1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=7ygJss2afGb9QNzqMgQ/z1bf5ekesUjSSRVIDa6pn8M=;
        b=jwq+YbitnsWbKRWd74sp2tiY10IBnNMx67ZP3UmSj4321T2leQq0dGpiIbdJYzu8hvXxJQ99Jm6KJLydhSi+j9tuVcsWS8HBCim45IIjt86LPWpjC09tp2wgxL2ReSBZ6GdR2uP4FHPt7917xFJ94xJ6JjV9A/W7uh3XgIA1Ijs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fwv6g-0003fz-Kf; Mon, 03 Sep 2018 22:05:54 +0200
Date:   Mon, 3 Sep 2018 22:05:54 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v2 4/7] net: phy: mscc: read
 'vsc8531,edge-slowdown' as an u32
Message-ID: <20180903200554.GJ4445@lunn.ch>
References: <20180903084853.18092-1-quentin.schulz@bootlin.com>
 <20180903084853.18092-4-quentin.schulz@bootlin.com>
 <20180903132756.GD4445@lunn.ch>
 <20180903133746.wsvezy3rbdivnjfs@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903133746.wsvezy3rbdivnjfs@qschulz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Just to be sure, we're talking here about making sure the value stored
> in the DT is not bigger than the specified value (here an u8)? If so,
> that isn't the reason why I'm suggesting those two patches.
> 
> Without /bits 8/ in the DT property, whatever were the values I put in
> the property, I'd always get a 0. So I need to fix it either in the DT
> (but Rob does not really like it) or in the driver.

Hi Quentin

Ah, you are fixing endian issues. That was not clear to me from the
commit message.

I don't know enough about how DT stores values in the blob. Is there
type info? Can the DT core tell if a value in the blob is a u8 or a
u32?  It would be nice if it warned about reading a u8 from a u32
blob.

Anyway, this change still removes some bounds checking. Are they
important? Do they need to be added back?

Thanks
	Andrew
