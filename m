Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26052C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFBE2190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbfBLShC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:37:02 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56098 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBLShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:37:02 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 813F714C50539;
        Tue, 12 Feb 2019 10:37:01 -0800 (PST)
Date:   Tue, 12 Feb 2019 10:37:00 -0800 (PST)
Message-Id: <20190212.103700.893095897141469287.davem@davemloft.net>
To:     khlebnikov@yandex-team.ru
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sashal@kernel.org, linux-sctp@vger.kernel.org
Subject: Re: [PATCH] inet_diag: fix reporting cgroup classid and fallback
 to priority
From:   David Miller <davem@davemloft.net>
In-Reply-To: <154970855279.305165.13649851988934332761.stgit@buzz>
References: <154970855279.305165.13649851988934332761.stgit@buzz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Feb 2019 10:37:01 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Date: Sat, 09 Feb 2019 13:35:52 +0300

> Field idiag_ext in struct inet_diag_req_v2 used as bitmap of requested
> extensions has only 8 bits. Thus extensions starting from DCTCPINFO
> cannot be requested directly. Some of them included into response
> unconditionally or hook into some of lower 8 bits.
> 
> Extension INET_DIAG_CLASS_ID has not way to request from the beginning.
> 
> This patch bundle it with INET_DIAG_TCLASS (ipv6 tos), fixes space
> reservation, and documents behavior for other extensions.
> 
> Also this patch adds fallback to reporting socket priority. This filed
> is more widely used for traffic classification because ipv4 sockets
> automatically maps TOS to priority and default qdisc pfifo_fast knows
> about that. But priority could be changed via setsockopt SO_PRIORITY so
> INET_DIAG_TOS isn't enough for predicting class.
> 
> Also cgroup2 obsoletes net_cls classid (it always zero), but we cannot
> reuse this field for reporting cgroup2 id because it is 64-bit (ino+gen).
> 
> So, after this patch INET_DIAG_CLASS_ID will report socket priority
> for most common setup when net_cls isn't set and/or cgroup2 in use.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 0888e372c37f ("net: inet: diag: expose sockets cgroup classid")

Applied, and queued up for -stable.

Please always put the Fixes: tag first in the list of tags.  I fixed
it up for you this time.

Thanks.
