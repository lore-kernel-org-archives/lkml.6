Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeFDSDR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeFDSDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:03:12 -0400
From: Jeff Layton <jlayton@kernel.org>
To: viro@ZenIV.linux.org.uk, dhowells@redhat.com
Cc: willy@infradead.org, andres@anarazel.de, cmaiolino@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] samples: extend test-fsinfo to access error_state
Date: Mon,  4 Jun 2018 14:03:04 -0400
Message-Id: <20180604180304.9662-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604180304.9662-1-jlayton@kernel.org>
References: <20180604180304.9662-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Add support for error_state struct to test-fsinfo sample program.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 samples/statx/test-fsinfo.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/samples/statx/test-fsinfo.c b/samples/statx/test-fsinfo.c
index 9d70c422da11..b383a6ec81a0 100644
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
@@ -303,6 +306,15 @@ static void dump_attr_io_size(union reply *r, int size)
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
@@ -320,6 +332,7 @@ static const dumper_t fsinfo_attr_dumper[fsinfo_attr__nr] = {
 	FSINFO_DUMPER(volume_uuid),
 	FSINFO_DUMPER(server_address),
 	FSINFO_DUMPER(io_size),
+	FSINFO_DUMPER(error_state),
 };
 
 static void dump_fsinfo(enum fsinfo_attribute attr, __u8 about,
-- 
2.17.0
