Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D125C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62628217C7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62628217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbeHDLHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:07:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeHDLHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:07:20 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 50D03BB3;
        Sat,  4 Aug 2018 09:07:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anatoly Pugachev <matorola@gmail.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 021/124] disable loading f2fs module on PAGE_SIZE > 4KB
Date:   Sat,  4 Aug 2018 11:00:10 +0200
Message-Id: <20180804082703.228796761@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anatoly Pugachev <matorola@gmail.com>

[ Upstream commit 4071e67cffcc5c2a007116a02437471351f550eb ]

The following patch disables loading of f2fs module on architectures
which have PAGE_SIZE > 4096 , since it is impossible to mount f2fs on
such architectures , log messages are:

mount: /mnt: wrong fs type, bad option, bad superblock on
/dev/vdiskb1, missing codepage or helper program, or other error.
/dev/vdiskb1: F2FS filesystem,
UUID=1d8b9ca4-2389-4910-af3b-10998969f09c, volume name ""

May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Invalid
page_cache_size (8192), supports only 4KB
May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Can't find valid F2FS
filesystem in 1th superblock
May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Invalid
page_cache_size (8192), supports only 4KB
May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Can't find valid F2FS
filesystem in 2th superblock
May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Invalid
page_cache_size (8192), supports only 4KB

which was introduced by git commit 5c9b469295fb6b10d98923eab5e79c4edb80ed20

tested on git kernel 4.17.0-rc6-00309-gec30dcf7f425

with patch applied:

modprobe: ERROR: could not insert 'f2fs': Invalid argument
May 28 01:40:28 v215 kernel: F2FS not supported on PAGE_SIZE(8192) != 4096

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/super.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1566,6 +1566,12 @@ static int __init init_f2fs_fs(void)
 {
 	int err;
 
+	if (PAGE_SIZE != F2FS_BLKSIZE) {
+		printk("F2FS not supported on PAGE_SIZE(%lu) != %d\n",
+				PAGE_SIZE, F2FS_BLKSIZE);
+		return -EINVAL;
+	}
+
 	f2fs_build_trace_ios();
 
 	err = init_inodecache();


