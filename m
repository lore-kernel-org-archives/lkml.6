Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BB3C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015472087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXNwhk4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015472087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeJIBwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbeJIBwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:52:20 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D782087D;
        Mon,  8 Oct 2018 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023956;
        bh=OKuqgotXO1TvxUpP+kcUw/GH4iPFpInuHshMjIApE2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXNwhk4HdFweM6axLhk9c9D79dtatMDITgr5nDlzXs5KSBzNA6eqgzpu6e8a1BqOx
         yg84A2FczUMp1h/pgsmSr/ZjzHtEmmqv1aQ4oE1Gqio6/bSDLBk4P7dmrwnYbnkcs/
         Z42lp97mv55h1YFCAUddmzozu1Z/DNBTtRpERihg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hisao Tanabe <xtanabe@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 30/59] perf evsel: Fix potential null pointer dereference in perf_evsel__new_idx()
Date:   Mon,  8 Oct 2018 20:31:37 +0200
Message-Id: <20181008175549.975493974@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175546.620836256@linuxfoundation.org>
References: <20181008175546.620836256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hisao Tanabe <xtanabe@gmail.com>

[ Upstream commit fd8d2702791a970c751f8b526a17d8e725a05b46 ]

If evsel is NULL, we should return NULL to avoid a NULL pointer
dereference a bit later in the code.

Signed-off-by: Hisao Tanabe <xtanabe@gmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 03e0a7df3efd ("perf tools: Introduce bpf-output event")
LPU-Reference: 20180824154556.23428-1-xtanabe@gmail.com
Link: https://lkml.kernel.org/n/tip-e5plzjhx6595a5yjaf22jss3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/evsel.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -241,8 +241,9 @@ struct perf_evsel *perf_evsel__new_idx(s
 {
 	struct perf_evsel *evsel = zalloc(perf_evsel__object.size);
 
-	if (evsel != NULL)
-		perf_evsel__init(evsel, attr, idx);
+	if (!evsel)
+		return NULL;
+	perf_evsel__init(evsel, attr, idx);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
 		evsel->attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |


