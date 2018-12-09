Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54A5C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8406920661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8406920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeLIWDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:03:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35656 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726599AbeLIVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:28 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72r-0002ir-1O; Sun, 09 Dec 2018 21:55:25 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0003hD-Jh; Sun, 09 Dec 2018 21:55:19 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Ahern" <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.108445890@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 319/328] net/ipv6: Fix index counter for unicast
 addresses in in6_dump_addrs
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

commit 4ba4c566ba8448a05e6257e0b98a21f1a0d55315 upstream.

The loop wants to skip previously dumped addresses, so loops until
current index >= saved index. If the message fills it wants to save
the index for the next address to dump - ie., the one that did not
fit in the current message.

Currently, it is incrementing the index counter before comparing to the
saved index, and then the saved index is off by 1 - it assumes the
current address is going to fit in the message.

Change the index handling to increment only after a succesful dump.

Fixes: 502a2ffd7376a ("ipv6: convert idev_list to list macros")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv6/addrconf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4085,8 +4085,8 @@ static int in6_dump_addrs(struct inet6_d
 
 		/* unicast address incl. temp addr */
 		list_for_each_entry(ifa, &idev->addr_list, if_list) {
-			if (++ip_idx < s_ip_idx)
-				continue;
+			if (ip_idx < s_ip_idx)
+				goto next;
 			err = inet6_fill_ifaddr(skb, ifa,
 						NETLINK_CB(cb->skb).portid,
 						cb->nlh->nlmsg_seq,
@@ -4095,6 +4095,8 @@ static int in6_dump_addrs(struct inet6_d
 			if (err <= 0)
 				break;
 			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
+next:
+			ip_idx++;
 		}
 		break;
 	}

