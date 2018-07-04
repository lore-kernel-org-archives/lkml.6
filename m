Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D98C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9040321AA6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9040321AA6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbeGDOn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:43:58 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.97]:20404 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752622AbeGDOnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:43:52 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 5B84314C145
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jul 2018 09:43:51 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aj0ZfBS9DaSeyaj0ZfprWV; Wed, 04 Jul 2018 09:43:51 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=46300 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1faj0Y-000Gac-SP; Wed, 04 Jul 2018 09:43:50 -0500
Date:   Wed, 4 Jul 2018 09:43:49 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] dlm: use 64-bit arithmetic instead of 32-bit
Message-ID: <20180704144349.GA13170@embeddedor.com>
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
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1faj0Y-000Gac-SP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:46300
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 29
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix LL to constant 10000 in order to give the compiler
complete information about the proper arithmetic to use.

Notice that such constant is used in a context that expects an
expression of type s64 (64 bits, signed) and the following
expression is currently being evaluated using 32-bit arithmetic:

dlm_config.ci_timewarn_cs * 10000

Addresses-Coverity-ID: 200667 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/dlm/lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index cc91963..a3939b2 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1876,7 +1876,7 @@ void dlm_scan_timeout(struct dlm_ls *ls)
 				do_cancel = 1;
 
 			if ((lkb->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
-			    wait_us >= dlm_config.ci_timewarn_cs * 10000)
+			    wait_us >= dlm_config.ci_timewarn_cs * 10000LL)
 				do_warn = 1;
 
 			if (!do_cancel && !do_warn)
-- 
2.7.4

