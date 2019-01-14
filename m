Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7EBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881C220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YjByJ4Pc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cvhv/Kg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfANHTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 02:19:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55878 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfANHTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 02:19:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3405460886; Mon, 14 Jan 2019 07:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547450350;
        bh=Z+svzhK5SMN0zjlYUpaaNFfbRpMzTU/a3Jtm13ynYHs=;
        h=Date:From:To:Cc:Subject:From;
        b=YjByJ4PccQNNOY5bCmKHwgC8tOEHrP1628AneGbO7+t/wWdbjJLECP4HZNvQLSLVe
         WURmil+J30CEF0JQgBPuHSWIzoMhMAnwdzgAO8FqrMnNjh3Of/yWmBKGEaF+QcBwwR
         LSpGqBapXqYBh94iFGLHYdInAKUBC06OMxYtLHFc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DF9E56079C;
        Mon, 14 Jan 2019 07:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547450349;
        bh=Z+svzhK5SMN0zjlYUpaaNFfbRpMzTU/a3Jtm13ynYHs=;
        h=Date:From:To:Cc:Subject:From;
        b=Cvhv/Kg/sKMervrOCp478XW9Ztt5ZDE0F70GuTex3NTkYITSfWcu6wmE6ypMvUcVv
         tPWeTSbOXndr2Wpl0532oqq04ovAnaUlBMpHm94qMIqo2S9KedHfboXgAV7Iravx8e
         6QHmMYXzAhutiBB/3sUT6UngGM0Ncub2vaOH9O08=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Jan 2019 15:19:09 +0800
From:   yuankuiz@codeaurora.org
To:     mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: hardcode the debug message for -ENOENT
Message-ID: <7e752055f72d67a4b963436d67965123@codeaurora.org>
X-Sender: yuankuiz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From d6892f54a81bf85ad011bfb8822567690713d575 Mon Sep 17 00:00:00 2001

When the return code of "-ENOENT" was printed inside
of the debug message, which could be hardcoded simply.

Signed-off-by: John Zhao <yuankuiz@codeaurora.org>
---
  drivers/base/firmware_loader/main.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c 
b/drivers/base/firmware_loader/main.c
index 8e9213b..9ab1409 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -328,12 +328,12 @@ fw_get_filesystem_firmware(struct device *device, 
struct fw_priv *fw_priv)
  		rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
  						msize, id);
  		if (rc) {
-			if (rc == -ENOENT)
-				dev_dbg(device, "loading %s failed with error %d\n",
-					 path, rc);
-			else
+			if (rc != -ENOENT)
  				dev_warn(device, "loading %s failed with error %d\n",
  					 path, rc);
+			else
+				dev_dbg(device, "loading %s failed with error -ENOENT\n",
+					 path);
  			continue;
  		}
  		dev_dbg(device, "direct-loading %s\n", fw_priv->fw_name);
-- 
2.7.4
