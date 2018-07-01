Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002D3C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44A8256B5
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44A8256B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934199AbeGARhE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:37:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031233AbeGAQgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:36:14 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F1193ACC;
        Sun,  1 Jul 2018 16:36:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.14 118/157] perf tools: Fix symbol and object code resolution for vdso32 and vdsox32
Date:   Sun,  1 Jul 2018 18:23:10 +0200
Message-Id: <20180701160858.559839460@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
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

From: Adrian Hunter <adrian.hunter@intel.com>

commit aef4feace285f27c8ed35830a5d575bec7f3e90a upstream.

Fix __kmod_path__parse() so that perf tools does not treat vdso32 and
vdsox32 as kernel modules and fail to find the object.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: stable@vger.kernel.org
Fixes: 1f121b03d058 ("perf tools: Deal with kernel module names in '[]' correctly")
Link: http://lkml.kernel.org/r/1528117014-30032-3-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/dso.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -352,6 +352,8 @@ int __kmod_path__parse(struct kmod_path
 		if ((strncmp(name, "[kernel.kallsyms]", 17) == 0) ||
 		    (strncmp(name, "[guest.kernel.kallsyms", 22) == 0) ||
 		    (strncmp(name, "[vdso]", 6) == 0) ||
+		    (strncmp(name, "[vdso32]", 8) == 0) ||
+		    (strncmp(name, "[vdsox32]", 9) == 0) ||
 		    (strncmp(name, "[vsyscall]", 10) == 0)) {
 			m->kmod = false;
 


