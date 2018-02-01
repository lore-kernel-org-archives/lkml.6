Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AH8x226kkKwvryP3pRtu0pcI+ENcTkNtrHIk+fTz7xyr2+oid2UaoyI5FAGRDrjckPfbIVPyRz1l
ARC-Seal: i=1; a=rsa-sha256; t=1517508133; cv=none;
        d=google.com; s=arc-20160816;
        b=VF49zkvt5pDpOAZImSPn8A0UWbyM5kNr59ohUMrCnhSyV9M81qzPdIlBV3zxEhEGZ5
         JY58+ZTsJC6NETUECsBHoL7Yfq5YhBrMdsfOeiKTyo001SCkQw6dYiqbE8eQy4wJUaqP
         6dgPbTUNo6fmhsy6wZs3MQBijOtNoP5NqAuWl4JfhNsGWqYnzGla1nyhVmSvZIC840pg
         HU7WnrL2J8gTIKrPktOUhGxyZ4/5KIdEDKjVtm95RMNIMWXn4Cuke0ITfhlOzswfIX+E
         4T7111TUTMGTYHmwXvd+EPetpHGzC3QaSoLBy+LsewCmm62Gl2j2dNbZgvFJtxaQLRek
         U/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=NxbTRPn0RuHG9VYIAhhQIgaatn1I1OF71ZHIgqrDpVA=;
        b=UwZNkWeEE7o1tVOGS7ns+bJkWLiQU1PUmq+CdtgRaS+TGTLqrOn0x4vUUzTzFN5dat
         Pn7iGQm/rRA+2geOL4IpfB4/MN5QYE72/ZwaQoEAIVGDmB1E3COyZkpKmkkH34lMmkIJ
         DpUYFybUA9IuVO3SSfbDDGwlhOv5CyEyLMacfjx0DxZkP3KSdd+QCTaDLzBEqp0N9pGA
         eVFQV7G+gvjtNmHfrjwfM9ztaDJl5pTLOl+qQ3prr72jExMpJT8uDFLUfUe1+mdxOIfv
         DIO224gilQGEx5tOyrFjvANcuNwxOhZTFjOv5sB4UoscXQ/Ndqc/mNFi6r1fJePdtqEQ
         dBAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=CJCtQ2/i;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=CJCtQ2/i;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Khalid Aziz <khalid.aziz@oracle.com>
To: akpm@linux-foundation.org, davem@davemloft.net
Cc: Khalid Aziz <khalid.aziz@oracle.com>, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, tglx@linutronix.de, anthony.yznaga@oracle.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        Khalid Aziz <khalid@gonehiking.org>
Subject: [PATCH v11 09/10] mm: Allow arch code to override copy_highpage()
Date: Thu,  1 Feb 2018 11:01:17 -0700
Message-Id: <3e5949f4cedfdd499bd745135bd99f36cbb13503.1517497017.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1517497017.git.khalid.aziz@oracle.com>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1517497017.git.khalid.aziz@oracle.com>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010231
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591222607977470527?=
X-GMAIL-MSGID: =?utf-8?q?1591222607977470527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some architectures can support metadata for memory pages and when a
page is copied, its metadata must also be copied. Sparc processors
from M7 onwards support metadata for memory pages. This metadata
provides tag based protection for access to memory pages. To maintain
this protection, the tag data must be copied to the new page when a
page is migrated across NUMA nodes. This patch allows arch specific
code to override default copy_highpage() and copy metadata along
with page data upon migration.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
v9:
	- new patch

 include/linux/highmem.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 776f90f3a1cd..0690679832d4 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -237,6 +237,8 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
 
 #endif
 
+#ifndef __HAVE_ARCH_COPY_HIGHPAGE
+
 static inline void copy_highpage(struct page *to, struct page *from)
 {
 	char *vfrom, *vto;
@@ -248,4 +250,6 @@ static inline void copy_highpage(struct page *to, struct page *from)
 	kunmap_atomic(vfrom);
 }
 
+#endif
+
 #endif /* _LINUX_HIGHMEM_H */
-- 
2.11.0
