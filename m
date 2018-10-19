Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7931EECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A3220843
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A3220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJSWqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:46:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38000 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeJSWqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:46:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id 193-v6so3917523wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 07:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HU0R7KVf1xoioTYJzHVw3MUGocV2f9Bu+ekPmQEz7Vg=;
        b=GszPjLtcJhnSw3x6KeEV16rf7vjCZ6O2OvMMBpYuXAUID9b0zDHJrtS2IMHzdH9zjw
         BmOgb5VfzYlLZ6bUxPaEEPX6Ij2cbuYo2VFl6nAJtZXhZZvZ0LZdYzLvBF/RYCqx752S
         7EdudYcRtyPxjcpdvgT+/NTyIJojkJIpIzVwtbupRqw81mvPTV31bt+zIrJq/Gb6ghHe
         7ZafSvA5fr+Jl0+6H/qpFfdCQc0xQ7YD2OMQBLNjXaJt17KFxsjp6I3dF8L+FopcZ0sP
         8uRpMHFIqsVP7zmPT+rMw9fJBEzq387ZmcVlKLfSFeaOcAX0SrPZJZCjJi8A7nBWkWl6
         EeJg==
X-Gm-Message-State: ABuFfohmW6qQ+weqWtBqJ6vbjc9EGBCxrH5GMIfO1vzAnfBwITg1j2jS
        Za1KVUH5uKC/nu9+y3YYfmDBHg==
X-Google-Smtp-Source: ACcGV63citd/TL8wF2EqX8hL279O3gAwa3XMG0gQj31gHy3coq89QtHAnwxIj3FVLH+bWK4xYFz3/w==
X-Received: by 2002:a1c:2bc3:: with SMTP id r186-v6mr5412645wmr.51.1539959978481;
        Fri, 19 Oct 2018 07:39:38 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x139-v6sm7251879wme.3.2018.10.19.07.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 07:39:37 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 6/5] statx: add STATX_RESULT_MASK flag
Date:   Fri, 19 Oct 2018 16:39:32 +0200
Message-Id: <20181019143932.6697-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This request_mask flag indicates that the caller is interested in the
result_mask.  At the moment all ->getattr() callers discard the result mask
except sys_statx().

FUSE needs this, because it uses legacy inode initialization, that doesn't
return a result_mask, so needs a refresh when caller asks for it with
statx().

It might make sense later to promote this to a proper statx mask flag and
return it in stx_mask to userspace.  This needs some more work to make sure
only filesystems set this flag where the result_mask is valid (e.g. NFS
wouldn't be able to set it, since it doesn't query the server about
supported fields).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/stat.c            | 1 +
 include/linux/stat.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index b46583df70d4..0b71e5bdbc6b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -576,6 +576,7 @@ SYSCALL_DEFINE5(statx,
 	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
 		return -EINVAL;
 
+	mask |= STATX_RESULT_MASK;
 	error = vfs_statx(dfd, filename, flags, &stat, mask);
 	if (error)
 		return error;
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 765573dc17d6..65448b1163d3 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -21,6 +21,12 @@
 
 #define KSTAT_QUERY_FLAGS (AT_STATX_SYNC_TYPE)
 
+/*
+ * This is an internal mask value, meaning: caller is interested in
+ * .result_mask, i.e. it's sys_statx().
+ */
+#define STATX_RESULT_MASK STATX__RESERVED
+
 struct kstat {
 	u32		result_mask;	/* What fields the user got */
 	umode_t		mode;
-- 
2.14.3

