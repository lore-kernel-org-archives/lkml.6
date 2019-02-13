Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8A0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B68620835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083442;
	bh=FuMhLuCT7pZGXx9cA5UICxiU1sJJ/3qTBzaaeeLwxXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u3abpcNAF/E9Uls4y80Sn6G7ooDYGP5peRL3Y0PgopLL9vkknwlA5VWJVxCbswX7D
	 AGSdg0T0cZ3x2Tz+V2elbgiRd4JczduRGhh4qfWFMhOHh2yMUksQQ1vcJ1S3ah8Wua
	 aahFi45kU+bXblYu0FgtaJXOE0oXf+Nox+L5UweA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406028AbfBMSoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:44:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406007AbfBMSn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2861E20811;
        Wed, 13 Feb 2019 18:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083435;
        bh=FuMhLuCT7pZGXx9cA5UICxiU1sJJ/3qTBzaaeeLwxXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xJb+K/naPmP3tAdmL70DWLevVTXWVuHzCKgff1fvnu+VpYfueT5F/a3hgWjdk8Uu+
         2EoHNZiT1kfJvhHZHGMaht3QSAw6kXOKylDbXNMmMzny+C+IkbTLLzy/SwCbWYBWho
         M4ZRv4j4RDgEKKnFTmVtI4PiH3TJ26Qx9D/dv0iM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>
Subject: [PATCH 4.19 35/44] drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user
Date:   Wed, 13 Feb 2019 19:38:36 +0100
Message-Id: <20190213183654.742220109@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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
@@ -3843,7 +3843,7 @@ int vmw_execbuf_fence_commands(struct dr
 		*p_fence = NULL;
 	}
 
-	return 0;
+	return ret;
 }
 
 /**


