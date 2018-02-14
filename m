Return-Path: <khandual@linux.vnet.ibm.com>
X-Google-Smtp-Source: AH8x22596JxIw6bOpV39xNxbRFALncS2z+yXelSqWLYIpuTe8ScVLP52LIOOLMjvRcvztOPQgRMv
ARC-Seal: i=1; a=rsa-sha256; t=1518584298; cv=none;
        d=google.com; s=arc-20160816;
        b=su4DHAsiv8idzJK+8v88N9qljXY/Wh9Zkw/Scd++DiNjMUaH7kIXYqvqXsF1i938zm
         A6vmHUE/uMb8ndTw+6MeQknQnvU9oWuQ1Vfle7czl+rJ3quE8jbbshHj+ueEP7onr7ua
         9TB8b+OCXMruDa074/hjolwbujrmQhi+xYr1YMJE/1ohX3Oiocw0CHuH36J5EbtOTbWH
         lHeWqYiC5lk5qfCtyK8CTGx7UCevKUssWV+WtGYdvH07m180TTpJ3fNj6r/3yhQSaFQp
         46sg7F/RCk8cyfU42W8JY8NdHRIHiW5nGLHIs88VA82dpNx1eyNRqpBOKNXJW8dyC7kP
         GJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=SwJgqZJAoImPjYTWc6y7oYMg2w3uVmVWj3DuN8UYeYc=;
        b=a6Xak9lJXSOJQ1Z6zrYMlosQMOyv93P2St0jsJxsHToJYZkI4QbXSUcRV0X02C/2tM
         rTXzDWJM/wz3ouE3c5Hjz3QeuvCPwkyuyaGVe01IzkW75BfM2SnN/N1i1FpW359HS7vo
         viO5PRjwq2iSzQbdqoXXAKz7KvLMeiCQF/GNQOd3hXDCIVrG4YQ2wg8VAEx80k0w7aB3
         txG0OQyBORUZwHLPl2h2uEsl6R4Dt4LSs09M9X6wMqlpm/5t9asH92FD7ciaMSucsX8W
         bQY4IwLow+N1UZ1BddIOZ9ZTQ+7Fft8xY7CK+ZMuNLwjvIL0T01fpOopr8+FlEMcM1Sn
         j4dw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of khandual@linux.vnet.ibm.com) smtp.mailfrom=khandual@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of khandual@linux.vnet.ibm.com) smtp.mailfrom=khandual@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        bart.vanassche@wdc.com, jthumshirn@suse.de, axboe@kernel.dk,
        chris@chris-wilson.co.uk, tvrtko.ursulin@intel.com
Cc: khandual@linux.vnet.ibm.com
Subject: [PATCH] lib/scatterlist: Add SG_CHAIN and SG_EMARK macros for LSB encodings
Date: Wed, 14 Feb 2018 10:28:04 +0530
X-Mailer: git-send-email 2.9.3
X-TM-AS-GCONF: 00
x-cbid: 18021404-0040-0000-0000-0000042F8B48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021404-0041-0000-0000-000020D350FF
Message-Id: <20180214045804.9113-1-khandual@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802140055
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592351049846277975?=
X-GMAIL-MSGID: =?utf-8?q?1592351049846277975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This replaces scatterlist->page_link LSB encodings with SG_CHAIN and
SG_EMARK definitions without any functional change.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 include/linux/scatterlist.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 22b2131bcdcd..63d00bdb2fb3 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -65,16 +65,18 @@ struct sg_table {
  */
 
 #define SG_MAGIC	0x87654321
+#define SG_CHAIN	0x01
+#define SG_EMARK	0x02
 
 /*
  * We overload the LSB of the page pointer to indicate whether it's
  * a valid sg entry, or whether it points to the start of a new scatterlist.
  * Those low bits are there for everyone! (thanks mason :-)
  */
-#define sg_is_chain(sg)		((sg)->page_link & 0x01)
-#define sg_is_last(sg)		((sg)->page_link & 0x02)
+#define sg_is_chain(sg)		((sg)->page_link & SG_CHAIN)
+#define sg_is_last(sg)		((sg)->page_link & SG_EMARK)
 #define sg_chain_ptr(sg)	\
-	((struct scatterlist *) ((sg)->page_link & ~0x03))
+	((struct scatterlist *) ((sg)->page_link & ~(SG_CHAIN | SG_EMARK)))
 
 /**
  * sg_assign_page - Assign a given page to an SG entry
@@ -88,13 +90,13 @@ struct sg_table {
  **/
 static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
 {
-	unsigned long page_link = sg->page_link & 0x3;
+	unsigned long page_link = sg->page_link & (SG_CHAIN | SG_EMARK);
 
 	/*
 	 * In order for the low bit stealing approach to work, pages
 	 * must be aligned at a 32-bit boundary as a minimum.
 	 */
-	BUG_ON((unsigned long) page & 0x03);
+	BUG_ON((unsigned long) page & (SG_CHAIN | SG_EMARK));
 #ifdef CONFIG_DEBUG_SG
 	BUG_ON(sg->sg_magic != SG_MAGIC);
 	BUG_ON(sg_is_chain(sg));
@@ -130,7 +132,7 @@ static inline struct page *sg_page(struct scatterlist *sg)
 	BUG_ON(sg->sg_magic != SG_MAGIC);
 	BUG_ON(sg_is_chain(sg));
 #endif
-	return (struct page *)((sg)->page_link & ~0x3);
+	return (struct page *)((sg)->page_link & ~(SG_CHAIN | SG_EMARK));
 }
 
 /**
@@ -178,7 +180,8 @@ static inline void sg_chain(struct scatterlist *prv, unsigned int prv_nents,
 	 * Set lowest bit to indicate a link pointer, and make sure to clear
 	 * the termination bit if it happens to be set.
 	 */
-	prv[prv_nents - 1].page_link = ((unsigned long) sgl | 0x01) & ~0x02;
+	prv[prv_nents - 1].page_link = ((unsigned long) sgl | SG_CHAIN)
+					& ~SG_EMARK;
 }
 
 /**
@@ -198,8 +201,8 @@ static inline void sg_mark_end(struct scatterlist *sg)
 	/*
 	 * Set termination bit, clear potential chain bit
 	 */
-	sg->page_link |= 0x02;
-	sg->page_link &= ~0x01;
+	sg->page_link |= SG_EMARK;
+	sg->page_link &= ~SG_CHAIN;
 }
 
 /**
@@ -215,7 +218,7 @@ static inline void sg_unmark_end(struct scatterlist *sg)
 #ifdef CONFIG_DEBUG_SG
 	BUG_ON(sg->sg_magic != SG_MAGIC);
 #endif
-	sg->page_link &= ~0x02;
+	sg->page_link &= ~SG_EMARK;
 }
 
 /**
-- 
2.11.0
