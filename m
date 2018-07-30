Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BC3160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0395720870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T66+5UXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0395720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeG3RXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:23:43 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50582 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbeG3RXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=FfiSEAIq+tAAv2IxgftK6KqQ7hG/A5FrRS7L0mX3qWA=;
        b=T66+5UXT5GAQXACoMeZqzcE7+xxUNryASVsjpFRyXSsPpJCGJMrl/HoMROQfAX4/SSHo66dWOM9iPNWY3z0l3uwBB04g/qGveD5Mg2FQk/vW76hZWnpPBPzGP/ht9hIGApETggLwPVV2YyRKQyIgBR7zXAHPFCUlMBl53bRcEmE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fkAOx-0000yZ-Hm; Mon, 30 Jul 2018 17:48:03 +0200
Date:   Mon, 30 Jul 2018 17:48:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC PATCH net-next v2 09/17] ethtool: implement GET_DRVINFO
 message
Message-ID: <20180730154803.GB2983@lunn.ch>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <4dcd60f25efe368ada4e0c035dc1d7612ab59132.1532953989.git.mkubecek@suse.cz>
 <20180730142825.GL13198@lunn.ch>
 <20180730144644.r3utyf4toqkjcxwd@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730144644.r3utyf4toqkjcxwd@unicorn.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is interesting. It would mean current (ioctl) ethtool approach with
> string set may not work correctly either.

Hi Michal 

For the statistics, it is a bit of a corner case. One of the Ethernet
switches in DSA can have two different PHYs linked to one MAC. One PHY
is built in, the second is connected via a SERDES interface. Which
every gets link first is used. However, the SERDES interface has
additional statistics counters. So if the SERDES is in use, we return
more statistics. If somebody was to plug in the cable at just the
wrong/right time, the count of statistics could be different to the
number of statistics.

Another corner case i can think of. Some drivers return statistics per
queue. And there is an ioctl to change the number of queues....

I could also imaging tests being similar. There are more loopback
tests you can do with a SERDES which you cannot do with a built in
PHY. But so far, i've not seen anything like that.

     Andrew
