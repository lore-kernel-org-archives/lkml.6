Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B6AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C307218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358834;
	bh=tiZqL59sNN3TJDcQyUxYKjVi/9gtE6L2bHWSlvfNBwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rZWwNbNFCNghmlb+6xQeJVCFYSxKC1gZpYTsxWe5bFp7eeqUaZnbPImT1Ax1W1NDY
	 oP1X2Izlv1b+8dob5dOdMuxYy4In9Nl28Qjrp85w0nANgX5vQ9OTINvvr27A+O/oPF
	 mMBV/pIsD85/L4DmQCShoP3N/WDGIp1AGOW0DC8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733292AbfAXTkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733252AbfAXTk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:40:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B79320663;
        Thu, 24 Jan 2019 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358827;
        bh=tiZqL59sNN3TJDcQyUxYKjVi/9gtE6L2bHWSlvfNBwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojtgc5LPtligV5GA2+7A9AsymJZQvCIP3kUgZwQw6JarF9CDDcVo7vMd7OngpMHX4
         r8wo5IHJk0ZsfwbK3BN/8ietW2M+egUPb7CdnfqDkKgL44MH49rfkRYFpk5NOttC0y
         XChmR9Unw15doU3wtOfE+g70WEMy/mIUygcNeheU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 009/127] ipv6: Fix dump of specific table with strict checking
Date:   Thu, 24 Jan 2019 20:19:15 +0100
Message-Id: <20190124190212.500190791@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 73155879b3c1ac3ace35208a54a3a160ec520bef ]

Dump of a specific table with strict checking enabled is looping. The
problem is that the end of the table dump is not marked in the cb. When
dumping a specific table, cb args 0 and 1 are not used (they are the hash
index and entry with an hash table index when dumping all tables). Re-use
args[0] to hold a 'done' flag for the specific table dump.

Fixes: 13e38901d46ca ("net/ipv6: Plumb support for filtering route dumps")
Reported-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_fib.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -627,7 +627,11 @@ static int inet6_dump_fib(struct sk_buff
 			return -ENOENT;
 		}
 
-		res = fib6_dump_table(tb, skb, cb);
+		if (!cb->args[0]) {
+			res = fib6_dump_table(tb, skb, cb);
+			if (!res)
+				cb->args[0] = 1;
+		}
 		goto out;
 	}
 


