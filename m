Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90259C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D5C214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsfJ2HD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D5C214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeJPMEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbeJPMEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:04:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07CB8214D5;
        Tue, 16 Oct 2018 04:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663358;
        bh=coiY8FXP1NKrAtIR6JWFc9TRqVnFymed52KE2Tk0Zsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MsfJ2HD0xL/bx2xiRzlwAIapkIeyjwgPoESmkIToV3Zx+WXWlza1ceff5oi3vXQ16
         SN+8upjDYdaVTdHgQYUxHhtN0U3skFZocPiOs1OFQuieYqq5VgP8dHlZCn8f0Drrtj
         vK9tYuTOBMNTXoeEwvt8hJXSAqRkMn80zd0MXZDE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 37/38] net: cxgb3_main: fix a missing-check bug
Date:   Tue, 16 Oct 2018 00:15:21 -0400
Message-Id: <20181016041522.135789-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041522.135789-1-sashal@kernel.org>
References: <20181016041522.135789-1-sashal@kernel.org>
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
index dc0efbd91c32..ddd1ec8f7bd0 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -2150,6 +2150,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EPERM;
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
+		if (t.cmd != CHELSIO_SET_QSET_PARAMS)
+			return -EINVAL;
 		if (t.qset_idx >= SGE_QSETS)
 			return -EINVAL;
 		if (!in_range(t.intr_lat, 0, M_NEWTIMER) ||
@@ -2249,6 +2251,9 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
 
+		if (t.cmd != CHELSIO_GET_QSET_PARAMS)
+			return -EINVAL;
+
 		/* Display qsets for all ports when offload enabled */
 		if (test_bit(OFFLOAD_DEVMAP_BIT, &adapter->open_device_map)) {
 			q1 = 0;
@@ -2294,6 +2299,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EBUSY;
 		if (copy_from_user(&edata, useraddr, sizeof(edata)))
 			return -EFAULT;
+		if (edata.cmd != CHELSIO_SET_QSET_NUM)
+			return -EINVAL;
 		if (edata.val < 1 ||
 			(edata.val > 1 && !(adapter->flags & USING_MSIX)))
 			return -EINVAL;
@@ -2334,6 +2341,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EPERM;
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
+		if (t.cmd != CHELSIO_LOAD_FW)
+			return -EINVAL;
 		/* Check t.len sanity ? */
 		fw_data = memdup_user(useraddr + sizeof(t), t.len);
 		if (IS_ERR(fw_data))
@@ -2357,6 +2366,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EBUSY;
 		if (copy_from_user(&m, useraddr, sizeof(m)))
 			return -EFAULT;
+		if (m.cmd != CHELSIO_SETMTUTAB)
+			return -EINVAL;
 		if (m.nmtus != NMTUS)
 			return -EINVAL;
 		if (m.mtus[0] < 81)	/* accommodate SACK */
@@ -2398,6 +2409,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EBUSY;
 		if (copy_from_user(&m, useraddr, sizeof(m)))
 			return -EFAULT;
+		if (m.cmd != CHELSIO_SET_PM)
+			return -EINVAL;
 		if (!is_power_of_2(m.rx_pg_sz) ||
 			!is_power_of_2(m.tx_pg_sz))
 			return -EINVAL;	/* not power of 2 */
@@ -2431,6 +2444,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EIO;	/* need the memory controllers */
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
+		if (t.cmd != CHELSIO_GET_MEM)
+			return -EINVAL;
 		if ((t.addr & 7) || (t.len & 7))
 			return -EINVAL;
 		if (t.mem_id == MEM_CM)
@@ -2483,6 +2498,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EAGAIN;
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
+		if (t.cmd != CHELSIO_SET_TRACE_FILTER)
+			return -EINVAL;
 
 		tp = (const struct trace_params *)&t.sip;
 		if (t.config_tx)
-- 
2.17.1

