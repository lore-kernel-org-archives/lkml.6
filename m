Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D9913F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B37E20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B37E20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeG3QWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:22:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:42178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731783AbeG3QWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:22:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0787BAD87;
        Mon, 30 Jul 2018 14:46:45 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 91EBCA0BE8; Mon, 30 Jul 2018 16:46:44 +0200 (CEST)
Date:   Mon, 30 Jul 2018 16:46:44 +0200
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
Message-ID: <20180730144644.r3utyf4toqkjcxwd@unicorn.suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <4dcd60f25efe368ada4e0c035dc1d7612ab59132.1532953989.git.mkubecek@suse.cz>
 <20180730142825.GL13198@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730142825.GL13198@lunn.ch>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 04:28:25PM +0200, Andrew Lunn wrote:
> On Mon, Jul 30, 2018 at 02:53:27PM +0200, Michal Kubecek wrote:
> 
> > +    ETHA_DRVINFO_FWVERSION	(string)	firmware version
> > +    ETHA_DRVINFO_BUSINFO	(string)	device bus address
> > +    ETHA_DRVINFO_EROM_VER	(string)	expansion ROM version
> > +    ETHA_DRVINFO_N_PRIV_FLAGS	(u32)		number of private flags
> > +    ETHA_DRVINFO_N_STATS	(u32)		number of device stats
> 
> I know there is at least one driver that has somewhat dynamic number
> of statistics. It would be better to have the strings and the values
> in the same message, so there is no need to first get the number of
> strings, allocate the memory, get the strings, then get the values.
> 
> > +    ETHA_DRVINFO_TESTINFO_LEN	(u32)		number of test results
> 
> In theory, this also does not need to be fixed. 

This is interesting. It would mean current (ioctl) ethtool approach with
string set may not work correctly either. On the other hand, this should
not be a problem for netlink interface. Statistics are unlikely to
appear in notifications and daemons collecting them periodically will
have to learn with it. Adding test name to notification "test started"
or "test finished" seems quite natural.

> > +    ETHA_DRVINFO_EEDUMP_LEN	(u32)		EEPROM dump size
> > +    ETHA_DRVINFO_REGDUMP_LEN	(u32)		register dump size
> 
> I would suggest removing all these _LEN properties, and let netlink
> return what it needs to return.

Agreed.

Michal Kubecek
