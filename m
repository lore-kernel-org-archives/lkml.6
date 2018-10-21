Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98ECECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 05:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A3B2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 05:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A3B2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeJUNjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 09:39:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38936 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeJUNjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 09:39:54 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B31CA141B37FE;
        Sat, 20 Oct 2018 22:26:49 -0700 (PDT)
Date:   Sat, 20 Oct 2018 22:26:45 -0700 (PDT)
Message-Id: <20181020.222645.1496129473806890473.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181020.154737.106692150032143674.davem@davemloft.net>
References: <20181020.154737.106692150032143674.davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 20 Oct 2018 22:26:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sat, 20 Oct 2018 15:47:37 -0700 (PDT)

> 
> A few straggler bug fixes:
> 
> 1) Fix indexing of multi-pass dumps of ipv6 addresses, from David
>    Ahern.
> 
> 2) Revert RCU locking change for bonding netpoll, causes worse problems
>    than it solves.
> 
> 3) pskb_trim_rcsum_slow() doesn't handle odd trim offsets, resulting in
>    erroneous bad hw checksum triggers with CHECKSUM_COMPLETE devices.
>    From Dimitris Michailidis.
> 
> Please pull, thanks a lot!

Great, I appended one more bug fix to this pull request, a revert to
some neighbour code changes that adjust notifications in a way that
confuses some apps.

====================
From d2fb4fb8ee91c1b8a1dbba6afda6f5ed2eb28bdc Mon Sep 17 00:00:00 2001
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Sat, 20 Oct 2018 18:09:31 -0700
Subject: [PATCH] Revert "neighbour: force neigh_invalidate when NUD_FAILED
 update is from admin"

This reverts commit 8e326289e3069dfc9fa9c209924668dd031ab8ef.

This patch results in unnecessary netlink notification when one
tries to delete a neigh entry already in NUD_FAILED state. Found
this with a buggy app that tries to delete a NUD_FAILED entry
repeatedly. While the notification issue can be fixed with more
checks, adding more complexity here seems unnecessary. Also,
recent tests with other changes in the neighbour code have
shown that the INCOMPLETE and PROBE checks are good enough for
the original issue.

Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/core/neighbour.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 91592fceeaad..4e07824eec5e 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1148,8 +1148,7 @@ int neigh_update(struct neighbour *neigh, const u8 *lladdr, u8 new,
 		neigh->nud_state = new;
 		err = 0;
 		notify = old & NUD_VALID;
-		if (((old & (NUD_INCOMPLETE | NUD_PROBE)) ||
-		     (flags & NEIGH_UPDATE_F_ADMIN)) &&
+		if ((old & (NUD_INCOMPLETE | NUD_PROBE)) &&
 		    (new & NUD_FAILED)) {
 			neigh_invalidate(neigh);
 			notify = 1;
-- 
2.17.2

