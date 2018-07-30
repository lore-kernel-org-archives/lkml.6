Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A37C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0CD20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OMlPWAxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0CD20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbeG3UbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:31:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50780 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729542AbeG3UbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=dw4D28ckE9fX3uMqOipEs12A338/3sGkH/XDZMr0aNo=;
        b=OMlPWAxvFFkhx3jqIMnc+dCN+QzTJbKoxWq4sgEDCiEZzQ/sEpXmMDwKngOW+G2NHGibcLGN/WwkTYSTEsqUTfcE8ecghAlVndGy+3w16xh9gwmdJ2pqNAD1lfEvrq5J5p3GmoVcON80ewNDcl6ptYydS5/jVruf6i25Udtsfn8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fkDJn-0002Va-HM; Mon, 30 Jul 2018 20:54:55 +0200
Date:   Mon, 30 Jul 2018 20:54:55 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC PATCH net-next v2 10/17] ethtool: implement GET_SETTINGS
 message
Message-ID: <20180730185455.GJ2983@lunn.ch>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <67d3b68a50e95db9612cc96e42a52ce332f716a9.1532953989.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d3b68a50e95db9612cc96e42a52ce332f716a9.1532953989.git.mkubecek@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* Internal kernel helper to query a device ethtool_link_settings.
> + *
> + * Backward compatibility note: for compatibility with legacy drivers
> + * that implement only the ethtool_cmd API, this has to work with both
> + * drivers implementing get_link_ksettings API and drivers
> + * implementing get_settings API. When drivers implement get_settings
> + * and report ethtool_cmd deprecated fields
> + * (transceiver/maxrxpkt/maxtxpkt), these fields are silently ignored
> + * because the resulting struct ethtool_link_settings does not report them.

~/linux/drivers$ grep -r [.]get_settings *
net/ethernet/8390/etherh.c:		 .get_settings	= etherh_get_settings,

I don't think it is worth adding support for .get_settings for just
one driver. It is better to just convert that driver to the new API.

    Andrew
