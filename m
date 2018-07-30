Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDD2FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CAE208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CAE208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbeG3SXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:23:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbeG3SXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:23:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9614AEDE;
        Mon, 30 Jul 2018 16:47:16 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 01917A0BE8; Mon, 30 Jul 2018 18:47:14 +0200 (CEST)
Date:   Mon, 30 Jul 2018 18:47:14 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC PATCH net-next v2 09/17] ethtool: implement GET_DRVINFO
 message
Message-ID: <20180730164714.lqf5codtzxigsufe@unicorn.suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <4dcd60f25efe368ada4e0c035dc1d7612ab59132.1532953989.git.mkubecek@suse.cz>
 <20180730142825.GL13198@lunn.ch>
 <20180730144644.r3utyf4toqkjcxwd@unicorn.suse.cz>
 <20180730154803.GB2983@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730154803.GB2983@lunn.ch>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 05:48:03PM +0200, Andrew Lunn wrote:
> 
> For the statistics, it is a bit of a corner case. One of the Ethernet
> switches in DSA can have two different PHYs linked to one MAC. One PHY
> is built in, the second is connected via a SERDES interface. Which
> every gets link first is used. However, the SERDES interface has
> additional statistics counters. So if the SERDES is in use, we return
> more statistics. If somebody was to plug in the cable at just the
> wrong/right time, the count of statistics could be different to the
> number of statistics.
> 
> Another corner case i can think of. Some drivers return statistics per
> queue. And there is an ioctl to change the number of queues....
> 
> I could also imaging tests being similar. There are more loopback
> tests you can do with a SERDES which you cannot do with a built in
> PHY. But so far, i've not seen anything like that.

Thank you for the explanation. What I have in mind is that there are two
different types of userspace applications: one shot and running long
term. It can be seen in my series in the way e.g. link modes are
handled. There are two formats in which a bitset can be passed: verbose
(list of bits with names) or compact (just bitmaps). For one shot
queries (e.g. "ethtool eth0") it's easier to use verbose format so that
you get names with bit values in one package. But for long running
applications processing many messages ("ethtool --monitor" or config
management daemons), it's more practical to load the names once and pass
only data with each notification or response.

I suppose in the scenarios you mentioned the driver would be able to
trigger a notification whenever the list changes so that userspace
application could reload the string set.

Michal Kubecek
