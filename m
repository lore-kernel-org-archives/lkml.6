Return-Path: <khandual@linux.vnet.ibm.com>
X-Google-Smtp-Source: AH8x226KT8FydbBrae4E/VSyiJlN3nKZyo1VNUCYXdfwDiYnZvjM1QBeBs4R05CJ55IE/85kT8AE
ARC-Seal: i=1; a=rsa-sha256; t=1519049274; cv=none;
        d=google.com; s=arc-20160816;
        b=MhU6Ff/9k676765rxxEH2gjjeY97VdznL5mcfh8zy3ehhJQKXJ8CxL9erlNURLhaxB
         OQ2gZGlL3kPEAx4MqZ68fEIIEUe7QszCWEXHVuutymPwbiAezw94nWVfsbGFHcS5R4sa
         joJkl4ZcPIE1yK/eBii4qaD12O6HZW4XgWPn54Iq8bs6TUlqusPavDYJMswED2gUwIFB
         sKAD9iNp1vM2mh//T7hhaZRm+HUxgG2/mZzyqxjD54rDCU0urZkRd518xqkyWDC8EsHF
         Ylyh3iLWsvJ1VaykOItMbPUWwAjx4KnJV7hGG9Lxj1Mbc5SF33g3H4QHpK0Z9BXP6H8j
         EJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=mHT6h95Er0Fd+YNAmv5fIRt1g9c9MjycQGdoYMxpzzY=;
        b=a0ylFMXLEk8dk25WYuRn/BH9TUAd+77eZF5hmlQDOvnS+j+zrI1HZ0l18hm4/2MhBf
         OLw9YuCvG/CRYi1eII6QeIkEQ9erdtkNutPiOw6V/u4SIONcKPcUC4Jd7ltMP0eJpzMn
         V5G5Bw/61DKQHT8NWCh1EJQQ3WW/7CliZVXmAeuFp3xe2ssiGnegfPFc9VtXKjHGqTrr
         MukMM277O4tCmotuH0MK2ZCQzMELFiQY1INAGUAqMv7G5gvpvcE535eujHFODPtYj0DA
         mZIjwTuvRxAuenTC/NmhP8XKNihFiDjTBMjCZckuiyhyxP5fSMjTL10q+gnIoJkc80wp
         e0XQ==
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
Subject: [PATCH V3] lib/scatterlist: Add SG_CHAIN and SG_LAST macros for LSB encodings
Date: Mon, 19 Feb 2018 19:37:39 +0530
X-Mailer: git-send-email 2.9.3
X-TM-AS-GCONF: 00
x-cbid: 18021914-0008-0000-0000-000004D13D01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021914-0009-0000-0000-00001E6448B0
Message-Id: <20180219140739.24383-1-khandual@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802190176
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592838612913137336?=
X-GMAIL-MSGID: =?utf-8?q?1592838612913137336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This replaces scatterlist->page_link LSB encodings with SG_CHAIN and
SG_LAST definitions without any functional change. While here also
add macro definitions SG_PAGE_BITS and SG_PAGE_MASK.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changes in V3:
- Changed SG_END as SG_LAST due to a build failure
- Added SG_PAGE_BITS and SG_PAGE_MASK as per Tvrtko
- Used BIT() macro as per Chris

Changes in V2:
- Changed SG_EMARK as SG_END as per Johannes and Tvrtko
- Added 'UL' to the constants as per Bart

 include/linux/scatterlist.h | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 22b2131bcdcd..494b84c7f3c8 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -66,15 +66,20 @@ struct sg_table {
 
 #define SG_MAGIC	0x87654321
 
+#define SG_CHAIN	BIT(0)
+#define SG_LAST		BIT(1)
+#define SG_PAGE_BITS	(SG_CHAIN | SG_LAST)
+#define SG_PAGE_MASK	(~SG_PAGE_BITS)
+
 /*
  * We overload the LSB of the page pointer to indicate whether it's
  * a valid sg entry, or whether it points to the start of a new scatterlist.
  * Those low bits are there for everyone! (thanks mason :-)
  */
-#define sg_is_chain(sg)		((sg)->page_link & 0x01)
-#define sg_is_last(sg)		((sg)->page_link & 0x02)
+#define sg_is_chain(sg)		((sg)->page_link & SG_CHAIN)
+#define sg_is_last(sg)		((sg)->page_link & SG_LAST)
 #define sg_chain_ptr(sg)	\
-	((struct scatterlist *) ((sg)->page_link & ~0x03))
+	((struct scatterlist *) ((sg)->page_link & SG_PAGE_MASK))
 
 /**
  * sg_assign_page - Assign a given page to an SG entry
@@ -88,13 +93,13 @@ struct sg_table {
  **/
 static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
 {
-	unsigned long page_link = sg->page_link & 0x3;
+	unsigned long page_link = sg->page_link & SG_PAGE_BITS;
 
 	/*
 	 * In order for the low bit stealing approach to work, pages
 	 * must be aligned at a 32-bit boundary as a minimum.
 	 */
-	BUG_ON((unsigned long) page & 0x03);
+	BUG_ON((unsigned long) page & SG_PAGE_BITS);
 #ifdef CONFIG_DEBUG_SG
 	BUG_ON(sg->sg_magic != SG_MAGIC);
 	BUG_ON(sg_is_chain(sg));
@@ -130,7 +135,7 @@ static inline struct page *sg_page(struct scatterlist *sg)
 	BUG_ON(sg->sg_magic != SG_MAGIC);
 	BUG_ON(sg_is_chain(sg));
 #endif
-	return (struct page *)((sg)->page_link & ~0x3);
+	return (struct page *)((sg)->page_link & SG_PAGE_MASK);
 }
 
 /**
@@ -178,7 +183,8 @@ static inline void sg_chain(struct scatterlist *prv, unsigned int prv_nents,
 	 * Set lowest bit to indicate a link pointer, and make sure to clear
 	 * the termination bit if it happens to be set.
 	 */
-	prv[prv_nents - 1].page_link = ((unsigned long) sgl | 0x01) & ~0x02;
+	prv[prv_nents - 1].page_link = ((unsigned long) sgl | SG_CHAIN)
+					& ~SG_LAST;
 }
 
 /**
@@ -198,8 +204,8 @@ static inline void sg_mark_end(struct scatterlist *sg)
 	/*
 	 * Set termination bit, clear potential chain bit
 	 */
-	sg->page_link |= 0x02;
-	sg->page_link &= ~0x01;
+	sg->page_link |= SG_LAST;
+	sg->page_link &= ~SG_CHAIN;
 }
 
 /**
@@ -215,7 +221,7 @@ static inline void sg_unmark_end(struct scatterlist *sg)
 #ifdef CONFIG_DEBUG_SG
 	BUG_ON(sg->sg_magic != SG_MAGIC);
 #endif
-	sg->page_link &= ~0x02;
+	sg->page_link &= ~SG_LAST;
 }
 
 /**
-- 
2.11.0
