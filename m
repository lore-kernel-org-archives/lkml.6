Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E4FC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D65D2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bh8NkKUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D65D2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeJQBEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbeJQBEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:04:22 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5080F21476;
        Tue, 16 Oct 2018 17:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709979;
        bh=Z2z0XH3qE5QdB0mydd2JnffCebKM7CzBhOwAUYI3ZYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bh8NkKUtZl3Ep3JKG9LQCTBY6ZMdnLaapMtw7J1awXVxNThRrNu0/TNyVTwLR/ox/
         mgO3/Z7rrgKHFsc+nCjcQtHfLZdyMKNeCmxTVyfnWamDkoKjE9FSaYfiON74IlunBm
         /bSJ7Hfo0ujwiP04VDHvjzHHp6VFaMs0ES7a8Tcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 062/135] vxlan: fill ttl inherit info
Date:   Tue, 16 Oct 2018 19:04:52 +0200
Message-Id: <20181016170518.792162131@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 8fd780698745ba121530c5c20fd237aacde4c371 ]

When add vxlan ttl inherit support, I forgot to fill it when dump
vlxan info. Fix it now.

Fixes: 72f6d71e491e6 ("vxlan: add ttl inherit support")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -3537,6 +3537,7 @@ static size_t vxlan_get_size(const struc
 		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_LINK */
 		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_VXLAN_LOCAL{6} */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TTL */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TTL_INHERIT */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TOS */
 		nla_total_size(sizeof(__be32)) + /* IFLA_VXLAN_LABEL */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_LEARNING */
@@ -3601,6 +3602,8 @@ static int vxlan_fill_info(struct sk_buf
 	}
 
 	if (nla_put_u8(skb, IFLA_VXLAN_TTL, vxlan->cfg.ttl) ||
+	    nla_put_u8(skb, IFLA_VXLAN_TTL_INHERIT,
+		       !!(vxlan->cfg.flags & VXLAN_F_TTL_INHERIT)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
 	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
 	    nla_put_u8(skb, IFLA_VXLAN_LEARNING,


