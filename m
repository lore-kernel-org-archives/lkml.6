Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DBDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F21920855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kdIhdNFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F21920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeKZNTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 08:19:53 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:48773 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbeKZNTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 08:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Ha3cDveggPtSD4sEpMeqIa8/ivd1C8QC695nLLy98EQ=;
        b=kdIhdNFGQc5COp/a/lOHenReGzfDhtxiREb4wzDtq/2NxT536J/jkmkiQX4cwTAU9qjdTTihJ3mic5oHae0IrbnNM/W2MfVfiMKMjECf106aQ3CY+vACHvBWUr+WuTz1NMw/vu1AwTcsc3iKEb2Wl7HB52rVu9tfZGSGyq2h66o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gR6cB-0000G5-Dt; Mon, 26 Nov 2018 03:27:11 +0100
Date:   Mon, 26 Nov 2018 03:27:11 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx
 packet size
Message-ID: <20181126022711.GD32164@lunn.ch>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125234315.28313-1-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 05:43:15PM -0600, Grygorii Strashko wrote:
> For proper VLAN packets forwarding CPSW driver uses min tx packet size of
> 64bytes (VLAN_ETH_ZLEN, excluding ETH_FCS) which was corrected by
> commit 9421c9015047 ("net: ethernet: ti: cpsw: fix min eth packet size").
> 
> Unfortunately, this breaks some industrial automation protocols, as
> reported by TI customers [1], which can work only with min TX packet size
> from 60 byte (ecluding FCS).

Hi Grygorii

excluding...

> Hence, introduce module boot parameter "tx_packet_min" to allow configure
> min TX packet size at boot time.

Module parameters are generally not liked.

What actually happens here with this lower limit? Does the hardware
send runt packets? Does the protocol actually require runt packets?

I'm just wondering if the module parameter can be avoided by setting
this as the default. But we need to ensure ARP packets, which are
smaller than the minimum MTU are correctly padded.

Thanks
	Andrew
