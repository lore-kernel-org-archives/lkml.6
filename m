Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B88C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B8F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547115185;
	bh=HHa7fPV9lnl+G/MTGtxHB5Gm0sLJoJBqD/F6A9+6Olg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=o9kHKG0IVKc4HMCk4eu5XDOQ+QZhGVNhBPPZEmOfLKxkk8awlm2QOuGNPSZvSXsz+
	 QrYodrKtL/uKmCBYPewiFskKej5yWaoYli/cW+95WbFfQY+mttoDWWRcCTnkupcdHj
	 xPZjhHrEjpm/ntiUKJc6r5DWaTSCxGIZplpEeDfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfAJKNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:13:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfAJKND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:13:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A866FCA396;
        Thu, 10 Jan 2019 10:13:03 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0C9026380;
        Thu, 10 Jan 2019 10:13:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCHv2 0/6] perf session: Add reader object
Date:   Thu, 10 Jan 2019 11:12:55 +0100
Message-Id: <20190110101301.6196-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 10 Jan 2019 10:13:03 +0000 (UTC)
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
  perf/reader

Changes in v2:
  - rebased on latest perf/core
  - added dependency patch (1/6) that was omitted in the original post

thanks,
jirka


---
Jiri Olsa (6):
      perf session: Rearrange perf_session__process_events function
      perf session: Get rid of file_size variable
      perf session: Add reader object
      perf session: Add data_size to reader object
      perf session: Add data_offset to reader object
      perf session: Add reader__process_events function

 tools/perf/util/session.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 50 insertions(+), 35 deletions(-)
