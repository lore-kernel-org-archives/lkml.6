Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9133C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7983921502
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7983921502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeJIBQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:16:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:40834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726391AbeJIBQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:16:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A33DAE60;
        Mon,  8 Oct 2018 18:03:49 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 1264BA0A65; Mon,  8 Oct 2018 20:03:47 +0200 (CEST)
Date:   Mon, 8 Oct 2018 20:03:47 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Edward Cree <ecree@solarflare.com>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Alan Brady <alan.brady@intel.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ethtool: fix a privilege escalation bug
Message-ID: <20181008180346.GA9504@unicorn.suse.cz>
References: <1539013777-1625-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539013777-1625-1-git-send-email-wang6495@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 10:49:35AM -0500, Wenwen Wang wrote:
> In dev_ethtool(), the eth command 'ethcmd' is firstly copied from the
> use-space buffer 'useraddr' and checked to see whether it is
> ETHTOOL_PERQUEUE. If yes, the sub-command 'sub_cmd' is further copied from
> the user space. Otherwise, 'sub_cmd' is the same as 'ethcmd'. Next,
> according to 'sub_cmd', a permission check is enforced through the function
> ns_capable(). For example, the permission check is required if 'sub_cmd' is
> ETHTOOL_SCOALESCE, but it is not necessary if 'sub_cmd' is
> ETHTOOL_GCOALESCE, as suggested in the comment "Allow some commands to be
> done by anyone". The following execution invokes different handlers
> according to 'ethcmd'. Specifically, if 'ethcmd' is ETHTOOL_PERQUEUE,
> ethtool_set_per_queue() is called. In ethtool_set_per_queue(), the kernel
> object 'per_queue_opt' is copied again from the user-space buffer
> 'useraddr' and 'per_queue_opt.sub_command' is used to determine which
> operation should be performed. Given that the buffer 'useraddr' is in the
> user space, a malicious user can race to change the sub-command between the
> two copies. In particular, the attacker can supply ETHTOOL_PERQUEUE and
> ETHTOOL_GCOALESCE to bypass the permission check in dev_ethtool(). Then
> before ethtool_set_per_queue() is called, the attacker changes
> ETHTOOL_GCOALESCE to ETHTOOL_SCOALESCE. In this way, the attacker can
> bypass the permission check and execute ETHTOOL_SCOALESCE.
> 
> This patch enforces a check in ethtool_set_per_queue() after the second
> copy from 'useraddr'. If the sub-command is different from the one obtained
> in the first copy in dev_ethtool(), an error code EINVAL will be returned.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Reviewed-by: Michal Kubecek <mkubecek@suse.cz>

I'm just not sure if "privilege escalation" is an appropriate term but
at least some sources define it loosely enough to cover also a simple
permission check bypass like this.

Michal Kubecek

> ---
>  net/core/ethtool.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/ethtool.c b/net/core/ethtool.c
> index c9993c6..ccb337e 100644
> --- a/net/core/ethtool.c
> +++ b/net/core/ethtool.c
> @@ -2462,13 +2462,17 @@ static int ethtool_set_per_queue_coalesce(struct net_device *dev,
>  	return ret;
>  }
>  
> -static int ethtool_set_per_queue(struct net_device *dev, void __user *useraddr)
> +static int ethtool_set_per_queue(struct net_device *dev,
> +				 void __user *useraddr, u32 sub_cmd)
>  {
>  	struct ethtool_per_queue_op per_queue_opt;
>  
>  	if (copy_from_user(&per_queue_opt, useraddr, sizeof(per_queue_opt)))
>  		return -EFAULT;
>  
> +	if (per_queue_opt.sub_command != sub_cmd)
> +		return -EINVAL;
> +
>  	switch (per_queue_opt.sub_command) {
>  	case ETHTOOL_GCOALESCE:
>  		return ethtool_get_per_queue_coalesce(dev, useraddr, &per_queue_opt);
> @@ -2838,7 +2842,7 @@ int dev_ethtool(struct net *net, struct ifreq *ifr)
>  		rc = ethtool_get_phy_stats(dev, useraddr);
>  		break;
>  	case ETHTOOL_PERQUEUE:
> -		rc = ethtool_set_per_queue(dev, useraddr);
> +		rc = ethtool_set_per_queue(dev, useraddr, sub_cmd);
>  		break;
>  	case ETHTOOL_GLINKSETTINGS:
>  		rc = ethtool_get_link_ksettings(dev, useraddr);
> -- 
> 2.7.4
> 
