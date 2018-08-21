Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F52FC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A34D217B4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A34D217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeHUSMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:12:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:42844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726730AbeHUSMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:12:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F574AEB5;
        Tue, 21 Aug 2018 14:52:21 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 13A07A09F2; Tue, 21 Aug 2018 16:52:19 +0200 (CEST)
Date:   Tue, 21 Aug 2018 16:52:19 +0200
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
Message-ID: <20180821145218.fuucfjlo3ejhofrx@unicorn.suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <67d3b68a50e95db9612cc96e42a52ce332f716a9.1532953989.git.mkubecek@suse.cz>
 <20180730185455.GJ2983@lunn.ch>
 <20180821093245.ktattosaduf6jvya@unicorn.suse.cz>
 <20180821141022.GD2985@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821141022.GD2985@lunn.ch>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 04:10:22PM +0200, Andrew Lunn wrote:
> On Tue, Aug 21, 2018 at 11:32:46AM +0200, Michal Kubecek wrote:
> > I have prepared a patch converting 8390/etherh driver to use
> > {g,s}et_link_ksettings and I'm going to submit it when net-next opens.
> > Do you think we can then drop {g,s}et_settings callbacks completely
> > (i.e. also from ioctl() code and ethtool_ops)?  Do we care about
> > unconverted out of tree drivers?
> 
> We cannot break ethtool, the ABI it uses. But there is already code to
> use get_link_ksettings() and only fall back to get_settings if it does
> not exist. So we can clean up all the fallback code, remove the
> ethtool_ops, etc.

Yes, that's what I have in mind: keep the ethtool interface as is (both
ETHTOOL_{G,S}SET and ETHTOOL_{G,S}LINKSETTINGS) but drop get_settings
and set_settings from ethtool_ops and the code that falls back to them.
This way both old and new versions of ethtool would still work and the
only problem would be with out of tree drivers not converted to
{s,g}et_link_ksettings (which won't build so that it won't be silent
breakage).

Michal Kubecek
