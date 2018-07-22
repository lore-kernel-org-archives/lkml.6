Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9941EECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C3E20850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M+m7TrAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C3E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeGVF4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 01:56:22 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:51963 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbeGVF4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 01:56:22 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d35ed52c;
        Sun, 22 Jul 2018 04:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=uI4k+BL24/Cs1Sdbow7t7gVyK9c=; b=M+m7Tr
        AsRQlLC8Khp8J7mU4cTqEDhV5gGx0UCJ3BTz/uIV6q7gZhvVqd1zr1pKgcIiKtul
        6MQNWR0vSMjc+CS5TH9Um9eTjh75mRn258246TbBLRAaOD3Q641fPcY4jE2uEPrF
        nAB8/sowL8C7ioeLdiox3AdpD1pN9EtP8iJf6Pu6rL59quz1ZSPxZuQrAqmw+e4/
        SNYxUiiYixJN90bU5B3PkBE+5qgRbfZ3UZ5B8I4aj/w0X8OCmrsLGUxc0Zxid5U1
        IBhiQuUrbdR28RW9vgQMCYV86qfhjwUJmsD0a8qZ1w16JJVYeTb4z8+6wOIYfNjo
        oMkibIirfkZmSYig==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 17af482c (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 22 Jul 2018 04:50:54 +0000 (UTC)
Received: by mail-oi0-f43.google.com with SMTP id k81-v6so27927371oib.4;
        Sat, 21 Jul 2018 22:01:00 -0700 (PDT)
X-Gm-Message-State: AOUpUlGIAJ0S44bb1MpO6FVh+xk2RZ4sOB6ydgQ3RC5KABHibkLGxDTf
        fXopmupC+K1EcKsE5GKDUsRney2n66k0DgGxKoc=
X-Google-Smtp-Source: AAOMgpeSaclrgVjqrqH8h/YIjSOU23WMp7P81Pwex/HuO6kKsGZ7e/6PzJAnLYLPSaQGu5W7cg76oXkmHkdjzs+UreQ=
X-Received: by 2002:aca:ceca:: with SMTP id e193-v6mr3911977oig.37.1532235659121;
 Sat, 21 Jul 2018 22:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180722024925.3176-1-cscnull@gmail.com>
In-Reply-To: <20180722024925.3176-1-cscnull@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 22 Jul 2018 07:00:47 +0200
X-Gmail-Original-Message-ID: <CAHmME9pLNd5GeR4kq_KHcarPKh3mkS5Cv-2s-tiQsPG6GcZ6sw@mail.gmail.com>
Message-ID: <CAHmME9pLNd5GeR4kq_KHcarPKh3mkS5Cv-2s-tiQsPG6GcZ6sw@mail.gmail.com>
Subject: Re: [PATCH] netlink: fix memory leak
To:     cscnull@gmail.com
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>, kadlec@blackhole.kfki.hu,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        kstewart@linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dsahern@gmail.com, lucien.xin@gmail.com, ktkhai@virtuozzo.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 4:51 AM Shaochun Chen <cscnull@gmail.com> wrote:
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 393573a99a5a..7b85176cf9bb 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2275,6 +2275,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
>         struct netlink_callback *cb;
>         struct sock *sk;
>         struct netlink_sock *nlk;
> +       bool cb_running = false;
>         int ret;
>
>         refcount_inc(&skb->users);
> @@ -2317,6 +2318,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
>
>         nlk->cb_running = true;
>         nlk->dump_done_errno = INT_MAX;
> +       cb_running = true;
>
>         mutex_unlock(nlk->cb_mutex);
>
> @@ -2339,6 +2341,8 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
>         mutex_unlock(nlk->cb_mutex);
>  error_free:
>         kfree_skb(skb);
> +       if (cb_running)
> +               netlink_dump_start_fail(control);

cb_running is never true here, since nothing jumps to error_free after
you set it to be true. Pasting more code for context:


       nlk->cb_running = true;
       nlk->dump_done_errno = INT_MAX;
1) ----> cb_runnning = true;

       mutex_unlock(nlk->cb_mutex);

       ret = netlink_dump(sk);

       sock_put(sk);

       if (ret)
A)               return ret;

       /* We successfully started a dump, by returning -EINTR we
        * signal not to send ACK even if it was requested.
        */
B)       return -EINTR;

error_put:
       module_put(control->module);
error_unlock:
       sock_put(sk);
       mutex_unlock(nlk->cb_mutex);
error_free:
       kfree_skb(skb);
2) ----> if (cb_running) netlink_dump_start_fail(control);
       return ret;


After (1) is set, the function exits via (A) or (B), and so (2) is never hit.


But even if you moved it somehow to the if(ret), I'm still not sure
it'd be correct; start cbs should either succeed, or they should error
out and cleanup entirely after themselves.


>         return ret;
>  }
>  EXPORT_SYMBOL(__netlink_dump_start);
> --
> 2.17.1
>
