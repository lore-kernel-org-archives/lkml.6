Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6927C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D9C214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D9C214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeIZTIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:08:30 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37669 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIZTIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:08:30 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N7RHv-1fhlp61MVh-017q2Q; Wed, 26 Sep 2018 14:55:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: fix build warning without DEBUGFS
Date:   Wed, 26 Sep 2018 14:54:49 +0200
Message-Id: <20180926125536.2125929-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:CTDgeXKpqxsHvolkz9QqH9ftySROsyuGHCVHObrgLlz+xzs8bir
 E9L9fQ+mMlTvOTsz2OKGl5J8i+ODoviAeo3OtU29WYcxDmYVlnhazC0irNBPpNzDT/e8BF/
 c+ew6/5nGbyA/Q15p5jtP67tkMqUL8KsP2rXxQINWcf0jOADcMtdqMQyrKWIL7wjhovQ84N
 QELEQGCj19+0wlyG//jVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3iufRyDZMK4=:H7qM8xBFAxJVvEONF0FCDb
 DCvQOnWYCFgwHuiG+1YTKiW/e+Ssape8H/pnvZj+aOzbDfSxZxdWLT47NYN+vQCtoTU0Xkx3Z
 nDqmb2qo1zpiTIq63RuY/e86L5xnZyInMZDbaNMl7uism26xyT3+AVxEYvZFnrCz+BclI/3r2
 RdUV2l/Su46ME9DAbzlmSMWh5FdxerrqP0J2FvfzT6VqzxhRyxcRT84/qsnxuG/3F+1iC3awH
 ZPvl2PBn1Ypc5dD/NUN+sWm8Fz27Fx1EXHE6bsrDbkjm4wIIoYCRV95/NCbyouaGjf4ODIZ5C
 vw5fwDobk1G3u98i0SsqLKYYPb8JDyhjcwxiyNMHDeG0LnVY/FmcYK9qhHZ3VckZ6HDlYHvzW
 /5FQ/CS40ZmwkfQyIni8Os9ihRZfGqZLrtBc4AAxK5cyHbz4omuPuA2+yPAd2ZPMY8EQF9KX4
 qRlEwTpKs/n5oatsaGPVsOaSVN6NX2AX7jZuCjFz3IS4H0bLBy9tWRYjMHfjsomZml699iVRc
 IVlEYLjJFOjBKKzgBnqfU4SvTSYr4Cg3T6oI74p6Gt+LOm00St6o5A7sfoya/vhQx01vhtp0+
 lO85cPY0WvtEC955HLeE6T+scmd6xuhEqc66wGzajgLzppqVKmZi5o/z5tCpvnFNxQk3VdFBM
 xGV5w88N11oXFGX04QAm06ya06SHgwVP9kqRY4+zudkPlGMZiM8xubY9FvbWcoEAkT3w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The icc_debugfs_dir variable is only used inside of an #ifdef
and should be moved into the same to avoid a harmless warning:

drivers/interconnect/core.c:26:23: error: 'icc_debugfs_dir' defined but not used [-Werror=unused-variable]

Fixes: d54599e06b06 ("interconnect: Allow endpoints translation via DT")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/interconnect/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 2740f1a441d8..2d8709cf59a4 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -23,7 +23,6 @@
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_provider_list);
 static DEFINE_MUTEX(icc_lock);
-static struct dentry *icc_debugfs_dir;
 
 /**
  * struct icc_req - constraints that are attached to each node
@@ -54,6 +53,8 @@ struct icc_path {
 
 #ifdef CONFIG_DEBUG_FS
 
+static struct dentry *icc_debugfs_dir;
+
 static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
 {
 	if (!n)
-- 
2.18.0

