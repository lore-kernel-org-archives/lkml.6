Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2037BECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5A620883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwTk+o/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5A620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeKIHbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:31:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbeKIHbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:31:18 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B0252081C;
        Thu,  8 Nov 2018 21:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714032;
        bh=6tTcfYevycYaeVK1ct5LG2hzmM8GdPG9Q4BTZzK2DZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FwTk+o/gjezjwI6lQKMyi4J9OFr6pOTZe0EeR1MbUbk8c0/FEMySos3gwdSiFV3oI
         4xCD/cL+ZyjHO61QiDxxhOR3oMxqD798ndYP5aPS32U37DlT9MD0q36+fN0BSGBxze
         D+OT6VNtGraYA45tFZRZMDS07zeR5UIXwqp1iJUo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Tranchetti <stranche@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 009/144] netlabel: check for IPV4MASK in addrinfo_get
Date:   Thu,  8 Nov 2018 13:49:40 -0800
Message-Id: <20181108215055.475987914@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Tranchetti <stranche@codeaurora.org>

[ Upstream commit f88b4c01b97e09535505cf3c327fdbce55c27f00 ]

netlbl_unlabel_addrinfo_get() assumes that if it finds the
NLBL_UNLABEL_A_IPV4ADDR attribute, it must also have the
NLBL_UNLABEL_A_IPV4MASK attribute as well. However, this is
not necessarily the case as the current checks in
netlbl_unlabel_staticadd() and friends are not sufficent to
enforce this.

If passed a netlink message with NLBL_UNLABEL_A_IPV4ADDR,
NLBL_UNLABEL_A_IPV6ADDR, and NLBL_UNLABEL_A_IPV6MASK attributes,
these functions will all call netlbl_unlabel_addrinfo_get() which
will then attempt dereference NULL when fetching the non-existent
NLBL_UNLABEL_A_IPV4MASK attribute:

Unable to handle kernel NULL pointer dereference at virtual address 0
Process unlab (pid: 31762, stack limit = 0xffffff80502d8000)
Call trace:
	netlbl_unlabel_addrinfo_get+0x44/0xd8
	netlbl_unlabel_staticremovedef+0x98/0xe0
	genl_rcv_msg+0x354/0x388
	netlink_rcv_skb+0xac/0x118
	genl_rcv+0x34/0x48
	netlink_unicast+0x158/0x1f0
	netlink_sendmsg+0x32c/0x338
	sock_sendmsg+0x44/0x60
	___sys_sendmsg+0x1d0/0x2a8
	__sys_sendmsg+0x64/0xb4
	SyS_sendmsg+0x34/0x4c
	el0_svc_naked+0x34/0x38
Code: 51001149 7100113f 540000a0 f9401508 (79400108)
---[ end trace f6438a488e737143 ]---
Kernel panic - not syncing: Fatal exception

Signed-off-by: Sean Tranchetti <stranche@codeaurora.org>

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlabel/netlabel_unlabeled.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -787,7 +787,8 @@ static int netlbl_unlabel_addrinfo_get(s
 {
 	u32 addr_len;
 
-	if (info->attrs[NLBL_UNLABEL_A_IPV4ADDR]) {
+	if (info->attrs[NLBL_UNLABEL_A_IPV4ADDR] &&
+	    info->attrs[NLBL_UNLABEL_A_IPV4MASK]) {
 		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
 		if (addr_len != sizeof(struct in_addr) &&
 		    addr_len != nla_len(info->attrs[NLBL_UNLABEL_A_IPV4MASK]))


