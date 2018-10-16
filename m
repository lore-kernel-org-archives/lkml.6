Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EFAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971EA21477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7TCZIpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971EA21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbeJPMDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbeJPMDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:03:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55CEB2145D;
        Tue, 16 Oct 2018 04:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663299;
        bh=Onqtm8dkCV7nsGa8/Y0TCcyPczlvysD66/E87NntnXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7TCZIpCW+kUhoNOL6CGWAxM0oaRY3Pahj95Kkpt5b/QbPEb2I3LYcOpM+IsZEzna
         nC3HRjVyZMXuICGIbyrdsdXEEIoEzS3pILjbIqhtxdWiq4v0HVNTYbXJjiHIF6Z97C
         PhAywO4PDHt39QLmTI3mW/2ALnyc6zQHDtQb99D4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 59/61] yam: fix a missing-check bug
Date:   Tue, 16 Oct 2018 00:14:01 -0400
Message-Id: <20181016041403.135678-59-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>

[ Upstream commit 0781168e23a2fc8dceb989f11fc5b39b3ccacc35 ]

In yam_ioctl(), the concrete ioctl command is firstly copied from the
user-space buffer 'ifr->ifr_data' to 'ioctl_cmd' and checked through the
following switch statement. If the command is not as expected, an error
code EINVAL is returned. In the following execution the buffer
'ifr->ifr_data' is copied again in the cases of the switch statement to
specific data structures according to what kind of ioctl command is
requested. However, after the second copy, no re-check is enforced on the
newly-copied command. Given that the buffer 'ifr->ifr_data' is in the user
space, a malicious user can race to change the command between the two
copies. This way, the attacker can inject inconsistent data and cause
undefined behavior.

This patch adds a re-check in each case of the switch statement if there is
a second copy in that case, to re-check whether the command obtained in the
second copy is the same as the one in the first copy. If not, an error code
EINVAL will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hamradio/yam.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/hamradio/yam.c b/drivers/net/hamradio/yam.c
index 7a7c5224a336..16a6e1193912 100644
--- a/drivers/net/hamradio/yam.c
+++ b/drivers/net/hamradio/yam.c
@@ -980,6 +980,8 @@ static int yam_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 				 sizeof(struct yamdrv_ioctl_mcs));
 		if (IS_ERR(ym))
 			return PTR_ERR(ym);
+		if (ym->cmd != SIOCYAMSMCS)
+			return -EINVAL;
 		if (ym->bitrate > YAM_MAXBITRATE) {
 			kfree(ym);
 			return -EINVAL;
@@ -995,6 +997,8 @@ static int yam_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		if (copy_from_user(&yi, ifr->ifr_data, sizeof(struct yamdrv_ioctl_cfg)))
 			 return -EFAULT;
 
+		if (yi.cmd != SIOCYAMSCFG)
+			return -EINVAL;
 		if ((yi.cfg.mask & YAM_IOBASE) && netif_running(dev))
 			return -EINVAL;		/* Cannot change this parameter when up */
 		if ((yi.cfg.mask & YAM_IRQ) && netif_running(dev))
-- 
2.17.1

