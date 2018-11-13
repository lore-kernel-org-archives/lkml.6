Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12861C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE0D2251C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAQZNdiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE0D2251C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbeKMPsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:48:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732688AbeKMPsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:48:38 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E422251F;
        Tue, 13 Nov 2018 05:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088331;
        bh=U5tbPCsrfZjD7HmLG4UiMbv/5pTnTm4SutG8xgj0QF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAQZNdiCS/trmET5J+Ru1osbubjODgRI6Gp3aCnRrQVDp8bVIk35XJugGOmP3EEHo
         pleI9v0V8ZGghfRwh5RbSomAbCFKugYFDr2e6lzEZr9lpzFLxS0RFlh+imktg5iA3L
         k2oMkJXdUW7q5gW2U6+5l9Hpg128y8FPXwStvIm8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chengguang Xu <cgxu519@gmx.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 17/26] fs/exofs: fix potential memory leak in mount option parsing
Date:   Tue, 13 Nov 2018 00:51:41 -0500
Message-Id: <20181113055150.78773-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055150.78773-1-sashal@kernel.org>
References: <20181113055150.78773-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengguang Xu <cgxu519@gmx.com>

[ Upstream commit 515f1867addaba49c1c6ac73abfaffbc192c1db4 ]

There are some cases can cause memory leak when parsing
option 'osdname'.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exofs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/exofs/super.c b/fs/exofs/super.c
index 819624cfc8da..c9ec652e2fcd 100644
--- a/fs/exofs/super.c
+++ b/fs/exofs/super.c
@@ -100,6 +100,7 @@ static int parse_options(char *options, struct exofs_mountopt *opts)
 		token = match_token(p, tokens, args);
 		switch (token) {
 		case Opt_name:
+			kfree(opts->dev_name);
 			opts->dev_name = match_strdup(&args[0]);
 			if (unlikely(!opts->dev_name)) {
 				EXOFS_ERR("Error allocating dev_name");
@@ -863,8 +864,10 @@ static struct dentry *exofs_mount(struct file_system_type *type,
 	int ret;
 
 	ret = parse_options(data, &opts);
-	if (ret)
+	if (ret) {
+		kfree(opts.dev_name);
 		return ERR_PTR(ret);
+	}
 
 	if (!opts.dev_name)
 		opts.dev_name = dev_name;
-- 
2.17.1

