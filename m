Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A2AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9FD217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170666;
	bh=dw7UrnCp2OMhSlYLvAqKCX6txpTh0ypjq35rFZggrYE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PBuI5DnOSfLA7thUNt+IZ5OlbcnPcRG9fDOI+FN77CKJs7OZMO5c4QWXeuotvO+s7
	 QNckunAW4Bzru2Jq+/hoJpapMbkvoe6yKk15miYe8dzE7s4YYqvZ5uM/W2DaIu7l5F
	 dbiosTIadgNMB62eepqKacbm49lwHhd+uDFsKMVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfAVPYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:24:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbfAVPYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:24:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2DB217F4;
        Tue, 22 Jan 2019 15:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170663;
        bh=dw7UrnCp2OMhSlYLvAqKCX6txpTh0ypjq35rFZggrYE=;
        h=From:To:Cc:Subject:Date:From;
        b=sOWky0rNGcTCF7v98R6zTdnvLpFHn3BWAPj7COfYRP9keoMSew6X1/Wry0smmjieO
         Jfpk4NKaTFWvWHr7ykv8m1JQ8bJOMOnOj8m+lFoRJr4VS96xUFReQoFZqidckSqQnZ
         HVtxVvbVwKxHeutLAAaraCJPdzt6Bupm1NKCfOsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] trace: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:40 +0100
Message-Id: <20190122152151.16139-41-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c521b7347482..629bbb45279a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8107,10 +8107,6 @@ struct dentry *tracing_init_dentry(void)
 	 */
 	tr->dir = debugfs_create_automount("tracing", NULL,
 					   trace_automount, NULL);
-	if (!tr->dir) {
-		pr_warn_once("Could not create debugfs directory 'tracing'\n");
-		return ERR_PTR(-ENOMEM);
-	}
 
 	return NULL;
 }
-- 
2.20.1

