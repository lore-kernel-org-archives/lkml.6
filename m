Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BD1C43615
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F322C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bKD7DZ7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F322C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeHVMT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:19:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37859 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbeHVMT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:19:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so955530wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Y7bygxqp+oUBKrjqJLXJ+RdXwP95pqwW6urLGjhbdH8=;
        b=bKD7DZ7TtzPUiW1okzqVUqtcO4boWKs+MKO1LeS3umH9gboifQBhhuCzw7zaQAKqCN
         z5t1O+N5sGt9cuX8MXA7ODRAGw5/9dQwOl/EMBCzU16H5EeL3k9pcodmMCe4+6qqjT8T
         a9tlonaRvyo+aOWM7cxAC2AfiDcbqd2Q2Norw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Y7bygxqp+oUBKrjqJLXJ+RdXwP95pqwW6urLGjhbdH8=;
        b=kQAyw0dbYVJoi6YYuWBZjnuU8qAbRlSRb1Lm0Kzhv5CL0rYVcm9WAQTWZEeZ68RSv4
         MSoqZBahfP400LcCZish1WdQpR8lUiy8JsP1g4clNMBN9s3DsVXBoOKxRxrUXdbEgKMa
         vScu02yicS8tZ9YSIx9i+QTE1XSLjZNP29NieM7y0u1kBehyDcWHncYrKIfqQwpAsNv8
         4wCR94u5Wdf8bUaW6j+J9M4c11DNqN1UjNqHCoxdwEqY7CslZL/Knvu00rZZhLSaH4P9
         8A1NHl5ZtUwh8TsaROK1u+iAcuzLcSm+NkV91bgFPhg0uaPjtxq/k8WyEOH+5dTuRO7k
         xdbg==
X-Gm-Message-State: AOUpUlHXQFy0fiM+k+zL1VyYewg/jV0QSUa7WO8I+Cm/qmJel4wrErgc
        /V42Sj2yf1eySLfKdcTUXkdW3A==
X-Google-Smtp-Source: AA+uWPxuaht3b80DXZTFzjT3khNZ4CWls14WKBN/2KLgvWMsLXpxYHs0fxsxxKVSxOyuTVSHsAZT+Q==
X-Received: by 2002:adf:dc4c:: with SMTP id m12-v6mr36769160wrj.84.1534928130218;
        Wed, 22 Aug 2018 01:55:30 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id l18-v6sm1728670wru.75.2018.08.22.01.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 01:55:29 -0700 (PDT)
Date:   Wed, 22 Aug 2018 10:55:22 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCH] ovl: set I_CREATING on inode being created
Message-ID: <20180822085522.GA14354@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...otherwise there will be list corruption due to inode_sb_list_add() being
called for inode already on the sb list.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: e950564b97fd ("vfs: don't evict uninitialized inode")
---
This missed the 4.19 overlay pull request, because it fixes a bug
introduced by patch not in said pull (buggy patch is also mine,
incidentally).

 fs/overlayfs/dir.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -603,6 +603,10 @@ static int ovl_create_object(struct dent
 	if (!inode)
 		goto out_drop_write;
 
+	spin_lock(&inode->i_lock);
+	inode->i_state |= I_CREATING;
+	spin_unlock(&inode->i_lock);
+
 	inode_init_owner(inode, dentry->d_parent->d_inode, mode);
 	attr.mode = inode->i_mode;
 

