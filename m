Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB01ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101D921582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101D921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeI0PZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:25:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeI0PZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:25:30 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 09CB71116;
        Thu, 27 Sep 2018 09:08:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liam mcbirnie <liam.mcbirnie@boeing.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 22/88] net: rtnl_configure_link: fix dev flags changes arg to __dev_notify_flags
Date:   Thu, 27 Sep 2018 11:03:03 +0200
Message-Id: <20180927090303.235199010@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
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

From: Roopa Prabhu <roopa@cumulusnetworks.com>

[ Upstream commit 56a49d7048703f5ffdb84d3a0ee034108fba6850 ]

This fix addresses https://bugzilla.kernel.org/show_bug.cgi?id=201071

Commit 5025f7f7d506 wrongly relied on __dev_change_flags to notify users of
dev flag changes in the case when dev->rtnl_link_state = RTNL_LINK_INITIALIZED.
Fix it by indicating flag changes explicitly to __dev_notify_flags.

Fixes: 5025f7f7d506 ("rtnetlink: add rtnl_link_state check in rtnl_configure_link")
Reported-By: Liam mcbirnie <liam.mcbirnie@boeing.com>
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/rtnetlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2760,7 +2760,7 @@ int rtnl_configure_link(struct net_devic
 	}
 
 	if (dev->rtnl_link_state == RTNL_LINK_INITIALIZED) {
-		__dev_notify_flags(dev, old_flags, 0U);
+		__dev_notify_flags(dev, old_flags, (old_flags ^ dev->flags));
 	} else {
 		dev->rtnl_link_state = RTNL_LINK_INITIALIZED;
 		__dev_notify_flags(dev, old_flags, ~0U);


