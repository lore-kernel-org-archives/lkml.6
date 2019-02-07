Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B702C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00E520663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfBGNbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:31:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:39123 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfBGNbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:31:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 05:31:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,344,1544515200"; 
   d="scan'208";a="114406966"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 07 Feb 2019 05:31:32 -0800
Received: from [10.125.252.152] (abudanko-mobl.ccr.corp.intel.com [10.125.252.152])
        by linux.intel.com (Postfix) with ESMTP id E81C55800E0;
        Thu,  7 Feb 2019 05:31:28 -0800 (PST)
Subject: [PATCH v2 3/4] perf-security: elaborate on perf_events/Perf
 privileged users
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Jonatan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <fd896eec-7833-f23a-ad2f-95005dca5fff@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e9ca1b07-a79b-58f1-663d-10130299dfe0@linux.intel.com>
Date:   Thu, 7 Feb 2019 16:31:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <fd896eec-7833-f23a-ad2f-95005dca5fff@linux.intel.com>
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
Changes in v2:
- applied comments on v1

---
 Documentation/admin-guide/perf-security.rst | 43 +++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/admin-guide/perf-security.rst b/Documentation/admin-guide/perf-security.rst
index e6eb7e1ee5ad..f27a62805651 100644
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
+users who are permitted to execute performance monitoring without scope limits.
+The following steps can be taken to create such a group of privileged Perf users.
+
+1. Create perf_users group of privileged Perf users, assign perf_users group to
+   Perf tool executable and limit access to the executable for other users in the
+   system who are not in the perf_users group:
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
+2. Assign the required capabilities to the Perf tool executable file and enable
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
+when executes, passes perf_events subsystem scope checks.
+
+This specific access control management is only available to superuser or root
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
