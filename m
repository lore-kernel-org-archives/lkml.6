Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498B6C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1008F2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276877;
	bh=MHwDGGG1dqi50sT67KrlRXyht4GU1zTgEdTnizjLKDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UDpH7lTTdrBnBJ0V8vI9bSsf2qCRpUyzRCVthYlTteQIGpgjmlcriJUlPROhUL3px
	 t3zngdMGJZkgrMHbW3TR5m8z3LC4ode9FPHysbxLz2uaftCJLzerh08haQ1gZz2xT5
	 JgqpN5cJXKYG5JouliwsM/ycvB9+A8v0BLSJOIlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfBDKlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:41:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730226AbfBDKlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:41:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70D6A2070C;
        Mon,  4 Feb 2019 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276871;
        bh=MHwDGGG1dqi50sT67KrlRXyht4GU1zTgEdTnizjLKDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v1j+xm0rrH9pHJhyvPoaqdMRVfxkKNbT3sqL+luQkgu1li3N1rVnig2fjZDCMG9il
         VmnfiFWqNFGs9Bu8W/BzEzpekxjGmMgaozPwT49UFiw549F2Pn7BzYs5wivtLE7Bv1
         gseaGjb4I8tAj6obAaf31atcyo7uoA5Eo7wHmsMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Vuille <jpmv27@aim.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 24/65] perf unwind: Unwind with libdw doesnt take symfs into account
Date:   Mon,  4 Feb 2019 11:36:17 +0100
Message-Id: <20190204103614.762496520@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3d20c6246690219881786de10d2dda93f616d0ac ]

Path passed to libdw for unwinding doesn't include symfs path
if specified, so unwinding fails because ELF file is not found.

Similar to unwinding with libunwind, pass symsrc_filename instead
of long_name. If there is no symsrc_filename, fallback to long_name.

Signed-off-by: Martin Vuille <jpmv27@aim.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20180211212420.18388-1-jpmv27@aim.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/unwind-libdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 60edec383281..880e8db32484 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -47,7 +47,7 @@ static int __report_module(struct addr_location *al, u64 ip,
 
 	if (!mod)
 		mod = dwfl_report_elf(ui->dwfl, dso->short_name,
-				      dso->long_name, -1, al->map->start,
+				      (dso->symsrc_filename ? dso->symsrc_filename : dso->long_name), -1, al->map->start,
 				      false);
 
 	return mod && dwfl_addrmodule(ui->dwfl, ip) == mod ? 0 : -1;
-- 
2.19.1



