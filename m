Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD3FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615C02083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131569;
	bh=oE5u7gPOYmqRiluZw/WWYiA3pOfOjFrYrSUL4WnvpSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kZhH6nYhU3baGrnsmsR35mXfS+xu5X03FqxGsibbhD6nbM3BHwUiLgzwI5oub9QY6
	 Fs0k6elTgaeAwc27U8VnHf+e6xbCAnm9oIFizEB5igbmRNfHO7fRsm0/JV+xJVYbvq
	 Ib75L/+zxUDmI8ynAAulfgmdRgbWY/cSRTJGOi9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfBYVWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730473AbfBYVWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:34 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB46721848;
        Mon, 25 Feb 2019 21:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129753;
        bh=oE5u7gPOYmqRiluZw/WWYiA3pOfOjFrYrSUL4WnvpSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBHpFGUD+Nb6QESw2hyzVdGJukgwrWD75gFJC1Pj4hgjSNZ0vGUf1wjk6Dhir78YW
         pAkBEBSs10L4cOapNYzE8/+UWnCkaNGFrBTneYSIOvGMX+r2Ya45wqXJZmhcCvc9it
         1OyMUnV6DY3HgLgS5upnolegXjP/5I9n+yQ/YRQU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Sanagi Koki <sanagi.koki@jp.fujitsu.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/37] perf script python: Add Python3 support to netdev-times.py
Date:   Mon, 25 Feb 2019 18:20:26 -0300
Message-Id: <20190225212035.24781-29-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Support both Python2 and Python3 in the netdev-times.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2
version is now v2.6.

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Sanagi Koki <sanagi.koki@jp.fujitsu.com>
Link: http://lkml.kernel.org/r/20190222230619.17887-2-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/netdev-times.py | 82 ++++++++++++-----------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/tools/perf/scripts/python/netdev-times.py b/tools/perf/scripts/python/netdev-times.py
index 9b2050f778f1..267bda49325d 100644
--- a/tools/perf/scripts/python/netdev-times.py
+++ b/tools/perf/scripts/python/netdev-times.py
@@ -8,6 +8,8 @@
 # dev=: show only thing related to specified device
 # debug: work with debug mode. It shows buffer status.
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -17,6 +19,7 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 from perf_trace_context import *
 from Core import *
 from Util import *
+from functools import cmp_to_key
 
 all_event_list = []; # insert all tracepoint event related with this script
 irq_dic = {}; # key is cpu and value is a list which stacks irqs
@@ -61,12 +64,12 @@ def diff_msec(src, dst):
 def print_transmit(hunk):
 	if dev != 0 and hunk['dev'].find(dev) < 0:
 		return
-	print "%7s %5d %6d.%06dsec %12.3fmsec      %12.3fmsec" % \
+	print("%7s %5d %6d.%06dsec %12.3fmsec      %12.3fmsec" %
 		(hunk['dev'], hunk['len'],
 		nsecs_secs(hunk['queue_t']),
 		nsecs_nsecs(hunk['queue_t'])/1000,
 		diff_msec(hunk['queue_t'], hunk['xmit_t']),
-		diff_msec(hunk['xmit_t'], hunk['free_t']))
+		diff_msec(hunk['xmit_t'], hunk['free_t'])))
 
 # Format for displaying rx packet processing
 PF_IRQ_ENTRY= "  irq_entry(+%.3fmsec irq=%d:%s)"
@@ -98,55 +101,55 @@ def print_receive(hunk):
 	if show_hunk == 0:
 		return
 
-	print "%d.%06dsec cpu=%d" % \
-		(nsecs_secs(base_t), nsecs_nsecs(base_t)/1000, cpu)
+	print("%d.%06dsec cpu=%d" %
+		(nsecs_secs(base_t), nsecs_nsecs(base_t)/1000, cpu))
 	for i in range(len(irq_list)):
-		print PF_IRQ_ENTRY % \
+		print(PF_IRQ_ENTRY %
 			(diff_msec(base_t, irq_list[i]['irq_ent_t']),
-			irq_list[i]['irq'], irq_list[i]['name'])
-		print PF_JOINT
+			irq_list[i]['irq'], irq_list[i]['name']))
+		print(PF_JOINT)
 		irq_event_list = irq_list[i]['event_list']
 		for j in range(len(irq_event_list)):
 			irq_event = irq_event_list[j]
 			if irq_event['event'] == 'netif_rx':
-				print PF_NET_RX % \
+				print(PF_NET_RX %
 					(diff_msec(base_t, irq_event['time']),
-					irq_event['skbaddr'])
-				print PF_JOINT
-	print PF_SOFT_ENTRY % \
-		diff_msec(base_t, hunk['sirq_ent_t'])
-	print PF_JOINT
+					irq_event['skbaddr']))
+				print(PF_JOINT)
+	print(PF_SOFT_ENTRY %
+		diff_msec(base_t, hunk['sirq_ent_t']))
+	print(PF_JOINT)
 	event_list = hunk['event_list']
 	for i in range(len(event_list)):
 		event = event_list[i]
 		if event['event_name'] == 'napi_poll':
-			print PF_NAPI_POLL % \
-			    (diff_msec(base_t, event['event_t']), event['dev'])
+			print(PF_NAPI_POLL %
+			    (diff_msec(base_t, event['event_t']), event['dev']))
 			if i == len(event_list) - 1:
-				print ""
+				print("")
 			else:
-				print PF_JOINT
+				print(PF_JOINT)
 		else:
-			print PF_NET_RECV % \
+			print(PF_NET_RECV %
 			    (diff_msec(base_t, event['event_t']), event['skbaddr'],
-				event['len'])
+				event['len']))
 			if 'comm' in event.keys():
-				print PF_WJOINT
-				print PF_CPY_DGRAM % \
+				print(PF_WJOINT)
+				print(PF_CPY_DGRAM %
 					(diff_msec(base_t, event['comm_t']),
-					event['pid'], event['comm'])
+					event['pid'], event['comm']))
 			elif 'handle' in event.keys():
-				print PF_WJOINT
+				print(PF_WJOINT)
 				if event['handle'] == "kfree_skb":
-					print PF_KFREE_SKB % \
+					print(PF_KFREE_SKB %
 						(diff_msec(base_t,
 						event['comm_t']),
-						event['location'])
+						event['location']))
 				elif event['handle'] == "consume_skb":
-					print PF_CONS_SKB % \
+					print(PF_CONS_SKB %
 						diff_msec(base_t,
-							event['comm_t'])
-			print PF_JOINT
+							event['comm_t']))
+			print(PF_JOINT)
 
 def trace_begin():
 	global show_tx
@@ -172,8 +175,7 @@ def trace_begin():
 
 def trace_end():
 	# order all events in time
-	all_event_list.sort(lambda a,b :cmp(a[EINFO_IDX_TIME],
-					    b[EINFO_IDX_TIME]))
+	all_event_list.sort(key=cmp_to_key(lambda a,b :a[EINFO_IDX_TIME] < b[EINFO_IDX_TIME]))
 	# process all events
 	for i in range(len(all_event_list)):
 		event_info = all_event_list[i]
@@ -210,19 +212,19 @@ def trace_end():
 			print_receive(receive_hunk_list[i])
 	# display transmit hunks
 	if show_tx:
-		print "   dev    len      Qdisc        " \
-			"       netdevice             free"
+		print("   dev    len      Qdisc        "
+			"       netdevice             free")
 		for i in range(len(tx_free_list)):
 			print_transmit(tx_free_list[i])
 	if debug:
-		print "debug buffer status"
-		print "----------------------------"
-		print "xmit Qdisc:remain:%d overflow:%d" % \
-			(len(tx_queue_list), of_count_tx_queue_list)
-		print "xmit netdevice:remain:%d overflow:%d" % \
-			(len(tx_xmit_list), of_count_tx_xmit_list)
-		print "receive:remain:%d overflow:%d" % \
-			(len(rx_skb_list), of_count_rx_skb_list)
+		print("debug buffer status")
+		print("----------------------------")
+		print("xmit Qdisc:remain:%d overflow:%d" %
+			(len(tx_queue_list), of_count_tx_queue_list))
+		print("xmit netdevice:remain:%d overflow:%d" %
+			(len(tx_xmit_list), of_count_tx_xmit_list))
+		print("receive:remain:%d overflow:%d" %
+			(len(rx_skb_list), of_count_rx_skb_list))
 
 # called from perf, when it finds a correspoinding event
 def irq__softirq_entry(name, context, cpu, sec, nsec, pid, comm, callchain, vec):
-- 
2.20.1

