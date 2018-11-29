Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DEEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161F421019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8Acej/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161F421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeK2RDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:03:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeK2RDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:03:34 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC95D208E7;
        Thu, 29 Nov 2018 05:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471163;
        bh=USgoQ4D9VCbfZVSzN36RiwJFaTW0Xd3TaUs21r/PocE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8Acej/vQ9KByqaO7/VIbLbBf7iwVu+rxQe0a3fZdPxKYrKpu8XWvAHoyi7TeqqgZ
         sOuPvs02PIeL4RzWcrb2VA+PC5pm3OR0e6xfu/LGq7e7jgFGVDuDNQeWh6jFHYaV28
         7yqpCHNNnCzcvjH9Q6F3kKKS3a0xdmBsVMKygF+U=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Herrmann <dh.herrmann@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 41/68] Revert "HID: uhid: use strlcpy() instead of strncpy()"
Date:   Thu, 29 Nov 2018 00:55:32 -0500
Message-Id: <20181129055559.159228-41-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Herrmann <dh.herrmann@gmail.com>

[ Upstream commit 4d26d1d1e8065bb3326a7c06d5d4698e581443a9 ]

This reverts commit 336fd4f5f25157e9e8bd50e898a1bbcd99eaea46.

Please note that `strlcpy()` does *NOT* do what you think it does.
strlcpy() *ALWAYS* reads the full input string, regardless of the
'length' parameter. That is, if the input is not zero-terminated,
strlcpy() will *READ* beyond input boundaries. It does this, because it
always returns the size it *would* copy if the target was big enough,
not the truncated size it actually copied.

The original code was perfectly fine. The hid device is
zero-initialized and the strncpy() functions copied up to n-1
characters. The result is always zero-terminated this way.

This is the third time someone tried to replace strncpy with strlcpy in
this function, and gets it wrong. I now added a comment that should at
least make people reconsider.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/uhid.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 051639c09f72..840634e0f1e3 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -497,12 +497,13 @@ static int uhid_dev_create2(struct uhid_device *uhid,
 		goto err_free;
 	}
 
-	len = min(sizeof(hid->name), sizeof(ev->u.create2.name));
-	strlcpy(hid->name, ev->u.create2.name, len);
-	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys));
-	strlcpy(hid->phys, ev->u.create2.phys, len);
-	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq));
-	strlcpy(hid->uniq, ev->u.create2.uniq, len);
+	/* @hid is zero-initialized, strncpy() is correct, strlcpy() not */
+	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
+	strncpy(hid->name, ev->u.create2.name, len);
+	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
+	strncpy(hid->phys, ev->u.create2.phys, len);
+	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
+	strncpy(hid->uniq, ev->u.create2.uniq, len);
 
 	hid->ll_driver = &uhid_hid_driver;
 	hid->bus = ev->u.create2.bus;
-- 
2.17.1

