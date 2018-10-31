Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16077ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA47820821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA47820821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeKAHGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:06:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54101 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbeKAHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:06:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM60cF2560587
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:06:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM5xxH2560584;
        Wed, 31 Oct 2018 15:05:59 -0700
Date:   Wed, 31 Oct 2018 15:05:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-c00bqzclscgah26z2g5zxm73@git.kernel.org>
Cc:     adrian.hunter@intel.com, namhyung@kernel.org, wangnan0@huawei.com,
        Jason@zx2c4.com, hpa@zytor.com, herbert@gondor.apana.org.au,
        acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        mingo@kernel.org, tglx@linutronix.de, dsahern@gmail.com
Reply-To: jolsa@kernel.org, mingo@kernel.org, tglx@linutronix.de,
          dsahern@gmail.com, adrian.hunter@intel.com, namhyung@kernel.org,
          wangnan0@huawei.com, Jason@zx2c4.com, hpa@zytor.com,
          herbert@gondor.apana.org.au, acme@redhat.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include uapi: Update linux/fs.h copy
Git-Commit-ID: 733ac4f9935c4b257aff2ec476e6c20665daf6c2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  733ac4f9935c4b257aff2ec476e6c20665daf6c2
Gitweb:     https://git.kernel.org/tip/733ac4f9935c4b257aff2ec476e6c20665daf6c2
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 30 Oct 2018 12:27:37 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 09:57:51 -0300

tools include uapi: Update linux/fs.h copy

To silence this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fs.h' differs from latest version at 'include/uapi/linux/fs.h'
  diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h

Due to just two comments added by:

  Fixes: 578bdaabd015 ("crypto: speck - remove Speck")

So nothing that entails changes in tools/, that so far uses fs.h to
generate the mount and umount syscalls 'flags' argument integer->string
tables with:

  $ tools/perf/trace/beauty/mount_flags.sh
  static const char *mount_flags[] = {
	[4096 ? (ilog2(4096) + 1) : 0] = "BIND",
<SNIP>
	[30 + 1] = "ACTIVE",
	[31 + 1] = "NOUSER",
  };
  $
  # trace -e mount,umount mount --bind /proc /mnt
     1.228 ( 2.581 ms): mount/1068 mount(dev_name: /mnt, dir_name: 0x55f011c354a0, type: 0x55f011c38170, flags: BIND) = 0
  # trace -e mount,umount umount /proc /mnt
  umount: /proc: target is busy.
     1.587 ( 0.010 ms): umount/1070 umount2(name: /proc) = -1 EBUSY Device or resource busy
     1.799 (12.660 ms): umount/1070 umount2(name: /mnt) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lkml.kernel.org/n/tip-c00bqzclscgah26z2g5zxm73@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index 73e01918f996..a441ea1bfe6d 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -279,8 +279,8 @@ struct fsxattr {
 #define FS_ENCRYPTION_MODE_AES_256_CTS		4
 #define FS_ENCRYPTION_MODE_AES_128_CBC		5
 #define FS_ENCRYPTION_MODE_AES_128_CTS		6
-#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7
-#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8
+#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7 /* Removed, do not use. */
+#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8 /* Removed, do not use. */
 
 struct fscrypt_policy {
 	__u8 version;
