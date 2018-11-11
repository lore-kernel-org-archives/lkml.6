Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49566C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0709E2175B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozREihHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0709E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbeKLITG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730142AbeKLITE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:04 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11129208A3;
        Sun, 11 Nov 2018 22:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975348;
        bh=V23ibcH2BbTJaaPkTvwvt/JyeKei9/dIxvH4lNU1yoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozREihHOziwnyJO18UnK8l+IOYe6uDT+ZKCmJEJbLfM5vvY1HJ+pE/BNvXprsO1RD
         ZDFP2seMm+ag+L0HUYnlQvK+3IrmGEZBmMTKiUKj175l3XFxl1wbwNSRn8c/7PeNKW
         2XUE+E6s5nh28L/4AT1AIZBPd/fVAuP2oE4PiOWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Berizzi <pupilla@libero.it>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 357/361] net: sched: Remove TCA_OPTIONS from policy
Date:   Sun, 11 Nov 2018 14:21:44 -0800
Message-Id: <20181111221702.011368856@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

commit e72bde6b66299602087c8c2350d36a525e75d06e upstream.

Marco reported an error with hfsc:
root@Calimero:~# tc qdisc add dev eth0 root handle 1:0 hfsc default 1
Error: Attribute failed policy validation.

Apparently a few implementations pass TCA_OPTIONS as a binary instead
of nested attribute, so drop TCA_OPTIONS from the policy.

Fixes: 8b4c3cdd9dd8 ("net: sched: Add policy validation for tc attributes")
Reported-by: Marco Berizzi <pupilla@libero.it>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sched/sch_api.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1309,7 +1309,6 @@ check_loop_fn(struct Qdisc *q, unsigned
 
 const struct nla_policy rtm_tca_policy[TCA_MAX + 1] = {
 	[TCA_KIND]		= { .type = NLA_STRING },
-	[TCA_OPTIONS]		= { .type = NLA_NESTED },
 	[TCA_RATE]		= { .type = NLA_BINARY,
 				    .len = sizeof(struct tc_estimator) },
 	[TCA_STAB]		= { .type = NLA_NESTED },


