Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4631C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CAC20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CAC20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbeJNXj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:39:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35935 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727506AbeJNXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:51 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLe-0004cH-Qt; Sun, 14 Oct 2018 16:30:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000m4-Gz; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Sachin Grover" <sgrover@codeaurora.org>,
        "Paul Moore" <paul@paul-moore.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.819318547@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 361/366] selinux: KASAN: slab-out-of-bounds in
 xattr_getsecurity
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sachin Grover <sgrover@codeaurora.org>

commit efe3de79e0b52ca281ef6691480c8c68c82a4657 upstream.

Call trace:
 [<ffffff9203a8d7a8>] dump_backtrace+0x0/0x428
 [<ffffff9203a8dbf8>] show_stack+0x28/0x38
 [<ffffff920409bfb8>] dump_stack+0xd4/0x124
 [<ffffff9203d187e8>] print_address_description+0x68/0x258
 [<ffffff9203d18c00>] kasan_report.part.2+0x228/0x2f0
 [<ffffff9203d1927c>] kasan_report+0x5c/0x70
 [<ffffff9203d1776c>] check_memory_region+0x12c/0x1c0
 [<ffffff9203d17cdc>] memcpy+0x34/0x68
 [<ffffff9203d75348>] xattr_getsecurity+0xe0/0x160
 [<ffffff9203d75490>] vfs_getxattr+0xc8/0x120
 [<ffffff9203d75d68>] getxattr+0x100/0x2c8
 [<ffffff9203d76fb4>] SyS_fgetxattr+0x64/0xa0
 [<ffffff9203a83f70>] el0_svc_naked+0x24/0x28

If user get root access and calls security.selinux setxattr() with an
embedded NUL on a file and then if some process performs a getxattr()
on that file with a length greater than the actual length of the string,
it would result in a panic.

To fix this, add the actual length of the string to the security context
instead of the length passed by the userspace process.

Signed-off-by: Sachin Grover <sgrover@codeaurora.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/selinux/ss/services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1270,7 +1270,7 @@ static int security_context_to_sid_core(
 				      scontext_len, &context, def_sid);
 	if (rc == -EINVAL && force) {
 		context.str = str;
-		context.len = scontext_len;
+		context.len = strlen(str) + 1;
 		str = NULL;
 	} else if (rc)
 		goto out_unlock;

