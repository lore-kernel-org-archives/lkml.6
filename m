Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AFBC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4555E214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896643;
	bh=Vmnu2LaRbmsB8ctH47yQrgFg2U5Kx0Tcc4IHtCbFmOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g+kK1dfA/lk+BNPPzS5MYXpI2pMuENy/D3DNyt2BSHCVjcZILGHN8C8naTZGsh73M
	 4SCgnvDCFNAaa1lm/9y1eP+9gBZxhi5KhJfO82HESynyuDd1tXA14uyu+15DKwH8lp
	 6kYcrP8pJAFhuSM15oZegSEI8VuzIRiQJ7/Fqa70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388143AbfBKOul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388113AbfBKOue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:50:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 451CD20700;
        Mon, 11 Feb 2019 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896633;
        bh=Vmnu2LaRbmsB8ctH47yQrgFg2U5Kx0Tcc4IHtCbFmOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWNHtUtKFyNrwqBDewGvnk5pNxtDS1VHth8JZnDEjeCxZs9Fo2Q78lhJaGHv1ioo0
         rDRc/EbsiAQtOLHf+lntSieJbfzJR3hjm9/tfFQjPONcyP3liqxP65bPQRxVnMCjbk
         RIr8utPjEA/4VNnv+vRG8V+RuZS/UXFEdzZwCi+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 222/313] cgroup: fix parsing empty mount option string
Date:   Mon, 11 Feb 2019 15:18:22 +0100
Message-Id: <20190211141908.074341297@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 1aa517908561..e578c3999970 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1743,7 +1743,7 @@ static int parse_cgroup_root_flags(char *data, unsigned int *root_flags)
 
 	*root_flags = 0;
 
-	if (!data)
+	if (!data || *data == '\0')
 		return 0;
 
 	while ((token = strsep(&data, ",")) != NULL) {
-- 
2.19.1



