Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5263C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748C12147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692325;
	bh=hGd9f+HHcKS8p9dpJcPxPMa8efylS7K4Jgslw/GpUuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I6ebFemXadUqKzxDw33lXDk5EodjUuS3HeQtal2TJw5JmBwEoSg/Xufe54PAZ5+xP
	 lM4bOhFbekOIUux6KjFsQ4yCZQ+6Kecxda3o6pdeAVT8kfS7iOLG6m5Wl5eDhiXxjW
	 a4sp30HH5or/BF3hrKl9gHaWruyDXnKC/NPbXuPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbfA1QSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:18:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732969AbfA1QSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:18:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C6D2175B;
        Mon, 28 Jan 2019 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692319;
        bh=hGd9f+HHcKS8p9dpJcPxPMa8efylS7K4Jgslw/GpUuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wLDLreN6IDqJqeAZjdN/icbWlLwbwaDNEn5cYkK3NG5YPhdURG1YsL0dyO3cggo75
         GXL9fPP5f2J3Iv/bU7zeH+fH63gseqwMgzrrTOYTIyN6XTG7W3V3PEeI5+u1D1OTa4
         ZE6dHdwOp4EQnYmIm+kUD2JyI0wFP0Mw8u/Dxugs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 151/170] cgroup: fix parsing empty mount option string
Date:   Mon, 28 Jan 2019 11:11:41 -0500
Message-Id: <20190128161200.55107-151-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit e250d91d65750a0c0c62483ac4f9f357e7317617 ]

This fixes the case where all mount options specified are consumed by an
LSM and all that's left is an empty string. In this case cgroupfs should
accept the string and not fail.

How to reproduce (with SELinux enabled):

    # umount /sys/fs/cgroup/unified
    # mount -o context=system_u:object_r:cgroup_t:s0 -t cgroup2 cgroup2 /sys/fs/cgroup/unified
    mount: /sys/fs/cgroup/unified: wrong fs type, bad option, bad superblock on cgroup2, missing codepage or helper program, or other error.
    # dmesg | tail -n 1
    [   31.575952] cgroup: cgroup2: unknown option ""

Fixes: 67e9c74b8a87 ("cgroup: replace __DEVEL__sane_behavior with cgroup2 fs type")
[NOTE: should apply on top of commit 5136f6365ce3 ("cgroup: implement "nsdelegate" mount option"), older versions need manual rebase]
Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 109c32c56de7..21bbfc09e395 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1692,7 +1692,7 @@ static int parse_cgroup_root_flags(char *data, unsigned int *root_flags)
 
 	*root_flags = 0;
 
-	if (!data)
+	if (!data || *data == '\0')
 		return 0;
 
 	while ((token = strsep(&data, ",")) != NULL) {
-- 
2.19.1

