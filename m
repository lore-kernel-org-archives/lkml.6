Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819D5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B1C20643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197381;
	bh=slqZOW3NcXL8rk3Ff3ypikJsnDyGCNZgL8hOq0D+F+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=USt63HXuq9Nkn7cAasiI6W4YXdhLatN0iJ3gVM8MCCRjF4HF/ABfZ7P/iRJo+6NDL
	 3s4b0c3quqPHmaa57dzKY4ZTCZiBhkcy7t73bBGzx1bGZVxa70DkPpqNcX4DVI0ExP
	 wbeS9jKOGnTyVSLlaaAyRz2TcCHP3Lfcv77y1sik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392439AbfBOCW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:22:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391799AbfBOCOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:14:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBE9120643;
        Fri, 15 Feb 2019 02:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196879;
        bh=slqZOW3NcXL8rk3Ff3ypikJsnDyGCNZgL8hOq0D+F+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPnf1AJ3OmPdmAqojrOhK4DvnVfh2zKO8xGlcHsfDkimc6P2is5cc2UvtB36KpbY4
         TCKl8U12pU4bVIRhRCUVpNMSL0xkv5ry9iIe8pMxAyB94kZY4KwopuJUi1Z5Bv/EaA
         E1IChh+tuTCaIXXDRSLLIHlzRSEJO2dWvvjNcKrE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/27] usb: gadget: Potential NULL dereference on allocation error
Date:   Thu, 14 Feb 2019 21:14:04 -0500
Message-Id: <20190215021424.178979-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021424.178979-1-sashal@kernel.org>
References: <20190215021424.178979-1-sashal@kernel.org>
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
index 8784fa12ea2c..6e9d958004a0 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -842,7 +842,7 @@ static struct usb_function *source_sink_alloc_func(
 
 	ss = kzalloc(sizeof(*ss), GFP_KERNEL);
 	if (!ss)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	ss_opts =  container_of(fi, struct f_ss_opts, func_inst);
 
-- 
2.19.1

