Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847B0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FD320870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfBAH3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:29:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:57494 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbfBAH3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:29:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 23:29:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; 
   d="scan'208";a="143307554"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2019 23:29:16 -0800
Received: from [10.125.252.37] (abudanko-mobl.ccr.corp.intel.com [10.125.252.37])
        by linux.intel.com (Postfix) with ESMTP id 5A1045806C8;
        Thu, 31 Jan 2019 23:29:12 -0800 (PST)
Subject: [PATCH v1 1/3] perf-security: document perf_events/Perf resource
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
Message-ID: <bfd0e4bb-a4a5-e65d-e8e2-d2c9d03f3160@linux.intel.com>
Date:   Fri, 1 Feb 2019 10:29:11 +0300
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


Extend perf-security.rst file with perf_events/Perf resource control
section describing RLIMIT_NOFILE and perf_event_mlock_kb settings for
performance monitoring user processes.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 Documentation/admin-guide/perf-security.rst | 36 +++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/perf-security.rst b/Documentation/admin-guide/perf-security.rst
index f73ebfe9bfe2..ff6832191577 100644
--- a/Documentation/admin-guide/perf-security.rst
+++ b/Documentation/admin-guide/perf-security.rst
@@ -84,6 +84,40 @@ governed by perf_event_paranoid [2]_ setting:
      locking limit is imposed but ignored for unprivileged processes with
      CAP_IPC_LOCK capability.
 
+perf_events/Perf resource control
+---------------------------------
+
+perf_events system call API [2]_ allocates file descriptors for every configured
+PMU event. Open file descriptors are a per-process accountable *resource* governed
+by RLIMIT_NOFILE [11]_ limit (ulimit -n), which is usually derived from the login
+shell process. When configuring Perf collection for a long list of events on a
+large server system, this limit can be easily hit preventing required monitoring
+configuration. RLIMIT_NOFILE limit can be increased on per-user basis modifying
+content of limits.conf file [12]_ on some systems. Ordinary Perf sampling session
+(perf record) requires an amount of open perf_event file descriptors that is not
+less than a number of monitored events multiplied by a number of monitored CPUs.
+
+An amount of memory available to user processes for capturing performance monitoring
+data is governed by perf_event_mlock_kb [2]_ setting. This perf_event specific
+*resource* setting defines overall per-cpu limits of memory allowed for mapping
+by the user processes to execute performance monitoring. The setting essentially
+extends RLIMIT_MEMLOCK [11]_ limit but only for memory regions mapped specially
+for capturing monitored performance events and related data.
+
+For example, if a machine has eight cores and perf_event_mlock_kb limit is set
+to 516 KiB then a user process is provided with 516 KiB * 8 = 4128 KiB of memory
+above RLIMIT_MEMLOCK limit (ulimit -l) for perf_event mmap buffers. In particular
+this means that if the user wants to start two or more performance monitoring
+processes, it is required to manually distribute available 4128 KiB between the
+monitoring processes, for example, using --mmap-pages Perf record mode option.
+Otherwise, the first started performance monitoring process allocates all available
+4128 KiB and the other processes will fail to proceed due to the lack of memory.
+
+RLIMIT_MEMLOCK and perf_event_mlock_kb *resource* constraints are ignored for
+processes with CAP_IPC_LOCK capability. Thus, perf_events/Perf privileged users
+can be provided with memory above the constraints for perf_events/Perf performance
+monitoring purpose by providing the Perf executable with CAP_IPC_LOCK capability.
+
 Bibliography
 ------------
 
@@ -94,4 +128,6 @@ Bibliography
 .. [5] `<https://www.kernel.org/doc/html/latest/security/credentials.html>`_
 .. [6] `<http://man7.org/linux/man-pages/man7/capabilities.7.html>`_
 .. [7] `<http://man7.org/linux/man-pages/man2/ptrace.2.html>`_
+.. [11] `<http://man7.org/linux/man-pages/man2/getrlimit.2.html>`_
+.. [12] `<http://man7.org/linux/man-pages/man5/limits.conf.5.html>`_
