Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6B8C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF14222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083326;
	bh=Y3k9zW6QjyRBWrBRWmAILogTdqbxRarzHfmmILCrG2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WHNC95SS/dy7a+GNRQbG8uWTCe+0GA8TUDRDZB3HeCqMYB4tx4c1N6iJKK+rXamL1
	 iAKyfMJYWFni4RPCiAfj5qLnBCsRenJ4KdD7oUcbeERKppwdCIUbQqDi7DGO4BXZqo
	 VJwaqc31GuT6PLIoyI8e/S72mXq7gFB2j//dInaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405576AbfBMSmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393914AbfBMSmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:42:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93862222D6;
        Wed, 13 Feb 2019 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083322;
        bh=Y3k9zW6QjyRBWrBRWmAILogTdqbxRarzHfmmILCrG2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwkpJOSVUD4hVaHuQ8luwb5dJSQucS31bzR+KKTERdEFKjVn37sPBSISwn54Jh715
         9GhBXigb0FvJiG01/ku6P8ECnMiHTJXBkMnzArzSr7ovAXxC5NPivte1SGH+jk6ieJ
         UcTbNVQGh7JtZncgI34dADFInkmU2CbwfddMGQgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xiubo Li <xiubli@redhat.com>,
        Hailong Liu <liu.hailong6@zte.com.cn>,
        Jiang Biao <jiang.biao2@zte.com.cn>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 33/35] uio: fix wrong return value from uio_mmap()
Date:   Wed, 13 Feb 2019 19:38:28 +0100
Message-Id: <20190213183707.531196774@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hailong Liu <liu.hailong6@zte.com.cn>

commit e7de2590f18a272e63732b9d519250d1b522b2c4 upstream.

uio_mmap has multiple fail paths to set return value to nonzero then
goto out. However, it always returns *0* from the *out* at end, and
this will mislead callers who check the return value of this function.

Fixes: 57c5f4df0a5a0ee ("uio: fix crash after the device is unregistered")
CC: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -816,7 +816,7 @@ static int uio_mmap(struct file *filep,
 
 out:
 	mutex_unlock(&idev->info_lock);
-	return 0;
+	return ret;
 }
 
 static const struct file_operations uio_fops = {


