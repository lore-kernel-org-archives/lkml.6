Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E321C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F36222A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900654;
	bh=mtvvRI3wp9+pV9E1Y73ZMdakdEsymN7zWb1ePqQQc88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EP2ytLxwPyirhXDWnlmUMgTxzhaa6ZNbG4J927IbQeGOOMEl5aIiW1v4DQBw5/bjv
	 7sMwr9/ZlluIEJHtBzVxUeXo8WiLYo8iwQ1FW3ur1IM1wMBKXrsA/2vWBEfySzjMyp
	 7JD8rIXC8xNTotxFUlGqKJB57qkC6/ljDXQDfBWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbfBKOdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730648AbfBKOda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:33:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 394C520844;
        Mon, 11 Feb 2019 14:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895609;
        bh=mtvvRI3wp9+pV9E1Y73ZMdakdEsymN7zWb1ePqQQc88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJHYGCZsSUoT3jPtleyz682uylD2eP8AwRLdMv4bMRWFJRu1QIWwhOoKeqNbSt4EZ
         9KhbrVE0hqDNJeR5vCP57ZO0iSkfPSTyu6cBc/B1YB31dt5VBKyVwtfDUVkVhsh/9S
         uhsdphheWZf6hdKn/WUYA0n9Fse8JzZN7ZGNHV1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 262/352] cgroup: fix parsing empty mount option string
Date:   Mon, 11 Feb 2019 15:18:09 +0100
Message-Id: <20190211141903.715636746@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 1f84977fab47..498c6bcf992a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1744,7 +1744,7 @@ static int parse_cgroup_root_flags(char *data, unsigned int *root_flags)
 
 	*root_flags = 0;
 
-	if (!data)
+	if (!data || *data == '\0')
 		return 0;
 
 	while ((token = strsep(&data, ",")) != NULL) {
-- 
2.19.1



