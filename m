Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C46FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A02F213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551108617;
	bh=pJ/WxosENjmMNFSBuplGKaHM7XeXIpgs149Y7lu5bDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zVJ58PHkjB5jcPSZdr5x6vXobP80KaVHheBVwplkKcxV56fiu9bOl14SA6rhxqx64
	 VfspXXeeXlbfcwkRHLwtT0hC1i4M4MdQPdg4booL6fMHf/QeDWo/KDI9l7H5bM6lZ7
	 DpPbD6G6cREgEd+7QrEEgw6ZX1LJSEhYx8O6Fv+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfBYPaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727515AbfBYPaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:30:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A9C20663;
        Mon, 25 Feb 2019 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551108614;
        bh=pJ/WxosENjmMNFSBuplGKaHM7XeXIpgs149Y7lu5bDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftwGHIwn4szrehgaDIF0uXH5qScJTCZ5uk8NSmotFbQy/yCY5QmCzjx3N7Lib+vEx
         3//YBNSW4NDWnJI3O9PtL7AtxQmoQTx+KFq798FUETUQUPyDAGAb37Ueb3MPeTZa4u
         bGbEn+x5gwuHs1DQ3k7V0b+9zqPzOrREPDSlKAcM=
Date:   Mon, 25 Feb 2019 16:30:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, "Arad, Ronen" <ronen.arad@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dmitry Safonov <dima@arista.com>,
        David Ahern <dsahern@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Li RongQing <lirongqing@baidu.com>, YU Bo <tsu.yubo@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>, netdev@vger.kernel.org,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [stable 3.18 backport v2] netlink: Trim skb to alloc size to
 avoid MSG_TRUNC
Message-ID: <20190225153011.GG16015@kroah.com>
References: <20190222160330.34237-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222160330.34237-1-salyzyn@android.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 08:03:28AM -0800, Mark Salyzyn wrote:
> From: "Arad, Ronen" <ronen.arad@intel.com>
> 
> Direct this upstream db65a3aaf29ecce2e34271d52e8d2336b97bd9fe sha to
> stable 3.18.  This patch addresses a race condition where a call to
> 
>  nlk->max_recvmsg_len = max(nlk->max_recvmsg_len, len);
>  nlk->max_recvmsg_len = min_t(size_t, nlk->max_recvmsg_len,
> 
> one thread in-between another thread:
> 
>  skb = netlink_alloc_skb(sk,
> 
> and
> 
>  skb_reserve(skb, skb_tailroom(skb) -
>              nlk->max_recvmsg_len);
> 
> in netlink_dump.  The result can be a negative value and will cause
> a kernel panic ad BUG at net/core/skbuff.c because the negative value
> turns into an extremely large positive value.
> 
> Original commit:
> 
> netlink_dump() allocates skb based on the calculated min_dump_alloc or
> a per socket max_recvmsg_len.
> min_alloc_size is maximum space required for any single netdev
> attributes as calculated by rtnl_calcit().
> max_recvmsg_len tracks the user provided buffer to netlink_recvmsg.
> It is capped at 16KiB.
> The intention is to avoid small allocations and to minimize the number
> of calls required to obtain dump information for all net devices.
> 
> netlink_dump packs as many small messages as could fit within an skb
> that was sized for the largest single netdev information. The actual
> space available within an skb is larger than what is requested. It could
> be much larger and up to near 2x with align to next power of 2 approach.
> 
> Allowing netlink_dump to use all the space available within the
> allocated skb increases the buffer size a user has to provide to avoid
> truncaion (i.e. MSG_TRUNG flag set).
> 
> It was observed that with many VLANs configured on at least one netdev,
> a larger buffer of near 64KiB was necessary to avoid "Message truncated"
> error in "ip link" or "bridge [-c[ompressvlans]] vlan show" when
> min_alloc_size was only little over 32KiB.
> 
> This patch trims skb to allocated size in order to allow the user to
> avoid truncation with more reasonable buffer size.
> 
> Signed-off-by: Ronen Arad <ronen.arad@intel.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> (cherry pick commit db65a3aaf29ecce2e34271d52e8d2336b97bd9fe)
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ronen Arad <ronen.arad@intel.com>
> Cc: "David S . Miller" <davem@davemloft.net>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Andrei Vagin <avagin@virtuozzo.com>
> Cc: Li RongQing <lirongqing@baidu.com>
> Cc: YU Bo <tsu.yubo@gmail.com>
> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org # 3.18
> ---
>  net/netlink/af_netlink.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)

Now queued up, thanks.

greg k-h
