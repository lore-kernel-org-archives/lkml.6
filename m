Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F120C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2395120663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s2W9wA5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2395120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeK0Bqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:46:35 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49499 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeK0Bqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=qpeqr1RVm0aX6xRtJv8DUVFMfa9V7O7COPfCVjJm3Dc=;
        b=s2W9wA5+FbJOZLmt9nEhpG6OtZnxzBXshJRYUT/x/2y/pAoJGI/Vo5VVPpOfB+qCz9C2SD4xSHvdYjObnhojAAeSDZmbb31JuotDTye8xoHTI2bHXA37wyIxh+zprpwC/qB6uEtFOWyEH8HjBeb0ohd9YcrLPv59JEVKbCRbOx0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gRIF8-0004fZ-AE; Mon, 26 Nov 2018 15:52:10 +0100
Date:   Mon, 26 Nov 2018 15:52:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Claudiu.Beznea@microchip.com
Cc:     harini.katakam@xilinx.com, Nicolas.Ferre@microchip.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harinikatakamlinux@gmail.com, harinik@xilinx.com,
        shubhrajyoti.datta@xilinx.com, sai.pavan.boddu@xilinx.com
Subject: Re: [PATCH v2 1/4] net: macb: Check MDIO state before read/write and
 use timeouts
Message-ID: <20181126145210.GD12116@lunn.ch>
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
 <1543216072-9623-2-git-send-email-harini.katakam@xilinx.com>
 <5de882e3-65ac-7ff1-bb55-7537666dfc77@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5de882e3-65ac-7ff1-bb55-7537666dfc77@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 02:46:01PM +0000, Claudiu.Beznea@microchip.com wrote:
> Hi Harini,
> 
> On 26.11.2018 09:07, Harini Katakam wrote:
> > From: Harini Katakam <harinik@xilinx.com>
> > 
> > Replace the while loop in MDIO read/write functions with a timeout.
> > In addition, add a check for MDIO bus busy before initiating a new
> > operation as well to make sure there is no ongoing MDIO operation.
> 
> Is this MDIO bus busy check necessary? The caller of
> macb_mdio_read/macb_mdio_write locks the mdio bus mutex before calling it
> (e.g. mdiobus_read).

Hi Claudiu

It depends on the implementation. A write operation you could just
launch, but not wait for it to complete, allowing you to do other
stuff while the hardware is busy. For the next operation you then do
need to check the previous operation has completed.

I've not checked it is actually implemented this way.

     Andrew
