Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ECEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEBD2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499339;
	bh=z/16bH7V2Vw8DfpmRHJmjQbR//82ZDgQzRH7IizkrcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cFJdBo8xsimGg63mvu+zJCkfnQ4Q9vxJ8Ksa6g+TGMwy2z8p4f/GEh37Vd7sUM6cC
	 cx58h8Eot+Hj+mXCZ7O2x7EF+Gk954OHume9IhyO2e3mY3LnDPl8BMeUUFa/uq011v
	 N/mY/0uqCBxlKH3fKdRIWT543T7+LqMpmqS1z7d8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391993AbfBROPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391889AbfBROMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:12:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B4EC218AD;
        Mon, 18 Feb 2019 14:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499122;
        bh=z/16bH7V2Vw8DfpmRHJmjQbR//82ZDgQzRH7IizkrcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0fC8dC6ixo5yfCmWi2+0P3S6wXiTIuEjtqG5KDvPkNBulUpCTPoc+MspPOX3b7Ulu
         JJLciJuoWjvJjeCMt1O/woTJD/+C0nXYCVOM10ceAudsy6VdzP5BP0lU6ZRl61vLHu
         8vqusk5cNUiIgh8WHBuok25d2oCmuDW9zIh68efI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>
Subject: [PATCH 3.18 084/108] drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user
Date:   Mon, 18 Feb 2019 14:44:20 +0100
Message-Id: <20190218133523.443072524@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellstrom <thellstrom@vmware.com>

commit 728354c005c36eaf44b6e5552372b67e60d17f56 upstream.

The function was unconditionally returning 0, and a caller would have to
rely on the returned fence pointer being NULL to detect errors. However,
the function vmw_execbuf_copy_fence_user() would expect a non-zero error
code in that case and would BUG otherwise.

So make sure we return a proper non-zero error code if the fence pointer
returned is NULL.

Cc: <stable@vger.kernel.org>
Fixes: ae2a104058e2: ("vmwgfx: Implement fence objects")
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -2346,7 +2346,7 @@ int vmw_execbuf_fence_commands(struct dr
 		*p_fence = NULL;
 	}
 
-	return 0;
+	return ret;
 }
 
 /**


