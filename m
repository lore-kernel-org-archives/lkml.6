Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9660C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BEE222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="wZESp+J5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbfBMM2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:28:32 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:44215 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbfBMM2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:28:31 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 9DE9A217BC;
        Wed, 13 Feb 2019 15:28:27 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id iJWuuFQPtU-SR6irMFg;
        Wed, 13 Feb 2019 15:28:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1550060907; bh=9sleoejbfoKY9GGVeZDa0Am1Q5NWr+nbrcXoZQyHhDg=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=wZESp+J5XNKvT/FKgJwpPqaUD+jz92YdltB5SeelIoPuF2KYbwpBQkpBL88EbXo1h
         0hb4qI2ZzUSpYkLaByXDb1/qzKSAlvVIOkbrKdkBDIeeuKf8OFlERjTial9CFMu3Re
         2HSfiBBISf8FZxNQB5UX3b8sLbolVuIUmYYqiZgM=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ccb1:d36:e945:f357])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id LI40LDvAOm-SR506eHN;
        Wed, 13 Feb 2019 15:28:27 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] inet_diag: fix reporting cgroup classid and fallback to
 priority
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sashal@kernel.org, linux-sctp@vger.kernel.org
References: <154970855279.305165.13649851988934332761.stgit@buzz>
 <20190212.103700.893095897141469287.davem@davemloft.net>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <5501a69f-0888-68b9-8442-1eda4008c85c@yandex-team.ru>
Date:   Wed, 13 Feb 2019 15:28:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212.103700.893095897141469287.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.02.2019 21:37, David Miller wrote:
> From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Date: Sat, 09 Feb 2019 13:35:52 +0300
> 
>> Field idiag_ext in struct inet_diag_req_v2 used as bitmap of requested
>> extensions has only 8 bits. Thus extensions starting from DCTCPINFO
>> cannot be requested directly. Some of them included into response
>> unconditionally or hook into some of lower 8 bits.
>>
>> Extension INET_DIAG_CLASS_ID has not way to request from the beginning.
>>
>> This patch bundle it with INET_DIAG_TCLASS (ipv6 tos), fixes space
>> reservation, and documents behavior for other extensions.
>>
>> Also this patch adds fallback to reporting socket priority. This filed
>> is more widely used for traffic classification because ipv4 sockets
>> automatically maps TOS to priority and default qdisc pfifo_fast knows
>> about that. But priority could be changed via setsockopt SO_PRIORITY so
>> INET_DIAG_TOS isn't enough for predicting class.
>>
>> Also cgroup2 obsoletes net_cls classid (it always zero), but we cannot
>> reuse this field for reporting cgroup2 id because it is 64-bit (ino+gen).
>>
>> So, after this patch INET_DIAG_CLASS_ID will report socket priority
>> for most common setup when net_cls isn't set and/or cgroup2 in use.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Fixes: 0888e372c37f ("net: inet: diag: expose sockets cgroup classid")
> 
> Applied, and queued up for -stable.
> 
> Please always put the Fixes: tag first in the list of tags.  I fixed
> it up for you this time.

Ok. Never heard about that rule, checkpatch.pl doesn't complain about that too.

> 
> Thanks.
> 
