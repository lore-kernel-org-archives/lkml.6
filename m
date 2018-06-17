Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33975C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 18:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CC12086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 18:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CC12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934189AbeFQSP1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 14:15:27 -0400
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:48082 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932524AbeFQSPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 14:15:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E7B081802EC3D;
        Sun, 17 Jun 2018 18:15:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: net76_2eb2e1bb9c863
X-Filterd-Recvd-Size: 2768
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun, 17 Jun 2018 18:15:20 +0000 (UTC)
Message-ID: <051e78ff15ac6a2e647b0c8c539ac80b3aec6328.camel@perches.com>
Subject: Re: [PATCH] net: hamradio: remove unused variable
From:   Joe Perches <joe@perches.com>
To:     Stefan Agner <stefan@agner.ch>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 17 Jun 2018 11:15:19 -0700
In-Reply-To: <20180617130335.3947-1-stefan@agner.ch>
References: <20180617130335.3947-1-stefan@agner.ch>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-17 at 15:03 +0200, Stefan Agner wrote:
> The array bpq_eth_addr is only used to get the size of an
> address. Remove the array and use the size of the array
> bcast_addr which is actually copied.
> 
> Also constify and tidy up the bcast_addr declaration.
> 
> This fixes a warning seen with clang:
> drivers/net/hamradio/bpqether.c:94:13: warning: variable 'bpq_eth_addr' is not
>       needed and will not be emitted [-Wunneeded-internal-declaration]
> static char bpq_eth_addr[6];
>             ^
> 1 warning generated.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/net/hamradio/bpqether.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
> index f347fd9c5b28..8c9c9977241e 100644
> --- a/drivers/net/hamradio/bpqether.c
> +++ b/drivers/net/hamradio/bpqether.c
> @@ -89,9 +89,7 @@
>  static const char banner[] __initconst = KERN_INFO \
>  	"AX.25: bpqether driver version 004\n";
>  
> -static char bcast_addr[6]={0xFF,0xFF,0xFF,0xFF,0xFF,0xFF};
> -
> -static char bpq_eth_addr[6];
> +static const char bcast_addr[6] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
>  
>  static int bpq_rcv(struct sk_buff *, struct net_device *, struct packet_type *, struct net_device *);
>  static int bpq_device_event(struct notifier_block *, unsigned long, void *);
> @@ -501,8 +499,8 @@ static int bpq_new_device(struct net_device *edev)
>  	bpq->ethdev = edev;
>  	bpq->axdev = ndev;
>  
> -	memcpy(bpq->dest_addr, bcast_addr, sizeof(bpq_eth_addr));
> -	memcpy(bpq->acpt_addr, bcast_addr, sizeof(bpq_eth_addr));
> +	memcpy(bpq->dest_addr, bcast_addr, sizeof(bcast_addr));
> +	memcpy(bpq->acpt_addr, bcast_addr, sizeof(bcast_addr));

Probably better to remove bcast_addr altogether and use

	eth_broadcast_addr(bpq->dst_addr);
	eth_broadcast_addr(bpq->acpt_addr);


>  
>  	err = register_netdevice(ndev);
>  	if (err)
