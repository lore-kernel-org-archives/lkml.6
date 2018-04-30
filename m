Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754370AbeD3OVK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:21:10 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:53124 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753759AbeD3OVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:21:08 -0400
Subject: Re: [PATCH] ethtool: fix a potential missing-check bug
To: Wenwen Wang <wang6495@umn.edu>
CC: Kangjie Lu <kjlu@umn.edu>, "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Inbar Karmy <inbark@mellanox.com>,
        Eugenia Emantayev <eugenia@mellanox.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Vidya Sagar Ravipati <vidya.chowdary@gmail.com>,
        Alan Brady <alan.brady@intel.com>,
        "Stephen Hemminger" <stephen@networkplumber.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525051915-31944-1-git-send-email-wang6495@umn.edu>
From: Edward Cree <ecree@solarflare.com>
Message-ID: <00aa634b-edc0-220d-47d1-551c73af9f3b@solarflare.com>
Date: Mon, 30 Apr 2018 15:20:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1525051915-31944-1-git-send-email-wang6495@umn.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-MDID: 1525098066-1oYQh2zyq2r5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/18 02:31, Wenwen Wang wrote:
> In ethtool_get_rxnfc(), the object "info" is firstly copied from
> user-space. If the FLOW_RSS flag is set in the member field flow_type of
> "info" (and cmd is ETHTOOL_GRXFH), info needs to be copied again from
> user-space because FLOW_RSS is newer and has new definition, as mentioned
> in the comment. However, given that the user data resides in user-space, a
> malicious user can race to change the data after the first copy. By doing
> so, the user can inject inconsistent data. For example, in the second
> copy, the FLOW_RSS flag could be cleared in the field flow_type of "info".
> In the following execution, "info" will be used in the function
> ops->get_rxnfc(). Such inconsistent data can potentially lead to unexpected
> information leakage since ops->get_rxnfc() will prepare various types of
> data according to flow_type, and the prepared data will be eventually
> copied to user-space. This inconsistent data may also cause undefined
> behaviors based on how ops->get_rxnfc() is implemented.
I'm not sure there's actually an issue here, since the only purpose of the
 FLOW_RSS check is to avoid faulting/trampling user memory when the user
 process only has the short version of 'info'.
If userland subsequently removes the FLOW_RSS flag, then all that will
 happen is that info_size is larger than it ought to be; that cannot affect
 ops->get_rxnfc() since it isn't passed; the op should already be treating
 'info' as unsafe/user-controlled.
The only way this could lead to information leakage would be if in the non-
 FLOW_RSS case ops->get_rxnfc() was writing things it shouldn't into the
 latter part of 'info' and was getting away with it so far as that was
 never copied_to_user; that seems improbable to me, but I suppose you might
 want to do the check anyway as belt-and-braces security.
(A cleaner approach might be to only copy_from_user() the extra region of
 'info', leaving the previously-copied part alone.  That way each byte is
 only copied_from_user once and thus cannot change.)

-Ed

> This patch re-verifies the flow_type field of "info" after the second copy.
> If the value is not as expected, an error code will be returned.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  net/core/ethtool.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/ethtool.c b/net/core/ethtool.c
> index 03416e6..a121034 100644
> --- a/net/core/ethtool.c
> +++ b/net/core/ethtool.c
> @@ -1032,6 +1032,8 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
>  		info_size = sizeof(info);
>  		if (copy_from_user(&info, useraddr, info_size))
>  			return -EFAULT;
> +		if (!(info.flow_type & FLOW_RSS))
> +			return -EINVAL;
>  	}
>  
>  	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
