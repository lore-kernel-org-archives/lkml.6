Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F9AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF68F20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF68F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeIHB5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:57:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbeIHB5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:57:41 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E7F7BFEB;
        Fri,  7 Sep 2018 21:14:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com,
        Jun Piao <piaojun@huawei.com>,
        Yiwen Jiang <jiangyiwen@huawei.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 4.18 053/145] net/9p/client.c: version pointer uninitialized
Date:   Fri,  7 Sep 2018 23:08:39 +0200
Message-Id: <20180907210908.925047681@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Bortoli <tomasbortoli@gmail.com>

commit 7913690dcc5e18e235769fd87c34143072f5dbea upstream.

The p9_client_version() does not initialize the version pointer. If the
call to p9pdu_readf() returns an error and version has not been allocated
in p9pdu_readf(), then the program will jump to the "error" label and will
try to free the version pointer. If version is not initialized, free()
will be called with uninitialized, garbage data and will provoke a crash.

Link: http://lkml.kernel.org/r/20180709222943.19503-1-tomasbortoli@gmail.com
Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com
Reviewed-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Yiwen Jiang <jiangyiwen@huawei.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Ron Minnich <rminnich@sandia.gov>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/9p/client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -958,7 +958,7 @@ static int p9_client_version(struct p9_c
 {
 	int err = 0;
 	struct p9_req_t *req;
-	char *version;
+	char *version = NULL;
 	int msize;
 
 	p9_debug(P9_DEBUG_9P, ">>> TVERSION msize %d protocol %d\n",


