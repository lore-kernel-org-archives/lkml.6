Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C45C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D94217C6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D94217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbeHDLGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:06:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49092 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeHDLGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:06:18 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 67047BD1;
        Sat,  4 Aug 2018 09:06:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jeremy Cline <jcline@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 27/32] net: socket: fix potential spectre v1 gadget in socketcall
Date:   Sat,  4 Aug 2018 11:01:17 +0200
Message-Id: <20180804082651.284127864@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082649.908295462@linuxfoundation.org>
References: <20180804082649.908295462@linuxfoundation.org>
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

From: Jeremy Cline <jcline@redhat.com>

commit c8e8cd579bb4265651df8223730105341e61a2d1 upstream.

'call' is a user-controlled value, so sanitize the array index after the
bounds check to avoid speculating past the bounds of the 'nargs' array.

Found with the help of Smatch:

net/socket.c:2508 __do_sys_socketcall() warn: potential spectre issue
'nargs' [r] (local cap)

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/socket.c |    2 ++
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
@@ -2338,6 +2339,7 @@ SYSCALL_DEFINE2(socketcall, int, call, u
 
 	if (call < 1 || call > SYS_SENDMMSG)
 		return -EINVAL;
+	call = array_index_nospec(call, SYS_SENDMMSG + 1);
 
 	len = nargs[call];
 	if (len > sizeof(a))


