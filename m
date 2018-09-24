Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABCEECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EA0208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EA0208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbeIXSUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:20:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbeIXSUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:20:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28356308421A;
        Mon, 24 Sep 2018 12:18:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D7581077D49;
        Mon, 24 Sep 2018 12:18:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] keys: Fix the use of the C++ keyword "private" in
 uapi/linux/keyctl.h
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Stephan Mueller <smueller@chronox.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        lkundrak@v3.sk, rdunlap@infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Sep 2018 13:18:43 +0100
Message-ID: <153779152340.28003.6461494237075964365.stgit@warthog.procyon.org.uk>
In-Reply-To: <153779150602.28003.4692837431529288988.stgit@warthog.procyon.org.uk>
References: <153779150602.28003.4692837431529288988.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 24 Sep 2018 12:18:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The keyctl_dh_params struct in uapi/linux/keyctl.h contains the symbol
"private" which means that the header file will cause compilation failure
if #included in to a C++ program.  Further, the patch that added the same
struct to the keyutils package named the symbol "priv", not "private".

The previous attempt to fix this (commit 8a2336e549d3) did so by simply
renaming the kernel's copy of the field to dh_private, but this then breaks
existing userspace and as such has to be reverted (which is done by the
preceding patch).

[And note, to those who think that wrapping the struct in extern "C" {}
 will work: it won't; that only changes how symbol names are presented to
 the assembler and linker.].

Instead, insert an anonymous union around the "private" member and add a
second member in there with the name "priv" to match the one in the
keyutils package.  The "private" member is then wrapped in !__cplusplus
cpp-conditionals to hide it from C++.

Fixes: ddbb41148724 ("KEYS: Add KEYCTL_DH_COMPUTE command")
Fixes: 8a2336e549d3 ("uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Randy Dunlap <rdunlap@infradead.org>
cc: Lubomir Rintel <lkundrak@v3.sk>
cc: James Morris <jmorris@namei.org>
cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
cc: Stephan Mueller <smueller@chronox.de>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: stable@vger.kernel.org
---

 include/uapi/linux/keyctl.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 7b8c9e19bad1..0f3cb13db8e9 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -65,7 +65,12 @@
 
 /* keyctl structures */
 struct keyctl_dh_params {
-	__s32 private;
+	union {
+#ifndef __cplusplus
+		__s32 private;
+#endif
+		__s32 priv;
+	};
 	__s32 prime;
 	__s32 base;
 };

