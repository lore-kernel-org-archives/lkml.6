Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDECC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ABA2147E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsZkQpwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67ABA2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbeJPMDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729618AbeJPMDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:03:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CE612148C;
        Tue, 16 Oct 2018 04:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663299;
        bh=2QkO856xA4MaXjjF2pl8xZTGzoV3b+jIDrw8ZL48eXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BsZkQpwbQXPCIZqojLHpXnJvXS0mrYKJfVyvRyG9gOP1uF++Sw6U+cXky4+fSClEo
         yt/9N465CrCUWpUZ4PfPLLaY7a9dTmrOZ7FEihRpEhoYX5dAk8qwS6X20QejG0h/9Z
         J1ghe/XXGcPBUJKtTlV0EUWQnO6PnOX+poi+6ygM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 58/61] net: cxgb3_main: fix a missing-check bug
Date:   Tue, 16 Oct 2018 00:14:00 -0400
Message-Id: <20181016041403.135678-58-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>

[ Upstream commit 2c05d88818ab6571816b93edce4d53703870d7ae ]

In cxgb_extension_ioctl(), the command of the ioctl is firstly copied from
the user-space buffer 'useraddr' to 'cmd' and checked through the
switch statement. If the command is not as expected, an error code
EOPNOTSUPP is returned. In the following execution, i.e., the cases of the
switch statement, the whole buffer of 'useraddr' is copied again to a
specific data structure, according to what kind of command is requested.
However, after the second copy, there is no re-check on the newly-copied
command. Given that the buffer 'useraddr' is in the user space, a malicious
user can race to change the command between the two copies. By doing so,
the attacker can supply malicious data to the kernel and cause undefined
behavior.

This patch adds a re-check in each case of the switch statement if there is
a second copy in that case, to re-check whether the command obtained in the
second copy is the same as the one in the first copy. If not, an error code
EINVAL is returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index bf291e90cdb0..79053d2ce7a3 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -2159,6 +2159,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EPERM;
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
+		if (t.cmd != CHELSIO_SET_QSET_PARAMS)
+			return -EINVAL;
 		if (t.qset_idx >= SGE_QSETS)
 			return -EINVAL;
 		if (!in_range(t.intr_lat, 0, M_NEWTIMER) ||
@@ -2258,6 +2260,9 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
 
+		if (t.cmd != CHELSIO_GET_QSET_PARAMS)
+			return -EINVAL;
+
 		/* Display qsets for all ports when offload enabled */
 		if (test_bit(OFFLOAD_DEVMAP_BIT, &adapter->open_device_map)) {
 			q1 = 0;
@@ -2303,6 +2308,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EBUSY;
 		if (copy_from_user(&edata, useraddr, sizeof(edata)))
 			return -EFAULT;
+		if (edata.cmd != CHELSIO_SET_QSET_NUM)
+			return -EINVAL;
 		if (edata.val < 1 ||
 			(edata.val > 1 && !(adapter->flags & USING_MSIX)))
 			return -EINVAL;
@@ -2343,6 +2350,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EPERM;
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
+		if (t.cmd != CHELSIO_LOAD_FW)
+			return -EINVAL;
 		/* Check t.len sanity ? */
 		fw_data = memdup_user(useraddr + sizeof(t), t.len);
 		if (IS_ERR(fw_data))
@@ -2366,6 +2375,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EBUSY;
 		if (copy_from_user(&m, useraddr, sizeof(m)))
 			return -EFAULT;
+		if (m.cmd != CHELSIO_SETMTUTAB)
+			return -EINVAL;
 		if (m.nmtus != NMTUS)
 			return -EINVAL;
 		if (m.mtus[0] < 81)	/* accommodate SACK */
@@ -2407,6 +2418,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EBUSY;
 		if (copy_from_user(&m, useraddr, sizeof(m)))
 			return -EFAULT;
+		if (m.cmd != CHELSIO_SET_PM)
+			return -EINVAL;
 		if (!is_power_of_2(m.rx_pg_sz) ||
 			!is_power_of_2(m.tx_pg_sz))
 			return -EINVAL;	/* not power of 2 */
@@ -2440,6 +2453,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EIO;	/* need the memory controllers */
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
+		if (t.cmd != CHELSIO_GET_MEM)
+			return -EINVAL;
 		if ((t.addr & 7) || (t.len & 7))
 			return -EINVAL;
 		if (t.mem_id == MEM_CM)
@@ -2492,6 +2507,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EAGAIN;
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
+		if (t.cmd != CHELSIO_SET_TRACE_FILTER)
+			return -EINVAL;
 
 		tp = (const struct trace_params *)&t.sip;
 		if (t.config_tx)
-- 
2.17.1

