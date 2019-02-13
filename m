Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28C6C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BC8222DA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083301;
	bh=F/715+I9TyXr5VFyhOU9ZTECQ08k5b+6tnotasXcf4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iFccaPjhPavRJkNBo5z0FMhUx3ym3LDrwrSF/3QIgEEk9O0gT6knlfjLLSa3Pops3
	 GOEMsn65ZgMSC4Ltp+cyS6j9joYovmhJrtnHFovYWoj/SXkwucemIFqp28MGKQ/s23
	 hF4oOVtlUiUrx5Vwg60QIVCQTq6P3i5jjFuKuDMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390271AbfBMSlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:41:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405184AbfBMSli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:41:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31830222D7;
        Wed, 13 Feb 2019 18:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083297;
        bh=F/715+I9TyXr5VFyhOU9ZTECQ08k5b+6tnotasXcf4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oG6Sg+4wvDkVHt1dJ3YTgNsgzoF8IpKR9WRn5UkGqa+99Pqn383dqKWnAEDQbbZRo
         3gRwnUvSQrrBXDzyyQE+77RN12HgclKhz6gah69Xfc1h5VZI4fExgk5jUEmwO/OTrB
         x/fLb4e+g0/CnFJ83OXHQK11EKS04t7GlvZLoRFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 26/35] perf tests attr: Fix group stat tests
Date:   Wed, 13 Feb 2019 19:38:21 +0100
Message-Id: <20190213183707.284678675@linuxfoundation.org>
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

From: Jiri Olsa <jolsa@redhat.com>

commit f6a9820d572bd8384d982357cbad214b3a6c04bb upstream.

We started to use group read whenever it's possible:

  82bf311e15d2 perf stat: Use group read for event groups

That breaks some of attr tests, this change adds the new possible
read_format value.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
LPU-Reference: 20170928160633.GA26973@krava
Link: http://lkml.kernel.org/n/tip-1ko2zc4nph93d8lfwjyk9ivz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/tests/attr/test-stat-group  |    2 ++
 tools/perf/tests/attr/test-stat-group1 |    2 ++
 2 files changed, 4 insertions(+)

--- a/tools/perf/tests/attr/test-stat-group
+++ b/tools/perf/tests/attr/test-stat-group
@@ -6,6 +6,7 @@ ret     = 1
 [event-1:base-stat]
 fd=1
 group_fd=-1
+read_format=3|15
 
 [event-2:base-stat]
 fd=2
@@ -13,3 +14,4 @@ group_fd=1
 config=1
 disabled=0
 enable_on_exec=0
+read_format=3|15
--- a/tools/perf/tests/attr/test-stat-group1
+++ b/tools/perf/tests/attr/test-stat-group1
@@ -6,6 +6,7 @@ ret     = 1
 [event-1:base-stat]
 fd=1
 group_fd=-1
+read_format=3|15
 
 [event-2:base-stat]
 fd=2
@@ -13,3 +14,4 @@ group_fd=1
 config=1
 disabled=0
 enable_on_exec=0
+read_format=3|15


