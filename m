Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754769AbeD3QOA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:14:00 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33700 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754555AbeD3QN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:13:58 -0400
Date: Mon, 30 Apr 2018 12:13:57 -0400 (EDT)
Message-Id: <20180430.121357.2257158218189689071.davem@davemloft.net>
To: amsalam20@gmail.com
Cc: dav.lebrun@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next v2] ipv6: sr: extract the right key values for
 "seg6_make_flowlabel"
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524910715-12097-1-git-send-email-amsalam20@gmail.com>
References: <1524910715-12097-1-git-send-email-amsalam20@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmed Abdelsalam <amsalam20@gmail.com>
Date: Sat, 28 Apr 2018 12:18:35 +0200

> The seg6_make_flowlabel() is used by seg6_do_srh_encap() to compute the
> flowlabel from a given skb. It relies on skb_get_hash() which eventually
> calls __skb_flow_dissect() to extract the flow_keys struct values from
> the skb.
> 
> In case of IPv4 traffic, calling seg6_make_flowlabel() after skb_push(),
> skb_reset_network_header(), and skb_mac_header_rebuild() will results in
> flow_keys struct of all key values set to zero.
> 
> This patch calls seg6_make_flowlabel() before resetting the headers of skb
> to get the right key values.
> 
> Extracted Key values are based on the type inner packet as follows:
> 1) IPv6 traffic: src_IP, dst_IP, L4 proto, and flowlabel of inner packet.
> 2) IPv4 traffic: src_IP, dst_IP, L4 proto, src_port, and dst_port
> 3) L2 traffic: depends on what kind of traffic carried into the L2
> frame. IPv6 and IPv4 traffic works as discussed 1) and 2)
> 
> Here a hex_dump of struct flow_keys for IPv4 and IPv6 traffic
> 10.100.1.100: 47302 > 30.0.0.2: 5001
> 00000000: 14 00 02 00 00 00 00 00 08 00 11 00 00 00 00 00
> 00000010: 00 00 00 00 00 00 00 00 13 89 b8 c6 1e 00 00 02
> 00000020: 0a 64 01 64
> 
> fc00:a1:a > b2::2
> 00000000: 28 00 03 00 00 00 00 00 86 dd 11 00 99 f9 02 00
> 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 b2 00 00
> 00000020: 00 00 00 00 00 00 00 00 00 00 00 02 fc 00 00 a1
> 00000030: 00 00 00 00 00 00 00 00 00 00 00 0a
> 
> Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>

Looks good, applied, thank you.
