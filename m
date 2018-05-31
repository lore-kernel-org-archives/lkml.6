Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755606AbeEaQVN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:21:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43244 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755456AbeEaQVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:21:11 -0400
Date: Thu, 31 May 2018 11:21:10 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] coresight: documentation: update sysfs section
Message-Id: <20180531112110.5769511ef6e379df24820158@arm.com>
In-Reply-To: <20180516152458.d392b0d1e09393da30e2aeb6@arm.com>
References: <20180507172915.c032cd71c07b1849bf419a5f@arm.com>
        <CANLsYkyQLan3XajOz2uuoOF8OQchGfeu2ZkZJ9H1Xm9q==aXTw@mail.gmail.com>
        <20180514121959.a9a3d2fb3d3d270849ffbc39@arm.com>
        <20180516131823.4b1a3ecb@lwn.net>
        <20180516152458.d392b0d1e09393da30e2aeb6@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Align and show updated ls devices output from the TC2, based on
  current driver

- Provide an example from an ETMv4 based system (Juno)

- Reflect changes to the way the RAM write pointer is accessed since
  it got changed in commit 7d83d17795ef ("coresight: tmc: adding sysFS
  management entries").

Cc: Jonathan Corbet <corbet@lwn.net>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
v4: v3 + Randy and Mathieu's acked-bys, for Jonathan to apply.
v3: address Randy Dunlap's showns->shown,  corrected - and + line merging
v2: address Mathieu's comment about clarifying the sinks on the Juno
    vs. TC2 platforms.

 Documentation/trace/coresight.txt | 43 +++++++++++++++++++------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 6f0120c3a4f1..15d2a0f1e1b8 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -141,13 +141,25 @@ register the device with the core framework.  The unregister function takes
 a reference to a "struct coresight_device", obtained at registration time.
 
 If everything goes well during the registration process the new devices will
-show up under /sys/bus/coresight/devices, as showns here for a TC2 platform:
+show up under /sys/bus/coresight/devices, as shown here for a TC2 platform:
 
 root:~# ls /sys/bus/coresight/devices/
-replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
-20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
+20010000.etb   20040000.funnel	2201d000.ptm  2203d000.etm  replicator
+20030000.tpiu  2201c000.ptm	2203c000.etm  2203e000.etm
 root:~#
 
+and here for a Juno platform:
+
+root@juno:~# ls /sys/bus/coresight/devices/
+20010000.etf	 20120000.replicator  22040000.etm     230c0000.funnel
+20030000.tpiu	 20130000.funnel      220c0000.funnel  23140000.etm
+20040000.funnel  20140000.etf	      22140000.etm     23240000.etm
+20070000.etr	 20150000.funnel      23040000.etm     23340000.etm
+root@juno:~# 
+
+Note that on Juno users can select the ETF, ETR and TPIU as a sink target while
+on TC2, the ETB and TPIU can be selected.
+
 The functions take a "struct coresight_device", which looks like this:
 
 struct coresight_desc {
@@ -193,16 +205,16 @@ the information carried in "THIS_MODULE".
 How to use the tracer modules
 -----------------------------
 
-Before trace collection can start, a coresight sink needs to be identify.
+Before trace collection can start, a coresight sink needs to be identified.
 There is no limit on the amount of sinks (nor sources) that can be enabled at
 any given moment.  As a generic operation, all device pertaining to the sink
 class will have an "active" entry in sysfs:
 
 root:/sys/bus/coresight/devices# ls
-replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
-20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
+20010000.etb   20040000.funnel	2201d000.ptm  2203d000.etm  replicator
+20030000.tpiu  2201c000.ptm	2203c000.etm  2203e000.etm
 root:/sys/bus/coresight/devices# ls 20010000.etb
-enable_sink  status  trigger_cntr
+enable_sink  mgmt  power  subsystem  trigger_cntr  uevent
 root:/sys/bus/coresight/devices# echo 1 > 20010000.etb/enable_sink
 root:/sys/bus/coresight/devices# cat 20010000.etb/enable_sink
 1
@@ -216,16 +228,13 @@ trigger a trace capture:
 root:/sys/bus/coresight/devices# echo 1 > 2201c000.ptm/enable_source
 root:/sys/bus/coresight/devices# cat 2201c000.ptm/enable_source
 1
-root:/sys/bus/coresight/devices# cat 20010000.etb/status
-Depth:          0x2000
-Status:         0x1
-RAM read ptr:   0x0
-RAM wrt ptr:    0x19d3   <----- The write pointer is moving
-Trigger cnt:    0x0
-Control:        0x1
-Flush status:   0x0
-Flush ctrl:     0x2001
-root:/sys/bus/coresight/devices#
+
+Observe the write pointer moving:
+
+root:/sys/bus/coresight/devices# cat 20010000.etb/mgmt/rwp
+0x1a8
+root:/sys/bus/coresight/devices# cat 20010000.etb/mgmt/rwp
+0x19a6
 
 Trace collection is stopped the same way:
 
-- 
2.17.0
