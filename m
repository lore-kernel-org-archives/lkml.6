Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AC4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15185217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130482;
	bh=o/zL6tf+JD3Ftbdn6PpqX5iSl3btM/Kgw7yjm7OBmQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P4GoVOzbBZrJjPTdBEoMyCi7hvYiTHFeyJ3RHuoceMgiyAzkr1c+WPC4T+MvRXD+J
	 vBwjYgFqZsqar/qzl03Y9WTMwa4FVz8J1duwa6jfnFbzhfa6ocznuMOnnsFW2z7UN4
	 Fyv0aW5S1o/uq3mfbtD6Iwt3svuRb6SgOR/7aQ5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbfBYVel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:34:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbfBYVej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:34:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A366F217F5;
        Mon, 25 Feb 2019 21:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130479;
        bh=o/zL6tf+JD3Ftbdn6PpqX5iSl3btM/Kgw7yjm7OBmQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aQzDub70bda2NGfgtBPRtIxqaX2KVWh+tV7+lCwZJzytuX4A8sivrwfWoiPuy+QmR
         JNpcUZzrwcZYJPh92c5rj6m6FTjZpJcKdTEiK39Q53nQKnkgZTmx5GVHopN8rMFMi9
         5x6feqxaHyP1CRdt852idFcTrs86ozwGPjfwGtUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Wunderlich <frank-w@public-files.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4.20 133/183] net: dsa: Fix NPD checking for br_vlan_enabled()
Date:   Mon, 25 Feb 2019 22:11:46 +0100
Message-Id: <20190225195117.250539286@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream not applicable ]

It is possible for the DSA slave network device not to be part of a
bridge, yet have an upper device like a VLAN device be part of a bridge.
When that VLAN device is enslaved, since it does not define any
switchdev_ops, we will recurse down to the lower/physical port device,
call switchdev_port_obj_add() with a VLAN, and here we will check
br_vlan_enabled() on a NULL dp->bridge_dev, thus causing a NULL pointer
de-reference.

This is no longer a problem upstream after commit d17d9f5e5143
("switchdev: Replace port obj add/del SDO with a notification").

Fixes: 2ea7a679ca2a ("net: dsa: Don't add vlans when vlan filtering is disabled")
Reported-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/port.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -255,7 +255,7 @@ int dsa_port_vlan_add(struct dsa_port *d
 	if (netif_is_bridge_master(vlan->obj.orig_dev))
 		return -EOPNOTSUPP;
 
-	if (br_vlan_enabled(dp->bridge_dev))
+	if (dp->bridge_dev && br_vlan_enabled(dp->bridge_dev))
 		return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_ADD, &info);
 
 	return 0;
@@ -273,7 +273,7 @@ int dsa_port_vlan_del(struct dsa_port *d
 	if (netif_is_bridge_master(vlan->obj.orig_dev))
 		return -EOPNOTSUPP;
 
-	if (br_vlan_enabled(dp->bridge_dev))
+	if (dp->bridge_dev && br_vlan_enabled(dp->bridge_dev))
 		return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_DEL, &info);
 
 	return 0;


