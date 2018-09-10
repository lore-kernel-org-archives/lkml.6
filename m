Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D270CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D050204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="16gUqPEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D050204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeIJH4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:56:44 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56889 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbeIJH4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=9kI0nQPEqhOvMHtcuqnAhHPib/A27fwdSh9u34hTtwo=;
        b=16gUqPEYdPKlYtpa5aMsADBZYxPfwWwc7dzjYbOxTF/YSBPtXmpFsKR8XN1EcJER+F1E2eI2Sg4UTEZW9t3BGXLbbVTwIRZCELBt9c0TKKklf9AWyEzYlIk8eqshzxf9JfvfrWzE9IiZ5q+Fzma1OD5zD5f6zd0D9zb84kRFfM0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fzCVK-0005oD-TU; Mon, 10 Sep 2018 05:04:46 +0200
Date:   Mon, 10 Sep 2018 05:04:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: Expose tagging protocol to user-space
Message-ID: <20180910030446.GB17151@lunn.ch>
References: <20180907180908.3223-1-f.fainelli@gmail.com>
 <20180908094331.GB3246@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180908094331.GB3246@nanopsycho.orion>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 11:43:31AM +0200, Jiri Pirko wrote:
> Fri, Sep 07, 2018 at 08:09:02PM CEST, f.fainelli@gmail.com wrote:
> >There is no way for user-space to know what a given DSA network device's
> >tagging protocol is. Expose this information through a dsa/tagging
> >attribute which reflects the tagging protocol currently in use.
> >
> >This is helpful for configuration (e.g: none behaves dramatically
> >different wrt. bridges) as well as for packet capture tools when there
> >is not a proper Ethernet type available.
> 
> 
> Hmm, I wonder. It this something that varies between ports of an
> individual ASIC? Or is it rather something defined per-ASIC. If so, this
> looks more like a devlink-api material.

Hi Jiri

This is between the CPU ethernet device and the switch port that
interface is connect to.

For the Marvell devices, any switch port can be connected to the CPU
Ethernet interface, and the same protocol is used. However, some
switches have a special port which should be used to connect to the
CPU ethernet and supports this tagging protocol. If the designer gets
it wrong and uses a different port to connect the CPU, no tagging
protocol can be used, which as Florian indicated, has a big impact on
bridging, etc.

And just to make it more complex, Marvel has two tagging
schemes. Older devices use DSA, newer devices uses EDSA. However, for
the very new devices in the 6390 family, Marvell made a subtle change
to how EDSA works, which broke it, so we had to go back to DSA.

Of the different tagging protocols used by the 50 or so switches Linux
supports, only the EDSA tagging protocol makes use of an
Ethertype. tcpdump knows how to decode these packets. For all the
other tagging protocols, it has no idea, the Ethertype is all messed
up, and it just prints hex. What i think Florian wants to do is stuff
the tagging protocol into the pcap-ng header so that tcpdump knows
what protocol is in use, and can put the correct protocol dissector in
the chain.

And just for completeness, there potentially is a second tagging
scheme when you have multiple switches connected together in a
cluster, but that is internal to the cluster. The CPU is unaware of
it. But if you are snooping on the traffic, you need to know what the
protocol is, so you can decode the frames. In theory, that could be
EDSA or DSA, and can be selected per intra-switch link. In practice,
they are all DSA, and i've not heard of anybody actually snooping this
traffic.

	Andrew
