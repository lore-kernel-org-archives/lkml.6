Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA4AECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C32720892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv6PL7mT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C32720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbeKIHiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:38:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbeKIHiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:38:13 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A358420818;
        Thu,  8 Nov 2018 22:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714444;
        bh=S3ef1LPLFvyjbmvhG8K8VaJuSc0b4ike0iJEPXOxWO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kv6PL7mTlk6ldMXj9Pfa73NRy/nEpai2OG5+iqIWLLZ4Qdk27yQUKkCnp4x6nUST+
         VKJiAZRaJSw56s6V57qhmwr6ByL5xYtkNJRpAGYvFFb29lF57QWGwjCswp6C1+f6lO
         oHdoGyJlkzQJIfOtW4Vqqtz/9hEL5mWPKVmeC/EE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 092/114] net/ipv6: Fix index counter for unicast addresses in in6_dump_addrs
Date:   Thu,  8 Nov 2018 13:51:47 -0800
Message-Id: <20181108215109.105708903@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4439,8 +4439,8 @@ static int in6_dump_addrs(struct inet6_d
 
 		/* unicast address incl. temp addr */
 		list_for_each_entry(ifa, &idev->addr_list, if_list) {
-			if (++ip_idx < s_ip_idx)
-				continue;
+			if (ip_idx < s_ip_idx)
+				goto next;
 			err = inet6_fill_ifaddr(skb, ifa,
 						NETLINK_CB(cb->skb).portid,
 						cb->nlh->nlmsg_seq,
@@ -4449,6 +4449,8 @@ static int in6_dump_addrs(struct inet6_d
 			if (err < 0)
 				break;
 			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
+next:
+			ip_idx++;
 		}
 		break;
 	}


