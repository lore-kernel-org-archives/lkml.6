Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BAEC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963452089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963452089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbeG0Laz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:30:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0Lay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:30:54 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8E64FBB6;
        Fri, 27 Jul 2018 10:09:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 12/33] rtnetlink: add rtnl_link_state check in rtnl_configure_link
Date:   Fri, 27 Jul 2018 12:08:53 +0200
Message-Id: <20180727100828.135365522@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727100827.665729981@linuxfoundation.org>
References: <20180727100827.665729981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roopa Prabhu <roopa@cumulusnetworks.com>

[ Upstream commit 5025f7f7d506fba9b39e7fe8ca10f6f34cb9bc2d ]

rtnl_configure_link sets dev->rtnl_link_state to
RTNL_LINK_INITIALIZED and unconditionally calls
__dev_notify_flags to notify user-space of dev flags.

current call sequence for rtnl_configure_link
rtnetlink_newlink
    rtnl_link_ops->newlink
    rtnl_configure_link (unconditionally notifies userspace of
                         default and new dev flags)

If a newlink handler wants to call rtnl_configure_link
early, we will end up with duplicate notifications to
user-space.

This patch fixes rtnl_configure_link to check rtnl_link_state
and call __dev_notify_flags with gchanges = 0 if already
RTNL_LINK_INITIALIZED.

Later in the series, this patch will help the following sequence
where a driver implementing newlink can call rtnl_configure_link
to initialize the link early.

makes the following call sequence work:
rtnetlink_newlink
    rtnl_link_ops->newlink (vxlan) -> rtnl_configure_link (initializes
                                                link and notifies
                                                user-space of default
                                                dev flags)
    rtnl_configure_link (updates dev flags if requested by user ifm
                         and notifies user-space of new dev flags)

Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/rtnetlink.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2339,9 +2339,12 @@ int rtnl_configure_link(struct net_devic
 			return err;
 	}
 
-	dev->rtnl_link_state = RTNL_LINK_INITIALIZED;
-
-	__dev_notify_flags(dev, old_flags, ~0U);
+	if (dev->rtnl_link_state == RTNL_LINK_INITIALIZED) {
+		__dev_notify_flags(dev, old_flags, 0U);
+	} else {
+		dev->rtnl_link_state = RTNL_LINK_INITIALIZED;
+		__dev_notify_flags(dev, old_flags, ~0U);
+	}
 	return 0;
 }
 EXPORT_SYMBOL(rtnl_configure_link);


