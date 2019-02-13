Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58B1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6BF20835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083594;
	bh=3pwkpBlmhxd/MZwUH/g467coBQACOEYJlD5PrR8fXUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QAxeCj53a0T/1Jkg4aNcDzAd6rX+rHESocPnVfwjNlpTVv2D0MgFpLgvIsoHwNzqW
	 jDPqh37ph+V9MFaqPzsEzAHMvdoKx1ZSdr3yo2O7uMyt5XktvYdtZkCH20KBL0+DrV
	 j3pAGSK0lU/hJBuAi1LMZv3f3uExw5CTHSxPAArI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406469AbfBMSqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:46:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbfBMSq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB0B320811;
        Wed, 13 Feb 2019 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083589;
        bh=3pwkpBlmhxd/MZwUH/g467coBQACOEYJlD5PrR8fXUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRqUbwAekin1zDoqwnuSfBLoT1p0RTCB6npdeFQtAT0yODIPxm3S5J2y8hmighwol
         5sbgdMNUNALeFueYHWvv6Kgs8g0Z7fdF5dKY8Xg9LzilLQkNIi3Yka3Xx8PW+XHAn1
         lv5we6ViIIuRe3XSt15veDYpZfReCAiWw4pGxEVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>,
        Brian Paul <brianp@vmware.com>, Sinclair Yeh <syeh@vmware.com>
Subject: [PATCH 4.20 42/50] drm/vmwgfx: Fix an uninitialized fence handle value
Date:   Wed, 13 Feb 2019 19:38:47 +0100
Message-Id: <20190213183658.995570990@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellstrom <thellstrom@vmware.com>

commit 51fdbeb4ca1a8415c98f87cb877956ae83e71627 upstream.

if vmw_execbuf_fence_commands() fails, The handle value will be
uninitialized and a bogus fence handle might be copied to user-space.

Cc: <stable@vger.kernel.org>
Fixes: 2724b2d54cda: ("drm/vmwgfx: Use new validation interface for the modesetting code v2")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Brian Paul <brianp@vmware.com> #v1
Reviewed-by: Sinclair Yeh <syeh@vmware.com> #v1
Reviewed-by: Deepak Rawat <drawat@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -2592,8 +2592,8 @@ void vmw_kms_helper_validation_finish(st
 				      user_fence_rep)
 {
 	struct vmw_fence_obj *fence = NULL;
-	uint32_t handle;
-	int ret;
+	uint32_t handle = 0;
+	int ret = 0;
 
 	if (file_priv || user_fence_rep || vmw_validation_has_bos(ctx) ||
 	    out_fence)


