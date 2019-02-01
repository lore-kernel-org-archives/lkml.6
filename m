Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462FDC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B9E20870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfBAHbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:31:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:56904 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBAHbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:31:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 23:31:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; 
   d="scan'208";a="143307941"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2019 23:31:03 -0800
Received: from [10.125.252.37] (abudanko-mobl.ccr.corp.intel.com [10.125.252.37])
        by linux.intel.com (Postfix) with ESMTP id 9DBC15803DC;
        Thu, 31 Jan 2019 23:30:59 -0800 (PST)
Subject: [PATCH v1 3/3] perf-security: document perf_events/Perf resource
 control
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Jonatan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <9cfbf7a1-72dd-f9d0-8137-0f120fa74d21@linux.intel.com>
Organization: Intel Corp.
Message-ID: <5ac4b7aa-b640-d8a4-1926-cf612fada974@linux.intel.com>
Date:   Fri, 1 Feb 2019 10:30:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9cfbf7a1-72dd-f9d0-8137-0f120fa74d21@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Elaborate on possible perf_event/Perf privileged users groups
and document steps about creating such groups.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 Documentation/admin-guide/perf-security.rst | 43 +++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/admin-guide/perf-security.rst b/Documentation/admin-guide/perf-security.rst
index 7da7fa459718..fe90f8952be9 100644
--- a/Documentation/admin-guide/perf-security.rst
+++ b/Documentation/admin-guide/perf-security.rst
@@ -73,6 +73,48 @@ enable capturing of additional data required for later performance analysis of
 monitored processes or a system. For example, CAP_SYSLOG capability permits
 reading kernel space memory addresses from /proc/kallsyms file.
 
+perf_events/Perf privileged users
+---------------------------------
+
+Mechanisms of capabilities, privileged capability-dumb files [6]_ and file system
+ACLs [10]_ can be used to create a dedicated group of perf_events/Perf privileged
+users who are permitted to execute performance monitoring without *scope* limits.
+The following steps can be taken to create such a group of privileged Perf users.
+
+1. Create perf_users group of privileged Perf users, assign perf_users group to
+   Perf tool executable and limit *access* to the executable for other users in
+   the system:
+
+::
+
+   # groupadd perf_users
+   # ls -alhF
+   -rwxr-xr-x  2 root root  11M Oct 19 15:12 perf
+   # chgrp perf_users perf
+   # ls -alhF
+   -rwxr-xr-x  2 root perf_users  11M Oct 19 15:12 perf
+   # chmod o-rwx perf
+   # ls -alhF
+   -rwxr-x---  2 root perf_users  11M Oct 19 15:12 perf
+
+2. Assign required capabilities to the Perf tool executable file and enable
+   members of perf_users group with performance monitoring privileges [6]_ :
+
+::
+
+   # setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog=ep" perf
+   # setcap -v "cap_sys_admin,cap_sys_ptrace,cap_syslog=ep" perf
+   perf: OK
+   # getcap perf
+   perf = cap_sys_ptrace,cap_sys_admin,cap_syslog+ep
+
+As a result, members of perf_users group are capable of conducting performance
+monitoring by using functionality of the configured Perf tool executable that,
+when executes, passes perf_events subsystem *scope* checks.
+
+This specific *access* control management is only available to superuser or root
+running processes with CAP_SETPCAP, CAP_SETFCAP [6]_ capabilities.
+
 perf_events/Perf unprivileged users
 -----------------------------------
 
@@ -156,6 +198,7 @@ Bibliography
 .. [7] `<http://man7.org/linux/man-pages/man2/ptrace.2.html>`_
 .. [8] `<https://en.wikipedia.org/wiki/Hardware_performance_counter>`_
 .. [9] `<https://en.wikipedia.org/wiki/Model-specific_register>`_
+.. [10] `<http://man7.org/linux/man-pages/man5/acl.5.html>`_
 .. [11] `<http://man7.org/linux/man-pages/man2/getrlimit.2.html>`_
 .. [12] `<http://man7.org/linux/man-pages/man5/limits.conf.5.html>`_

