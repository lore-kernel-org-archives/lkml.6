Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90FCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E11620818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E11620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbeKLGQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:16:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50810 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730597AbeKLFs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:26 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsl-0000lF-EH; Sun, 11 Nov 2018 19:58:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001nK-Ls; Sun, 11 Nov 2018 19:58:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Jeremy Cline" <jcline@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.632796283@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 300/366] net: socket: fix potential spectre v1 gadget
 in socketcall
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Cline <jcline@redhat.com>

commit c8e8cd579bb4265651df8223730105341e61a2d1 upstream.

'call' is a user-controlled value, so sanitize the array index after the
bounds check to avoid speculating past the bounds of the 'nargs' array.

Found with the help of Smatch:

net/socket.c:2508 __do_sys_socketcall() warn: potential spectre issue
'nargs' [r] (local cap)

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/socket.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/net/socket.c
+++ b/net/socket.c
@@ -89,6 +89,7 @@
 #include <linux/magic.h>
 #include <linux/slab.h>
 #include <linux/xattr.h>
+#include <linux/nospec.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -2494,6 +2495,7 @@ SYSCALL_DEFINE2(socketcall, int, call, u
 
 	if (call < 1 || call > SYS_SENDMMSG)
 		return -EINVAL;
+	call = array_index_nospec(call, SYS_SENDMMSG + 1);
 
 	len = nargs[call];
 	if (len > sizeof(a))

