Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0025CC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB6520664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB6520664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbeJ2SJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:09:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729442AbeJ2SJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:09:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83B9831A3B25;
        Mon, 29 Oct 2018 09:21:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 592BA5C57A;
        Mon, 29 Oct 2018 09:21:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181029200620.75f71e94@canb.auug.org.au>
References: <20181029200620.75f71e94@canb.auug.org.au> <20180910133525.28c5dd20@canb.auug.org.au> <20181029153334.7c8d16cc@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5182.1540804880.1@warthog.procyon.org.uk>
Date:   Mon, 29 Oct 2018 09:21:20 +0000
Message-ID: <5183.1540804880@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 29 Oct 2018 09:21:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think these changes should cover them all.

David
---
diff --git a/samples/vfs/test-fs-query.c b/samples/vfs/test-fs-query.c
index 511541d12b9e..4635bf1eb3d4 100644
--- a/samples/vfs/test-fs-query.c
+++ b/samples/vfs/test-fs-query.c
@@ -27,6 +27,13 @@
 #include <linux/socket.h>
 #include <sys/stat.h>
 
+#ifndef __NR_fsopen
+#define __NR_fsopen -1
+#endif
+#ifndef __NR_fsinfo
+#define __NR_fsinfo -1
+#endif
+
 static int fsopen(const char *fs_name, unsigned int flags)
 {
 	return syscall(__NR_fsopen, fs_name, flags);
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 75f5c2a61445..125010212eee 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -28,6 +28,10 @@
 #include <sys/stat.h>
 #include <arpa/inet.h>
 
+#ifndef __NR_fsinfo
+#define __NR_fsinfo -1
+#endif
+
 static bool debug = 0;
 
 static __attribute__((unused))
diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index 9ac4b7707aba..4ef0c914a62a 100644
--- a/samples/vfs/test-statx.c
+++ b/samples/vfs/test-statx.c
@@ -161,7 +161,8 @@ static void dump_statx(struct statx *stx)
 			"?dai?c??"	/*  7- 0	0x00000000-000000ff */
 			;
 
-		printf("Attributes: %016llx (", stx->stx_attributes);
+		printf("Attributes: %016llx (",
+		       (unsigned long long)stx->stx_attributes);
 		for (byte = 64 - 8; byte >= 0; byte -= 8) {
 			bits = stx->stx_attributes >> byte;
 			mbits = stx->stx_attributes_mask >> byte;
