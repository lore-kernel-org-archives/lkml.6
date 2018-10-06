Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AACECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1402147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1402147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeJGCrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 22:47:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbeJGCru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 22:47:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 773CB308212B;
        Sat,  6 Oct 2018 19:43:18 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-33.brq.redhat.com [10.40.200.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA0DE171F8;
        Sat,  6 Oct 2018 19:43:16 +0000 (UTC)
Date:   Sat, 6 Oct 2018 21:43:48 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next v7 28/28] net: WireGuard secure network tunnel
Message-ID: <20181006194348.GK32759@asgard.redhat.com>
References: <20181006025709.4019-1-Jason@zx2c4.com>
 <20181006025709.4019-29-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006025709.4019-29-Jason@zx2c4.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 06 Oct 2018 19:43:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 04:57:09AM +0200, Jason A. Donenfeld wrote:
> +static int get_allowedips(void *ctx, const u8 *ip, u8 cidr, int family)
> +{
> +	struct allowedips_ctx *actx = ctx;
> +	struct nlattr *allowedip_nest;
> +
> +	allowedip_nest = nla_nest_start(actx->skb, actx->i++);

Second parameter of nl_nest_start is an attribute type; (ab)using it as
array index leads to special handling of such structures in parsers.
It's better to have some type like WGDEVICE_A_PEER_ITEM and provide an
additional attribute inside it for index (WGPEER_A_INDEX?).
See, for example, commit v4.12-rc1~119^2~131 ("nbd: add a status netlink
command").

> +static int get_peer(struct wireguard_peer *peer, unsigned int index,
> +		    struct allowedips_cursor *rt_cursor, struct sk_buff *skb)
> +{
> +	struct nlattr *allowedips_nest, *peer_nest = nla_nest_start(skb, index);

Same here.
