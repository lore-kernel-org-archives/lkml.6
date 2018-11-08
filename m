Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7411EC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0D020844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZ63gcFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0D020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbeKIHhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbeKIHhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:54 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1663E208E3;
        Thu,  8 Nov 2018 22:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714426;
        bh=HMnt/gwabkufMXC2+3GiYTf8vI681mW6XWvYtLHvoSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZ63gcFGceUqHvrjkO6d/Tupxeqwoe7rTd4XaQ811siuYJxrUqMs+m+HoypQe5WGp
         VUtYvu8JqvOqD5hJjTvlha707m7pzpHb40tMGQVW2eDy/kybr0ZDEwDL8vkljFKtAL
         VWW0en2QanPsHuMPNOIhsh3dGgH1+cKQ8BBu9K7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 036/114] tpm: fix: return rc when devm_add_action() fails
Date:   Thu,  8 Nov 2018 13:50:51 -0800
Message-Id: <20181108215104.226618623@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4f3b193dee4423d8c89c9a3e8e05f9197ea459a4 ]

Call put_device() and return error code if devm_add_action() fails.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reported-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Fixes: 8e0ee3c9faed ("tpm: fix the cleanup of struct tpm_chip")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-chip.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index e759100e41a7..28894878dcd5 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -230,7 +230,11 @@ struct tpm_chip *tpmm_chip_alloc(struct device *dev,
 	chip->cdev.owner = dev->driver->owner;
 	chip->cdev.kobj.parent = &chip->dev.kobj;
 
-	devm_add_action(dev, (void (*)(void *)) put_device, &chip->dev);
+	rc = devm_add_action(dev, (void (*)(void *)) put_device, &chip->dev);
+	if (rc) {
+		put_device(&chip->dev);
+		return ERR_PTR(rc);
+	}
 
 	return chip;
 }
-- 
2.17.1



