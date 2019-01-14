Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF19C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B6D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfANOI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:08:58 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:36828 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfANOI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:08:57 -0500
Received: from cpe-2606-a000-111b-405a-f7a2-17fc-4213-1a54.dyn6.twc.com ([2606:a000:111b:405a:f7a2:17fc:4213:1a54] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1gj2uv-0003VS-Ba; Mon, 14 Jan 2019 09:08:53 -0500
Date:   Mon, 14 Jan 2019 09:08:12 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH net] sctp: allocate sctp_sockaddr_entry with kzalloc
Message-ID: <20190114140812.GA4751@hmswarspite.think-freely.org>
References: <b1033e296052216772051e87ba5aa61bfc222076.1547462042.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1033e296052216772051e87ba5aa61bfc222076.1547462042.git.lucien.xin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 06:34:02PM +0800, Xin Long wrote:
> The similar issue as fixed in Commit 4a2eb0c37b47 ("sctp: initialize
> sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event") also exists
> in sctp_inetaddr_event, as Alexander noticed.
> 
> To fix it, allocate sctp_sockaddr_entry with kzalloc for both sctp
> ipv4 and ipv6 addresses, as does in sctp_v4/6_copy_addrlist().
> 
> Reported-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/sctp/ipv6.c     | 5 +----
>  net/sctp/protocol.c | 4 +---
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
> index b9ed271..ed8e006 100644
> --- a/net/sctp/ipv6.c
> +++ b/net/sctp/ipv6.c
> @@ -97,11 +97,9 @@ static int sctp_inet6addr_event(struct notifier_block *this, unsigned long ev,
>  
>  	switch (ev) {
>  	case NETDEV_UP:
> -		addr = kmalloc(sizeof(struct sctp_sockaddr_entry), GFP_ATOMIC);
> +		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
>  		if (addr) {
>  			addr->a.v6.sin6_family = AF_INET6;
> -			addr->a.v6.sin6_port = 0;
> -			addr->a.v6.sin6_flowinfo = 0;
>  			addr->a.v6.sin6_addr = ifa->addr;
>  			addr->a.v6.sin6_scope_id = ifa->idev->dev->ifindex;
>  			addr->valid = 1;
> @@ -434,7 +432,6 @@ static void sctp_v6_copy_addrlist(struct list_head *addrlist,
>  		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
>  		if (addr) {
>  			addr->a.v6.sin6_family = AF_INET6;
> -			addr->a.v6.sin6_port = 0;
>  			addr->a.v6.sin6_addr = ifp->addr;
>  			addr->a.v6.sin6_scope_id = dev->ifindex;
>  			addr->valid = 1;
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index d5878ae..4e0eeb1 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -101,7 +101,6 @@ static void sctp_v4_copy_addrlist(struct list_head *addrlist,
>  		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
>  		if (addr) {
>  			addr->a.v4.sin_family = AF_INET;
> -			addr->a.v4.sin_port = 0;
>  			addr->a.v4.sin_addr.s_addr = ifa->ifa_local;
>  			addr->valid = 1;
>  			INIT_LIST_HEAD(&addr->list);
> @@ -776,10 +775,9 @@ static int sctp_inetaddr_event(struct notifier_block *this, unsigned long ev,
>  
>  	switch (ev) {
>  	case NETDEV_UP:
> -		addr = kmalloc(sizeof(struct sctp_sockaddr_entry), GFP_ATOMIC);
> +		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
>  		if (addr) {
>  			addr->a.v4.sin_family = AF_INET;
> -			addr->a.v4.sin_port = 0;
>  			addr->a.v4.sin_addr.s_addr = ifa->ifa_local;
>  			addr->valid = 1;
>  			spin_lock_bh(&net->sctp.local_addr_lock);
> -- 
> 2.1.0
> 
> 
Acked-by: Neil Horman <nhorman@tuxdriver.com>

