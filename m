Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AFBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA5F21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfBSHCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:02:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:52120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfBSHC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:02:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5CBA3AD62;
        Tue, 19 Feb 2019 07:02:28 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id A1F49E0122; Tue, 19 Feb 2019 08:02:26 +0100 (CET)
Date:   Tue, 19 Feb 2019 08:02:26 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 07/21] ethtool: implement EVENT
 notifications
Message-ID: <20190219070226.GB23151@unicorn.suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
 <c75c70d7b8f5e1b9a3ef6b83c2adaac2b113db31.1550513384.git.mkubecek@suse.cz>
 <20190218234608.GI14879@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218234608.GI14879@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 12:46:08AM +0100, Andrew Lunn wrote:
> On Mon, Feb 18, 2019 at 07:21:59PM +0100, Michal Kubecek wrote:
> > Three types of netlink notifications are introduced:
> > 
> >   - ETHA_EVENT_NEWDEV to notify about newly registered network devices
> >   - ETHA_EVENT_DELDEV to notify about unregistered network devices
> >   - ETHA_EVENT_RENAMEDEV to notify about renamed network device
> > 
> > The notifications are triggered by NETDEV_REGISTER, NETDEV_UNREGISTER and
> > NETDEV_CHANGENAME notifiers.
> > 
> > These notifications are intended for applications and daemons monitoring
> > ethtool events to allow updating the list of existing devices without
> > having to open another socket for rtnetlink.
> 
> Hi Michal
> 
> Does ETHA_EVENT_RENAMEDEV actually contain enough information to avoid
> needing a rtnetlink lookup? If i understand the code correctly, all
> you have is the new name. You don't know the old name?
> 
> Having said that, i don't see an easy way to get access to the old
> name when handling the NETDEV_CHANGENAME.

We don't have the old name and without modifying the NETDEV_CHANGENAME
notifier to pass it, there is probably no way to get it. But the ethtool
notification also contains ifindex so that userspace applications which
want to track the configuration can remember both and identify the
renamed device by ifindex.

Michal
