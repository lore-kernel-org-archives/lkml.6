Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E61BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651FA2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnrV475z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651FA2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeKZVrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:47:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeKZVrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:47:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E036320817;
        Mon, 26 Nov 2018 10:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229602;
        bh=+V1TnxQxaGdxwYbneQg2QCwCLBCfQquzSmHXJBa8gWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UnrV475zUkuWmdWVE7WhYAV54teJ/gKtQWitOYl/wcN0flR2ca2T1XAuu0GBU5mXh
         BJW4+c5Vttp/9fZCS0pAt9EmJgrNw5MF8BlUOOGLEj8NSsxRioIYUdCuDrA0K20aqa
         wAvgxnI7D83E9XJnF2AXxAjrJJU87/9IdjlHih28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 06/24] fs/exofs: fix potential memory leak in mount option parsing
Date:   Mon, 26 Nov 2018 11:51:00 +0100
Message-Id: <20181126105030.629742320@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
References: <20181126105029.790599475@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 95965503afcb..e3f9cf332304 100644
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
@@ -868,8 +869,10 @@ static struct dentry *exofs_mount(struct file_system_type *type,
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



