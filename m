Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53979C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D9920855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543821;
	bh=OMHJTWGVK3H1/PnOllSVHvGsCb/SL7iolFwjaD25umU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zWXgfgG6fU9HFOrJfJGtL3Oa0MExGbKFuVnEbKyeD9n0LfVxdMnt3muwRETaXXBFw
	 8gcGCt8LrtiZ0ZhVAJoXwQ3dAMDZ4B61E8jsbUPgdP0HmkA2bkPizDdrQ/YX93mIja
	 DMIRe+1Uudguq2kNEZZqzp3ZYt4rEnQtJODxoDOo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D9920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeLKP5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:57:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:45760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730686AbeLKP4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A067F2146E;
        Tue, 11 Dec 2018 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543814;
        bh=OMHJTWGVK3H1/PnOllSVHvGsCb/SL7iolFwjaD25umU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1j/OZcVpY+ykqZJN3Py5bVRV2ka/G3v4m3BjOQNIXzI1//CC0fxYWYugvDhovkSI8
         rGm2MM72AFtL879YNreODEhd2ukosNgmbfS+ju0fmFjwVAis3qavyqliXfp8xlJfOu
         VwG9pjaAfQw6g3MdbduTWAHr1c94RW7RQoPLACHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/118] Revert "HID: uhid: use strlcpy() instead of strncpy()"
Date:   Tue, 11 Dec 2018 16:40:58 +0100
Message-Id: <20181211151645.814443453@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



