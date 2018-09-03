Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CB2C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C4220779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C4220779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeICVMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:12:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36310 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbeICVMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:12:19 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5274DCF3;
        Mon,  3 Sep 2018 16:51:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 24/56] cachefiles: Wait rather than BUGing on "Unexpected object collision"
Date:   Mon,  3 Sep 2018 18:49:14 +0200
Message-Id: <20180903164925.298388018@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>

[ Upstream commit c2412ac45a8f8f1cd582723c1a139608694d410d ]

If we meet a conflicting object that is marked FSCACHE_OBJECT_IS_LIVE in
the active object tree, we have been emitting a BUG after logging
information about it and the new object.

Instead, we should wait for the CACHEFILES_OBJECT_ACTIVE flag to be cleared
on the old object (or return an error).  The ACTIVE flag should be cleared
after it has been removed from the active object tree.  A timeout of 60s is
used in the wait, so we shouldn't be able to get stuck there.

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
Signed-off-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cachefiles/namei.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -193,7 +193,6 @@ wait_for_old_object:
 		pr_err("\n");
 		pr_err("Error: Unexpected object collision\n");
 		cachefiles_printk_object(object, xobject);
-		BUG();
 	}
 	atomic_inc(&xobject->usage);
 	write_unlock(&cache->active_lock);


