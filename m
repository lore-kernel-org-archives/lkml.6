Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B012C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E522146F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131774;
	bh=aY00gAMW56nmm+CBK1BIxxUjPq7pmP6pHILN949m4Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yT1v3xA5zkjV9Irb/VwI2R5ppZlNsRJS1z/ziZ1YDkPJ+rWdRycB+XVSjTd4y1N2q
	 xM1EywE88J8rA00hJga0itqImuOsHLxLnDd3dRtCxUdXkUIUza/g/ME9rKVBK6Kqsc
	 8iLkr3TTrsu7gAfalEtlZrbsnOb+WjSqztcvAqe4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E522146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbeLFV3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:29:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeLFV32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:29:28 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45EE721479;
        Thu,  6 Dec 2018 21:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131767;
        bh=aY00gAMW56nmm+CBK1BIxxUjPq7pmP6pHILN949m4Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrpyXo9yheC1iWUNDEVXbOGP4qA/075vDtUBe9iWCZvPk6jnnOP0zXKZGXZXBCeQL
         +CZTWUaxoGb5eMqq64gwOU90KR7MGl9Ob5i7aysD4/l6ZhxDTMS57A1M3fOj9qOMJR
         j14wmN8aGNNYwtGSYOx1IiqB7JkkjZTf58SQV8OY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 44/75] perf trace: We need to consider "nr" if "__syscall_nr" is not there
Date:   Thu,  6 Dec 2018 18:25:31 -0300
Message-Id: <20181206212602.20474-45-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To cope with older kernels that don't have this patch backported:

  026842d148b9 ("tracing/syscalls: Rename "/format" tracepoint field name "nr" to "__syscall_nr:")

This makes 'perf trace' work again in RHEL7 kernels.

Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6h1syw2isegnhb1bjmtr9x9k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2a347ed7bdf4..98aff12af9e6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -258,7 +258,8 @@ static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel)
 	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
 
 	if (evsel->priv != NULL) {
-		if (perf_evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_nr"))
+		if (perf_evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_nr") &&
+		    perf_evsel__init_tp_uint_field(evsel, &sc->id, "nr"))
 			goto out_delete;
 		return 0;
 	}
-- 
2.19.2

