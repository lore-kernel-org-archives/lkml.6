Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AB5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF04D20843
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7wJ1C3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF04D20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbeKCDyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbeKCDym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:54:42 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D924C20837;
        Fri,  2 Nov 2018 18:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184388;
        bh=0Dk52O5XdnEzfKIO8JEer6a0RbZ1yo8FwJ1bJ7rQWtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7wJ1C3iati1TVojG/9Y8U9Wp13yiwNsHVNWcjSB1zILhQF0c63oVnyY+oPLlSbwl
         Ay5Q3+jrHLlj61ZUdWlR6jA2sQ9B295ZOABRQLqUkd7pJiUnX1Ys5bB8UAytup4MSd
         +8b9bsX/6Zty9g3EkAEFgFwYrC9Mxa1VEbltITjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 122/150] ethtool: fix a privilege escalation bug
Date:   Fri,  2 Nov 2018 19:34:44 +0100
Message-Id: <20181102182911.454589845@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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

From: Wenwen Wang <wang6495@umn.edu>

[ Upstream commit 58f5bbe331c566f49c9559568f982202a278aa78 ]

In dev_ethtool(), the eth command 'ethcmd' is firstly copied from the
use-space buffer 'useraddr' and checked to see whether it is
ETHTOOL_PERQUEUE. If yes, the sub-command 'sub_cmd' is further copied from
the user space. Otherwise, 'sub_cmd' is the same as 'ethcmd'. Next,
according to 'sub_cmd', a permission check is enforced through the function
ns_capable(). For example, the permission check is required if 'sub_cmd' is
ETHTOOL_SCOALESCE, but it is not necessary if 'sub_cmd' is
ETHTOOL_GCOALESCE, as suggested in the comment "Allow some commands to be
done by anyone". The following execution invokes different handlers
according to 'ethcmd'. Specifically, if 'ethcmd' is ETHTOOL_PERQUEUE,
ethtool_set_per_queue() is called. In ethtool_set_per_queue(), the kernel
object 'per_queue_opt' is copied again from the user-space buffer
'useraddr' and 'per_queue_opt.sub_command' is used to determine which
operation should be performed. Given that the buffer 'useraddr' is in the
user space, a malicious user can race to change the sub-command between the
two copies. In particular, the attacker can supply ETHTOOL_PERQUEUE and
ETHTOOL_GCOALESCE to bypass the permission check in dev_ethtool(). Then
before ethtool_set_per_queue() is called, the attacker changes
ETHTOOL_GCOALESCE to ETHTOOL_SCOALESCE. In this way, the attacker can
bypass the permission check and execute ETHTOOL_SCOALESCE.

This patch enforces a check in ethtool_set_per_queue() after the second
copy from 'useraddr'. If the sub-command is different from the one obtained
in the first copy in dev_ethtool(), an error code EINVAL will be returned.

Fixes: f38d138a7da6 ("net/ethtool: support set coalesce per queue")
Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/ethtool.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -2461,13 +2461,17 @@ roll_back:
 	return ret;
 }
 
-static int ethtool_set_per_queue(struct net_device *dev, void __user *useraddr)
+static int ethtool_set_per_queue(struct net_device *dev,
+				 void __user *useraddr, u32 sub_cmd)
 {
 	struct ethtool_per_queue_op per_queue_opt;
 
 	if (copy_from_user(&per_queue_opt, useraddr, sizeof(per_queue_opt)))
 		return -EFAULT;
 
+	if (per_queue_opt.sub_command != sub_cmd)
+		return -EINVAL;
+
 	switch (per_queue_opt.sub_command) {
 	case ETHTOOL_GCOALESCE:
 		return ethtool_get_per_queue_coalesce(dev, useraddr, &per_queue_opt);
@@ -2838,7 +2842,7 @@ int dev_ethtool(struct net *net, struct
 		rc = ethtool_get_phy_stats(dev, useraddr);
 		break;
 	case ETHTOOL_PERQUEUE:
-		rc = ethtool_set_per_queue(dev, useraddr);
+		rc = ethtool_set_per_queue(dev, useraddr, sub_cmd);
 		break;
 	case ETHTOOL_GLINKSETTINGS:
 		rc = ethtool_get_link_ksettings(dev, useraddr);


