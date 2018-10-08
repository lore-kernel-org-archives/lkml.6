Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC02C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79E62077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jmhCyvZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79E62077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJHXCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:02:12 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:36306 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbeJHXCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:02:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id EC53563A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 15:49:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cDIuEuPQ9FEh for <linux-kernel@vger.kernel.org>;
        Mon,  8 Oct 2018 10:49:48 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id B4B23F4F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 10:49:48 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id z15-v6so18954619iob.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G3hHQo/9jnZpYEQeZQbO+SwMO1g3XEusnUb2WPTA/us=;
        b=jmhCyvZrEa0pPy8ROklYbzHOGlORLRakQExGaQmP64fUpRYrQ0AKFoReJNavFBa91T
         LEZ2gsmP0uB4531aLGPXAQwc3uZpwq6sNbKDkCTTgxjigG9ExiXEHQs+jVspiBxqvGxj
         kGyPo4nzo+DJ7iR6tFK5H7UEGzW6Exd8GeLieWQTrTtINdef4f4OZDePMKEbl3111NKm
         1RCQJmZMzQXTUBFbpglBoD7apZ7/Th1sxZopMgw8UwwlZ+lRWj109SnxMOhes26Nz1hy
         K98QzMHV64FrhjMVePO8QAxbtbwgOYcqrRmUfLfVA1Bs8ByG16VPby8HMYE/txdfsLk8
         jjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G3hHQo/9jnZpYEQeZQbO+SwMO1g3XEusnUb2WPTA/us=;
        b=Wpm1iN1kFu5pxOTmY+cvaooL+QgXlEBcmMAE4OiZMz5vQU6muhTNLQjjvcchxqP5Na
         AiNABl4Ang6V64U9ScukZ28SYzfyS039uJnw7Trc78lMGgxnQmYijvdpduiSrlbRMhUM
         Yfu7KVD6JTMsxOqc3jjnJfGZpwLe3IsFN1qyTgL34oOR2c2x7uQ9SsRlRJNz8KILapR6
         mBTzUt3q0X2FOBze+jpxBrhSbu2YrscU7gssz47OJwf9q4v/ug9Y39k39CZpOYs3Rk++
         +nnNm9c4NM+Q4yU9RYVCyS4Cjjo8PfHk6ngJzGJzfyBurY5w/IQXyVYzBjjaAyfBrc0x
         hidw==
X-Gm-Message-State: ABuFfogt54baIFcgNs4gV7nhWFrLIbpuujqdw5GURTQoOGgXmjESAavO
        bzcSHgE6s/tTuW1krV8SfnqNKIOLqhIjMqAaeVFmIguBcnEMuYsQWC7qSLONuXFi5l93o3NbDFm
        CiqVFLuOTxUlqhmnsPjTYN5ccRHqZ
X-Received: by 2002:a24:7f52:: with SMTP id r79-v6mr13436297itc.100.1539013788321;
        Mon, 08 Oct 2018 08:49:48 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60UAx+tgiIzpG74zOdIxt97rHdhBO5amSulvjuAVdihtCfgfChgKuJwluiQaW9VXx16JPVnSQ==
X-Received: by 2002:a24:7f52:: with SMTP id r79-v6mr13436286itc.100.1539013788064;
        Mon, 08 Oct 2018 08:49:48 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id k5-v6sm4563516ita.14.2018.10.08.08.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Oct 2018 08:49:47 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Edward Cree <ecree@solarflare.com>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Alan Brady <alan.brady@intel.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ethtool: fix a privilege escalation bug
Date:   Mon,  8 Oct 2018 10:49:35 -0500
Message-Id: <1539013777-1625-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 net/core/ethtool.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index c9993c6..ccb337e 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -2462,13 +2462,17 @@ static int ethtool_set_per_queue_coalesce(struct net_device *dev,
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
@@ -2838,7 +2842,7 @@ int dev_ethtool(struct net *net, struct ifreq *ifr)
 		rc = ethtool_get_phy_stats(dev, useraddr);
 		break;
 	case ETHTOOL_PERQUEUE:
-		rc = ethtool_set_per_queue(dev, useraddr);
+		rc = ethtool_set_per_queue(dev, useraddr, sub_cmd);
 		break;
 	case ETHTOOL_GLINKSETTINGS:
 		rc = ethtool_get_link_ksettings(dev, useraddr);
-- 
2.7.4

