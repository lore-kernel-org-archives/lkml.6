Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AB0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBCA20835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550084088;
	bh=WEHIL1r/DJ9eVXsov0T17YDlwMQ8sCGidjdyWbjyyMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wiIc38u+03GwXdai8qRc4VoJXMYdVuScL2VhjubZEiY6Rn7URlutFK1XoONEx1+kf
	 FrWcLXYbPVeuNjI6rftbO3dd9eFfpN/o2COFvUcXrJS7dIx/yWEFlu2qkj0bQm+3UI
	 11zFYT/BMHxnyQ+4EmzustLOQ5NEDt1wNBRup/Cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394312AbfBMSyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:54:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393869AbfBMSlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:41:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DBFF222D6;
        Wed, 13 Feb 2019 18:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083295;
        bh=WEHIL1r/DJ9eVXsov0T17YDlwMQ8sCGidjdyWbjyyMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N388nfp2CQjx55XjoPuAibmsDbIJSFp8UV9WSWxsetuvB08BcOg15DaktFPxqzTMv
         BD+mxOFGfdBmAM24g9da1JZMF+l2dnvZCd7EinDKNaVvGlICJ7emrY4CV7o4z7O9D/
         V8ujBHuRNmFS6XvvDwYU75pvWInfPTNDP0ZV15i0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 25/35] perf tests attr: Fix task term values
Date:   Wed, 13 Feb 2019 19:38:20 +0100
Message-Id: <20190213183707.248020472@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 10836d9f9ac63d40ccfa756f871ce4ed51ae3b52 upstream.

The perf_event_attr::task is 1 by default for first (tracking) event in
the session. Setting task=1 as default and adding task=0 for cases that
need it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170703145030.12903-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/tests/attr/base-record                |    2 +-
 tools/perf/tests/attr/test-record-group          |    1 +
 tools/perf/tests/attr/test-record-group-sampling |    2 +-
 tools/perf/tests/attr/test-record-group1         |    1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -23,7 +23,7 @@ comm=1
 freq=1
 inherit_stat=0
 enable_on_exec=1
-task=0
+task=1
 watermark=0
 precise_ip=0|1|2|3
 mmap_data=0
--- a/tools/perf/tests/attr/test-record-group
+++ b/tools/perf/tests/attr/test-record-group
@@ -17,5 +17,6 @@ sample_type=327
 read_format=4
 mmap=0
 comm=0
+task=0
 enable_on_exec=0
 disabled=0
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ b/tools/perf/tests/attr/test-record-group-sampling
@@ -23,7 +23,7 @@ sample_type=343
 
 # PERF_FORMAT_ID | PERF_FORMAT_GROUP
 read_format=12
-
+task=0
 mmap=0
 comm=0
 enable_on_exec=0
--- a/tools/perf/tests/attr/test-record-group1
+++ b/tools/perf/tests/attr/test-record-group1
@@ -18,5 +18,6 @@ sample_type=327
 read_format=4
 mmap=0
 comm=0
+task=0
 enable_on_exec=0
 disabled=0


