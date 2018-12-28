Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5FFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7928218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CAI9gIgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbeL1JGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 04:06:40 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:58377 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbeL1JGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 04:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=aVHbAh/EKNUMNq0E/VVcGQa3cxxwH0xlaMHrPKxabnE=;
        b=CAI9gIgcHvr7e/j1kPFthN5RQvOuLDJN++MdEzLlGv7+m1y2RlGSg1pnby3ovC3zJQBfMIfCckXdus3SHpb43DfJd2AHfxA1zi6hrHbWtxruCT5Rfg+XUzgOnRlasCy5rloNFZLrgx0W/CA+SFrY1/WOvXJFdE1hqqQu73/5waI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gco6A-0008If-OK; Fri, 28 Dec 2018 10:06:30 +0100
Date:   Fri, 28 Dec 2018 10:06:30 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Anderson Luiz Alves <alacn1@gmail.com>,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] mv88e6060: disable hardware level MAC learning
Message-ID: <20181228090630.GB31460@lunn.ch>
References: <20181130235836.11741-1-alacn1@gmail.com>
 <20181228082255.GB6341@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228082255.GB6341@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 09:22:55AM +0100, Pavel Machek wrote:
> On Fri 2018-11-30 21:58:36, Anderson Luiz Alves wrote:
> > Disable hardware level MAC learning because it breaks station roaming.
> > When enabled it drops all frames that arrive from a MAC address
> > that is on a different port at learning table.
> > 
> > Signed-off-by: Anderson Luiz Alves <alacn1@gmail.com>
> 
> Will not this effectively disable the hardware switching leading to
> serious performance implications?

Hi Pavel

This switch is not doing hardware switching to start with. See
mv88e6060_setup_port():

        /* Port based VLAN map: give each port its own address
         * database, allow the CPU port to talk to each of the 'real'
         * ports, and allow each of the 'real' ports to only talk to
         * the CPU port.
         */
        REG_WRITE(addr, PORT_VLAN_MAP,
                  ((p & 0xf) << PORT_VLAN_MAP_DBNUM_SHIFT) |
                   (dsa_is_cpu_port(ds, p) ? dsa_user_ports(ds) :
                    BIT(dsa_to_port(ds, p)->cpu_dp->index)));

        /* Port Association Vector: when learning source addresses
         * of packets, add the address to the address database using
         * a port bitmap that has only the bit for this port set and
         * the other bits clear.
         */
        REG_WRITE(addr, PORT_ASSOC_VECTOR, BIT(p));


This is a very old driver, added way before offload support was added.

     Andrew
