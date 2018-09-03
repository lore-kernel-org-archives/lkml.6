Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965D9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B6C20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B6C20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeICSKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:10:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbeICSKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:10:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EEF78185331;
        Mon,  3 Sep 2018 13:50:26 +0000 (UTC)
Received: from localhost (ovpn-204-244.brq.redhat.com [10.40.204.244])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF78210EE789;
        Mon,  3 Sep 2018 13:50:21 +0000 (UTC)
Date:   Mon, 3 Sep 2018 15:50:20 +0200
From:   Jiri Benc <jbenc@redhat.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Christian Brauner <christian.brauner@canonical.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
Message-ID: <20180903155020.6112f773@redhat.com>
In-Reply-To: <2319a029-7aca-b7aa-2e8f-4dfdeedcb6df@virtuozzo.com>
References: <20180828231859.29758-1-christian@brauner.io>
        <adc2fae5-e22b-3a74-d531-01570e7970ee@virtuozzo.com>
        <20180829181303.4sacopk7y3p5xyou@gmail.com>
        <81379a4f-7149-10ff-2453-886314d0b0c4@virtuozzo.com>
        <20180830144544.tpross4jd6awou4u@gmail.com>
        <20180901013427.tj3t2mlik4t7hlt5@gmail.com>
        <2319a029-7aca-b7aa-2e8f-4dfdeedcb6df@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 03 Sep 2018 13:50:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 03 Sep 2018 13:50:26 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jbenc@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2018 16:41:45 +0300, Kirill Tkhai wrote:
> But this is a synthetic test, while I asked about real workflow.
> Is this real problem for lxd, and there is observed performance
> decrease?

It's actually not as much a performance problem but rather the only way
to get the data in some situations. Namely, when you have only netnsid.
This happens e.g. when you want to query a veth peer in another netns.

setns() requires a file descriptor which you don't have. Nor there is
a way to convert netnsid to a fd.

While developing the IFLA_IF_NETNSID patch, I was first thinking about
implementing an API doing the conversion. The problem is there's no
good place to put this into. It can't be done over netlink: netlink is
unreliable and you can't have the kernel open a fd for you and lose it.
There's no ioctl to use. So we'd be left with a procfs/sysfs or a
syscall.

Using netnsid to refer to the target netns seems to be a nice solution -
after all, netnsid is the identifier to use in netlink.

 Jiri
