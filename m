Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAA3C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B4D21919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738136;
	bh=Avq+VJtqu1toCmKDyZ6RnlAVYN5fXXym5aXu4isq1v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=txbETZIMyR7z73+9Q0CBc/ujIinzTFcGG3vuKFDMjw0zb1GkIBkdDXXCWEdaXdX1e
	 upgJEUqIDQslbyalcXgIDaPcpxB+oWXbAEJs02HQfCCX5bTo5Iip4SzHfy6e2sS79c
	 rvyQH5KeEZi9G98jasTO64XDkNvtJX9kZ+OFkUgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfBISsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:48:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbfBISsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7C9B2192C;
        Sat,  9 Feb 2019 18:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738130;
        bh=Avq+VJtqu1toCmKDyZ6RnlAVYN5fXXym5aXu4isq1v0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wUL8f19I82hTvqqe7ZvQad0NfbrcYIWPfXhRVXX5BdyNTR6KeHuoGzToIwrQU+a2J
         Fw//2PQ2es+Rj2+Vhxnr+bWkzYy7+tYsoeYqX/WafcDynvbtu7Hy7fUzjhVWLvG2ae
         mTB8DLgTNrHUEjBUGxSVCTU8jIk/zjwxO4LxmsPA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 04/28] perf test shell: Use a fallback to get the pathname in vfs_getname
Date:   Sat,  9 Feb 2019 13:48:12 -0500
Message-Id: <20190209184840.126418-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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

