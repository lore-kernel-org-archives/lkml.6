Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8425CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFD121104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1hz56TLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFD121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404367AbeKTDVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:21:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403836AbeKTDVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:21:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C60F206BA;
        Mon, 19 Nov 2018 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646606;
        bh=OONiypWLNo+xZZhM6IfON+mnCyqpjkcN4/4H6G/USj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1hz56TLbufAz4z2OWtZ9d7hD+WFnSu9JTNsjNn2wRE18C0bjZND7dKzyS6ANRexyY
         ymnM95nICa6qhMG9UW2wqZVeRElTds406Pz6w+BQUzX39Xi2Bf71aomnoSGmlwCoHw
         eqkIoD3sQb9fBZQQe5+DfRVueYPBpNlDvCwAtess=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sanskriti Sharma <sansharm@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 021/160] perf tools: Cleanup trace-event-info tdata leak
Date:   Mon, 19 Nov 2018 17:27:40 +0100
Message-Id: <20181119162632.567170848@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanskriti Sharma <sansharm@redhat.com>

[ Upstream commit faedbf3fd19f2511a39397f76359e4cc6ee93072 ]

Free tracing_data structure in tracing_data_get() error paths.

Fixes the following coverity complaint:

  Error: RESOURCE_LEAK (CWE-772):
  leaked_storage: Variable "tdata" going out of scope leaks the storage

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Link: http://lkml.kernel.org/r/1538490554-8161-3-git-send-email-sansharm@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/trace-event-info.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -507,12 +507,14 @@ struct tracing_data *tracing_data_get(st
 			 "/tmp/perf-XXXXXX");
 		if (!mkstemp(tdata->temp_file)) {
 			pr_debug("Can't make temp file");
+			free(tdata);
 			return NULL;
 		}
 
 		temp_fd = open(tdata->temp_file, O_RDWR);
 		if (temp_fd < 0) {
 			pr_debug("Can't read '%s'", tdata->temp_file);
+			free(tdata);
 			return NULL;
 		}
 


