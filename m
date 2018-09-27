Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8C9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8B721582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8B721582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeI1Faz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:30:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbeI1Faz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:30:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65F6688312;
        Thu, 27 Sep 2018 23:10:14 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 53E161062242;
        Thu, 27 Sep 2018 23:10:14 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 210DB18005CE;
        Thu, 27 Sep 2018 23:10:14 +0000 (UTC)
Date:   Thu, 27 Sep 2018 19:10:13 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     syzbot+001516d86dbe88862cec@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Message-ID: <525568947.16793847.1538089813920.JavaMail.zimbra@redhat.com>
In-Reply-To: <CANn89iJNNfiEPM24NgnodV-QUnCyJcrRjKsHV9jdP4i3fBdESw@mail.gmail.com>
References: <0000000000005e2e530576c6f9ce@google.com> <20180927213026.16863-1-vdronov@redhat.com> <CANn89iJNNfiEPM24NgnodV-QUnCyJcrRjKsHV9jdP4i3fBdESw@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in __dev_mc_add
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.200.20, 10.4.195.25]
Thread-Topic: KMSAN: uninit-value in __dev_mc_add
Thread-Index: rdSpYqoLF7bzz3JYiAErs+/p6K4VQA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 27 Sep 2018 23:10:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Eric, all,

> I dunno, your patch looks quite not the right fix.

I agree, it looks more like a dirty hack. Unfortunately, I lack the deep
expertise in the network stack subsystem, so I've posted the patch to,
sort of, start a discussion and probably get some hints.
 
> If TUN is able to change dev->type,  how comes it does not set the
> appropriate dev->addr_len at the same time ?

Well,... probably, nobody cared to do so:

[drivers/net/tun.c]
        case TUNSETLINK:
                ...
                        tun->dev->type = (int) arg; //<--- that's all!
                        tun_debug(KERN_INFO, tun, "linktype set to %d\n",
                                  tun->dev->type);
                        ret = 0;
                }
                break;

> Really the bug seems to be deeper, and without setting proper
> dev->addr_len, we'll need more 'fixes' like yours.

Absolutely. Unfortunately, I wasn't able to just write such deeper patch. 
Let me share what I have found and let me hope to get an advise.

- So setting just the tun->dev->type makes the dev struct inconsistent.

- There are more field to adjust, at least dev->broadcast. Also, there are
  a number of *_ops fields which are all set for the Ethernet type, most
  probably they must be adjusted also.

- There is no get_addr_len_by_link_type() or a simple way to get link layer
  properties by dev->type. Such settings are scattered in *_setup and
  *_init functions, like ipgre_tunnel_init() { ... dev->addr_len = 4; ...}

Having these, I can imagine 2 ways for a proper fix.

1) Destroy the net_device in question and recreate it when changing a link
type. This way all the dev fields are set right. Create it in a similar way
as rtnl_newlink() does. Again, we do not have get_X_by_link_type(), so it
probably will be some large switch()/case:

  $ grep '^#define ARPHRD_' include/uapi/linux/if_arp.h | wc -l
  59

2) Leave tun an Ethernet device, add some tun->pretend_to_be_this_link_type
field and change only it on TUNSETLINK. And use this field in cases for which
TUNSETLINK was invented in the first place. Unfortunately, I do not have such
a list. The initial the commit ff4cc3ac93e1 says:

  For use with
  wireless and other networking types it should be possible to set the
  ARP type via an ioctl.

Surely, there can be something else which I do not see. Could anyone suggest
an advice on this?

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer
