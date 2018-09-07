Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CFBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB18C20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB18C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbeIHC1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:27:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57730 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeIHC1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:27:23 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 06A79F36;
        Fri,  7 Sep 2018 21:44:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 3.18 23/29] Revert "UBIFS: Fix potential integer overflow in allocation"
Date:   Fri,  7 Sep 2018 23:10:44 +0200
Message-Id: <20180907210911.087838848@linuxfoundation.org>
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
 fs/ubifs/journal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1101,7 +1101,7 @@ static int recomp_data_node(struct ubifs
 	int err, len, compr_type, out_len;
 
 	out_len = le32_to_cpu(dn->size);
-	buf = kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
+	buf = kmalloc(out_len * WORST_COMPR_FACTOR, GFP_NOFS);
 	if (!buf)
 		return -ENOMEM;
 


