Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F59C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BFB2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692588;
	bh=W4ht6Hd5uhsGM2iHA4lVHWEamCnuIvc2bCAjKvSupjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D+zpfSVWvmzbjskPjux9RTjJ2Nk55feKbmhSdLwg96DjWUnS9J9G7ieMKKiwKdpLz
	 sjqmIQiEz5QvRI0BNP9aMf4YZeeyH/ehrYygHpomgcphT0+xzDoW2tfMZlBCBjz87C
	 AJX7KCqwzPjul7hm7LwGU3tNCeoomMwe2KD0kD8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389367AbfA1QXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:23:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388661AbfA1QXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:23:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 150882084A;
        Mon, 28 Jan 2019 16:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692582;
        bh=W4ht6Hd5uhsGM2iHA4lVHWEamCnuIvc2bCAjKvSupjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8Oxwv/Pm4BT0fopw36MKEgxq9/xOtGXVECkvdn18n8bEelv1I/sFcSf6vKCb2JG6
         GEY8SQobYzpHdV9sBVP+MYRfE35BROX/j7K/X6lqe4p+pJLqgs/r4T9pqmflXraPTc
         UIqUWH5+3yNuh4YgXcY/HqRHJM2zn4fI+dZd7Xow=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 077/107] i40e: define proper net_device::neigh_priv_len
Date:   Mon, 28 Jan 2019 11:19:17 -0500
Message-Id: <20190128161947.57405-77-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khorenko <khorenko@virtuozzo.com>

[ Upstream commit 31389b53b3e0b535867af9090a5d19ec64768d55 ]

Out of bound read reported by KASan.

i40iw_net_event() reads unconditionally 16 bytes from
neigh->primary_key while the memory allocated for
"neighbour" struct is evaluated in neigh_alloc() as

  tbl->entry_size + dev->neigh_priv_len

where "dev" is a net_device.

But the driver does not setup dev->neigh_priv_len and
we read beyond the neigh entry allocated memory,
so the patch in the next mail fixes this.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 57c7456a5751..7836072d3f63 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9194,6 +9194,9 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	ether_addr_copy(netdev->dev_addr, mac_addr);
 	ether_addr_copy(netdev->perm_addr, mac_addr);
 
+	/* i40iw_net_event() reads 16 bytes from neigh->primary_key */
+	netdev->neigh_priv_len = sizeof(u32) * 4;
+
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 	/* Setup netdev TC information */
-- 
2.19.1

