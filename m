Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68495C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE062172C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE062172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeHUNPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:15:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbeHUNPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:15:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7E65EC006;
        Tue, 21 Aug 2018 09:55:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-147.rdu2.redhat.com [10.10.123.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 447172026D64;
        Tue, 21 Aug 2018 09:55:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/6] vfs: Adjust fsinfo sample output
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 Aug 2018 10:55:30 +0100
Message-ID: <153484533075.1183.12355648565791228863.stgit@warthog.procyon.org.uk>
In-Reply-To: <153484529922.1183.17405985592221413059.stgit@warthog.procyon.org.uk>
References: <153484529922.1183.17405985592221413059.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 21 Aug 2018 09:55:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 21 Aug 2018 09:55:31 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the output of the test-fsinfo sample program to:

 (1) Print server addresses if of AF_INET or AF_INET6 family.

 (2) Not print parameter descriptions (the test-fs-query sample program can
     be used for that).

 (3) Only print non-blank parameter values so that parameters that just
     encode defaults don't clutter up the output.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/statx/test-fsinfo.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/samples/statx/test-fsinfo.c b/samples/statx/test-fsinfo.c
index 21714ef7ef5b..c08978acf08b 100644
--- a/samples/statx/test-fsinfo.c
+++ b/samples/statx/test-fsinfo.c
@@ -26,6 +26,7 @@
 #include <linux/fsinfo.h>
 #include <linux/socket.h>
 #include <sys/stat.h>
+#include <arpa/inet.h>
 
 static bool debug = 0;
 
@@ -304,6 +305,24 @@ static void dump_attr_VOLUME_UUID(union reply *r, int size)
 static void dump_attr_SERVER_ADDRESS(union reply *r, int size)
 {
 	struct fsinfo_server_address *f = &r->srv_addr;
+	struct sockaddr_in6 *sin6;
+	struct sockaddr_in *sin;
+	char buf[1024];
+
+	switch (f->address.ss_family) {
+	case AF_INET:
+		sin = (struct sockaddr_in *)&f->address;
+		if (!inet_ntop(AF_INET, &sin->sin_addr, buf, sizeof(buf)))
+			break;
+		printf("IPv4: %s\n", buf);
+		return;
+	case AF_INET6:
+		sin6 = (struct sockaddr_in6 *)&f->address;
+		if (!inet_ntop(AF_INET6, &sin6->sin6_addr, buf, sizeof(buf)))
+			break;
+		printf("IPv6: %s\n", buf);
+		return;
+	}
 
 	printf("family=%u\n", f->address.ss_family);
 }
@@ -426,6 +445,17 @@ static int try_one(const char *file, struct fsinfo_params *params, bool raw)
 		return 0;
 	}
 
+	switch (params->request) {
+	case FSINFO_ATTR_PARAM_DESCRIPTION:
+	case FSINFO_ATTR_PARAM_SPECIFICATION:
+	case FSINFO_ATTR_PARAM_NAME:
+	case FSINFO_ATTR_PARAM_ENUM:
+		return 0;
+	case FSINFO_ATTR_PARAMETER:
+		if (ret == 0)
+			return 0;
+	}
+
 	switch (about & 0xc000) {
 	case 0x0000:
 		printf("\e[33m%s\e[m: ",

