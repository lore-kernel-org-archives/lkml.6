Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeDDI3F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:29:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751314AbeDDI3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:29:04 -0400
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
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 3/9] Uprobe: Move mmput() into free_map_info()
Date: Wed,  4 Apr 2018 14:01:04 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180404083110.18647-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180404083110.18647-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18040408-0044-0000-0000-00000543446D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040408-0045-0000-0000-0000288359E4
Message-Id: <20180404083110.18647-4-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040089
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@redhat.com>

build_map_info() has a side effect like one need to perform
mmput() when done with the mm. Add mmput() in free_map_info()
so that user does not have to call it explicitly.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 kernel/events/uprobes.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 535fd39..1d439c7 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -704,6 +704,7 @@ struct map_info {
 static inline struct map_info *free_map_info(struct map_info *info)
 {
 	struct map_info *next = info->next;
+	mmput(info->mm);
 	kfree(info);
 	return next;
 }
@@ -773,8 +774,11 @@ static inline struct map_info *free_map_info(struct map_info *info)
 
 	goto again;
  out:
-	while (prev)
-		prev = free_map_info(prev);
+	while (prev) {
+		info = prev;
+		prev = prev->next;
+		kfree(info);
+	}
 	return curr;
 }
 
@@ -824,7 +828,6 @@ static inline struct map_info *free_map_info(struct map_info *info)
  unlock:
 		up_write(&mm->mmap_sem);
  free:
-		mmput(mm);
 		info = free_map_info(info);
 	}
  out:
-- 
1.8.3.1
