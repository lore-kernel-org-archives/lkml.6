Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE0EC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A17219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A17219E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeHFLPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:15:50 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:44913 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeHFLPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:15:50 -0400
Received: from [IPv6:2003:e9:d706:d44e:3252:cbff:fe54:190f] (p200300E9D706D44E3252CBFFFE54190F.dip0.t-ipconnect.de [IPv6:2003:e9:d706:d44e:3252:cbff:fe54:190f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 04AD7C75AE;
        Mon,  6 Aug 2018 11:07:40 +0200 (CEST)
Subject: Re: [PATCH] ieee802154: add rx LQI from userspace
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Romuald Cari <romuald.cari@devialet.com>,
        linux-wpan@vger.kernel.org
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>
References: <20180607140802.22666-1-peron.clem@gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <35c6ef3e-7f7b-2a2d-d73b-201efbc4594c@datenfreihafen.org>
Date:   Mon, 6 Aug 2018 11:07:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180607140802.22666-1-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 06/07/2018 04:08 PM, Clément Péron wrote:
> From: Romuald CARI <romuald.cari@devialet.com>
> 
> The Link Quality Indication data exposed by drivers could not be accessed from
> userspace. Since this data is per-datagram received, it makes sense to make it
> available to userspace application through the ancillary data mechanism in
> recvmsg rather than through ioctls. This can be activated using the socket
> option WPAN_WANTLQI under SOL_IEEE802154 protocol.
> 
> This LQI data is available in the ancillary data buffer under the SOL_IEEE802154
> level as the type WPAN_LQI. The value is an unsigned byte indicating the link
> quality with values ranging 0-255.
> 
> Signed-off-by: Romuald Cari <romuald.cari@devialet.com>
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> ---
>  include/net/af_ieee802154.h |  1 +
>  net/ieee802154/socket.c     | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
> index a5563d27a3eb..8003a9f6eb43 100644
> --- a/include/net/af_ieee802154.h
> +++ b/include/net/af_ieee802154.h
> @@ -56,6 +56,7 @@ struct sockaddr_ieee802154 {
>  #define WPAN_WANTACK		0
>  #define WPAN_SECURITY		1
>  #define WPAN_SECURITY_LEVEL	2
> +#define WPAN_WANTLQI		3
>  
>  #define WPAN_SECURITY_DEFAULT	0
>  #define WPAN_SECURITY_OFF	1
> diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> index a60658c85a9a..bc6b912603f1 100644
> --- a/net/ieee802154/socket.c
> +++ b/net/ieee802154/socket.c
> @@ -25,6 +25,7 @@
>  #include <linux/termios.h>	/* For TIOCOUTQ/INQ */
>  #include <linux/list.h>
>  #include <linux/slab.h>
> +#include <linux/socket.h>
>  #include <net/datalink.h>
>  #include <net/psnap.h>
>  #include <net/sock.h>
> @@ -452,6 +453,7 @@ struct dgram_sock {
>  	unsigned int bound:1;
>  	unsigned int connected:1;
>  	unsigned int want_ack:1;
> +	unsigned int want_lqi:1;
>  	unsigned int secen:1;
>  	unsigned int secen_override:1;
>  	unsigned int seclevel:3;
> @@ -486,6 +488,7 @@ static int dgram_init(struct sock *sk)
>  	struct dgram_sock *ro = dgram_sk(sk);
>  
>  	ro->want_ack = 1;
> +	ro->want_lqi = 0;
>  	return 0;
>  }
>  
> @@ -713,6 +716,7 @@ static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	size_t copied = 0;
>  	int err = -EOPNOTSUPP;
>  	struct sk_buff *skb;
> +	struct dgram_sock *ro = dgram_sk(sk);
>  	DECLARE_SOCKADDR(struct sockaddr_ieee802154 *, saddr, msg->msg_name);
>  
>  	skb = skb_recv_datagram(sk, flags, noblock, &err);
> @@ -744,6 +748,13 @@ static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  		*addr_len = sizeof(*saddr);
>  	}
>  
> +	if (ro->want_lqi) {
> +		err = put_cmsg(msg, SOL_IEEE802154, WPAN_WANTLQI,
> +			       sizeof(uint8_t), &(mac_cb(skb)->lqi));
> +		if (err)
> +			goto done;
> +	}
> +
>  	if (flags & MSG_TRUNC)
>  		copied = skb->len;
>  done:
> @@ -847,6 +858,9 @@ static int dgram_getsockopt(struct sock *sk, int level, int optname,
>  	case WPAN_WANTACK:
>  		val = ro->want_ack;
>  		break;
> +	case WPAN_WANTLQI:
> +		val = ro->want_lqi;
> +		break;
>  	case WPAN_SECURITY:
>  		if (!ro->secen_override)
>  			val = WPAN_SECURITY_DEFAULT;
> @@ -892,6 +906,9 @@ static int dgram_setsockopt(struct sock *sk, int level, int optname,
>  	case WPAN_WANTACK:
>  		ro->want_ack = !!val;
>  		break;
> +	case WPAN_WANTLQI:
> +		ro->want_lqi = !!val;
> +		break;
>  	case WPAN_SECURITY:
>  		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
>  		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
