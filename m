Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AFFC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E50D2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E50D2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJCUNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:13:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbeJCUNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:13:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A3BD31524E8;
        Wed,  3 Oct 2018 13:25:13 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5406F17C57;
        Wed,  3 Oct 2018 13:25:13 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A8CE34BB74;
        Wed,  3 Oct 2018 13:25:12 +0000 (UTC)
Date:   Wed, 3 Oct 2018 09:25:12 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, syzkaller@googlegroups.com,
        linux-kernel@vger.kernel.org
Message-ID: <2058134821.17788321.1538573112620.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181002.222540.1948082296309410659.davem@davemloft.net>
References: <20180926093018.6646-1-vdronov@redhat.com> <20180929.114023.1370133506922372520.davem@davemloft.net> <1615981257.17285278.1538393552487.JavaMail.zimbra@redhat.com> <20181002.222540.1948082296309410659.davem@davemloft.net>
Subject: Re: [PATCH] net: arp, ipv6: handle special case of tap device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.200.24, 10.4.195.23]
Thread-Topic: arp, ipv6: handle special case of tap device
Thread-Index: eIxJwjLVRzmlnjeCA2wqY3PDs93nmA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 03 Oct 2018 13:25:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "David Miller" <davem@davemloft.net>
> Sent: Wednesday, October 3, 2018 7:25:40 AM
>
> > Probably, this functionality is already used by some userspace, so I
> > believe, I cannot just remove TUNSETLINK ioctl.
> 
> Who uses it, how do they use it, and what do they sanely expect about
> the link layer header properties of a tap device which has had ->type
> changed?

Honestly, I have no idea. I was working on a syzkaller bug report and
found that the reason for that bug was TUNSETLINK ioctl.

This ioctl was introduced 13 years ago with ff4cc3ac93e1d and it says:

> For use with
> wireless and other networking types it should be possible to set the
> ARP type via an ioctl.

, that's all. Let me try to prepare a patch that sets dev->addr_len and
dev->broadcast according to dev->type. I would probably need an advise
what other fields must be adjusted too.

Otherwise, we can just to remove the TUNSETLINK ioctl.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer
