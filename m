Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CB1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AE020825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="UXBwNSKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AE020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeKJDLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:11:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39744 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbeKJDLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:11:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id n11-v6so1222691pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 09:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nd0cA+yM6Av4V6wqijD6LgdHe4+Oid5ajAvxjUtf+rA=;
        b=UXBwNSKAo+XBhLY45nOdli03Zi7oqHiaJ4UKo8GRcZZchtCior7J+bgDcNkEwpVZQZ
         b86eGN9DOGXKlMS8ul/DfBWxxNoQTluIYIZtoYM2PLOMerAs5sb4ZK1D73QvasMcrc/T
         64etc7N8PfgCpjcrsViX9z0tJtzDqQjicwuEeumVwcYpO+JCzVqsw16AtGFX12utPqOq
         BkYqo6vm2vta6JCTSaTE0uklUUCHzcOqmDHa6PyemcE+d4S+KGQqK+vnafrek1AMM9F7
         bYjAZzuNSo27BhkWx5UM22+lkb1J2gSU9aJSQdiBXE21TnR83NQXPp4xKDCQ0jgxfKNK
         SV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nd0cA+yM6Av4V6wqijD6LgdHe4+Oid5ajAvxjUtf+rA=;
        b=cjASzc4zmVmmxLlS44YwLEerCj2nNhqVhr8PN+lhkpseVofh/mij/PYWthDPpIVN3t
         Bfu9JCQJ+VgjONh7Jh116eY7KTzOptHhLCBZ96vglNpfFOleHy9deUVZSHL7eFcRA0UO
         PxAI9hS1vVF1igt+Ed/Uk7sw1CygYf5Ae4bJgrlpy2xjYHfnHhILls0aQwu60D/22oUq
         fxFFeYmbieabS/Ytt4Yw97+6iHaysxGQpcMJWCFwftzy5oa67LJTXAfHqveowrm1fX7z
         zuuXhb9Uv0eDNGCX98YG47+716NzAdfwkt1pxGGm8eb5K/o1oJPvwGxuxAUcn0u/fFEo
         NATg==
X-Gm-Message-State: AGRZ1gLvSA2PJIov+I+p4bl7THPCt4Xyl74sxiWfoQao4Q4lAKm3TMaS
        8S7Y+d5xPvWCMsKYJClSEqFu3Z7smlE=
X-Google-Smtp-Source: AJdET5clZ312Spf6uJDO8hzfMIwXQGIdSHKgHQTArFjvrxR8G8sEtyYbnbrdhU1SwVNDD7ZEu/6ijA==
X-Received: by 2002:a63:e54:: with SMTP id 20-v6mr7599002pgo.369.1541784604179;
        Fri, 09 Nov 2018 09:30:04 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id 69sm2124759pgg.86.2018.11.09.09.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 09:30:03 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@android.com
Subject: [PATCH v9 1/2] overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
Date:   Fri,  9 Nov 2018 09:29:52 -0800
Message-Id: <20181109172955.49832-1-salyzyn@android.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assumption never checked, should fail if the mounter creds are not
sufficient.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
---
v8 + v9:
- rebase

v7:
- This time for realz

v6:
- rebase

v5:
- dependency of "overlayfs: override_creds=off option bypass creator_cred"

 fs/overlayfs/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index efd372312ef1..3ac9dc8f6cc0 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -163,6 +163,9 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
 	if (!uuid_equal(&fh->uuid, &mnt->mnt_sb->s_uuid))
 		return NULL;
 
+	if (!capable(CAP_DAC_READ_SEARCH))
+		return ERR_PTR(-EPERM);
+
 	bytes = (fh->len - offsetof(struct ovl_fh, fid));
 	real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
 				  bytes >> 2, (int)fh->type,
-- 
2.19.1.930.g4563a0d9d0-goog

