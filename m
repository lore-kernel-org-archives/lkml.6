Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BC3C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789B62070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfACNKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:10:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58303 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbfACNKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:10:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DAfQ11383733
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:10:41 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DAfYK1383730;
        Thu, 3 Jan 2019 05:10:41 -0800
Date:   Thu, 3 Jan 2019 05:10:41 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-nt49d6iqle80cw8f529ovaqi@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
        mingo@kernel.org, wangnan0@huawei.com, jolsa@kernel.org,
        tglx@linutronix.de, adrian.hunter@intel.com, namhyung@kernel.org,
        lclaudio@redhat.com
Reply-To: acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          jolsa@kernel.org, mingo@kernel.org, wangnan0@huawei.com,
          tglx@linutronix.de, adrian.hunter@intel.com, lclaudio@redhat.com,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf beauty mmap: PROT_WRITE should come before
 PROT_EXEC
Git-Commit-ID: 5ce29d522e9b8cdc158329a8539bcd6206fc5bf4
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

Commit-ID:  5ce29d522e9b8cdc158329a8539bcd6206fc5bf4
Gitweb:     https://git.kernel.org/tip/5ce29d522e9b8cdc158329a8539bcd6206fc5bf4
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 19 Dec 2018 10:10:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 21 Dec 2018 09:42:46 -0300

perf beauty mmap: PROT_WRITE should come before PROT_EXEC

To match strace output:

  # cat mmap.c
  #include <sys/mman.h>

  int main(void)
  {
	  mmap(0, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
	  return 0;
  }
  # strace -e mmap ./mmap |& grep -v ^+++
  mmap(NULL, 103484, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f5bae400000
  mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5bae3fe000
  mmap(NULL, 3889792, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f5bade40000
  mmap(0x7f5bae1ec000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ac000) = 0x7f5bae1ec000
  mmap(0x7f5bae1f2000, 14976, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f5bae1f2000
  mmap(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5bae419000
  # trace -e mmap ./mmap |& grep -v ^+++
  mmap(NULL, 103484, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f6646c25000
  mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f6646c23000
  mmap(NULL, 3889792, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f6646665000
  mmap(0x7f6646a11000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ac000) = 0x7f6646a11000
  mmap(0x7f6646a17000, 14976, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS) = 0x7f6646a17000
  mmap(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f6646c3e000
  #

Reported-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-nt49d6iqle80cw8f529ovaqi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index eb31089790e3..859a8a9db2c6 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -18,8 +18,8 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 	}
 
 	P_MMAP_PROT(READ);
-	P_MMAP_PROT(EXEC);
 	P_MMAP_PROT(WRITE);
+	P_MMAP_PROT(EXEC);
 	P_MMAP_PROT(SEM);
 	P_MMAP_PROT(GROWSDOWN);
 	P_MMAP_PROT(GROWSUP);
