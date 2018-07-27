Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB988C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AD7208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AD7208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389532AbeG0Szj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:55:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728713AbeG0Szj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:55:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DFE84219DA8;
        Fri, 27 Jul 2018 17:32:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F22DF1102E29;
        Fri, 27 Jul 2018 17:32:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/38] vfs: Pass key and value into LSM and FS and provide a
 helper parser [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:32:44 +0100
Message-ID: <153271276449.9458.17623259664661449390.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 17:32:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 17:32:45 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: I've put some test code in the AFS filesystem that needs taking back
out.
---

 security/apparmor/lsm.c |   33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9a5915dffbdc..c52a87b0447d 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -553,15 +553,35 @@ static void apparmor_fs_context_free(struct fs_context *fc)
  * to pass them to the DFA evaluator *after* mount point parameters, which
  * means deferring the entire check to the sb_mountpoint hook.
  */
-static int apparmor_fs_context_parse_option(struct fs_context *fc, char *opt, size_t len)
+static int apparmor_fs_context_parse_option(struct fs_context *fc, const char *key,
+					    enum fs_value_type v_type,
+					    void *value, size_t v_len)
 {
 	struct apparmor_fs_context *afc = fc->security;
-	size_t space = 0;
+	size_t space = 0, k_len = strlen(key), len = k_len;
 	char *p, *q;
 
 	if (afc->saved_size > 0)
 		space = 1;
 
+	switch (v_type) {
+	case fs_value_is_string:
+		len += 1 + v_len;
+		break;
+	case fs_value_is_path:
+	case fs_value_is_path_empty: {
+		struct filename *f = value;
+		value = (char *)f->name;
+		v_len = strlen(f->name);
+		len += 1 + v_len;
+		break;
+	}
+	default:
+		value = NULL;
+		v_len = 0;
+		break;
+	}
+
 	p = krealloc(afc->saved_options, afc->saved_size + space + len + 1, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
@@ -569,8 +589,13 @@ static int apparmor_fs_context_parse_option(struct fs_context *fc, char *opt, si
 	q = p + afc->saved_size;
 	if (q != p)
 		*q++ = ' ';
-	memcpy(q, opt, len);
-	q += len;
+	memcpy(q, key, k_len);
+	q += k_len;
+	if (value) {
+		*q++ = '=';
+		memcpy(q, value, v_len);
+		q += v_len;
+	}
 	*q = 0;
 
 	afc->saved_options = p;

