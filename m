Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA59ECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7766321526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7766321526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733282AbeITU4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:56:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33627 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbeITU4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:56:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so9809540wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T/YPwrXVykLx5hkpqsiA0MJqO4coa4bJc+RtjykLZQc=;
        b=o6TjySgojfwrvPsakv2TvysSDasBzqATsVT9dIYjNw9v6jkJx1MR4Xct9/QsUftFGj
         XuHw1inh2S36rnKZugi8xsQNe2tw0WMMoF6dkJbCh5ka7VtiNXiPAMup1TROe3pB+Isb
         6ZQOcj4Q+Vxgj0A8owW8KMKABqKImcbDWYor/dvoElW3eUgKpWqCTGQZU8V3iNU2YQV4
         iRA7hYscI7gKRDE5VFCjyqVO6zdbEV7gnZhZGlRped4FTDNZBa68biH7EzGmZcbWf9bU
         sLK2msRml8NtaIwtoOOJnOsToUTZHN6LoILLx6D33z7P2MbXXpxgvlun6urZKvcZSeIc
         sQCg==
X-Gm-Message-State: APzg51DG3UxBChbplOT+Ef+L+DZo4MmURpL4zibbZzUh2O+BDhDnGJHA
        +l8rOaCPsj5OakJdA4DPsEwycg==
X-Google-Smtp-Source: ANB0VdaQVigOZt82X6lLMv0ssWlVBmVNEpsMS63HE3GQMp2f5FCgwmIyZe3q2hR9fbCsf4D1oVEpWg==
X-Received: by 2002:a5d:5450:: with SMTP id w16-v6mr35387051wrv.4.1537456345235;
        Thu, 20 Sep 2018 08:12:25 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id p89-v6sm55286201wrc.97.2018.09.20.08.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 08:12:24 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] fsconfig: parse "subtype" param for old internal API
Date:   Thu, 20 Sep 2018 17:12:12 +0200
Message-Id: <20180920151214.15484-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180920151214.15484-1-mszeredi@redhat.com>
References: <20180920151214.15484-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This subtype thing is specific to "fuse" and "fuseblk" filesystems.  When these
are switched over to the new context API, the handling of this parameter can be
moved from legacy_parse_param() into fuse.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index c0ecbb1ecdfe..0192456712d2 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -574,6 +574,16 @@ static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		param->string = NULL;
 		return 0;
 	}
+	if ((fc->fs_type->fs_flags & FS_HAS_SUBTYPE) &&
+	    strcmp(param->key, "subtype") == 0) {
+		if (param->type != fs_value_is_string)
+			return invalf(fc, "VFS: Legacy: Non-string subtype");
+		if (fc->subtype)
+			return invalf(fc, "VFS: Legacy: Multiple subtype");
+		fc->subtype = param->string;
+		param->string= NULL;
+		return 0;
+	}
 
 	if (ctx->param_type != LEGACY_FS_UNSET_PARAMS &&
 	    ctx->param_type != LEGACY_FS_INDIVIDUAL_PARAMS)
-- 
2.14.3

