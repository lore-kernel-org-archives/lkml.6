Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E37C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8BA2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8BA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIEUZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:25:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbeIEUZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:25:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24C6340241C3;
        Wed,  5 Sep 2018 15:54:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 216F42166BA4;
        Wed,  5 Sep 2018 15:54:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/11] UAPI: keys: Fix use of C++ keywords as structural
 members
From:   David Howells <dhowells@redhat.com>
To:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 05 Sep 2018 16:54:47 +0100
Message-ID: <153616288762.23468.17409226604948361939.stgit@warthog.procyon.org.uk>
In-Reply-To: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 05 Sep 2018 15:54:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 05 Sep 2018 15:54:50 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The keyctl_dh_params struct uses a C++ keyword as structural members.  Fix
this by inserting an anonymous union that provides an alternative name and
then hide the reserved name in C++.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
cc: keyrings@vger.kernel.org
---

 include/uapi/linux/keyctl.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 7b8c9e19bad1..170f015d1f25 100644
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
+		__s32 dh_private;
+	};
 	__s32 prime;
 	__s32 base;
 };

