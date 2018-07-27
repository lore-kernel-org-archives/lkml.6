Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAA1C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBDD208A5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBDD208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbeG0LtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:49:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42388 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbeG0LtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:49:10 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9C9B9CD1;
        Fri, 27 Jul 2018 10:27:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 06/27] ipv4: Return EINVAL when ping_group_range sysctl doesnt map to user ns
Date:   Fri, 27 Jul 2018 12:26:43 +0200
Message-Id: <20180727102649.275249134@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727102649.049641021@linuxfoundation.org>
References: <20180727102649.049641021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyler Hicks <tyhicks@canonical.com>

[ Upstream commit 70ba5b6db96ff7324b8cfc87e0d0383cf59c9677 ]

The low and high values of the net.ipv4.ping_group_range sysctl were
being silently forced to the default disabled state when a write to the
sysctl contained GIDs that didn't map to the associated user namespace.
Confusingly, the sysctl's write operation would return success and then
a subsequent read of the sysctl would indicate that the low and high
values are the overflowgid.

This patch changes the behavior by clearly returning an error when the
sysctl write operation receives a GID range that doesn't map to the
associated user namespace. In such a situation, the previous value of
the sysctl is preserved and that range will be returned in a subsequent
read of the sysctl.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/sysctl_net_ipv4.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -134,8 +134,9 @@ static int ipv4_ping_group_range(struct
 	if (write && ret == 0) {
 		low = make_kgid(user_ns, urange[0]);
 		high = make_kgid(user_ns, urange[1]);
-		if (!gid_valid(low) || !gid_valid(high) ||
-		    (urange[1] < urange[0]) || gid_lt(high, low)) {
+		if (!gid_valid(low) || !gid_valid(high))
+			return -EINVAL;
+		if (urange[1] < urange[0] || gid_lt(high, low)) {
 			low = make_kgid(&init_user_ns, 1);
 			high = make_kgid(&init_user_ns, 0);
 		}


