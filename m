Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F14FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E22420873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wY/MtnDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E22420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbeG3QDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:03:48 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50489 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbeG3QDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=fjiPlCaY1t6zV53k/gsqhl6rMTct6uW1CJvISkNHZAU=;
        b=wY/MtnDAEiD9YoN26fArm/FT/SX6JZuUEOV1R8VbJbtF9OxRCBkktA6BIItLC461MG9iY+omaWFI+WIi4a+SKN/IqKBV/EUehmov6xhKBJbxh48GZUmaIBspWZMd22i9++i1QfoeXmyuTjzdZrfJeJ555ZgKqQQXgGZzhlOtIzo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fk99t-0000Em-SA; Mon, 30 Jul 2018 16:28:25 +0200
Date:   Mon, 30 Jul 2018 16:28:25 +0200
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
Message-ID: <20180730142825.GL13198@lunn.ch>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <4dcd60f25efe368ada4e0c035dc1d7612ab59132.1532953989.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dcd60f25efe368ada4e0c035dc1d7612ab59132.1532953989.git.mkubecek@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 02:53:27PM +0200, Michal Kubecek wrote:
> Requests the same information as ETHTOOL_GDRVINFO command in ioct
> interface. This is read-only so that corresponding SET_DRVINFO exists but
> is only used in kernel replies.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---
>  Documentation/networking/ethtool-netlink.txt |  38 +++++-
>  include/uapi/linux/ethtool_netlink.h         |  22 ++++
>  net/ethtool/Makefile                         |   4 +-
>  net/ethtool/common.c                         |  43 ++++++
>  net/ethtool/common.h                         |   3 +
>  net/ethtool/drvinfo.c                        | 131 +++++++++++++++++++
>  net/ethtool/ioctl.c                          |  42 +-----
>  net/ethtool/netlink.c                        |   8 ++
>  8 files changed, 252 insertions(+), 39 deletions(-)
>  create mode 100644 net/ethtool/drvinfo.c
> 
> diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
> index 8b43f41a8140..1e3d5ffc97ab 100644
> --- a/Documentation/networking/ethtool-netlink.txt
> +++ b/Documentation/networking/ethtool-netlink.txt
> @@ -121,6 +121,8 @@ List of message types
>      ETHNL_CMD_EVENT			notification only
>      ETHNL_CMD_GET_STRSET
>      ETHNL_CMD_SET_STRSET		response only
> +    ETHNL_CMD_GET_DRVINFO
> +    ETHNL_CMD_SET_DRVINFO		response only
>  
>  All constants use ETHNL_CMD_ prefix, usually followed by "GET", "SET" or "ACT"
>  to indicate the type.
> @@ -156,6 +158,40 @@ and also multiple events of the same type (e.g. two or more newly registered
>  devices).
>  
>  
> +GET_DRVINFO
> +-----------
> +
> +GET_DRVINFO request corresponds to ETHTOOL_GDRVINFO ioctl command and provides
> +basic driver information.
> +
> +Request contents:
> +
> +    ETHA_DRVINFO_DEV		(nested)	device identification
> +
> +Kernel response contents:
> +
> +    ETHA_DRVINFO_DEV		(nested)	device identification
> +    ETHA_DRVINFO_DRIVER		(string)	driver name
> +    ETHA_DRVINFO_VERSION	(string)	driver version

Driver version is generally useless. Is version X.Y.Z of a driver the
same when backported to some ancient enterprise kernel with 1000s of
patches? Now seems like a good opportunity to drop it.

> +    ETHA_DRVINFO_FWVERSION	(string)	firmware version
> +    ETHA_DRVINFO_BUSINFO	(string)	device bus address
> +    ETHA_DRVINFO_EROM_VER	(string)	expansion ROM version
> +    ETHA_DRVINFO_N_PRIV_FLAGS	(u32)		number of private flags
> +    ETHA_DRVINFO_N_STATS	(u32)		number of device stats

I know there is at least one driver that has somewhat dynamic number
of statistics. It would be better to have the strings and the values
in the same message, so there is no need to first get the number of
strings, allocate the memory, get the strings, then get the values.

> +    ETHA_DRVINFO_TESTINFO_LEN	(u32)		number of test results

In theory, this also does not need to be fixed. 

> +    ETHA_DRVINFO_EEDUMP_LEN	(u32)		EEPROM dump size
> +    ETHA_DRVINFO_REGDUMP_LEN	(u32)		register dump size

I would suggest removing all these _LEN properties, and let netlink
return what it needs to return.

       Andrew
