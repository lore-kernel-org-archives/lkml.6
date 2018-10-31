Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DC1ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CB420823
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOWxwyJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CB420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbeKABpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729810AbeKABpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:45:03 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E89120821;
        Wed, 31 Oct 2018 16:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541004376;
        bh=HAL9csyQ4jzYHnD5PaWSTYjXpDO9HLD40iotAfwwOlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOWxwyJQdgMwvJeUIZmy2f40yfLL3SGsnHEzRWQuvgJFIutJVOqIQlEW1gM2GFbbo
         WXQJTnqm1N+QcVFQHfTD0B6plnTF3AS3chAn00biTWZxolWpkRvj9rD3EGtkES15hO
         ycKios/azxPqc39vdT9Ca3UQZ/jxJUbnKS36WE/c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 15/28] tools include uapi: Update linux/fs.h copy
Date:   Wed, 31 Oct 2018 13:44:55 -0300
Message-Id: <20181031164508.4784-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

