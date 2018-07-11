Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A521C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9326208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9326208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeGKKLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:11:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbeGKKLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:11:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C667D4071186;
        Wed, 11 Jul 2018 10:07:57 +0000 (UTC)
Received: from localhost (ovpn-204-186.brq.redhat.com [10.40.204.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CFC3111AF35;
        Wed, 11 Jul 2018 10:07:55 +0000 (UTC)
Date:   Wed, 11 Jul 2018 12:07:53 +0200
From:   Jiri Benc <jbenc@redhat.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Subject: Re: KASAN: use-after-free Read in ipv6_gso_pull_exthdrs
Message-ID: <20180711120753.6940b66d@redhat.com>
In-Reply-To: <CAF=yD-LcXtF94=5Xt5zeD=AmqHxNHGP+NURazJERigA8ysBuAQ@mail.gmail.com>
References: <000000000000b0ee7a056eea93a7@google.com>
        <00000000000033f8440570585207@google.com>
        <CAF=yD-JgBPy+D2Jm7SN=-bzAfAf__pxE92qAqNWs=9EqfyLmAA@mail.gmail.com>
        <CAF=yD-LcXtF94=5Xt5zeD=AmqHxNHGP+NURazJERigA8ysBuAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 11 Jul 2018 10:07:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 11 Jul 2018 10:07:57 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jbenc@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delayed reply, I'm working through a pile of stuff after
being off.

On Sun, 8 Jul 2018 18:58:14 -0400, Willem de Bruijn wrote:
> Setting skb->mac_len to 0, similar to mpls_gs_segment,
> is sufficient if the encapsulated packet is not ETH_P_TEB.
> 
> If the packet is encapsulated at L2, __skb_pull(skb, vlan_depth)
> has to pull the inner mac header before passing to l3 handlers like
> inet_gso_segment.
> 
> If that header includes VLAN tags, skb_network_protocol will
> parse then and update the mac length in vlan_depth. So
> hardcoding to ETH_HLEN should be fine:
> 
> @@ -104,7 +95,7 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
>         __skb_pull(skb, nsh_len);
> 
>         skb_reset_mac_header(skb);
> -       skb_reset_mac_len(skb);
> +       skb->mac_len = proto == ETH_P_TEB ? ETH_HLEN : 0;
>         skb->protocol = proto;
> 
>         features &= NETIF_F_SG;

I agree. I think my original intention was to set mac_len to 0. Which
is obviously not done by calling skb_reset_mac_len...

Strangely, skb_network_protocol does not set *depth to ETH_HLEN if it
is 0 and the type is ETH_P_TEB, which is something I would expect it to
do. Thus we indeed have to differentiate between the two cases before
calling skb_mac_gso_segment.

Willem, will you send the patch formally (with the htons fix)? Thanks a
lot for the analysis and the patch!

 Jiri
