Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42559C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED3A2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="KwdSnbpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED3A2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeH1Upz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:45:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41029 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeH1Upz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:45:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so970244pfk.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0CexIovvIoUkk1mBRlhD4MwFzMs0anqIHT31g/3XOo=;
        b=KwdSnbpfrf54n8IulUN1cxWu8rzOT/+8CfVP0p6e/RQzN0yymkANl/V2HbShoH8801
         aA4JuGYTFlxuA4MNAIfTDu/dslyed6B6doCOcJA0ltHu/1+TBeeUvpCpC6MTgVjT8H1U
         TsKZHpo3AEJj6cUHpOzNX2tqP+Bc/1tedi4ncedDv4A8pNLXhmeu+UxOtxMA+cNwJ9dF
         GCfs2swFjiJf2JAtMrtHcItHCw1blFM9e+Ckh0y/tb+7lq+MXY/CpofUCG4CeS6jt874
         ZVxx1yqrK4wwj7pasVNetNganYaiSZl6fFrPn8PwCrvZ2lH67Zf92cFPkRRh0ZydGsbD
         o8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0CexIovvIoUkk1mBRlhD4MwFzMs0anqIHT31g/3XOo=;
        b=RCCkmf7Ip6hsl7k4ezjR4LdBWDC/araqTx6H6tjJd3n2DxiYgwRHRROl9jKJDiwKTw
         o2RYGt+M3TETE8RobMwrZuVh7eXBlCrAyat++Ps22xVCM6h0Y2fZlgZv06u61Vnbt4ml
         PmmcSp10sOeed0yllSyGmX0pldN28aVGOuOdq5WEb8Q2D3gOrGEeSAyze20IrgL/Wwo9
         SP2xul4Pzc6jWiels/Fom0O8WeChn1Gg5Lf3okJI9l6Zhe/O5dDvtavVy5z+Gf9UalD9
         +fi6bjMsr2jnWegSZVUfabTbzROlSQDA+MP877birrGrWVuz11AtQzFYF4FKfUiVgA6M
         K3Aw==
X-Gm-Message-State: APzg51DUwP36QA8liP+EaL3aibl6qnsp7c7UJFV4DZqn1aq8Q+VADoTT
        C34t/dUpitxS0ceeV3nAsDBFbvEpnLUL2w==
X-Google-Smtp-Source: ANB0VdYDsCzV7vmjD08tdu8Ac3FXRv+v5WCRWn8VYmSA/cnLHM5T7Hp1X9akw4isHsoaB+dAIPVWuw==
X-Received: by 2002:a63:27c1:: with SMTP id n184-v6mr2291054pgn.298.1535475203580;
        Tue, 28 Aug 2018 09:53:23 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id 82-v6sm3270584pfw.159.2018.08.28.09.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 09:53:23 -0700 (PDT)
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
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v5 2/3] overlayfs: check CAP_MKNOD before issuing vfs_whiteout
Date:   Tue, 28 Aug 2018 09:53:16 -0700
Message-Id: <20180828165319.211563-1-salyzyn@android.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
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

v5
- dependency of "overlayfs: override_creds=off option bypass creator_cred"
---
 fs/overlayfs/overlayfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 7538b9b56237..bf3a80157d42 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -176,7 +176,7 @@ static inline int ovl_do_rename(struct inode *olddir, struct dentry *olddentry,
 
 static inline int ovl_do_whiteout(struct inode *dir, struct dentry *dentry)
 {
-	int err = vfs_whiteout(dir, dentry);
+	int err = capable(CAP_MKNOD) ? vfs_whiteout(dir, dentry) : -EPERM;
 	pr_debug("whiteout(%pd2) = %i\n", dentry, err);
 	return err;
 }
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

