Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5CCC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2951820849
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GwgLC8+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2951820849
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933343AbeGIWAW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:00:22 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35844 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933053AbeGIWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:00:19 -0400
Received: by mail-pf0-f195.google.com with SMTP id u16-v6so14586789pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 15:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=tuHn/zaz5ZdGnjNeeyOjWstdWIcCXsAyDAMyThlM9dc=;
        b=GwgLC8+rjPXgTyqgXEUMY5LLOD2tQedU8qWqlXIdXLH/7auYT/7QjrpCOTuVysDaXS
         UM0XbBvt8OL5nqtGIf4x/sc6DTachLRxRwWMXq/0zTUccwD025uoLRd+0MFG4uCGtHsp
         7TKYNakSMnfdIVi+MgUJyjt6pUE/H5N8xr5HPHd9d1MJIvzHPHMjStZ5GyE4h+knIC39
         oJhjly9JTRrcXcrcxkOZoNHN4NMsE2rrx1nVbhTqDd00x1a8Q8khVF9HdOCMA7aqJQUN
         4c4GZAlTBmMbay61qGfnXlE3DPDx5LBJ1FMNCxN6CTIdQgqUjNQojHyQmEGfQraLMKbg
         IWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=tuHn/zaz5ZdGnjNeeyOjWstdWIcCXsAyDAMyThlM9dc=;
        b=JidvpLOM3HbCK7HyribrI9jvyDAx+disX5IJ4iLMygXH73VhfCeXlOgdoyqzvPDcq4
         Mk89Zo2CHbVcLdJmG1TeqfkULPnsDwaWnUTkDLPh88J4/iou09XQiT9YQAasY562fhV1
         OT4LZjNQh/+5dCbwYVOzhj9iJVn5eQnWnmR+w8em5Mfdc0PtFHAV/fch3++SDN6OMFgU
         Jw0Jra+f46AlvGaxJSIDmDvL2BWYG45/Gyjn6pSJY8o0bgyFF4D2K8tb1wBaHcHUbzLY
         t7S84nFuXBGmNJRdkvzGrU6iKBidI78u+EId7LoRK8Zokeel9KSJrPbzcce8xw1+OXgw
         LWKA==
X-Gm-Message-State: APt69E2GFmY73cJCUDwmfO8MudDHVOJy7NLmonZ1xEBvLHm6U6zhECry
        PDnlcpBiODrhN1g5fq/jimkkww==
X-Google-Smtp-Source: AAOMgpdP12wdXUDme4pSCMqrdKcakyY9JTSNiCo28mis/Bw8HZM4fd5pHMFTR+DwVl6wFPrMimmQjg==
X-Received: by 2002:a62:c1:: with SMTP id 184-v6mr475291pfa.100.1531173618754;
        Mon, 09 Jul 2018 15:00:18 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z66-v6sm31639803pfi.150.2018.07.09.15.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:00:17 -0700 (PDT)
Date:   Mon, 9 Jul 2018 15:00:17 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch] docs, debugfs: start explicit debugfs documentation
Message-ID: <alpine.DEB.2.21.1807091459410.118937@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no canonical location for debugfs docuemntation, so start one.

This is primarily motivated to describe the oom_free_timeout_ms interface
but it is extended for all the debugfs files that I am personally
interested in.

Hopefully this can be expanded in the future for better insight into how
the various interfaces can be used.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 Documentation/clearing-warn-once.txt       |   7 --
 Documentation/debugfs/00-INDEX             |   8 ++
 Documentation/debugfs/extfrag.txt          |  46 +++++++
 Documentation/debugfs/provoke-crashes.txt  |   8 ++
 Documentation/debugfs/root.txt             | 137 +++++++++++++++++++++
 Documentation/filesystems/debugfs.txt      |  46 +++++++
 Documentation/power/basic-pm-debugging.txt |  25 +---
 Documentation/sysctl/vm.txt                |   7 +-
 8 files changed, 251 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/clearing-warn-once.txt
 create mode 100644 Documentation/debugfs/00-INDEX
 create mode 100644 Documentation/debugfs/extfrag.txt
 create mode 100644 Documentation/debugfs/provoke-crashes.txt
 create mode 100644 Documentation/debugfs/root.txt

diff --git a/Documentation/clearing-warn-once.txt b/Documentation/clearing-warn-once.txt
deleted file mode 100644
index 5b1f5d547be1..000000000000
--- a/Documentation/clearing-warn-once.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-
-WARN_ONCE / WARN_ON_ONCE only print a warning once.
-
-echo 1 > /sys/kernel/debug/clear_warn_once
-
-clears the state and allows the warnings to print once again.
-This can be useful after test suite runs to reproduce problems.
diff --git a/Documentation/debugfs/00-INDEX b/Documentation/debugfs/00-INDEX
new file mode 100644
index 000000000000..5ad3c7e1af51
--- /dev/null
+++ b/Documentation/debugfs/00-INDEX
@@ -0,0 +1,8 @@
+00-INDEX
+	- this file
+extfrag.txt
+	- External fragmentation (compaction)
+provoke-crash.txt
+	- LKDTM triggers
+root.txt
+	- Documentation for files at the debugfs root
diff --git a/Documentation/debugfs/extfrag.txt b/Documentation/debugfs/extfrag.txt
new file mode 100644
index 000000000000..4a351e34dd98
--- /dev/null
+++ b/Documentation/debugfs/extfrag.txt
@@ -0,0 +1,46 @@
+External fragmentation debugfs files
+
+This subdirectory is only available if memory compaction (CONFIG_COMPACTION) is
+enabled for defragmentation.
+
+
+extfrag_index
+=============
+The fragmentation index is a value between 0 and 1 and indicates how much
+external fragmentation there is for each allocation order, from order-0 to
+MAX_ORDER-1, for reach zone.  This can be used for memory compaction heuristics
+to determine if migrating memory is likely to allow an allocation at a specific
+order to become successful.  The higher the value specifies that the allocation
+at that order would fail due to fragmentation.  The lower the value specifies
+that the allocation at that order would fail to being low on memory.  A value
+of -1.000 specifies the allocation at that order would immediately succeed.
+
+Example output:
+
+Node 0, zone    DMA32 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000
+Node 0, zone   Normal -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000
+
+This file cannot be written.
+
+This is often used to tune the vm.extfrag_threshold sysctl, see
+Documentation/sysctl/vm.txt, to define memory compaction behavior.
+
+
+unusable_index
+==============
+The unusable free space index is a value between 0 and 1 and indicates how much
+of each zone's free memory cannot be used for an allocation of a given order,
+from order-0 to MAX_ORDER-1.  The higher the value, the more free memory is
+unusuable for that order and implicates external fragmentation.  This can be
+used in conjunction with extfrag_index to understand the external fragmentation
+of a zone.
+
+Example output:
+
+Node 0, zone    DMA32 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.002 0.004 
+Node 0, zone   Normal 0.000 0.000 0.001 0.003 0.005 0.007 0.008 0.008 0.008 0.008 0.008 
+
+This file cannot be written.
+
+This is often used to tune the vm.extfrag_threshold sysctl, see
+Documentation/sysctl/vm.txt, to define memory compaction behavior.
diff --git a/Documentation/debugfs/provoke-crashes.txt b/Documentation/debugfs/provoke-crashes.txt
new file mode 100644
index 000000000000..69ec3a0a5a86
--- /dev/null
+++ b/Documentation/debugfs/provoke-crashes.txt
@@ -0,0 +1,8 @@
+Provokes crashes LKDTM interface
+
+When the Linux Kernel Dump Test Tool Module (LKDTM) is available, this directory
+exports triggers that are available to induce specific actions, usually
+triggering different dumping mechanisms, at predefined crash points.
+
+See Documentation/fault-injection/provoke-crashes.txt for examples of how to
+induce exceptions, panics, overflow, etc, at predefined crash points.
diff --git a/Documentation/debugfs/root.txt b/Documentation/debugfs/root.txt
new file mode 100644
index 000000000000..3bb2ff395aff
--- /dev/null
+++ b/Documentation/debugfs/root.txt
@@ -0,0 +1,137 @@
+Debugfs root files
+Started by David Rientjes <rientjes@google.com>
+
+This file documents files at the root of debugfs.  For information on mounting
+or creating debugfs interfaces, please see
+Documentation/filesystems/debugfs.txt.
+
+Files under subdirectories of debugfs should be documented in a file of its
+subdirectory name in Documentation/debugfs.
+
+
+clear_warn_once
+===============
+Normally, WARN_ONCE() and WARN_ON_ONCE() prints a particular warning only a
+single time during a system's uptime.
+
+This file cannot be read.
+
+When written with any value, this clears the state of all such warnings.  This
+will cause the warnings to be emitted once again if reached.
+
+This is often useful for test suites to reproduce problems and detect errors
+that would otherwise be suppressed.
+
+
+fault_around_bytes
+==================
+On read fault, the VM attempts to fault pages surrounding the fault address for
+spacial locality.
+
+When read, this specifices that number of bytes that the VM will attempt to map
+around the faulting address.
+
+When written with a power-of-2 size, or the minimum of the native page size of
+the system, this defines the number of bytes to fault around.  The value will
+be rounded down to the nearest power-of-2.  The maximum value is the typically
+the amount of memory mapped by a pmd.
+
+
+oom_free_timeout_ms
+===================
+When a process is out of memory (oom) killed, a grace period is allowed for the
+process to handle the SIGKILL and free its memory before additional processes
+are oom killed.  In such situations, it is possible that the system becomes
+livelocked because the oom victim is waiting on a lock held by an allocator.
+
+When read, this specifies the minimum number of millisecs that the oom killer
+will wait before killing additional processes because it is assumed the original
+victim cannot make forward progress.
+
+When written, this increases or decreases the number of millisecs to wait before
+additional processes are oom killed.  A lower value will cause the oom killer
+to more aggressively kill additional processes, perhaps unnecessarily because
+the original victim could exit.  A higher value allows more time for the victim
+to exit.
+
+Since the oom reaper can usually free a least part of the victim's memory
+before it actually exits, it is recommended to set this to enough time such
+that additional processes are not killed unnecessarily.
+
+
+sleep_time
+==========
+Timekeeping keeps track of how much time is spent in suspend.
+
+When read, this file shows a histogram that describes the number of times that
+timekeeping was suspended for the shown range, in seconds.
+
+This file cannot be written.
+
+
+split_huge_pages
+================
+When transparent hugepages is enabled, hugepages may be transparently split
+without knowledge of the application that maps them.
+
+This file cannot be read.
+
+When '1' is written, this walks all memory and synchronously splits all
+transparent hugepages.  The number of hugepages split is shown in the kernel
+log.
+
+This is typically only needed for debugging.
+
+
+suspend_stats
+=============
+Supend to RAM provides statistics on the number of successes, and the number of
+failures in suspend, as well as a breakdown of how many failures are for the
+various possible reasons.
+
+When read, the following is example output:
+	success: 20
+	fail: 5
+	failed_freeze: 0
+	failed_prepare: 0
+	failed_suspend: 5
+	failed_suspend_noirq: 0
+	failed_resume: 0
+	failed_resume_noirq: 0
+	failures:
+	  last_failed_dev:	alarm
+				adc
+	  last_failed_errno:	-16
+				-16
+	  last_failed_step:	suspend
+				suspend
+
+This specifies the last two failed devices, error number, and failed suspend
+step.
+
+This file cannot be written.
+
+
+wakeup_sources
+==============
+For power management sleep, it is helpful to know the source of any wakeups
+that cause the sleep state to be interrupted.
+
+When read, this file specifies the source of wakeups (normally a device or
+timer), the active, event, and wakeup counts, total time, max time, and last
+change.
+
+The following is example output:
+name		active_count	event_count	wakeup_count	expire_count	active_since	total_time	max_time	last_change	prevent_suspend_time
+0000:00:1d.2	0		0		0		0		0		0		0		17416		0
+0000:00:1d.1	0		0		0		0		0		0		0		17415		0
+0000:00:1d.0	0		0		0		0		0		0		0		17414		0
+0000:00:1a.2	0		0		0		0		0		0		0		17413		0
+0000:00:1a.0	0		0		0		0		0		0		0		17412		0
+0000:00:1d.7	0		0		0		0		0		0		0		17406		0
+0000:00:1a.7	0		0		0		0		0		0		0		17395		0
+
+This file cannot be written.
+
+This is often helpful to determine the source of wakeups that may otherwise
+be unknown and for debugging.
diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index 4f45f71149cb..100fbd623b85 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -21,6 +21,10 @@ options can be used.
 
 Note that the debugfs API is exported GPL-only to modules.
 
+This document describes how information can be exported to and manipulated by
+user space.  For information on individual files present in debugfs, at least
+those that have been documented, see Documentation/debugfs.
+
 Code using debugfs should include <linux/debugfs.h>.  Then, the first order
 of business will be to create at least one directory to hold a set of
 debugfs files:
@@ -51,6 +55,48 @@ operations should be provided; others can be included as needed.  Again,
 the return value will be a dentry pointer to the created file, NULL for
 error, or ERR_PTR(-ENODEV) if debugfs support is missing.
 
+For simplicity, it is possible to use the generic DEFINE_SIMPLE_ATTRIBUTE()
+macro to specify the file operations:
+
+    DEFINE_SIMPLE_ATTRIBUTE(noop_debugfs_fops, noop_debugfs_read,
+			    noop_debugfs_write, "%lu\n");
+
+And then define the static callback functions using the "val" formal to
+pass information to be read or written:
+
+    static int noop_debugfs_read(void *data, u64 *val)
+    {
+	u64 p = *data;
+
+	*val = p;
+	return 0;
+    }
+
+    static int noop_debugfs_write(void *data, u64 val)
+    {
+	u64 *p = data;
+
+	*p = val;
+	return 0;
+    }
+
+The "data" pointer from debugfs_create_file() is passed to these callbacks.
+In the simplest form, DEFINE_SIMPLE_ATTRIBUTE() can be used by passing NULL
+for its "data" argument and the read and write callbacks can modify data
+directly:
+
+   static u64 my_noop_value;
+   static int noop_debugfs_read(void *data, u64 *val)
+   {
+	*val = my_noop_value;
+	return 0;
+   }
+   static int noop_debugfs_write(void *data, u64 val)
+   {
+	my_noop_value = val;
+	return 0;
+   }
+
 Create a file with an initial size, the following function can be used
 instead:
 
diff --git a/Documentation/power/basic-pm-debugging.txt b/Documentation/power/basic-pm-debugging.txt
index 708f87f78a75..b1a57763b0e6 100644
--- a/Documentation/power/basic-pm-debugging.txt
+++ b/Documentation/power/basic-pm-debugging.txt
@@ -229,26 +229,5 @@ analogous to the one described in section 1.  If you find some failing drivers,
 you will have to unload them every time before an STR transition (ie. before
 you run s2ram), and please report the problems with them.
 
-There is a debugfs entry which shows the suspend to RAM statistics. Here is an
-example of its output.
-	# mount -t debugfs none /sys/kernel/debug
-	# cat /sys/kernel/debug/suspend_stats
-	success: 20
-	fail: 5
-	failed_freeze: 0
-	failed_prepare: 0
-	failed_suspend: 5
-	failed_suspend_noirq: 0
-	failed_resume: 0
-	failed_resume_noirq: 0
-	failures:
-	  last_failed_dev:	alarm
-				adc
-	  last_failed_errno:	-16
-				-16
-	  last_failed_step:	suspend
-				suspend
-Field success means the success number of suspend to RAM, and field fail means
-the failure number. Others are the failure number of different steps of suspend
-to RAM. suspend_stats just lists the last 2 failed devices, error number and
-failed step of suspend.
+See Documentation/debugfs/root.txt for suspend to RAM statistics if debugfs is
+mounted.
diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
index 960e82759ffb..8eb3917cbd3d 100644
--- a/Documentation/sysctl/vm.txt
+++ b/Documentation/sysctl/vm.txt
@@ -244,9 +244,10 @@ extfrag_threshold
 This parameter affects whether the kernel will compact memory or direct
 reclaim to satisfy a high-order allocation. The extfrag/extfrag_index file in
 debugfs shows what the fragmentation index for each order is in each zone in
-the system. Values tending towards 0 imply allocations would fail due to lack
-of memory, values towards 1000 imply failures are due to fragmentation and -1
-implies that the allocation will succeed as long as watermarks are met.
+the system. See Documentation/debugfs/extfrag.txt. Values tending towards 0
+imply allocations would fail due to lack of memory, values towards 1000 imply
+failures are due to fragmentation and -1 implies that the allocation will
+succeed as long as watermarks are met.
 
 The kernel will not compact memory in a zone if the
 fragmentation index is <= extfrag_threshold. The default value is 500.
