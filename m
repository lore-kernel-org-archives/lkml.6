Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3B0C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0262151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0262151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404307AbeHGVKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:10:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33632 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733122AbeHGVKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:10:51 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ADE5FD0E;
        Tue,  7 Aug 2018 18:55:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shankara Pailoor <shankarapailoor@gmail.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 17/17] jfs: Fix inconsistency between memory allocation and ea_buf->max_size
Date:   Tue,  7 Aug 2018 20:51:53 +0200
Message-Id: <20180807172342.986953295@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172342.071526922@linuxfoundation.org>
References: <20180807172342.071526922@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shankara Pailoor <shankarapailoor@gmail.com>

commit 92d34134193e5b129dc24f8d79cb9196626e8d7a upstream.

The code is assuming the buffer is max_size length, but we weren't
allocating enough space for it.

Signed-off-by: Shankara Pailoor <shankarapailoor@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jfs/xattr.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -491,15 +491,17 @@ static int ea_get(struct inode *inode, s
 	if (size > PSIZE) {
 		/*
 		 * To keep the rest of the code simple.  Allocate a
-		 * contiguous buffer to work with
+		 * contiguous buffer to work with. Make the buffer large
+		 * enough to make use of the whole extent.
 		 */
-		ea_buf->xattr = kmalloc(size, GFP_KERNEL);
+		ea_buf->max_size = (size + sb->s_blocksize - 1) &
+		    ~(sb->s_blocksize - 1);
+
+		ea_buf->xattr = kmalloc(ea_buf->max_size, GFP_KERNEL);
 		if (ea_buf->xattr == NULL)
 			return -ENOMEM;
 
 		ea_buf->flag = EA_MALLOC;
-		ea_buf->max_size = (size + sb->s_blocksize - 1) &
-		    ~(sb->s_blocksize - 1);
 
 		if (ea_size == 0)
 			return 0;


