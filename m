Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0567EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3E1208B2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wWbxunhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3E1208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbeHAXZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732652AbeHAXZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:49 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 451C4208AD;
        Wed,  1 Aug 2018 21:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533159481;
        bh=QmQOFFUl4xNjk6SvM7rejHUGMYatfZ0udVEvbZmQKXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wWbxunhquefkY187VjZhMjnMjg0EQdlFfUyHtNXBmzanr7L4bjeRpI0J68lhhSxh+
         IbX5Zegd/h9a/BoTwfV+URITqlBk3AKE0NR5oElajcKlJFUJKIFmjoVAxPpDSozdP+
         UNmbc3nts6PuXIffR4EN0mBg0PXx1c6TGWAK6iT0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 18/21] perf bpf: Show better message when failing to load an object
Date:   Wed,  1 Aug 2018 18:36:45 -0300
Message-Id: <20180801213648.4814-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Before:

  libbpf: license of tools/perf/examples/bpf/etcsnoop.c is GPL
  libbpf: section(6) version, size 4, link 0, flags 3, type=1
  libbpf: kernel version of tools/perf/examples/bpf/etcsnoop.c is 41200
  libbpf: section(7) .symtab, size 120, link 1, flags 0, type=2
  bpf: config program 'syscalls:sys_enter_openat'
  libbpf: load bpf program failed: Operation not permitted
  libbpf: failed to load program 'syscalls:sys_enter_openat'
  libbpf: failed to load object 'tools/perf/examples/bpf/etcsnoop.c'
  bpf: load objects failed

After: (just the last line changes)

  bpf: load objects failed: err=-4009: (Incorrect kernel version)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-wi44iid0yjfht3lcvplc75fm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index cee658733e2c..3d02ae38ec56 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -747,7 +747,9 @@ int bpf__load(struct bpf_object *obj)
 
 	err = bpf_object__load(obj);
 	if (err) {
-		pr_debug("bpf: load objects failed\n");
+		char bf[128];
+		libbpf_strerror(err, bf, sizeof(bf));
+		pr_debug("bpf: load objects failed: err=%d: (%s)\n", err, bf);
 		return err;
 	}
 	return 0;
-- 
2.14.4

