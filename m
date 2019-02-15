Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AD6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AEF21B68
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191745;
	bh=Xqoqb70syHTXXii7aoOJtWuUbpHLY3TLedInyLVc5zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ybCW54tda/HDu9BSobAC9tpZs9JyrvpMQguQwzMAB+Pv/n/shD9R733IFQqOW1xiJ
	 P+eoOdBo7j1qU6eEqUKH9YA19zFsFPpnX76v8k51rv/n+WJQ4vIEu9Ja190EYuNoJE
	 EFh4qO2VmgkopBlWhkbNGhOHdgxNvcn6EMi9jU68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390033AbfBOAtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387628AbfBOAtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:49:01 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C34C21B1A;
        Fri, 15 Feb 2019 00:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191741;
        bh=Xqoqb70syHTXXii7aoOJtWuUbpHLY3TLedInyLVc5zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvQ8kvaW0E4ZfAkjPa+PkCzAbokdXN1BzrdYUQfDZwNXnC1PiHS9Yf9dZx9v5179m
         0cPK90FKPwb0+/1oD9z+ez1duoCDJYfFLv1FCfCmj3ypOgkK9WRuUtT6KqrYRM9yc4
         o4FgQIg3VEn0COafh1jAmMAzLtxmSoog4nFmAZr4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 43/43] tools build feature sched_getcpu: Undef _GNU_SOURCE at the end
Date:   Thu, 14 Feb 2019 21:45:39 -0300
Message-Id: <20190215004539.23571-44-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since this feature test is included in test-all.c, the feature detection
fast path compile/link phase, it can't leave any defines behind, as it
can affect the tests included after it, so remove it.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-lg3kpd9tzypc797vb1f42u6k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-sched_getcpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/build/feature/test-sched_getcpu.c b/tools/build/feature/test-sched_getcpu.c
index e448deb4124c..48995ac7911e 100644
--- a/tools/build/feature/test-sched_getcpu.c
+++ b/tools/build/feature/test-sched_getcpu.c
@@ -8,3 +8,5 @@ int main(void)
 {
 	return sched_getcpu();
 }
+
+#undef _GNU_SOURCE
-- 
2.19.1

