Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2F6ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BF521104
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wqRcsHar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BF521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeKIHc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbeKIHc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:27 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B90E2133D;
        Thu,  8 Nov 2018 21:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714100;
        bh=rZG9v41Og7wkbtp7TLVPOx/7qsmUab2zsng+y7buxx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wqRcsHar8O17dQCVCRO7oRn9/TBJLaqaJJpiZGwjTRfGyjgHAGEXyxOrDPexgjZV7
         aRd4Sn89JJD6JBLjeeXhXE6gMF5mssVphKfgqHrFjaXPfVy7bZaTMJMivauFiTm3Yd
         PguipblpyyiSVlu8eGBgtd87oSOFrFHjbXcVF7KU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Felipe Balbi <balbi@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 039/144] usb: gadget: gadgetfs: fix an oops in ep_write()
Date:   Thu,  8 Nov 2018 13:50:10 -0800
Message-Id: <20181108215057.681903481@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



