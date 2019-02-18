Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52B321901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498758;
	bh=2mY/HG+Z2IIbNG8FGG9jjQtEwWorK3Kq6J7WcUrthPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zDnbh4JHxdrruDW0vnKkoQiSXQ86SFhsi4+Zn+UTHaHemBEvTQuDgwyBbhzOLnK9M
	 FpndKGANNClX32tX/we5szeLR8GWyNqu4h9qdn63iL2gZVPRo9xvlqulqLFxk8Wn8Q
	 Mg94P7UPMN4QFENascgEn1dDOmXR24QQmR+XDbbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390286AbfBROF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:05:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390260AbfBROFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:05:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5FF4204FD;
        Mon, 18 Feb 2019 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498752;
        bh=2mY/HG+Z2IIbNG8FGG9jjQtEwWorK3Kq6J7WcUrthPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xvM5Ta/G+0M55/ftgTmtUZHZ8MXEfGZKQ2SuXGZEDPI1K8RL7aiCgvVfcIdvsObzc
         UJTEX+LBq2RfkH7DqFKScWd8jRk58kpUe8JJmSL/gfWIeeGLRURb0iAPLFlbYSHQzA
         XrwuSIp7qkfBpUAIEvqM5oAKaVSVL+B77ajtV4iI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>
Subject: [PATCH 4.4 110/143] drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user
Date:   Mon, 18 Feb 2019 14:43:58 +0100
Message-Id: <20190218133533.049404361@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3663,7 +3663,7 @@ int vmw_execbuf_fence_commands(struct dr
 		*p_fence = NULL;
 	}
 
-	return 0;
+	return ret;
 }
 
 /**


