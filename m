Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1380C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A55F2170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A55F2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeHUMwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 08:52:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:34448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726671AbeHUMwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 08:52:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A3FCAFC2;
        Tue, 21 Aug 2018 09:32:48 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 379C9A09F2; Tue, 21 Aug 2018 11:32:46 +0200 (CEST)
Date:   Tue, 21 Aug 2018 11:32:46 +0200
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
Message-ID: <20180821093245.ktattosaduf6jvya@unicorn.suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <67d3b68a50e95db9612cc96e42a52ce332f716a9.1532953989.git.mkubecek@suse.cz>
 <20180730185455.GJ2983@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730185455.GJ2983@lunn.ch>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 08:54:55PM +0200, Andrew Lunn wrote:
> > +/* Internal kernel helper to query a device ethtool_link_settings.
> > + *
> > + * Backward compatibility note: for compatibility with legacy drivers
> > + * that implement only the ethtool_cmd API, this has to work with both
> > + * drivers implementing get_link_ksettings API and drivers
> > + * implementing get_settings API. When drivers implement get_settings
> > + * and report ethtool_cmd deprecated fields
> > + * (transceiver/maxrxpkt/maxtxpkt), these fields are silently ignored
> > + * because the resulting struct ethtool_link_settings does not report them.
> 
> ~/linux/drivers$ grep -r [.]get_settings *
> net/ethernet/8390/etherh.c:		 .get_settings	= etherh_get_settings,
> 
> I don't think it is worth adding support for .get_settings for just
> one driver. It is better to just convert that driver to the new API.

I have prepared a patch converting 8390/etherh driver to use
{g,s}et_link_ksettings and I'm going to submit it when net-next opens.
Do you think we can then drop {g,s}et_settings callbacks completely
(i.e. also from ioctl() code and ethtool_ops)?  Do we care about
unconverted out of tree drivers?

Michal Kubecek
