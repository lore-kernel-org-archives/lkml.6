Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247F1C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF304205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF304205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388727AbeG0Rrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:47:53 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37322 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730771AbeG0Rrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:47:52 -0400
Received: by mail-qk0-f196.google.com with SMTP id t79-v6so3644992qke.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cr6pNW+fjS1yKdZySX4mrSYdRIKPWpKsxQDEMcRYIAI=;
        b=Ghb9PEUpMVpcQAfQ/HMlXb6ncuLoBOAwVHQo+D6Bz6AnZRMJudPjyJAspXRfnylHSX
         88wgTFsCIzR/Sy0xiDuiOBzHNJkAed8AajY7ZO7kWKP6i/SpA8GnrDsJ4Q2w0yDo3Yqw
         gMYfV+KmqJcUunbXsVb0RxgL1d6vlKDJEIyaCb+DLkyjBp6tvnjW7O/eRP1XkjjINFFM
         pgi/HKldTHDvqedIIAMytf9dyyRfCXCovKvZ5P8+FYZK8fe/hKvVNJ1LerYegsVyinFM
         rqS4DtmRwQCTh4m4Bmqjlj1+dnTv35IYip+oAxCPIjQq2f7WWsaJlMYoalUcjCxxXZNR
         iHlQ==
X-Gm-Message-State: AOUpUlFOy5r/W1QMPhbn872Ml7q9bQMGF+4/qtGbexQHZnbHwRmjFMKC
        UbGeC0dC4/n+h6Eup1h76TWG/A==
X-Google-Smtp-Source: AAOMgpc4eX4tCrOuryDqDXJUROPPdFohNdIcTlDJ7fzpqD07+SztbsJOYVUYvuFIXCBLoNUv9WUeXw==
X-Received: by 2002:ae9:e118:: with SMTP id g24-v6mr6392752qkm.306.1532708714744;
        Fri, 27 Jul 2018 09:25:14 -0700 (PDT)
Received: from builder.jcline.org.com ([2605:a601:80ce:4700:77a5:8983:ea8b:82ec])
        by smtp.gmail.com with ESMTPSA id s73-v6sm3137342qkl.65.2018.07.27.09.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 09:25:14 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/3] ext4: super: Fix spectre gadget in ext4_quota_on
Date:   Fri, 27 Jul 2018 16:23:55 +0000
Message-Id: <20180727162357.30801-2-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727162357.30801-1-jcline@redhat.com>
References: <20180727162357.30801-1-jcline@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'type' is a user-controlled value used to index into 's_qf_names', which
can be used in a Spectre v1 attack. Clamp 'type' to the size of the
array to avoid a speculative out-of-bounds read.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 fs/ext4/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6480e763080f..c04a09b51742 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -40,6 +40,7 @@
 #include <linux/crc16.h>
 #include <linux/dax.h>
 #include <linux/cleancache.h>
+#include <linux/nospec.h>
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
 
@@ -5559,6 +5560,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 	if (path->dentry->d_sb != sb)
 		return -EXDEV;
 	/* Journaling quota? */
+	type = array_index_nospec(type, EXT4_MAXQUOTAS);
 	if (EXT4_SB(sb)->s_qf_names[type]) {
 		/* Quotafile not in fs root? */
 		if (path->dentry->d_parent != sb->s_root)
-- 
2.17.1

