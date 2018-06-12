Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 93541C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CB8208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2lW2N+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CB8208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934950AbeFLQ4g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934957AbeFLQyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:54:23 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80CB8208B9;
        Tue, 12 Jun 2018 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822463;
        bh=zMrU25xrZmh+80z99gcRrmiQR2yCTioTQZ4YRhth5YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2lW2N+SsOgaz3WSZHQaPrvgqCZ8QiqPVSkf5+abw5AZ0IghIqOt2+1l6OR/K0f2y
         FVXpmovRPnIhb0sazQHJWffIkrkxtEFkP+WH3VWIpLq508OwG84W6cIVGKpFv2S7ti
         YaJ8MGJLLPPP2wTigwJWbW+fCaOfRrpreeRSDd8Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sachin Grover <sgrover@codeaurora.org>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 3.18 02/21] selinux: KASAN: slab-out-of-bounds in xattr_getsecurity
Date:   Tue, 12 Jun 2018 18:51:59 +0200
Message-Id: <20180612164825.495531260@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164825.401145490@linuxfoundation.org>
References: <20180612164825.401145490@linuxfoundation.org>
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
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/services.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1271,7 +1271,7 @@ static int security_context_to_sid_core(
 				      scontext_len, &context, def_sid);
 	if (rc == -EINVAL && force) {
 		context.str = str;
-		context.len = scontext_len;
+		context.len = strlen(str) + 1;
 		str = NULL;
 	} else if (rc)
 		goto out_unlock;


