Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06F0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3632080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3632080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeKAHAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:00:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41525 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeKAHAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:00:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM0Iss2558335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:00:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM0I3r2558332;
        Wed, 31 Oct 2018 15:00:18 -0700
Date:   Wed, 31 Oct 2018 15:00:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-btue14k5jemayuykfrwsnh85@git.kernel.org>
Cc:     jolsa@kernel.org, dsahern@gmail.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        wangnan0@huawei.com, acme@redhat.com, adrian.hunter@intel.com,
        tglx@linutronix.de, hpa@zytor.com, benjamin@python.org
Reply-To: namhyung@kernel.org, acme@redhat.com, tglx@linutronix.de,
          adrian.hunter@intel.com, benjamin@python.org, hpa@zytor.com,
          wangnan0@huawei.com, mingo@kernel.org, dsahern@gmail.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace beauty: Allow syscalls to mask an
 argument before considering it
Git-Commit-ID: 496fd346b71ffa0ff35623e9ec79df0bad47bd66
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

Commit-ID:  496fd346b71ffa0ff35623e9ec79df0bad47bd66
Gitweb:     https://git.kernel.org/tip/496fd346b71ffa0ff35623e9ec79df0bad47bd66
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 25 Oct 2018 16:09:47 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 30 Oct 2018 11:46:23 -0300

perf trace beauty: Allow syscalls to mask an argument before considering it

Take mount's 'flags' arg, to cope with this semantic, as defined in do_mount in fs/namespace.c:

  /*
   * Pre-0.97 versions of mount() didn't have a flags word.  When the
   * flags word was introduced its top half was required to have the
   * magic value 0xC0ED, and this remained so until 2.4.0-test9.
   * Therefore, if this magic number is present, it carries no
   * information and must be discarded.
   */

We need to mask this arg, and then see if it is zero, when we simply
don't print the arg name and value.

The next patch will use this for mount's 'flag' arg.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-btue14k5jemayuykfrwsnh85@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7081d7ea12e5..14fb63e17de5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -614,6 +614,7 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 
 struct syscall_arg_fmt {
 	size_t	   (*scnprintf)(char *bf, size_t size, struct syscall_arg *arg);
+	unsigned long (*mask_val)(struct syscall_arg *arg, unsigned long val);
 	void	   *parm;
 	const char *name;
 	bool	   show_zero;
@@ -1487,6 +1488,19 @@ static size_t syscall__scnprintf_name(struct syscall *sc, char *bf, size_t size,
 	return scnprintf(bf, size, "arg%d: ", arg->idx);
 }
 
+/*
+ * Check if the value is in fact zero, i.e. mask whatever needs masking, such
+ * as mount 'flags' argument that needs ignoring some magic flag, see comment
+ * in tools/perf/trace/beauty/mount_flags.c
+ */
+static unsigned long syscall__mask_val(struct syscall *sc, struct syscall_arg *arg, unsigned long val)
+{
+	if (sc->arg_fmt && sc->arg_fmt[arg->idx].mask_val)
+		return sc->arg_fmt[arg->idx].mask_val(arg, val);
+
+	return val;
+}
+
 static size_t syscall__scnprintf_val(struct syscall *sc, char *bf, size_t size,
 				     struct syscall_arg *arg, unsigned long val)
 {
@@ -1535,6 +1549,11 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 				continue;
 
 			val = syscall_arg__val(&arg, arg.idx);
+			/*
+			 * Some syscall args need some mask, most don't and
+			 * return val untouched.
+			 */
+			val = syscall__mask_val(sc, &arg, val);
 
 			/*
  			 * Suppress this argument if its value is zero and
