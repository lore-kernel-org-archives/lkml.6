Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F871C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3752F2084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt3jtgK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3752F2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbeKCEDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeKCEDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:03:07 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0657520848;
        Fri,  2 Nov 2018 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184891;
        bh=vtosIPG3DzgPCX8ORFzKtVCVfCBP1asxQ17kCa4tipg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dt3jtgK4UWwUdJDd8hIV0Oy1TS/dUrzM8KEPI9sgFgGUvPvWn4k1J3ZmGU4FW4xbt
         XaBqyG5pTAM45/JiiFFoJdmp2TFFToH3em2yjr0mWlS4XQLEloSnc4GT14tO+TFTf/
         uBdOK2io0/BSC4wUbpt3mPWiIsO0hK9YJl6TLiyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 121/143] net/ipv6: Fix index counter for unicast addresses in in6_dump_addrs
Date:   Fri,  2 Nov 2018 19:35:06 +0100
Message-Id: <20181102182907.549292253@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 4ba4c566ba8448a05e6257e0b98a21f1a0d55315 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/addrconf.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4793,8 +4793,8 @@ static int in6_dump_addrs(struct inet6_d
 
 		/* unicast address incl. temp addr */
 		list_for_each_entry(ifa, &idev->addr_list, if_list) {
-			if (++ip_idx < s_ip_idx)
-				continue;
+			if (ip_idx < s_ip_idx)
+				goto next;
 			err = inet6_fill_ifaddr(skb, ifa,
 						NETLINK_CB(cb->skb).portid,
 						cb->nlh->nlmsg_seq,
@@ -4803,6 +4803,8 @@ static int in6_dump_addrs(struct inet6_d
 			if (err < 0)
 				break;
 			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
+next:
+			ip_idx++;
 		}
 		break;
 	}


