Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAD4C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E3F2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E3F2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbeIHCZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55056 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbeIHCZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:04 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D934DFF8;
        Fri,  7 Sep 2018 21:42:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.4 37/47] ubifs: Check data node size before truncate
Date:   Fri,  7 Sep 2018 23:10:33 +0200
Message-Id: <20180907210908.513536223@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210904.607934824@linuxfoundation.org>
References: <20180907210904.607934824@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 95a22d2084d72ea067d8323cc85677dba5d97cae upstream.

Check whether the size is within bounds before using it.
If the size is not correct, abort and dump the bad data node.

Cc: Kees Cook <keescook@chromium.org>
Cc: Silvio Cesare <silvio.cesare@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 1e51764a3c2ac ("UBIFS: add new flash file system")
Reported-by: Silvio Cesare <silvio.cesare@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/journal.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1186,7 +1186,16 @@ int ubifs_jnl_truncate(struct ubifs_info
 		else if (err)
 			goto out_free;
 		else {
-			if (le32_to_cpu(dn->size) <= dlen)
+			int dn_len = le32_to_cpu(dn->size);
+
+			if (dn_len <= 0 || dn_len > UBIFS_BLOCK_SIZE) {
+				ubifs_err(c, "bad data node (block %u, inode %lu)",
+					  blk, inode->i_ino);
+				ubifs_dump_node(c, dn);
+				goto out_free;
+			}
+
+			if (dn_len <= dlen)
 				dlen = 0; /* Nothing to do */
 			else {
 				int compr_type = le16_to_cpu(dn->compr_type);


