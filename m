Return-Path: <khandual@linux.vnet.ibm.com>
X-Google-Smtp-Source: AH8x225XQl/F7HB1D5Tazm8cT2bcOb7AUKwmGnZQzeqNmPHuLgE7FC4eSAGkh9rab3ke8SlVIxKw
ARC-Seal: i=1; a=rsa-sha256; t=1518665689; cv=none;
        d=google.com; s=arc-20160816;
        b=Mw1QXSfpFnFolza2r0DcuSdHm0zRYorMdq0YllqJgrr2J75wKz26ERyupqYCyeXe28
         28SCYDHoWtivS4+7UlszpzCP0Ukhg1hBWFDFXgV33OA5a0SKd+xgrC9TK1x+aoaOxmU7
         jBc11q5aDB5oREsCIO9nt2lIcssVRXzk+1+DBOhouX5kb/a2N+EP3jLqKtP5L3szTda/
         NBQ+wqtZEMwQyfp16GVp9X07NMsrVtuVt9GW02jdOJaFwxbmLFlKYIbEXVwqf/xfA/SE
         jRSGebdCrE9OuzBak+CC3zSS/Ah8TjUakNGUJAj2CieQ8FD9w2oQNCYnFFZO1b/nmoUG
         AWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=jLzHIBa0h0PfVBlmQ60k6Z3MN/RUXEhQ3g1N03Tb8K8=;
        b=lZT1PuUEyZ9aPUzPCp3PomLS8PRCLTKlxQ4KbNecMpqi1CGuone0aqnHqrHT/EYUpw
         FoXyoQakQD9rloU3ur/7Nur5yG70xXIavUuhL93njkLPlm5KW14IQe5BVlj3KNLzz1NY
         Iq7ZCTdkBx5MdtjQUN8WZHIaLCVsRmByogtrAZ4RlcdWsYdhqkagqi55Jge/eBoqjA7P
         qxm7OnNtjzUpNUJcDLlp+7xeOnJdWA+DE8ntBA66BPyYxosWDL544FXAk7yhoShDIgPj
         04azA1Su6hYMF77VCJq4ojxgsVaAkqNG1rz8AKJvHuKgoXLhPHlyKQhi/L6RFq9bcmwY
         0ZYw==
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
Subject: [PATCH V2] lib/scatterlist: Add SG_CHAIN and SG_END macros for LSB encodings
Date: Thu, 15 Feb 2018 09:03:56 +0530
X-Mailer: git-send-email 2.9.3
X-TM-AS-GCONF: 00
x-cbid: 18021503-0040-0000-0000-0000042FE8C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021503-0041-0000-0000-000020D3B248
Message-Id: <20180215033356.6978-1-khandual@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802150044
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592436393983047782?=
X-GMAIL-MSGID: =?utf-8?q?1592436393983047782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This replaces scatterlist->page_link LSB encodings with SG_CHAIN and
SG_END definitions without any functional change.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changes in V2:
- Changed SG_EMARK as SG_END as per Johannes and Tvrtko
- Added 'UL' to the constants as per Bart

 include/linux/scatterlist.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 22b2131bcdcd..b6fe1815f5c4 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -65,16 +65,18 @@ struct sg_table {
  */
 
 #define SG_MAGIC	0x87654321
+#define SG_CHAIN	0x01UL
+#define SG_END		0x02UL
 
 /*
  * We overload the LSB of the page pointer to indicate whether it's
  * a valid sg entry, or whether it points to the start of a new scatterlist.
  * Those low bits are there for everyone! (thanks mason :-)
  */
-#define sg_is_chain(sg)		((sg)->page_link & 0x01)
-#define sg_is_last(sg)		((sg)->page_link & 0x02)
+#define sg_is_chain(sg)		((sg)->page_link & SG_CHAIN)
+#define sg_is_last(sg)		((sg)->page_link & SG_END)
 #define sg_chain_ptr(sg)	\
-	((struct scatterlist *) ((sg)->page_link & ~0x03))
+	((struct scatterlist *) ((sg)->page_link & ~(SG_CHAIN | SG_END)))
 
 /**
  * sg_assign_page - Assign a given page to an SG entry
@@ -88,13 +90,13 @@ struct sg_table {
  **/
 static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
 {
-	unsigned long page_link = sg->page_link & 0x3;
+	unsigned long page_link = sg->page_link & (SG_CHAIN | SG_END);
 
 	/*
 	 * In order for the low bit stealing approach to work, pages
 	 * must be aligned at a 32-bit boundary as a minimum.
 	 */
-	BUG_ON((unsigned long) page & 0x03);
+	BUG_ON((unsigned long) page & (SG_CHAIN | SG_END));
 #ifdef CONFIG_DEBUG_SG
 	BUG_ON(sg->sg_magic != SG_MAGIC);
 	BUG_ON(sg_is_chain(sg));
@@ -130,7 +132,7 @@ static inline struct page *sg_page(struct scatterlist *sg)
 	BUG_ON(sg->sg_magic != SG_MAGIC);
 	BUG_ON(sg_is_chain(sg));
 #endif
-	return (struct page *)((sg)->page_link & ~0x3);
+	return (struct page *)((sg)->page_link & ~(SG_CHAIN | SG_END));
 }
 
 /**
@@ -178,7 +180,8 @@ static inline void sg_chain(struct scatterlist *prv, unsigned int prv_nents,
 	 * Set lowest bit to indicate a link pointer, and make sure to clear
 	 * the termination bit if it happens to be set.
 	 */
-	prv[prv_nents - 1].page_link = ((unsigned long) sgl | 0x01) & ~0x02;
+	prv[prv_nents - 1].page_link = ((unsigned long) sgl | SG_CHAIN)
+					& ~SG_END;
 }
 
 /**
@@ -198,8 +201,8 @@ static inline void sg_mark_end(struct scatterlist *sg)
 	/*
 	 * Set termination bit, clear potential chain bit
 	 */
-	sg->page_link |= 0x02;
-	sg->page_link &= ~0x01;
+	sg->page_link |= SG_END;
+	sg->page_link &= ~SG_CHAIN;
 }
 
 /**
@@ -215,7 +218,7 @@ static inline void sg_unmark_end(struct scatterlist *sg)
 #ifdef CONFIG_DEBUG_SG
 	BUG_ON(sg->sg_magic != SG_MAGIC);
 #endif
-	sg->page_link &= ~0x02;
+	sg->page_link &= ~SG_END;
 }
 
 /**
-- 
2.11.0
