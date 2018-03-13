Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELsBLa84z1Vk1gItkwaxqxO1+rUBsLkUh+t3+wU5LM5kS3BbjacTlPRxGrGc1yF+n7oPbw+9
ARC-Seal: i=1; a=rsa-sha256; t=1520945659; cv=none;
        d=google.com; s=arc-20160816;
        b=GJVcKBC2od/oP091t04FlyrCQCUtMcA+zy6jDDfLsjVel9BsgNe7aDjJYQCNQwxBMQ
         rTOiev6MbGuMfRl/cEveBRN+5mCMZUcz8ONM6B1OIozkS4PAmhLUMLh/FQWLbBQrese6
         NsRiQDw9rcroN0DCdZE5/3ZSpomOYP/OWptOsYgOgfmq0AhZEngB8597pKqaejGpvpp0
         6JmtcyVQj+OftquQXCu30+c03RO8p8XCI9S2wo2IIULXp3S3w1Ib/vkn+Hg8LAKrKy4s
         9qdFvfYxf5nX1t3qwcrhDrgG27ymmvJjgPqHGccwxHc0JMtSzvQf5pon7JiHQdtWTbQ1
         QubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=4e6DbnzQbrEqHjJHotwM3+3Fm2D5JswjzjLZw71R5JI=;
        b=YViCipv3Wvwa0tXQ6gTHvRjVBQhGmFnkMTgNUcXT0oCHy9v8ZybeCFG3NN1oO82SKR
         Lm92/0vrlOZ312ptQKSaVsYM6K/ez2qPw1mKKL4r0pFiuBaT+V7GAS5BmX3WStRGCgL6
         VnHC5+NzA9EmqQorCN+hnUIGkSpsXmUB3x37xdEzGXWj5u8wv0aByKDdiBjlMkrrB/OR
         IOPpk9WmefoZk+/HnNT6XBkP18ZCShm0M6T+o8r0+J3cTPpt9NhMfkPKz3lBLuPb2ydZ
         ddsiVoTMJjWfgxjSdv7t7S3ZuOd1+8iKr2qsNJCgkXLrHzrPZ2OGUXaaFp2l0k013nK0
         To1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com
Cc: acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        huawei.libin@huawei.com, hughd@google.com, jack@suse.cz,
        jglisse@redhat.com, jolsa@redhat.com, kan.liang@intel.com,
        kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, pombredanne@nexb.com,
        rostedt@goodmis.org, tglx@linutronix.de, tmricht@linux.vnet.ibm.com,
        willy@infradead.org, yao.jin@linux.intel.com, fengguang.wu@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 1/8] Uprobe: Export vaddr <-> offset conversion functions
Date: Tue, 13 Mar 2018 18:25:56 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031312-0008-0000-0000-000004DBFABF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031312-0009-0000-0000-00001E6F2D65
Message-Id: <20180313125603.19819-2-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130153
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827116225046806?=
X-GMAIL-MSGID: =?utf-8?q?1594827116225046806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No functionality changes.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 include/linux/mm.h      | 12 ++++++++++++
 kernel/events/uprobes.c | 10 ----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42..95909f2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2274,6 +2274,18 @@ struct vm_unmapped_area_info {
 		return unmapped_area(info);
 }
 
+static inline unsigned long
+offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
+{
+	return vma->vm_start + offset - ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
+}
+
+static inline loff_t
+vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
+{
+	return ((loff_t)vma->vm_pgoff << PAGE_SHIFT) + (vaddr - vma->vm_start);
+}
+
 /* truncate.c */
 extern void truncate_inode_pages(struct address_space *, loff_t);
 extern void truncate_inode_pages_range(struct address_space *,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ce6848e..bd6f230 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -130,16 +130,6 @@ static bool valid_vma(struct vm_area_struct *vma, bool is_register)
 	return vma->vm_file && (vma->vm_flags & flags) == VM_MAYEXEC;
 }
 
-static unsigned long offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
-{
-	return vma->vm_start + offset - ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-}
-
-static loff_t vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
-{
-	return ((loff_t)vma->vm_pgoff << PAGE_SHIFT) + (vaddr - vma->vm_start);
-}
-
 /**
  * __replace_page - replace page in vma by new page.
  * based on replace_page in mm/ksm.c
-- 
1.8.3.1
