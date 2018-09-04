Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AA2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411322086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411322086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeIDLN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:13:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726094AbeIDLN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:13:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3DB020E19;
        Tue,  4 Sep 2018 06:50:12 +0000 (UTC)
Received: from localhost (ovpn-204-74.brq.redhat.com [10.40.204.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC7F62166BA8;
        Tue,  4 Sep 2018 06:50:08 +0000 (UTC)
Date:   Tue, 4 Sep 2018 08:50:06 +0200
From:   Jiri Benc <jbenc@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, fw@strlen.de, ktkhai@virtuozzo.com,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v1 3/5] ipv4: enable IFA_IF_NETNSID for
 RTM_GETADDR
Message-ID: <20180904085006.58c665c0@redhat.com>
In-Reply-To: <a4282d46-4c17-b395-dec0-7c8ac10cbf97@gmail.com>
References: <20180903043717.20136-1-christian@brauner.io>
        <20180903043717.20136-4-christian@brauner.io>
        <a4282d46-4c17-b395-dec0-7c8ac10cbf97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 04 Sep 2018 06:50:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 04 Sep 2018 06:50:12 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jbenc@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2018 21:11:30 -0600, David Ahern wrote:
> Can only use it once per message type, but NLM_F_DUMP_FILTERED is a flag
> that can be set to explicitly say the request is filtered as requested.

The problem is that NLM_F_DUMP_FILTERED is too coarse. There's no way
to determine whether the netnsid was honored or whether it was not but
other filtering took effect.

This is a general problem with netlink: unknown attributes are ignored.
We need a way to detect that certain attribute was understood by the
kernel or was not. And it needs to work retroactively, i.e. the
application has to be able to determine the currently running kernel
does not support the feature (because it's too old).

That's why we return back the attribute in responses to a request with
IFLA_IF_NETNSID present and why we should do the same for
IFA_IF_NETNSID.

> See 21fdd092acc7e. I would like to see other filters added for addresses
> in the same release this gets used. The only one that comes to mind for
> addresses is to only return addresses for devices with master device
> index N (same intent as 21fdd092acc7e for neighbors).

I also question the statement that IFA_F_NETNSID is a filter: my
understanding of "filter" is something that limits the output to a
certain subset. I.e., unfiltered results always contain everything that
is in a filtered result. While with IFA_F_NETNSID, we get a completely
different set of data. Does that really constitute a filter? Note that
we can still filter in the target netns.

Thanks,

 Jiri
