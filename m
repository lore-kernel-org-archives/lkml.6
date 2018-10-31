Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EDAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37780204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37780204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbeKAHCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:02:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56555 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeKAHCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:02:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM2Xei2558542
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:02:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM2XbO2558539;
        Wed, 31 Oct 2018 15:02:33 -0700
Date:   Wed, 31 Oct 2018 15:02:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-qsvhrm2es635cl4zicqjeth2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        benjamin@python.org, adrian.hunter@intel.com, jolsa@kernel.org,
        dsahern@gmail.com, namhyung@kernel.org, acme@redhat.com,
        mingo@kernel.org, wangnan0@huawei.com
Reply-To: adrian.hunter@intel.com, jolsa@kernel.org, benjamin@python.org,
          hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          wangnan0@huawei.com, mingo@kernel.org, acme@redhat.com,
          namhyung@kernel.org, dsahern@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Beautify mount's first pathname arg
Git-Commit-ID: 23c07a23cbed389d0b9c7a06486574621df8d1a4
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

Commit-ID:  23c07a23cbed389d0b9c7a06486574621df8d1a4
Gitweb:     https://git.kernel.org/tip/23c07a23cbed389d0b9c7a06486574621df8d1a4
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 26 Oct 2018 13:51:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 30 Oct 2018 11:46:23 -0300

perf trace: Beautify mount's first pathname arg

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
