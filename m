Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E89BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714812082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zdbsfcCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714812082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbeKCDpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbeKCDpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:45:02 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F7A20831;
        Fri,  2 Nov 2018 18:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183811;
        bh=Ti1vE9+zT2Wv5PPgUeGAtdTTliVRLXek5+gGSQ6dK7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zdbsfcCmC/oSlOzNv+0QjsIZgPZIodnNddS4PwuhaawSirzfqgUlutL0hnlo/VJH3
         vzuK5cVYqveWPcUvU54p771Acks7p7CkFlvj7ynuMDkZxzrvMwc6dPAmSUQd9i9Y8a
         zzUa37gpXVvuH6vA9L81TELeQxY0tbN+Sl/ClPBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shalom Toledo <shalomt@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 15/24] mlxsw: core: Fix devlink unregister flow
Date:   Fri,  2 Nov 2018 19:34:48 +0100
Message-Id: <20181102182842.146919357@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182839.725385066@linuxfoundation.org>
References: <20181102182839.725385066@linuxfoundation.org>
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

From: Shalom Toledo <shalomt@mellanox.com>

[ Upstream commit a22712a962912faf257e857ab6857f56a93cfb34 ]

After a failed reload, the driver is still registered to devlink, its
devlink instance is still allocated and the 'reload_fail' flag is set.
Then, in the next reload try, the driver's allocated devlink instance will
be freed without unregistering from devlink and its components (e.g,
resources). This scenario can cause a use-after-free if the user tries to
execute command via devlink user-space tool.

Fix by not freeing the devlink instance during reload (failed or not).

Fixes: 24cc68ad6c46 ("mlxsw: core: Add support for reload")
Signed-off-by: Shalom Toledo <shalomt@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -943,8 +943,8 @@ static int mlxsw_devlink_core_bus_device
 					     mlxsw_core->bus,
 					     mlxsw_core->bus_priv, true,
 					     devlink);
-	if (err)
-		mlxsw_core->reload_fail = true;
+	mlxsw_core->reload_fail = !!err;
+
 	return err;
 }
 
@@ -1083,8 +1083,15 @@ void mlxsw_core_bus_device_unregister(st
 {
 	struct devlink *devlink = priv_to_devlink(mlxsw_core);
 
-	if (mlxsw_core->reload_fail)
-		goto reload_fail;
+	if (mlxsw_core->reload_fail) {
+		if (!reload)
+			/* Only the parts that were not de-initialized in the
+			 * failed reload attempt need to be de-initialized.
+			 */
+			goto reload_fail_deinit;
+		else
+			return;
+	}
 
 	if (mlxsw_core->driver->fini)
 		mlxsw_core->driver->fini(mlxsw_core);
@@ -1098,9 +1105,12 @@ void mlxsw_core_bus_device_unregister(st
 	if (!reload)
 		devlink_resources_unregister(devlink, NULL);
 	mlxsw_core->bus->fini(mlxsw_core->bus_priv);
-	if (reload)
-		return;
-reload_fail:
+
+	return;
+
+reload_fail_deinit:
+	devlink_unregister(devlink);
+	devlink_resources_unregister(devlink, NULL);
 	devlink_free(devlink);
 }
 EXPORT_SYMBOL(mlxsw_core_bus_device_unregister);


