Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0C9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0104208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al6F+mnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0104208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeH1DE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:04:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46714 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeH1DE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id k14-v6so421377edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3EDnZlIeAFOJ8WEIsXbF6U8YYDDktTGw02/653a2pOg=;
        b=al6F+mnzWoZRjPPKKGXpJ8Gm3TXD/W65I2nh2b++L1qyIGeQNYeWQ6l13xMQRvFpOP
         NfY2aQ2PxTEwapzgH2yBPvmGPw2SnnngrhmNtO6K7Sa0ACV8ODPKPniSNAI6qUx9fPiw
         G43SEO5E6WmMonKzGsakU5PwbmM2b256lNbKBu7fQSlMWGAyaJLn9O1U5LsYnK3fGJtv
         qZ8ud+vb8MrJ3YuVi8OW8mMRZbB0smuyMOn5eSDA549hGP+EMhkhpLLgHu/hePUS6HkB
         Oeion7JjwR6HPnOBdhZSyMfcDoptdM8+c4AOHVp5n1vRCotqGm57RQ8VZevXjg/TX2Jy
         1WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3EDnZlIeAFOJ8WEIsXbF6U8YYDDktTGw02/653a2pOg=;
        b=fVYeb1HMX+qnUl36wfvydAqVVWAMWovibwGYwl/JJ9eMMxnKL+sxz3Ksifwm+OSs9N
         rSM0Ya2cIBppyMglc0La8eiSnEA4IzkihuDMmdTUOOq9nSCzhePTu1iZLzqRfgchcfv3
         eovezO3ab9WZ9VEJztHW84BiAMxn9g2ldO8ucUgf8Fvz5ZXvk7Y4Ysmw9poQIaRM3YI3
         /wt24lTq+Lw5x6OYndv/WB57GyAau4JBtg1pqwDdqqdRBRxa2/pnBosZ9T+w1pXOmgNY
         OckRtioWIxxtkZdcWpkB82AM7ubghMMgmsQKufAB6hpBB9IAGG+SJShbeQvv2ctSPVAv
         SRwQ==
X-Gm-Message-State: APzg51D9LkAaO0EWK6Y0778XCeYfkfbyL4TPuEnVrT2TlTZMpvI+qDBR
        8xEUFmHfKtp9KLXdCnHoMQ==
X-Google-Smtp-Source: ANB0VdZdDTn9x1BxHFAc0Pxoj6jsxsO1s0JL3mmqmacFGdNPJkSSRYzqb9TfrBD29m36Zn0uL04A7w==
X-Received: by 2002:a50:a402:: with SMTP id u2-v6mr18564439edb.237.1535411740048;
        Mon, 27 Aug 2018 16:15:40 -0700 (PDT)
Received: from localhost.localdomain (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id u3-v6sm173918edo.44.2018.08.27.16.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:15:39 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 09/13] proc: convert dentry flushing on exit to _print_integer()
Date:   Tue, 28 Aug 2018 02:14:59 +0300
Message-Id: <20180827231503.26899-9-adobriyan@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benchmark fork+exit+waitpid 2^16 times:

	6.579161299 seconds time elapsed ( +-  0.24% )
	6.482729157 seconds time elapsed ( +-  0.42% )

	-1.5%

Dentry flushing is very small part of exit(2), effects should be more
visible on a tiny 1-page process which doesn't uses libc.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/base.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 17666bd61ac8..79d2f7d72ad1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3022,11 +3022,11 @@ static const struct inode_operations proc_tgid_base_inode_operations = {
 static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
 {
 	struct dentry *dentry, *leader, *dir;
-	char buf[10 + 1];
+	char buf[10];
 	struct qstr name;
 
-	name.name = buf;
-	name.len = snprintf(buf, sizeof(buf), "%u", pid);
+	name.name = _print_integer_u32(buf + sizeof(buf), pid);
+	name.len = buf + sizeof(buf) - (char *)name.name;
 	/* no ->d_hash() rejects on procfs */
 	dentry = d_hash_and_lookup(mnt->mnt_root, &name);
 	if (dentry) {
@@ -3037,8 +3037,8 @@ static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
 	if (pid == tgid)
 		return;
 
-	name.name = buf;
-	name.len = snprintf(buf, sizeof(buf), "%u", tgid);
+	name.name = _print_integer_u32(buf + sizeof(buf), tgid);
+	name.len = buf + sizeof(buf) - (char *)name.name;
 	leader = d_hash_and_lookup(mnt->mnt_root, &name);
 	if (!leader)
 		goto out;
@@ -3049,8 +3049,8 @@ static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
 	if (!dir)
 		goto out_put_leader;
 
-	name.name = buf;
-	name.len = snprintf(buf, sizeof(buf), "%u", pid);
+	name.name = _print_integer_u32(buf + sizeof(buf), pid);
+	name.len = buf + sizeof(buf) - (char *)name.name;
 	dentry = d_hash_and_lookup(dir, &name);
 	if (dentry) {
 		d_invalidate(dentry);
-- 
2.16.4

