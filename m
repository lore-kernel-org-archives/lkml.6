Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762EEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1272148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfBUKO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:14:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:59270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfBUKO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:14:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5708AD98;
        Thu, 21 Feb 2019 10:14:25 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 4E631E00A5; Thu, 21 Feb 2019 11:14:25 +0100 (CET)
Date:   Thu, 21 Feb 2019 11:14:25 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 15/21] ethtool: provide link settings and
 link modes in GET_SETTINGS request
Message-ID: <20190221101425.GO23151@unicorn.suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
 <00e931c1ecd29bf302a190c7d7a3f2cbd0388542.1550513384.git.mkubecek@suse.cz>
 <f2f8ccdd-c8bb-7f0a-5df7-dd54359e859e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f8ccdd-c8bb-7f0a-5df7-dd54359e859e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 07:14:50PM -0800, Florian Fainelli wrote:
> On 2/18/2019 10:22 AM, Michal Kubecek wrote:
> > +#define ETH_SETTINGS_IM_LINKINFO		0x01
> > +#define ETH_SETTINGS_IM_LINKMODES		0x02
> > +
> > +#define ETH_SETTINGS_IM_ALL			0x03
> 
> You could define ETH_SETTINGS_IM_ALL as:
> 
> #define ETH_SETTING_IM_ALL		\
> 		(ETH_SETTINGS_IM_LINKINFO |
> 		 ETH_SETTINGS_IM_LINMODES)
> 
> that would scale better IMHO, especially given that you have to keep
> bumping that mask with new bits in subsequent patches.

I'm considering going even further and using something similar to what
is used for NETIF_F_* constants so that the *_ALL value would be
calculated automatically. But I'm not sure if it's not too fancy for
a uapi header file.

> > +	if (tb[ETHA_SETTINGS_INFOMASK])
> > +		req_info->req_mask = nla_get_u32(tb[ETHA_SETTINGS_INFOMASK]);
> > +	if (tb[ETHA_SETTINGS_COMPACT])
> > +		req_info->compact = true;
> > +	if (req_info->req_mask == 0)
> > +		req_info->req_mask = ETH_SETTINGS_IM_ALL;
> 
> What if userland is newer than the kernel and specifies a req_mask with
> bits set that you don't support? Should not you always do an &
> ETH_SETTINGS_IM_ALL here?

In that case only known bits would be handled and the check at the end
of prepare_info() would add a warning to extack that part of the
information couldn't be provided (same as if some of the recognized
parts didn't have necessary ethtool_ops handlers or if they failed).

Michal
