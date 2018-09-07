Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC79C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06032083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06032083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeIHCMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:12:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbeIHCMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:12:25 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 10B6AED1;
        Fri,  7 Sep 2018 21:29:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.14 71/89] Revert "UBIFS: Fix potential integer overflow in allocation"
Date:   Fri,  7 Sep 2018 23:10:05 +0200
Message-Id: <20180907210900.763002018@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 08acbdd6fd736b90f8d725da5a0de4de2dd6de62 upstream.

This reverts commit 353748a359f1821ee934afc579cf04572406b420.
It bypassed the linux-mtd review process and fixes the issue not as it
should.

Cc: Kees Cook <keescook@chromium.org>
Cc: Silvio Cesare <silvio.cesare@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/journal.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1283,11 +1283,10 @@ static int truncate_data_node(const stru
 			      int *new_len)
 {
 	void *buf;
-	int err, compr_type;
-	u32 dlen, out_len, old_dlen;
+	int err, dlen, compr_type, out_len, old_dlen;
 
 	out_len = le32_to_cpu(dn->size);
-	buf = kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
+	buf = kmalloc(out_len * WORST_COMPR_FACTOR, GFP_NOFS);
 	if (!buf)
 		return -ENOMEM;
 


