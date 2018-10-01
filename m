Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004F7C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82B82089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82B82089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbeJASJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:09:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbeJASJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:09:55 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EEF9380F9A;
        Mon,  1 Oct 2018 11:32:34 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 812E1D94D5;
        Mon,  1 Oct 2018 11:32:34 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A90841800533;
        Mon,  1 Oct 2018 11:32:32 +0000 (UTC)
Date:   Mon, 1 Oct 2018 07:32:32 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, syzkaller@googlegroups.com,
        linux-kernel@vger.kernel.org
Message-ID: <1615981257.17285278.1538393552487.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180929.114023.1370133506922372520.davem@davemloft.net>
References: <20180926093018.6646-1-vdronov@redhat.com> <20180929.114023.1370133506922372520.davem@davemloft.net>
Subject: Re: [PATCH] net: arp, ipv6: handle special case of tap device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.200.39, 10.4.195.2]
Thread-Topic: arp, ipv6: handle special case of tap device
Thread-Index: lUVett93TuT4LfTue9fXUgUwUunLfw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 01 Oct 2018 11:32:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David, all,

> This is insanely ugly.
> I'm not applying this, sorry. 

It is ugly, I agree.

> dev->type determines the link layer header layout and size.

Yes, unfortunately, TUNSETLINK ioctl handler does not adjust all the needed
fields after the tun->dev->type:

[drivers/net/tun.c]
        case TUNSETLINK:
                ...
                tun->dev->type = (int) arg; //<--- that's all

Let me share what I see and let me hope to get an advise for a better fix.
(also another related thread: https://marc.info/?t=153797194500007&r=1&w=2)

- So setting just the tun->dev->type makes the dev struct inconsistent.

- There are more field to adjust, at least dev->addr_len and dev->broadcast.

- There is no get_addr_len_by_link_type() or a simple way to get link layer
  properties by dev->type. Such settings are scattered in *_setup and
  *_init functions, like ipgre_tunnel_init() { ... dev->addr_len = 4; ...}

> I think tun/tap should be prevented from
> allowing the dev->type to be changed, unless it will make those changes
> adjust the link layer headers properly as well.

Probably, this functionality is already used by some userspace, so I believe,
I cannot just remove TUNSETLINK ioctl. Let me try to suggest a patch that
sets dev->addr_len and dev->broadcast (and probably other link-level-related)
fields according to the dev->type.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer
