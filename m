Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE4CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFAB2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFAB2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbeGJSbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:31:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45872 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387837AbeGJSbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:31:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 255E4EB4;
        Tue, 10 Jul 2018 18:31:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ido Schimmel <idosch@mellanox.com>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4.9 36/52] mlxsw: spectrum: Forbid linking of VLAN devices to devices that have uppers
Date:   Tue, 10 Jul 2018 20:25:04 +0200
Message-Id: <20180710182452.717134990@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182449.285532226@linuxfoundation.org>
References: <20180710182449.285532226@linuxfoundation.org>
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

From: Ido Schimmel <idosch@mellanox.com>

Jiri Slaby noticed that the backport of upstream commit 25cc72a33835
("mlxsw: spectrum: Forbid linking to devices that have uppers") to
kernel 4.9.y introduced the same check twice in the same function
instead of in two different places.

Fix this by relocating one of the checks to its intended place, thus
preventing unsupported configurations as described in the original
commit.

Fixes: 73ee5a73e75f ("mlxsw: spectrum: Forbid linking to devices that have uppers")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4187,10 +4187,6 @@ static int mlxsw_sp_netdevice_port_upper
 		if (netif_is_lag_port(dev) && is_vlan_dev(upper_dev) &&
 		    !netif_is_lag_master(vlan_dev_real_dev(upper_dev)))
 			return -EINVAL;
-		if (!info->linking)
-			break;
-		if (netdev_has_any_upper_dev(upper_dev))
-			return -EINVAL;
 		break;
 	case NETDEV_CHANGEUPPER:
 		upper_dev = info->upper_dev;
@@ -4566,6 +4562,8 @@ static int mlxsw_sp_netdevice_vport_even
 			return -EINVAL;
 		if (!info->linking)
 			break;
+		if (netdev_has_any_upper_dev(upper_dev))
+			return -EINVAL;
 		/* We can't have multiple VLAN interfaces configured on
 		 * the same port and being members in the same bridge.
 		 */


