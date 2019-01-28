Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81C6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E15B20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690375;
	bh=DU5khS8np+Qj0Ta/epIXKPKzQ4HfJPqtw0docfZcqoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jVD8pSCuOfCcHJ0aENw1UVq+rmdgP0O6JqPHBvLwzKvZ6OQVctqYtFXjqiq9bWgJ2
	 KxyxvJjiTDFUen70LAhth2zUwltq3G592MepfEQqrRGylXgzYwm3WB4oHieGizsGNs
	 9PsDz9CiAxufr6Hchz+R3HnMq93RhdyqsUX1dMmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfA1PqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:46:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfA1PqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:46:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 890BB21741;
        Mon, 28 Jan 2019 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690366;
        bh=DU5khS8np+Qj0Ta/epIXKPKzQ4HfJPqtw0docfZcqoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gLq19p0yfFEZwKAwm7+MV7GYINQ26Txz9mafaV7JX4dGPAID+5arTivY1mPkPx5bo
         mBv+ghNTmIHUmHgcfrgBWmenjS+dnQP/S7iaPGx0dEgpn5VG5yjFVMpJUnzUaIqx6O
         z9m8UcMBL9/peXwFlsel4U4uqeWxLNbnJZqtIjsM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.20 066/304] staging: erofs: fix the definition of DBG_BUGON
Date:   Mon, 28 Jan 2019 10:39:43 -0500
Message-Id: <20190128154341.47195-66-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

[ Upstream commit eef168789866514e5d4316f030131c9fe65b643f ]

It's better not to positively BUG_ON the kernel, however developers
need a way to locate issues as soon as possible.

DBG_BUGON is introduced and it could only crash when EROFS_FS_DEBUG
(EROFS developping feature) is on. It is helpful for developers
to find and solve bugs quickly by eng builds.

Previously, DBG_BUGON is defined as ((void)0) if EROFS_FS_DEBUG is off,
but some unused variable warnings as follows could occur:

drivers/staging/erofs/unzip_vle.c: In function `init_alway:':
drivers/staging/erofs/unzip_vle.c:61:33: warning: unused variable `work' [-Wunused-variable]
  struct z_erofs_vle_work *const work =
                                 ^~~~

Fix it to #define DBG_BUGON(x) ((void)(x)).

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/erofs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 57575c7f5635..048fb034b5aa 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -39,7 +39,7 @@
 #define debugln(x, ...)         ((void)0)
 
 #define dbg_might_sleep()       ((void)0)
-#define DBG_BUGON(...)          ((void)0)
+#define DBG_BUGON(x)            ((void)(x))
 #endif
 
 enum {
-- 
2.19.1

