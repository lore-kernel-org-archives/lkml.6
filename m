Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E8EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD3C2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501259;
	bh=49fVJJZn3Pxqhk48+uJhW6TY+JcqOEwd7pPFZiJK4cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uJ101DtD08cp0WYRzedkjLjTCt39uAcLuTcwNzjUeDPY44vgKiY063v4iAWVcxCp3
	 thd3CBeVClIIKlX5sroB7v4WfqOKSYLq6r6GRuo9V6ei04aBKRl5Fw+FAGmewAWe33
	 qvQRkRywgmZkgBU81iTx8dCK9MMLVRuBKh4UGiCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbfBRNpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731350AbfBRNpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE140218FC;
        Mon, 18 Feb 2019 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497533;
        bh=49fVJJZn3Pxqhk48+uJhW6TY+JcqOEwd7pPFZiJK4cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q56mvZZUmCTrlHgX8PXv/ayqfAlFvYNITuRSVOB3btF7rbsMNHh0y2UASO089czmb
         An0j4nP3Y9gEE8fGP7AtWMhS/OKUbg0MHW69NCHam7PKDGt3OP+MpzZOHGX5IGmTR4
         9bvph0n4rVOTpliY/2Yqcbio1o1KN74VPqp8ZDNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 08/92] perf test shell: Use a fallback to get the pathname in vfs_getname
Date:   Mon, 18 Feb 2019 14:42:11 +0100
Message-Id: <20190218133455.403916951@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 03fa483821c0b4db7c2b1453d3332f397d82313f ]

Some kernels, like 4.19.13-300.fc29.x86_64 in fedora 29, fail with the
existing probe definition asking for the contents of result->name,
working when we ask for the 'filename' variable instead, so add a
fallback to that.

Now those tests are back working on fedora 29 systems with that kernel:

  # perf test vfs_getname
  65: Use vfs_getname probe to get syscall args filenames   : Ok
  66: Add vfs_getname probe to get syscall args filenames   : Ok
  67: Check open filename arg using perf trace + vfs_getname: Ok
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-klt3n0i58dfqttveti09q3fi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 1c16e56cd93e..7cb99b433888 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -13,7 +13,8 @@ add_probe_vfs_getname() {
 	local verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
 		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
-		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=result->name:string"
+		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
+		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
 	fi
 }
 
-- 
2.19.1



