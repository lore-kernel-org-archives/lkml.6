Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NWTRCs3rGFsSbQAAmS7hNA
	; Thu, 07 Jun 2018 08:25:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B6391607F7; Thu,  7 Jun 2018 08:25:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 18B436063F;
	Thu,  7 Jun 2018 08:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18B436063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932683AbeFGIY5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:24:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53445 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932240AbeFGIYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:24:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578Obcs2127970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:24:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578ObCC2127967;
        Thu, 7 Jun 2018 01:24:37 -0700
Date: Thu, 7 Jun 2018 01:24:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-z960xobig39ca1pmp5brl2fr@git.kernel.org>
Cc: tglx@linutronix.de, jolsa@kernel.org, wangnan0@huawei.com,
        dsahern@gmail.com, mingo@kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        namhyung@kernel.org
Reply-To: wangnan0@huawei.com, jolsa@kernel.org, tglx@linutronix.de,
          namhyung@kernel.org, acme@redhat.com, mingo@kernel.org,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf symbols: Add BSS symbols when reading from
 /proc/kallsyms
Git-Commit-ID: 2be732c02adb15ed7f2196f075fe63ba6991642c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2be732c02adb15ed7f2196f075fe63ba6991642c
Gitweb:     https://git.kernel.org/tip/2be732c02adb15ed7f2196f075fe63ba6991642c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 5 Jun 2018 17:06:57 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:52:09 -0300

perf symbols: Add BSS symbols when reading from /proc/kallsyms

We were not considering 'B' and 'b' (BSS, uninitialized data objects,
that gets set to zero at program start), do it so that we can resolve
more symbols in tools doing resolution of data operands, like 'perf c2c'.

When using vmlinux, i.e. an ELF symbol table, those were already
considered, as the decision was about STT_FUNC or STT_OBJECT, and the
later covers BSS symbols.

  # grep -i ' b ' /proc/kallsyms  | head -20 | tail -5
  ffffffffa789d030 b execute_command
  ffffffffa789d038 b initcall_command_line
  ffffffffa789d040 b static_command_line
  ffffffffa789d048 B ROOT_DEV
  ffffffffa789d050 b once.73786
  #
  # readelf -s /lib/modules/`uname -r`/build/vmlinux | grep ROOT_DEV
  79219: ffffffff8289d048     4 OBJECT  GLOBAL DEFAULT   58 ROOT_DEV
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-z960xobig39ca1pmp5brl2fr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3f632c60888f..d188b7588152 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -73,7 +73,7 @@ static enum dso_binary_type binary_type_symtab[] = {
 static bool symbol_type__filter(char symbol_type)
 {
 	symbol_type = toupper(symbol_type);
-	return symbol_type == 'T' || symbol_type == 'W' || symbol_type == 'D';
+	return symbol_type == 'T' || symbol_type == 'W' || symbol_type == 'D' || symbol_type == 'B';
 }
 
 static int prefix_underscores_count(const char *str)
