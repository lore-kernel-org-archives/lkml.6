Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1053AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B80020C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B80020C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alphalink.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbeIRW0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:26:23 -0400
Received: from zimbra.alphalink.fr ([217.15.80.77]:52508 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbeIRW0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:26:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id DB3502B52057;
        Tue, 18 Sep 2018 18:52:55 +0200 (CEST)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7IRdn2atwe1w; Tue, 18 Sep 2018 18:52:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 97C622B52099;
        Tue, 18 Sep 2018 18:52:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XFZBZy_CznG4; Tue, 18 Sep 2018 18:52:54 +0200 (CEST)
Received: from c-dev-0.admin.alphalink.fr (94-84-15-217.reverse.alphalink.fr [217.15.84.94])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 5E09E2B52057;
        Tue, 18 Sep 2018 18:52:54 +0200 (CEST)
Received: by c-dev-0.admin.alphalink.fr (Postfix, from userid 1000)
        id 38DE860205; Tue, 18 Sep 2018 18:52:54 +0200 (CEST)
Date:   Tue, 18 Sep 2018 18:52:54 +0200
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        syzbot+f5f6080811c849739212@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>, mostrows@earthlink.net,
        Networking <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KMSAN: uninit-value in pppoe_rcv
Message-ID: <20180918165254.GB1473@alphalink.fr>
References: <0000000000004624c30575a9fd40@google.com>
 <CAG_fn=Vk2HMPCLJV3aj1dt0KkDmksasBRRfKGnCTRHjvQ6OnQg@mail.gmail.com>
 <7424e094-afda-084a-ad80-299f219ced92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7424e094-afda-084a-ad80-299f219ced92@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 06:57:54AM -0700, Eric Dumazet wrote:
> 
> 
> I guess the following patch would fix the issue
> 
> (I will submit it more formally)
>
Hi Eric,

Do you still plan to submit this patch? Otherwise I can take care of it.


> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index ce61231e96ea5fe27f512fbd0d80d4609997e508..333e967ed968ea3ff2dda25289f7f657263db2b9 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -423,6 +423,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
>         struct pppoe_hdr *ph;
>         struct pppox_sock *po;
>         struct pppoe_net *pn;
> +       __be16 sid;
>         int len;
>  
>         skb = skb_share_check(skb, GFP_ATOMIC);
> @@ -434,6 +435,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
>  
>         ph = pppoe_hdr(skb);
>         len = ntohs(ph->length);
> +       sid = ph->sid;
>  
>         skb_pull_rcsum(skb, sizeof(*ph));
>         if (skb->len < len)
> @@ -447,7 +449,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
>         /* Note that get_item does a sock_hold(), so sk_pppox(po)
>          * is known to be safe.
>          */
> -       po = get_item(pn, ph->sid, eth_hdr(skb)->h_source, dev->ifindex);
> +       po = get_item(pn, sid, eth_hdr(skb)->h_source, dev->ifindex);
>         if (!po)
>                 goto drop;
> 
> 
> 
