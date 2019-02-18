Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFCEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6542176F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e+8ZoVK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfBRXqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:46:20 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:57626 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfBRXqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VxbytXycNU9uc0b8gBx0ktORNuTfpm6vCkwd92AI3H4=; b=e+8ZoVK5k61GxdtULZb8OURI27
        Z+KtZmBK/xaK+v7r4S9qucYtBODpWN9+P6RTnmvZinIyDkhXzFiqzgWNrX6yqq+znMOVhJA7ZUCDs
        aPERvx8z07kJVpVDru8+OLhX5Gobw67mwjlN8cyMGQfIWPpcnMnUwHPXflZ5mdwIiiNM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gvsbw-0004VS-F3; Tue, 19 Feb 2019 00:46:08 +0100
Date:   Tue, 19 Feb 2019 00:46:08 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 07/21] ethtool: implement EVENT
 notifications
Message-ID: <20190218234608.GI14879@lunn.ch>
References: <cover.1550513384.git.mkubecek@suse.cz>
 <c75c70d7b8f5e1b9a3ef6b83c2adaac2b113db31.1550513384.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c75c70d7b8f5e1b9a3ef6b83c2adaac2b113db31.1550513384.git.mkubecek@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 07:21:59PM +0100, Michal Kubecek wrote:
> Three types of netlink notifications are introduced:
> 
>   - ETHA_EVENT_NEWDEV to notify about newly registered network devices
>   - ETHA_EVENT_DELDEV to notify about unregistered network devices
>   - ETHA_EVENT_RENAMEDEV to notify about renamed network device
> 
> The notifications are triggered by NETDEV_REGISTER, NETDEV_UNREGISTER and
> NETDEV_CHANGENAME notifiers.
> 
> These notifications are intended for applications and daemons monitoring
> ethtool events to allow updating the list of existing devices without
> having to open another socket for rtnetlink.

Hi Michal

Does ETHA_EVENT_RENAMEDEV actually contain enough information to avoid
needing a rtnetlink lookup? If i understand the code correctly, all
you have is the new name. You don't know the old name?

Having said that, i don't see an easy way to get access to the old
name when handling the NETDEV_CHANGENAME.

     Andrew
