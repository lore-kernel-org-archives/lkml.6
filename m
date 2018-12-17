Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77677C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4623F2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388757AbeLQSVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:21:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732671AbeLQSVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:21:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E23D564100;
        Mon, 17 Dec 2018 18:21:30 +0000 (UTC)
Received: from localhost (ovpn-200-20.brq.redhat.com [10.40.200.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3F9A6B8E4;
        Mon, 17 Dec 2018 18:21:26 +0000 (UTC)
Date:   Mon, 17 Dec 2018 19:21:21 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        syzbot <syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>
Subject: Re: WARNING in __rcu_read_unlock
Message-ID: <20181217192121.64f34511@redhat.com>
In-Reply-To: <20181217162421.6d636ee5@redhat.com>
References: <0000000000005e47a2057d0edc49@google.com>
        <20181216190412.GE4170@linux.ibm.com>
        <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com>
        <20181217112916.GG4170@linux.ibm.com>
        <1583d5fc-34bf-3a81-363d-01a1085a7363@linux.intel.com>
        <CACT4Y+aKn4XsGVgt3ELGnnJcg6H-m+dSdV018dLvJhrpshycWA@mail.gmail.com>
        <20641819-e4fb-f3bd-34c8-c68106cccd0e@gmail.com>
        <20181217162421.6d636ee5@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 17 Dec 2018 18:21:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 16:24:21 +0100
Stefano Brivio <sbrivio@redhat.com> wrote:

> On Mon, 17 Dec 2018 06:57:35 -0800
> Eric Dumazet <eric.dumazet@gmail.com> wrote:
> 
> > Might be cause by commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> > fou, fou6: ICMP error handlers for FoU and GUE  
> 
> This:
> 
> diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
> index 0d0ad19ecb87..20a6de26d146 100644
> --- a/net/ipv4/fou.c
> +++ b/net/ipv4/fou.c
> @@ -1008,6 +1008,9 @@ static int gue_err_proto_handler(int proto, struct sk_buff *skb, u32 info)
>  {
>         const struct net_protocol *ipprot = rcu_dereference(inet_protos[proto]);
>  
> +       if (ipprot == IPPROTO_UDP)
              ^^^ proto, of course

> +               return -EINVAL;
> +
>         if (ipprot && ipprot->err_handler) {
>                 if (!ipprot->err_handler(skb, info))
>                         return 0;
> 

-- 
Stefano
