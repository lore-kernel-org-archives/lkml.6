Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C59C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28A720836
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197632;
	bh=PyLJHc5efQtXFyfdSwXdRK867wo+zljRnnL+ZAd1cOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VAJGSUf/KsEKH/3ge9/NGYC+r6cmJ+P38KjEPMMUfhsRSZPKXQDEt3GBKtx1gN4ey
	 VtDD9vAS5YBXuANr6t0jqywbXeg9UYwmSlWHiJ3tnG07/qfCEi/Rs3IyZrI18KraBX
	 FurwttPznUbMFTpjaJDlgrOJF78G+/VTVIyMl8kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbfBOC1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:27:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404791AbfBOCNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:13:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2506E222D0;
        Fri, 15 Feb 2019 02:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196817;
        bh=PyLJHc5efQtXFyfdSwXdRK867wo+zljRnnL+ZAd1cOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlz+HRBUIx+LsEeve9zaUF66DzDCvMgVh8HAQMQOJnQorVKrgP0lpmV44CdCAkWor
         bvxggKgB1MZrNWKvgCiAE4am4GcVMUjt0dPz9Q8kTPzxv16iswn01WVH7KyZN1RSWZ
         Q6v3TxJmr18nLUbkRTe4BoVCvgsEnBx3f9XLnf8w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 14/40] selftests: gpio-mockup-chardev: Check asprintf() for error
Date:   Thu, 14 Feb 2019 21:12:47 -0500
Message-Id: <20190215021313.178476-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021313.178476-1-sashal@kernel.org>
References: <20190215021313.178476-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 508cacd7da6659ae7b7bdd0a335f675422277758 ]

With gcc 7.3.0:

    gpio-mockup-chardev.c: In function ‘get_debugfs’:
    gpio-mockup-chardev.c:62:3: warning: ignoring return value of ‘asprintf’, declared with attribute warn_unused_result [-Wunused-result]
       asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Handle asprintf() failures to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/gpio/gpio-mockup-chardev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
index 667e916fa7cc..6ceeeed4eeb9 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
@@ -37,7 +37,7 @@ static int get_debugfs(char **path)
 	struct libmnt_table *tb;
 	struct libmnt_iter *itr = NULL;
 	struct libmnt_fs *fs;
-	int found = 0;
+	int found = 0, ret;
 
 	cxt = mnt_new_context();
 	if (!cxt)
@@ -58,8 +58,11 @@ static int get_debugfs(char **path)
 			break;
 		}
 	}
-	if (found)
-		asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
+	if (found) {
+		ret = asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
+		if (ret < 0)
+			err(EXIT_FAILURE, "failed to format string");
+	}
 
 	mnt_free_iter(itr);
 	mnt_free_context(cxt);
-- 
2.19.1

