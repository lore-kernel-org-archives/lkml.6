Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE50C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D208E2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549289893;
	bh=0SQIPFggG+2ZObcRRa/S2D/2U1iTb6J3KMRdhc/2r3c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hHlrfs4M4sBQwFskA9r18k4xhxG0vq8eLjlE4CZAE6Pk7BBA/XDNKRoBK/cWAbYG2
	 BuVsqxsimeJK/lcUex4uLO4n3hSK8HnDZd/ed5LTADlX536DRRERaiVxOf/6Ycan9g
	 xrXf+gDbAzqNtR0frtThmxb+CwO8M22Yu8k+cU6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfBDOSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:18:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33977 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfBDOSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:18:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 852BA19E83;
        Mon,  4 Feb 2019 14:18:11 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73C7175A8E;
        Mon,  4 Feb 2019 14:18:09 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/3] perf tools: Move ipc_symbol computation to resort
Date:   Mon,  4 Feb 2019 15:18:05 +0100
Message-Id: <20190204141808.23031-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 04 Feb 2019 14:18:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
currently the we make annotation for ipc column during the
entry display, already outside the progress bar scope, so
it appears like perf report is stuck.

You can see that on following example (with perf.data big enough):
     $ perf record -b ...
     $ perf report -s symbol

The report TUI code will appear stuck when scrolling down,
because annotation are computed at that time. For --stdio,
the output will be displayed noticeably more slowly, than
with the fix.

There's no functional change, I'm just moving the annotation
retrieval to the resort phase, so all the data are ready for
display.

thanks,
jirka


---
Jiri Olsa (3):
      perf tools: Add argument to hists__resort_cb_t callback
      perf tools: Add perf_evsel__output_resort_cb function
      perf tools: Move symbol annotation to resort

 tools/perf/builtin-c2c.c    |  8 ++++----
 tools/perf/builtin-report.c | 21 +++++++++++++++++++--
 tools/perf/util/hist.c      | 19 +++++++++++++------
 tools/perf/util/hist.h      |  4 +++-
 tools/perf/util/sort.c      |  7 -------
 5 files changed, 39 insertions(+), 20 deletions(-)
