Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D571DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6BB215B2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6BB215B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeHOQ2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:28:46 -0400
Received: from gateway30.websitewelcome.com ([192.185.193.11]:28670 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729287AbeHOQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:28:46 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 1A71C4749C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 08:36:34 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id pvy7fdbGLbXuJpvyLf1KrB; Wed, 15 Aug 2018 08:36:33 -0500
X-Authority-Reason: nr=8
Received: from [189.250.37.72] (port=57088 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fpvy6-001yoE-QT; Wed, 15 Aug 2018 08:36:10 -0500
Date:   Wed, 15 Aug 2018 08:36:08 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] statfs: fix potential Spectre v1
Message-ID: <20180815133608.GA27979@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.37.72
X-Source-L: No
X-Exim-ID: 1fpvy6-001yoE-QT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.37.72]:57088
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

user_params.request is indirectly controlled by user-space, hence leading
to a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

fs/statfs.c:908 __do_sys_fsinfo() warn: potential spectre issue
'fsinfo_buffer_sizes' [r]

Fix this by sanitizing user_params.request before using it to index
fsinfo_buffer_sizes

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/statfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/statfs.c b/fs/statfs.c
index f714f05..d74a60a 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -11,6 +11,7 @@
 #include <linux/compat.h>
 #include <linux/fsinfo.h>
 #include <linux/fs_parser.h>
+#include <linux/nospec.h>
 #include "internal.h"
 
 static int flags_by_mnt(int mnt_flags)
@@ -886,6 +887,8 @@ SYSCALL_DEFINE5(fsinfo,
 			return -EINVAL;
 		if (user_params.request >= FSINFO_ATTR__NR)
 			return -EOPNOTSUPP;
+		user_params.request = array_index_nospec(user_params.request,
+							 FSINFO_ATTR__NR);
 		params.at_flags = user_params.at_flags;
 		params.request = user_params.request;
 		params.Nth = user_params.Nth;
-- 
2.7.4

