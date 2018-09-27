Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE63CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E6F216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzUCk7V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E6F216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeI1Enm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:43:42 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53235 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeI1Enm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:43:42 -0400
Received: by mail-it1-f194.google.com with SMTP id 134-v6so467230itz.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=83CocJOACgKGJl1oYACEpsBwRqW42LwLyQzp39xcIvE=;
        b=pzUCk7V5vnZjx2NYB21VURKdiF+KXldKInbRsOYnNW/NGLx6/dA6tV6xaATEb9/tJL
         6+4QBoDAhmAY2Xfao1r0m+09jtXQ/26ctceTr9UKDrVkf1QbqIpD3cG62/RcxXpXyLIz
         bw9mBj/k/6om+Vv3qH2LKwqhgupKeXirqlp6wAQdZuJm6JTwVf/XM72PKjhgoGNWkRMX
         RuXdQUnF75iw2EkcrSyxgnF+i9jzLfVQTZMqXt7LDMfy4Dzo2WnV7kmG54Prk9A9BNvT
         KCIuZyNZG+pDGqTtUN9IAnUa9SwASjEgV/zg3e2zmdlry4ePvLo4qpMyXmwKaX+6afL7
         fFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83CocJOACgKGJl1oYACEpsBwRqW42LwLyQzp39xcIvE=;
        b=Pxa6xCy/+nwsnc6eafkKjVTbJ8sdriSMfuixtxpNl8p0cgAMuG52vk753iXyfbb993
         1b+cREnEJVLYXlAQPc9Sf7seRYJKK5qbk3rlK8rKVrZiwFoV8AeuzD3LvrixnlY31cgi
         26suh9BIGsejiUSgmL3fUcMn8K2au9yVidvOxBGqz7YENyyE9YA1LP8dIeaSNLjuZ7Lk
         bA9hrEFyadVj8Kuh/msb2pg/li3Rke8GeoxRN4Idsb/zPilYiADAf7bc1Vk5yEfVBy8P
         b11Ig47OI8PQ9tlTq3b+vg/M3Wxkmkumbpiidy+PZCWGUXAsaWbPr+QuYBiHu/iDwYtp
         0s/Q==
X-Gm-Message-State: ABuFfohVJ7AqnqQYTv9ZXza28mmHwSeYcz524zo5xyhz9zuTxT2YZOEu
        nOTcyq/0PJd1WaSST6VKkL0iW1MQdp+V4jw/DbvxKA==
X-Google-Smtp-Source: ACcGV62+eDauko3TM/vWqvyouuT+dmFH5sLOLOl21svemm41TqVUAcJ+AlpKYEsDL1ZYdv1jvLxXK0IZzET5t/NDWZg=
X-Received: by 2002:a02:4142:: with SMTP id x63-v6mr11564139jaa.55.1538086992214;
 Thu, 27 Sep 2018 15:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005e2e530576c6f9ce@google.com> <20180927213026.16863-1-vdronov@redhat.com>
In-Reply-To: <20180927213026.16863-1-vdronov@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Sep 2018 15:22:59 -0700
Message-ID: <CANn89iJNNfiEPM24NgnodV-QUnCyJcrRjKsHV9jdP4i3fBdESw@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in __dev_mc_add
To:     vdronov@redhat.com
Cc:     syzbot+001516d86dbe88862cec@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 2:30 PM Vladis Dronov <vdronov@redhat.com> wrote:
>
> Hello,
>
> This report is actually for the same bug which was reported in:
>
> https://syzkaller.appspot.com/bug?id=088efeac32fdde781038a777a63e436c0d4d7036
>
> The note there that the bug was fixed by "Commits: net: fix uninit-value in
> __hw_addr_add_ex()" is wrong. A C-reproducer from the 2nd syzkaller report
> can trigger the bug from this one.
>
> I've researched this and a result is a proposed patch, the problem is the tun
> device code allowing to set an arbitrary link type.
>
> https://lkml.org/lkml/2018/9/26/416
> https://lore.kernel.org/lkml/20180926093018.6646-1-vdronov@redhat.com/T/#u
> https://marc.info/?l=linux-netdev&m=153795423320016&w=2
>

I dunno, your patch looks quite not the right fix.

If TUN is able to change dev->type,  how comes it does not set the
appropriate dev->addr_len at the same time ?

Really the bug seems to be deeper, and without setting proper
dev->addr_len, we'll need more 'fixes' like yours.

Thanks.
