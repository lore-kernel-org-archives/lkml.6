Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF739C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8088520855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8088520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbeIHC1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:27:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57720 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeIHC1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:27:16 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BE8E21028;
        Fri,  7 Sep 2018 21:44:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 3.18 22/29] ubifs: Fix memory leak in lprobs self-check
Date:   Fri,  7 Sep 2018 23:10:43 +0200
Message-Id: <20180907210911.026574141@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210909.523240901@linuxfoundation.org>
References: <20180907210909.523240901@linuxfoundation.org>
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

From: Richard Weinberger <richard@nod.at>

commit eef19816ada3abd56d9f20c88794cc2fea83ebb2 upstream.

Allocate the buffer after we return early.
Otherwise memory is being leaked.

Cc: <stable@vger.kernel.org>
Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/lprops.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/ubifs/lprops.c
+++ b/fs/ubifs/lprops.c
@@ -1091,10 +1091,6 @@ static int scan_check_cb(struct ubifs_in
 		}
 	}
 
-	buf = __vmalloc(c->leb_size, GFP_NOFS, PAGE_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
 	/*
 	 * After an unclean unmount, empty and freeable LEBs
 	 * may contain garbage - do not scan them.
@@ -1113,6 +1109,10 @@ static int scan_check_cb(struct ubifs_in
 		return LPT_SCAN_CONTINUE;
 	}
 
+	buf = __vmalloc(c->leb_size, GFP_NOFS, PAGE_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
 	sleb = ubifs_scan(c, lnum, 0, buf, 0);
 	if (IS_ERR(sleb)) {
 		ret = PTR_ERR(sleb);


