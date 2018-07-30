Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762BCC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE4520890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE4520890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbeG3VTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:19:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:52846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727037AbeG3VTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:19:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DB67ACC8;
        Mon, 30 Jul 2018 19:42:44 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 989F1A0BE8; Mon, 30 Jul 2018 21:42:42 +0200 (CEST)
Date:   Mon, 30 Jul 2018 21:42:42 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC PATCH net-next v2 10/17] ethtool: implement GET_SETTINGS
 message
Message-ID: <20180730194242.daornhxcc74o7f4c@unicorn.suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <67d3b68a50e95db9612cc96e42a52ce332f716a9.1532953989.git.mkubecek@suse.cz>
 <20180730190941.GL2983@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730190941.GL2983@lunn.ch>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:09:41PM +0200, Andrew Lunn wrote:
> > +Response contents:
> > +
> > +    ETHA_SETTINGS_LINK		(u32)		link state
> 
> > +	[ETHA_SETTINGS_LINK]		= { .type = NLA_FLAG },
> 
> Is this correct?

NLA_FLAG is wrong, we need three states: on/off/unknown for "get"
replies and on/off/keep for "set" requests.

> The link is either up or down. So a u32 seems a bit big.

I tend to use u32 everywhere with some obvious exceptions. The reason is
that netlink attributes are padded to 32 bits so that no matter if you
use u8, u16 or u32, the attribute still ends up taking 8 bytes. But yes,
this looks like an obvious exception where u8 wouldn't mean any risk of
running out of values one day.

Michal Kubecek
