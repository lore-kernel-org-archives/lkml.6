Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D91C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E4623F9F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E4623F9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934518AbeGFFx6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:53:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34048 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934722AbeGFFw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:52:58 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DD706BC1;
        Fri,  6 Jul 2018 05:52:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 55/61] perf bpf: Fix NULL return handling in bpf__prepare_load()
Date:   Fri,  6 Jul 2018 07:47:19 +0200
Message-Id: <20180706054714.441305625@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit ab4e32ff5aa797eaea551dbb67946e2fcb56cc7e ]

bpf_object__open()/bpf_object__open_buffer can return error pointer or
NULL, check the return values with IS_ERR_OR_NULL() in bpf__prepare_load
and bpf__prepare_load_buffer

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: netdev@vger.kernel.org
Link: https://lkml.kernel.org/n/tip-psf4xwc09n62al2cb9s33v9h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/bpf-loader.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -66,7 +66,7 @@ bpf__prepare_load_buffer(void *obj_buf,
 	}
 
 	obj = bpf_object__open_buffer(obj_buf, obj_buf_sz, name);
-	if (IS_ERR(obj)) {
+	if (IS_ERR_OR_NULL(obj)) {
 		pr_debug("bpf: failed to load buffer\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -102,14 +102,14 @@ struct bpf_object *bpf__prepare_load(con
 			pr_debug("bpf: successfull builtin compilation\n");
 		obj = bpf_object__open_buffer(obj_buf, obj_buf_sz, filename);
 
-		if (!IS_ERR(obj) && llvm_param.dump_obj)
+		if (!IS_ERR_OR_NULL(obj) && llvm_param.dump_obj)
 			llvm__dump_obj(filename, obj_buf, obj_buf_sz);
 
 		free(obj_buf);
 	} else
 		obj = bpf_object__open(filename);
 
-	if (IS_ERR(obj)) {
+	if (IS_ERR_OR_NULL(obj)) {
 		pr_debug("bpf: failed to load %s\n", filename);
 		return obj;
 	}


