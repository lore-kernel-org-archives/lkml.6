Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB3DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6A920657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6A920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeKBGx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:53:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58266 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeKBGx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:53:58 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1gIKpy-0008K0-DB
        for linux-kernel@vger.kernel.org; Thu, 01 Nov 2018 21:49:10 +0000
Received: by mail-io1-f72.google.com with SMTP id k9-v6so18707186ioj.18
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfcS/D8E2NVDSMMG2zN/Checw4lvvL0gTuc15nYTfSo=;
        b=sN+RZibsbwq4CfrZ0zqgInfKhRrvj/ivVX8DrqHEVBmFFigDBAgGXNFgEz5ygd7EKu
         R8XW7a53AlyXX98haY57kUHdF7vV2ZWsU6Wvq94g7CWggJIm5z8WEcnGfDYNK5LrTi9r
         ycNgNVtSd6RHEChEy2MVr43mrAWW4cG2ijI6wDrA1Y8C04ScW2ZeaEa5hxH7/KdbXBBe
         ULNsz3hl3LpcpSgly0A6KRFbSWdpOmBkf8skQ7Q4EcpmTzK4t3K/w3kBtIBvZBExcIRB
         Vt8IL2U8iEBg8iPSmHXHLJtDQRwKT1TuHvT4AqCxDezEq7Nrs+DMJ364Cqt4q+pyRHHi
         VF8A==
X-Gm-Message-State: AGRZ1gJfWKVhn0CU+22Had5ujLYNfOjjS7x5+Kx0LPEN6XlAPjBLENQ5
        Te7MmCLtBUjGWvC8JtYZ4wRsS3zIKISI57Sy9EagDVl5XZjBxt4mOUTKiC4MwiIuyfQE9uaZ7/A
        k7RaJuM07TcGCzETPpN8F9rUsy2QqClLPrJ4Reog77Q==
X-Received: by 2002:a02:a1cb:: with SMTP id o11-v6mr5094053jah.82.1541108948879;
        Thu, 01 Nov 2018 14:49:08 -0700 (PDT)
X-Google-Smtp-Source: AJdET5d3gaLKChjWegS4zR65Vvle9g3lwREu2tQNnuNxjRpAezX5+R1sKV/oUpo/g3vllPc4gpB2/w==
X-Received: by 2002:a02:a1cb:: with SMTP id o11-v6mr5094031jah.82.1541108948452;
        Thu, 01 Nov 2018 14:49:08 -0700 (PDT)
Received: from localhost ([2605:a601:ac7:2a20:7c8b:4047:a2ef:69cd])
        by smtp.gmail.com with ESMTPSA id k21-v6sm5266844iom.50.2018.11.01.14.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 14:49:07 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [RFC PATCH 4/6] shiftfs: translate uids using s_user_ns from lower fs
Date:   Thu,  1 Nov 2018 16:48:54 -0500
Message-Id: <20181101214856.4563-5-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101214856.4563-1-seth.forshee@canonical.com>
References: <20181101214856.4563-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not assume that ids from the lower filesystem are from
init_user_ns. Instead, translate them from that filesystem's
s_user_ns and then to the shiftfs user ns.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 fs/shiftfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/shiftfs.c b/fs/shiftfs.c
index 556594988dd2..226c03d8588b 100644
--- a/fs/shiftfs.c
+++ b/fs/shiftfs.c
@@ -613,6 +613,8 @@ static int shiftfs_getattr(const struct path *path, struct kstat *stat,
 	struct inode *reali = real->d_inode;
 	const struct inode_operations *iop = reali->i_op;
 	struct path newpath = { .mnt = path->dentry->d_sb->s_fs_info, .dentry = real };
+	struct user_namespace *from_ns = reali->i_sb->s_user_ns;
+	struct user_namespace *to_ns = inode->i_sb->s_user_ns;
 	int err = 0;
 
 	if (iop->getattr)
@@ -624,8 +626,8 @@ static int shiftfs_getattr(const struct path *path, struct kstat *stat,
 		return err;
 
 	/* transform the underlying id */
-	stat->uid = make_kuid(inode->i_sb->s_user_ns, __kuid_val(stat->uid));
-	stat->gid = make_kgid(inode->i_sb->s_user_ns, __kgid_val(stat->gid));
+	stat->uid = shift_kuid(from_ns, to_ns, stat->uid);
+	stat->gid = shift_kgid(from_ns, to_ns, stat->gid);
 	return 0;
 }
 
-- 
2.19.1

