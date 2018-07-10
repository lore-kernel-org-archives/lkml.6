Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FC9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D880A208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5+9t6V6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D880A208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeGJOBk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933549AbeGJOBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:01:34 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92F5F208E7;
        Tue, 10 Jul 2018 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531231294;
        bh=EIovew2vjeqv/jNHJXH4BxasomoAs9xnjmcwBrky7Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5+9t6V68JGgQn8HHPuClNnWLDvlOW9wOzkx8q5eMXO0Sh4pSW9TFKB/XGVKUzzBO
         YmbNRbAtzA3vmjumk3fJ1kJl/+EA/GbVU9NbzuSD/Bby90nGN78m+oU2x6rpbCF4Xd
         d3sToghNT6VFhFJPA3o2HbiCG86i9tqf7j4/IJ8Y=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@ZenIV.linux.org.uk, dhowells@redhat.com
Cc:     willy@infradead.org, andres@anarazel.de, cmaiolino@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/4] samples: extend test-fsinfo to access error_state
Date:   Tue, 10 Jul 2018 10:01:27 -0400
Message-Id: <20180710140127.20739-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710140127.20739-1-jlayton@kernel.org>
References: <20180710140127.20739-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Add support for error_state struct to test-fsinfo sample program.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 samples/statx/test-fsinfo.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/samples/statx/test-fsinfo.c b/samples/statx/test-fsinfo.c
index 9e9fa62a3b9f..01dd8c6d3c86 100644
--- a/samples/statx/test-fsinfo.c
+++ b/samples/statx/test-fsinfo.c
@@ -60,6 +60,7 @@ static const __u8 fsinfo_buffer_sizes[fsinfo_attr__nr] = {
 	FSINFO_STRING		(name_encoding),
 	FSINFO_STRING		(name_codepage),
 	FSINFO_STRUCT		(io_size),
+	FSINFO_STRUCT		(error_state),
 };
 
 #define FSINFO_NAME(N) [fsinfo_attr_##N] = #N
@@ -84,6 +85,7 @@ static const char *fsinfo_attr_names[fsinfo_attr__nr] = {
 	FSINFO_NAME(name_encoding),
 	FSINFO_NAME(name_codepage),
 	FSINFO_NAME(io_size),
+	FSINFO_NAME(error_state),
 };
 
 union reply {
@@ -98,6 +100,7 @@ union reply {
 	struct fsinfo_volume_uuid uuid;
 	struct fsinfo_server_address srv_addr;
 	struct fsinfo_io_size io_size;
+	struct fsinfo_error_state error_state;
 };
 
 static void dump_hex(unsigned int *data, int from, int to)
@@ -304,6 +307,15 @@ static void dump_attr_io_size(union reply *r, int size)
 	printf("bs=%u\n", f->block_size);
 }
 
+static void dump_attr_error_state(union reply *r, int size)
+{
+	struct fsinfo_error_state *f = &r->error_state;
+
+	printf("err_cookie=0x%x err_last=%u\n",
+			f->wb_error_cookie,
+			f->wb_error_last);
+}
+
 /*
  *
  */
@@ -321,6 +333,7 @@ static const dumper_t fsinfo_attr_dumper[fsinfo_attr__nr] = {
 	FSINFO_DUMPER(volume_uuid),
 	FSINFO_DUMPER(server_address),
 	FSINFO_DUMPER(io_size),
+	FSINFO_DUMPER(error_state),
 };
 
 static void dump_fsinfo(enum fsinfo_attribute attr, __u8 about,
-- 
2.17.1

