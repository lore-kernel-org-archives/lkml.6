Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5348C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABC7222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083192;
	bh=js4H7n3nUMN/k1vpbIbIbKZFpD23d3zu07r4jdIpzTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LZifsK6cmZ6BWG8WOZjSv0HXkyDDwkUxmPcjLhTsXOFrpxe9ZQNisNgGzMVh9F54R
	 AYm6NUuVTA0q30/6m9rZ92ERCzibFvsX+1CnOIjIYfnePj0T5KGJXyuD/z1gdixK1V
	 4XmpjhbWuwm2/q1l0H/wW71Fg3yGgFlwNIRF5r/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405291AbfBMSju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:39:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405269AbfBMSjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:39:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00309222D5;
        Wed, 13 Feb 2019 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083187;
        bh=js4H7n3nUMN/k1vpbIbIbKZFpD23d3zu07r4jdIpzTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hyghN79ngqqwL7BiO+VzN4CLqOk1Yvo0rnIjmIX5dfd07QW07YPcuFGqA0vOA3Uer
         XMDEqSsYNMUrgEL9UwE7OysPI+fqGMXPsA2OZCiD9EPV7TP4bjGlLF0MksXYPNrS5m
         OSHVQOppMWo7U6XZ23rrj1XdxDstjoPoW4wBiAAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>
Subject: [PATCH 4.9 16/24] drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user
Date:   Wed, 13 Feb 2019 19:38:13 +0100
Message-Id: <20190213183648.739148931@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183647.333441569@linuxfoundation.org>
References: <20190213183647.333441569@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3769,7 +3769,7 @@ int vmw_execbuf_fence_commands(struct dr
 		*p_fence = NULL;
 	}
 
-	return 0;
+	return ret;
 }
 
 /**


