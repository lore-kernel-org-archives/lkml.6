Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6D12089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDgF/l4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6D12089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbeKZV7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:59:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731251AbeKZV7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:59:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A0020672;
        Mon, 26 Nov 2018 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230316;
        bh=J4U3bpuAHwwYUkJ2yvx23lkvtKcdyY6j4ivYyKd5pCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDgF/l4tzbUMKSmPnJeICzojH4VkFOzTqhGxz7A/1J71qLtrZ0WEAcJkqpTtRXic7
         Vs5wpbmX5NqD8RjOUB69+/gA4fMs5hagOmlNyBDTpbF7fj8VLStkI/kxN0hyl/gWxm
         ywHOj+ZjiKrQdPbgnHG3VuADoMw2/8RWc4FJ+RG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Genki Sky <sky@genki.is>,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 090/118] Revert "scripts/setlocalversion: git: Make -dirty check more robust"
Date:   Mon, 26 Nov 2018 11:51:24 +0100
Message-Id: <20181126105105.316609760@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8ef14c2c41d962756d314f1d7dc972b0ea7a180f ]

This reverts commit 6147b1cf19651c7de297e69108b141fb30aa2349.

The reverted patch results in attempted write access to the source
repository, even if that repository is mounted read-only.

Output from "strace git status -uno --porcelain":

getcwd("/tmp/linux-test", 129)          = 16
open("/tmp/linux-test/.git/index.lock", O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) =
	-1 EROFS (Read-only file system)

While git appears to be able to handle this situation, a monitored
build environment (such as the one used for Chrome OS kernel builds)
may detect it and bail out with an access violation error. On top of
that, the attempted write access suggests that git _will_ write to the
file even if a build output directory is specified. Users may have the
reasonable expectation that the source repository remains untouched in
that situation.

Fixes: 6147b1cf19651 ("scripts/setlocalversion: git: Make -dirty check more robust"
Cc: Genki Sky <sky@genki.is>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/setlocalversion | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 79f7dd57d571..71f39410691b 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -74,7 +74,7 @@ scm_version()
 		fi
 
 		# Check for uncommitted changes
-		if git status -uno --porcelain | grep -qv '^.. scripts/package'; then
+		if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
 			printf '%s' -dirty
 		fi
 
-- 
2.17.1



