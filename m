Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA72C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDBD20823
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjaZC4my"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDBD20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbeKABom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbeKABom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:44:42 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D529F20854;
        Wed, 31 Oct 2018 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541004354;
        bh=Hq0j8KuwDtNcMBH5L6Q5zjDmE2d5BbwPbF6ib64U2MQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjaZC4myprlaZOxJyTzW3V0IVsttaKSF8zgtSuSamrBVPX0tOvo/0Z+wYlVBsaoW6
         weruZLVNOD7vZnuSSdSlmJMzqxSnofj2s0iaDj0DR/75yraglX7U9GEZJD6NHIBoDg
         bep2yO9nGTIx+pEVMF1Jwzv7HhG+imzVjlmbNjWA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Benjamin Peterson <benjamin@python.org>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 09/28] perf trace: Beautify mount's first pathname arg
Date:   Wed, 31 Oct 2018 13:44:49 -0300
Message-Id: <20181031164508.4784-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The pathname beautifiers so far support just one augmented pathname per
syscall, so do it just for mount's first arg, later this will get fixed.

With:

  # perf probe -l
  probe:vfs_getname    (on getname_flags:73@acme/git/linux/fs/namei.c with pathname)
  #

Later this will get added to augmented_syscalls.c (eBPF):

In one xterm:

  # perf trace -e mount,umount
  2687.331 ( 3.544 ms): mount/8892 mount(dev_name: /mnt, dir_name: 0x561f9ac184a0, type: 0x561f9ac1b170, flags: BIND) = 0
  3912.126 ( 8.807 ms): umount/8895 umount2(name: /mnt) = 0
  ^C#

In the other:

  $ sudo mount --bind /proc /mnt
  $ sudo umount /mnt

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qsvhrm2es635cl4zicqjeth2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d286f73ef2e5..dc8a6c4986ce 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -727,7 +727,8 @@ static struct syscall_fmt {
 		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
 		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ }, }, },
 	{ .name	    = "mount",
-	  .arg = { [3] = { .scnprintf = SCA_MOUNT_FLAGS, /* flags */
+	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* dev_name */ },
+		   [3] = { .scnprintf = SCA_MOUNT_FLAGS, /* flags */
 			   .mask_val  = SCAMV_MOUNT_FLAGS, /* flags */ }, }, },
 	{ .name	    = "mprotect",
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
-- 
2.14.4

