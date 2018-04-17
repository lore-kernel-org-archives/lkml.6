Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeDQEeP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 00:34:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752662AbeDQEeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 00:34:10 -0400
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com, rostedt@goodmis.org
Cc: acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, jolsa@redhat.com,
        kan.liang@intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, fengguang.wu@intel.com, jglisse@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v3 8/9] trace_uprobe/sdt: Document about reference counter
Date: Tue, 17 Apr 2018 10:02:43 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180417043244.7501-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180417043244.7501-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041704-0008-0000-0000-000004EC167E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041704-0009-0000-0000-00001E8017E6
Message-Id: <20180417043244.7501-9-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170042
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Reference counter gate the invocation of probe. If present,
by default reference count is 0. Kernel needs to increment
it before tracing the probe and decrement it when done. This
is identical to semaphore in Userspace Statically Defined
Tracepoints (USDT).

Document usage of reference counter.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 Documentation/trace/uprobetracer.txt | 16 +++++++++++++---
 kernel/trace/trace.c                 |  2 +-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/uprobetracer.txt b/Documentation/trace/uprobetracer.txt
index bf526a7c..cb6751d 100644
--- a/Documentation/trace/uprobetracer.txt
+++ b/Documentation/trace/uprobetracer.txt
@@ -19,15 +19,25 @@ user to calculate the offset of the probepoint in the object.
 
 Synopsis of uprobe_tracer
 -------------------------
-  p[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a uprobe
-  r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a return uprobe (uretprobe)
-  -:[GRP/]EVENT                           : Clear uprobe or uretprobe event
+  p[:[GRP/]EVENT] PATH:OFFSET[(REF_CTR_OFFSET)] [FETCHARGS]
+  r[:[GRP/]EVENT] PATH:OFFSET[(REF_CTR_OFFSET)] [FETCHARGS]
+  -:[GRP/]EVENT
+
+  p : Set a uprobe
+  r : Set a return uprobe (uretprobe)
+  - : Clear uprobe or uretprobe event
 
   GRP           : Group name. If omitted, "uprobes" is the default value.
   EVENT         : Event name. If omitted, the event name is generated based
                   on PATH+OFFSET.
   PATH          : Path to an executable or a library.
   OFFSET        : Offset where the probe is inserted.
+  REF_CTR_OFFSET: Reference counter offset. Optional field. Reference count
+		  gate the invocation of probe. If present, by default
+		  reference count is 0. Kernel needs to increment it before
+		  tracing the probe and decrement it when done. This is
+		  identical to semaphore in Userspace Statically Defined
+		  Tracepoints (USDT).
 
   FETCHARGS     : Arguments. Each probe can have up to 128 args.
    %REG         : Fetch register REG
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 300f4ea..d211937 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4604,7 +4604,7 @@ static int tracing_trace_options_open(struct inode *inode, struct file *file)
   "place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>\n"
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
-	"\t    place: <path>:<offset>\n"
+  "   place (uprobe): <path>:<offset>[(ref_ctr_offset)]\n"
 #endif
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
-- 
1.8.3.1
