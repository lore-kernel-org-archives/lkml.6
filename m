Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B51C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAD0222A2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896405;
	bh=lgHNNgnO/bS4tpgQQy3HoNZL/mLFqAZKhwi10wg0y30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mRBlMuCkxl+R7RDo8qqA1/wkk+1Z9UP269YlvFSZqV5LWDwvZpV+K/3582EeXwl8K
	 uZVpr6QvRQ28D8FQRclzYQ92/ArGJj4cpMcvyC9ApCVA3EEIplYQb8aIP5dh60vgIJ
	 KLfVXzhyM7R8ZhDEk6UtiU4OLUanOMDYeYKdwx38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbfBKOqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:46:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731776AbfBKOqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:46:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1AE6206BA;
        Mon, 11 Feb 2019 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896397;
        bh=lgHNNgnO/bS4tpgQQy3HoNZL/mLFqAZKhwi10wg0y30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+51kL6las5rV5+BLqmUhbdKvobgAveRU1OqByKjIZ2T5VNItHxqzM3Kn0dO+/bNr
         hBSsy4adBA41oe9zGtUto7RC6dxGes79jvZKHuP0iSHxj/n/yWgA7zJSnbL4lbdm/y
         XFCIqWndnCtPYDTxrT/n619SfupozVongOR5kZzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 171/313] perf tools: Cast off_t to s64 to avoid warning on bionic libc
Date:   Mon, 11 Feb 2019 15:17:31 +0100
Message-Id: <20190211141904.817811682@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 866053bb644f754d1a93aaa9db9998fecf7a8978 ]

To avoid this warning:

    CC       /tmp/build/perf/util/s390-cpumsf.o
  util/s390-cpumsf.c: In function 's390_cpumsf_samples':
  util/s390-cpumsf.c:508:3: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'off_t' [-Wformat=]
     pr_err("[%#08" PRIx64 "] Invalid AUX trailer entry TOD clock base\n",
     ^

Now the various Android cross toolchains used in the perf tools
container test builds are all clean and we can remove this:

  export EXTRA_MAKE_ARGS="WERROR=0"

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: https://lkml.kernel.org/n/tip-5rav4ccyb0sjciysz2i4p3sx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/s390-cpumsf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index d2c78ffd9fee..aa7f8c11fbb7 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -499,7 +499,7 @@ static int s390_cpumsf_samples(struct s390_cpumsf_queue *sfq, u64 *ts)
 	aux_ts = get_trailer_time(buf);
 	if (!aux_ts) {
 		pr_err("[%#08" PRIx64 "] Invalid AUX trailer entry TOD clock base\n",
-		       sfq->buffer->data_offset);
+		       (s64)sfq->buffer->data_offset);
 		aux_ts = ~0ULL;
 		goto out;
 	}
-- 
2.19.1



