Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E593FC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BD32070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519586;
	bh=1gHyeGQ1g5WCdfdTlbYmaV3tkDmpNiib/QkVGYG51xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q0K4U7HN4wKGHKQn9I4DGOHYgMTlotCU0NOHdRcblQsijzrmHZ7CVMUYSzpur+mfT
	 +vSmHPodo/T+lJJ7Z66bJVIkT4w78RsIwwg59CT0L+Z82DhkeGzWGuxdZN+r3s5xrE
	 UXH6dvkzKe+ZOrJGIoP6fvFvqswlxXaVNaC+8xMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfACMqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:46:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731315AbfACMqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:46:24 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5252218F0;
        Thu,  3 Jan 2019 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519583;
        bh=1gHyeGQ1g5WCdfdTlbYmaV3tkDmpNiib/QkVGYG51xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJeKctiocVr2ff0EKPtGh52Sr+cY+9VrLD1Ly6Vd/osKX5skh4DJxgqojTGErz5xM
         ELiFYByaLqc1g1dSsZMdASCRYPcUcBys+Dx3D364HWg+8grx1Vd2yE4Yr71t0j5rIQ
         Q+WApbSyx0HDOXzUqT8e9NngJtQrZth20iIR4cis=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 02/29] perf beauty mmap: PROT_WRITE should come before PROT_EXEC
Date:   Thu,  3 Jan 2019 09:45:42 -0300
Message-Id: <20190103124609.29672-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.19.2

