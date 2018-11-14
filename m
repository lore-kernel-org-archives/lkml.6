Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BFDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354CC22513
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NftK2JzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354CC22513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733033AbeKOI13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731448AbeKOI13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:29 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB8CA22522;
        Wed, 14 Nov 2018 22:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234146;
        bh=04Mozd/44z3rGL+pqPBKody6BPIOXpwDA/zLl/gB9nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NftK2JzXcGPh8Y/voNtkoDBY/xmNl1hixR2wDHC8gOQsw+uVJOevzAYtpouWM6Bwa
         QnhpJIo3MS5ldjdfzHPdDLqAciS3kocFBFrE6j6m4kSzgELyMTVK5qlI9J2J99VhQx
         eW2f76rclyat7Wfy9yIfOGsV5ly4hd1Upa2HFVr8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>, Genki Sky <sky@genki.is>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 72/73] Revert "scripts/setlocalversion: git: Make -dirty check more robust"
Date:   Wed, 14 Nov 2018 17:22:06 -0500
Message-Id: <20181114222207.98701-72-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

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

