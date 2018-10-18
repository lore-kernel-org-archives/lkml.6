Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD265ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6632098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6632098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeJRVMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:12:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35562 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbeJRVMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:12:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so33624735wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 06:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OtkmpEPbA/uDUjnzZb7wK0E7hpxNB+LznWScKZ/Q3fg=;
        b=CaTYJrj3TOSFl+iBUaqkiLNp37bAfpWz35e5ZbgU8JLSpIIdcElR1qLYLvsKNnYHih
         pO1f471Zni7KPJvttkQoCM7JYyEIkHSVD9EQGIQu40eKZ5cn0bzJ2QNRey3lDUO3caMX
         9vgHE8bewQj1shxBr15CXBrYaToknZuPfChPitnilT4+t9Wh4rXppmfIT1Ausz7KMYb+
         D5tklAwZS6+t3fhE1HOAdIlGO28o3DJi8ijGQqynjpMfjw4AAONnQUD9hFqaH9SSGbL1
         0SCUSy18LUwb1pfcnThEGdBun9MkwIc8g3dmTb+E2VcoNRqJgWFe4ASXcCxa/7e7Icdt
         JlbA==
X-Gm-Message-State: ABuFfogGOt3B8faEfX/2FjHt3PNzsnWDDr1LjJz1To9GpCJ1TlhGz5mu
        aRgDHYSLWCOx9cQ0pSdXLj8l4A==
X-Google-Smtp-Source: ACcGV63MdVp0Ch+GYIZzSyLP1v25GFOerViqQPcunER/yuj6bcxIZK32VFsRZSrw7vUVAxikIa5yFA==
X-Received: by 2002:a5d:4292:: with SMTP id k18-v6mr27993795wrq.225.1539868293844;
        Thu, 18 Oct 2018 06:11:33 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id u5-v6sm22246965wru.16.2018.10.18.06.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 06:11:33 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 3/3] statx: add STATX_ATTRIBUTES flag
Date:   Thu, 18 Oct 2018 15:11:25 +0200
Message-Id: <20181018131125.6303-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181018131125.6303-1-mszeredi@redhat.com>
References: <20181018131125.6303-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FUSE will want to know if stx_attributes is interesting or not, because
there's a non-zero cost of retreiving it.

This is more of a "want" flag, since stx_attributes_mask already indicates
whether we "got" stx_attributes or not.  So for now we can just deal with
this flag in the generic code.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
---
 fs/stat.c                       | 3 +++
 include/uapi/linux/stat.h       | 1 +
 samples/statx/test-statx.c      | 2 +-
 tools/include/uapi/linux/stat.h | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index 8d297a279991..6bf86d57e2e3 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -535,6 +535,9 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_size = stat->size;
 	tmp.stx_blocks = stat->blocks;
 	tmp.stx_attributes_mask = stat->attributes_mask;
+	/* Having anything in attributes_mask means attributes are valid. */
+	if (tmp.stx_attributes_mask)
+		tmp.stx_mask |= STATX_ATTRIBUTES;
 	tmp.stx_atime.tv_sec = stat->atime.tv_sec;
 	tmp.stx_atime.tv_nsec = stat->atime.tv_nsec;
 	tmp.stx_btime.tv_sec = stat->btime.tv_sec;
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 370f09d92fa6..aef0aba5dfe7 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -148,6 +148,7 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
+#define STATX_ATTRIBUTES	0x00001000U	/* Want/got stx_attributes */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
diff --git a/samples/statx/test-statx.c b/samples/statx/test-statx.c
index e354048dea3c..deef9a68ff68 100644
--- a/samples/statx/test-statx.c
+++ b/samples/statx/test-statx.c
@@ -211,7 +211,7 @@ int main(int argc, char **argv)
 	struct statx stx;
 	int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;
 
-	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME;
+	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME | STATX_ATTRIBUTES;
 
 	for (argv++; *argv; argv++) {
 		if (strcmp(*argv, "-F") == 0) {
diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index 370f09d92fa6..aef0aba5dfe7 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -148,6 +148,7 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
+#define STATX_ATTRIBUTES	0x00001000U	/* Want/got stx_attributes */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.14.3

