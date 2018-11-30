Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF330C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27CC2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27CC2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeK3Rkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:40:53 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:53278 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbeK3Rkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:40:53 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 320C628903D7A267F225;
        Fri, 30 Nov 2018 14:32:36 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAU6WVKr048891;
        Fri, 30 Nov 2018 14:32:31 +0800 (GMT-8)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018113014330853-13898659 ;
          Fri, 30 Nov 2018 14:33:08 +0800 
From:   Cheng Lin <cheng.lin130@zte.com.cn>
To:     mcgrof@kernel.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn, Cheng Lin <cheng.lin130@zte.com.cn>
Subject: [PATCH] proc/sysctl: fix return error for proc_doulongvec_minmax
Date:   Fri, 30 Nov 2018 14:35:17 +0800
Message-Id: <1543559717-27534-1-git-send-email-cheng.lin130@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-30 14:33:08,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-30 14:32:15,
        Serialize complete at 2018-11-30 14:32:15
X-MAIL: mse01.zte.com.cn wAU6WVKr048891
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the number of input parameters is less than the total
parameters, an INVAL error will be returned.

This patch ensure no error returned in this condition, just
like other interfaces do.

Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
---
 kernel/sysctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5fc724e..9ee261f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2779,6 +2779,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 			bool neg;
 
 			left -= proc_skip_spaces(&p);
+			if (!left)
+				break;
 
 			err = proc_get_long(&p, &left, &val, &neg,
 					     proc_wspace_sep,
-- 
1.8.3.1

