Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AE5ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88F02082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jc//GMCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88F02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeJZG0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:26:24 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:26220 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727616AbeJZG0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:26:23 -0400
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id D9F8E2634;
        Thu, 25 Oct 2018 14:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1540504318;
        bh=qaSim7D6Xh2XpeHY+q8gQwfE1/JZ7hMr1nE0gPLBya0=;
        h=From:To:Cc:Subject:Date;
        b=jc//GMCXi36edAch8Cp/d/MwPqPuaeuwPF099OcQX8F+I+xKVUwvR7commQ4M3Yyx
         ixdtcFIxFwwh1WDWcUF6sN7LyEwjKMYcGNhloEZ4esT+7TLpNlxFtQtl8IqIFt3Gvy
         5gRNPSw3M3eIZ+gOuvXMVcnweB/ZzcSFicGzuIoZFwgXSwPptl3zqF4LKOmxuIC9dZ
         T8ssGYxOiM9bWiTB1mLwE5d/4lTmSs6ZvpLAJgPoXtwcDLTmGMTWibtuwMghse/HAp
         uRzr7v+tbbLLbDF+3+jDWO11ir6FWf0S7TJw3e75t0TczXAOzC0Az+jk9NhJWbprfb
         +ZzI4d3hunWXg==
Received: from baptiste-eos-trunk-view.sjc.aristanetworks.com (dhcp-25-11-251.sjc.aristanetworks.com [172.25.11.251])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id CA1DC2630;
        Thu, 25 Oct 2018 14:51:58 -0700 (PDT)
From:   Baptiste Covolato <baptiste@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     baptiste@arista.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        pombredanne@nexb.com, yamada.masahiro@socionext.com,
        forney@google.com, andrzej.p@samsung.com
Subject: [PATCH v2] gen_init_cpio: allow file mtime to be overridden
Date:   Thu, 25 Oct 2018 14:51:33 -0700
Message-Id: <20181025215133.20138-1-baptiste@arista.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default gen_init_cpio uses the current time as mtime for links,
special files and directories. We have the possibility to set this
timestamp to a fixed value using -t. However, this timestamp doesn't
apply to regular files. For those, the mtime returned by stat is used.

This commit introduces a '-a' option, which when used, will modify the
mtime of regular files to match the timestamp of special files,
directories, ...

v2: Fix typos in commit title/message

Signed-off-by: Baptiste Covolato <baptiste@arista.com>
---
 usr/gen_init_cpio.c       | 19 +++++++++++++++----
 usr/gen_initramfs_list.sh |  2 +-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 03b21189d58b..e2432ff31965 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -24,6 +24,7 @@
 static unsigned int offset;
 static unsigned int ino = 721;
 static time_t default_mtime;
+static int default_mtime_all;
 
 struct file_handler {
 	const char *type;
@@ -305,6 +306,7 @@ static int cpio_mkfile(const char *name, const char *location,
 	int rc = -1;
 	int namesize;
 	unsigned int i;
+	time_t mtime;
 
 	mode |= S_IFREG;
 
@@ -320,6 +322,10 @@ static int cpio_mkfile(const char *name, const char *location,
 		goto error;
 	}
 
+	mtime = buf.st_mtime;
+	if (default_mtime_all)
+		mtime = default_mtime;
+
 	filebuf = malloc(buf.st_size);
 	if (!filebuf) {
 		fprintf (stderr, "out of memory\n");
@@ -348,7 +354,7 @@ static int cpio_mkfile(const char *name, const char *location,
 			(long) uid,		/* uid */
 			(long) gid,		/* gid */
 			nlinks,			/* nlink */
-			(long) buf.st_mtime,	/* mtime */
+			(long) mtime,		/* mtime */
 			size,			/* filesize */
 			3,			/* major */
 			1,			/* minor */
@@ -452,7 +458,7 @@ static int cpio_mkfile_line(const char *line)
 static void usage(const char *prog)
 {
 	fprintf(stderr, "Usage:\n"
-		"\t%s [-t <timestamp>] <cpio_list>\n"
+		"\t%s [-t <timestamp>] [-a] <cpio_list>\n"
 		"\n"
 		"<cpio_list> is a file containing newline separated entries that\n"
 		"describe the files to be included in the initramfs archive:\n"
@@ -487,7 +493,9 @@ static void usage(const char *prog)
 		"\n"
 		"<timestamp> is time in seconds since Epoch that will be used\n"
 		"as mtime for symlinks, special files and directories. The default\n"
-		"is to use the current time for these entries.\n",
+		"is to use the current time for these entries. If -a is specified,\n"
+		"the same mtime will be used for files, overriding their original\n"
+		"mtime.\n",
 		prog);
 }
 
@@ -529,12 +537,15 @@ int main (int argc, char *argv[])
 
 	default_mtime = time(NULL);
 	while (1) {
-		int opt = getopt(argc, argv, "t:h");
+		int opt = getopt(argc, argv, "t:ha");
 		char *invalid;
 
 		if (opt == -1)
 			break;
 		switch (opt) {
+		case 'a':
+			default_mtime_all = 1;
+			break;
 		case 't':
 			default_mtime = strtol(optarg, &invalid, 10);
 			if (!*optarg || *invalid) {
diff --git a/usr/gen_initramfs_list.sh b/usr/gen_initramfs_list.sh
index 0aad760fcd8c..1704e0638bcc 100755
--- a/usr/gen_initramfs_list.sh
+++ b/usr/gen_initramfs_list.sh
@@ -308,7 +308,7 @@ if [ ! -z ${output_file} ]; then
 		if test -n "$KBUILD_BUILD_TIMESTAMP"; then
 			timestamp="$(date -d"$KBUILD_BUILD_TIMESTAMP" +%s || :)"
 			if test -n "$timestamp"; then
-				timestamp="-t $timestamp"
+				timestamp="-a -t $timestamp"
 			fi
 		fi
 		cpio_tfile="$(mktemp ${TMPDIR:-/tmp}/cpiofile.XXXXXX)"
-- 
2.19.1

