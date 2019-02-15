Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CB9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98DC2229F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196929;
	bh=5abGJ/B3kl5X5PVBnFR3QueNIYhQTYaZwKyhwlmOPOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W2wqlnykfEVcsHF6z7v0Ec47JmkrWIZf4oq+AVNohWAfAGdOXy8Wc9c2dWTDFd3a3
	 IUZRNpUtr9aylO7w7vUJXRiFMmhmG00k0kFq7YbdKUmOuQW/k07dMHoA2Mu0dXriuO
	 De3s9Ei+srmpIU4/c/zEj9YeZ3ouZiDf8IUd23Ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405730AbfBOCP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:15:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405694AbfBOCPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:15:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C83521934;
        Fri, 15 Feb 2019 02:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196925;
        bh=5abGJ/B3kl5X5PVBnFR3QueNIYhQTYaZwKyhwlmOPOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YgZbjwQltOS3vRBo36hJo+bEOSCCucOQ3+euqHi7Z98O+7TDjPKOofjFp8WAhSpjX
         tZ1Sd2XGOuO51yX5rP3kPm64dim4TKtYW8ptFogIk0HTjdMvCt3DpoxHsUAIWbNHgI
         O7XY/PUHxkARGGMtZbdQOflnKsxuKsx7dXOQIF7w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 06/20] usb: gadget: Potential NULL dereference on allocation error
Date:   Thu, 14 Feb 2019 21:14:57 -0500
Message-Id: <20190215021511.179333-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021511.179333-1-sashal@kernel.org>
References: <20190215021511.179333-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit df28169e1538e4a8bcd8b779b043e5aa6524545c ]

The source_sink_alloc_func() function is supposed to return error
pointers on error.  The function is called from usb_get_function() which
doesn't check for NULL returns so it would result in an Oops.

Of course, in the current kernel, small allocations always succeed so
this doesn't affect runtime.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_sourcesink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
index 67b243989938..d7d095781be1 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -849,7 +849,7 @@ static struct usb_function *source_sink_alloc_func(
 
 	ss = kzalloc(sizeof(*ss), GFP_KERNEL);
 	if (!ss)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	ss_opts =  container_of(fi, struct f_ss_opts, func_inst);
 
-- 
2.19.1

