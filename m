Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC78C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E931C214DE
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNuyTkNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E931C214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbeKZVyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:54:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbeKZVyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:54:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0D92089F;
        Mon, 26 Nov 2018 11:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230036;
        bh=/5YxxoWXBroGeOD9LBhEmVCdRp2kpT0JV0CU+JGJ05g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNuyTkNWgwzOjhQcCuB9Zyan71fbIGteaeiKUBqih/dfLhq9XTpKQfoWQJVR8jUez
         obf9VkhjGLuQkigVyUTrM8ZBTJzjooDyrlY8fHQlNCg/hVhSCzPfJES6SUY4j3UVQJ
         1LVAwNZiyPx+zm842U/e3g6eblp0kCA206sJylrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 47/62] perf test code-reading: Fix perf_env setup for PTI entry trampolines
Date:   Mon, 26 Nov 2018 11:51:28 +0100
Message-Id: <20181126105054.323501538@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit f6c66d73bb8192d357bb5fb8cd5826920f811d8c upstream.

The "Object code reading" test will not create maps for the PTI entry
trampolines unless the machine environment exists to show that the arch is
x86_64.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1528183800-21577-1-git-send-email-adrian.hunter@intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/code-reading.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index fcc8984bc329..acad8ba06d77 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -527,6 +527,7 @@ static int do_test_code_reading(bool try_kcore)
 	pid = getpid();
 
 	machine = machine__new_host();
+	machine->env = &perf_env;
 
 	ret = machine__create_kernel_maps(machine);
 	if (ret < 0) {
-- 
2.17.1



