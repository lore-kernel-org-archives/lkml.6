Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC9ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C839520868
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bknw5XKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C839520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbeJYWwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbeJYWwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:08 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64C1820868;
        Thu, 25 Oct 2018 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477151;
        bh=G6J3ZOKCkA/A/NL5Kd33pMK396ZXIcXdJutYipJqa3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bknw5XKq8BT0NOHYScTAXYuM37T1++euGJKJ0pryTvpY9sFiUkEOyp/OdRlyhDtwy
         nX0sMvbTs8XTjkSG0wa2LvtPt5NoOxwSMlRHinAQ6tDWYNRrlSeAFZIP6hkRI4NYil
         fssAGQWI1WfZHLohT4SZBFG8l5i4uErg8ipLr0/k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Felipe Balbi <balbi@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 09/98] usb: gadget: gadgetfs: fix an oops in ep_write()
Date:   Thu, 25 Oct 2018 10:17:24 -0400
Message-Id: <20181025141853.214051-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 42d6cfa0caec4b68a7f17147fbf13a36e94a8bf2 ]

We try to free an ERR_PTR on this error path.

Fixes: b44be2462dbe ('usb: gadget: gadgetfs: Free memory allocated by memdup_user()')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/legacy/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index e2d57e3d67c7..7974956e8ded 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -442,6 +442,7 @@ ep_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	kbuf = memdup_user(buf, len);
 	if (IS_ERR(kbuf)) {
 		value = PTR_ERR(kbuf);
+		kbuf = NULL;
 		goto free1;
 	}
 
-- 
2.17.1

