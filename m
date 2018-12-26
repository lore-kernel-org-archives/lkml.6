Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FCDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F268321720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545832298;
	bh=YuLe31/adf888vtNYW4fmx16vzVCC0jEs/bxl++IO6g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xgILMO3ln9sgV5Moqb9wh3P/7T5bFytOOaNFwliyCd5C15odThqmlCGzFSAF5ZnpD
	 +sy//FN25kmBoZE3jRwIRfUD1Qm9ZRYpqYVXCg5nIVu41EIZ41WbWFASL+hBZqgfJR
	 N0kJFTj5Y4I41DughDfSErvUUl1inTfoxSGPDlPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeLZNvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:51:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbeLZNvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:51:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 818DB86663;
        Wed, 26 Dec 2018 13:51:36 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-92.brq.redhat.com [10.40.204.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4086719743;
        Wed, 26 Dec 2018 13:51:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 0/5] perf session: Add reader object
Date:   Wed, 26 Dec 2018 14:51:27 +0100
Message-Id: <20181226135132.29330-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 26 Dec 2018 13:51:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this patchset adds reader object to interface event
processing for any data. It's defined as:

  struct reader {
        int fd;
        u64 data_size;
        u64 data_offset;
  };

Now we can simply define reader object for arbitrary file
data portion and pass it to reader__process_events function
to process its data.

It's preparation for multiple file storage under perf.data
directory.

Available also in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


---
Jiri Olsa (5):
      perf session: Get rid of file_size variable
      perf session: Add reader object
      perf session: Add data_size to reader object
      perf session: Add data_offset to reader object
      perf session: Add reader__process_events function

 tools/perf/util/session.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 47 insertions(+), 26 deletions(-)
