Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqQZM8n+fZ/nHorc0pY5ICqiZl7rgBrTL4aEnqsEThKz4E8Bhkr0lHPVvH3wY0EmeWLrtAO
ARC-Seal: i=1; a=rsa-sha256; t=1525767337; cv=none;
        d=google.com; s=arc-20160816;
        b=01QMCQWS2DVDRF4lC/kGZwScZyUjvqV5IgLqfGDn2HLUCOmj2UNK9iv0RdbSVDlNja
         8PG4uz2QkxKeev9pkVtjM6SOm1xH5yjuOtatSv0Aw9zt9Rg2WPrqPTWLp3e4cBUa2Yzo
         eVvDuoL5wbM5mjBfTyNzpK7wvDoI0Sfj/ppjQ6F20UBG+OIDonL3JYi0YsYWg2NOVw4p
         SL8PRub1XQSxuAlw9rm6BZfC0alxIhqXe1Mrk0tfYOw07tjHFXEXVnSDlubncf0K6iFf
         CVWeJ3xndbZe62gN7wlLVV6popUZF5sUMznoYvpZVig7gRzNhJMDgwo4Q8pc9AuWVPRA
         oXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=cCB+DjMnZEaEMenU3PKr+Hzo4iUhGGo/HwedaVUTJ38=;
        b=pHuhzo7EQRSjXV9uixMA5QWMcS+UMZDkB+uYHssqXcq2Om5woF+EkMNrynS/OYO6dx
         YOqF3gTzDrDPMlwJ8W5wBFoAuLTuoognuEWhloPCiaRJ3zMshXGeVYWe1t8EUnnpH6js
         cTvL5yQKCc2yC2UgywO2IqjJP8n0ti2QDWBBEXMkAAnsccwN656607Sw6vE0sJsQbUIO
         qJ5mEFCKs4Etk55JJpFMG9irE3wHQxzs/W8eFSg1IAwt+spIE7j41uiGBAQPWlH4t6X/
         ezmVJH0KBSWOU4UUhUE/1M7LKHm31yukxuE/dAP17eWsih9twuKL8orcgBaV4Z+QCMlp
         O9Yg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qWdWPftt;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qWdWPftt;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 27/43] IB/hfi1: Fix loss of BECN with AHG
Date: Tue,  8 May 2018 10:10:46 +0200
Message-Id: <20180508074008.296447207@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882816352442145?=
X-GMAIL-MSGID: =?utf-8?q?1599883011926698832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

commit 0a0bcb046b2f0c15b89f8c1b08ad3de601a83c66 upstream.

AHG may be armed to use the stored header, which by design is limited
to edits in the PSN/A 32 bit word (bth2).

When the code is trying to send a BECN, the use of the stored header
will lose the BECN bit.

Fix by avoiding AHG when getting ready to send a BECN. This is
accomplished by always claiming the packet is not a middle packet which
is an AHG precursor.  BECNs are not a normal case and this should not
hurt AHG optimizations.

Cc: <stable@vger.kernel.org> # 4.14.x
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/ruc.c |   50 +++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/hw/hfi1/ruc.c
+++ b/drivers/infiniband/hw/hfi1/ruc.c
@@ -745,6 +745,20 @@ static inline void hfi1_make_ruc_bth(str
 	ohdr->bth[2] = cpu_to_be32(bth2);
 }
 
+/**
+ * hfi1_make_ruc_header_16B - build a 16B header
+ * @qp: the queue pair
+ * @ohdr: a pointer to the destination header memory
+ * @bth0: bth0 passed in from the RC/UC builder
+ * @bth2: bth2 passed in from the RC/UC builder
+ * @middle: non zero implies indicates ahg "could" be used
+ * @ps: the current packet state
+ *
+ * This routine may disarm ahg under these situations:
+ * - packet needs a GRH
+ * - BECN needed
+ * - migration state not IB_MIG_MIGRATED
+ */
 static inline void hfi1_make_ruc_header_16B(struct rvt_qp *qp,
 					    struct ib_other_headers *ohdr,
 					    u32 bth0, u32 bth2, int middle,
@@ -789,6 +803,12 @@ static inline void hfi1_make_ruc_header_
 	else
 		middle = 0;
 
+	if (qp->s_flags & RVT_S_ECN) {
+		qp->s_flags &= ~RVT_S_ECN;
+		/* we recently received a FECN, so return a BECN */
+		becn = true;
+		middle = 0;
+	}
 	if (middle)
 		build_ahg(qp, bth2);
 	else
@@ -796,11 +816,6 @@ static inline void hfi1_make_ruc_header_
 
 	bth0 |= pkey;
 	bth0 |= extra_bytes << 20;
-	if (qp->s_flags & RVT_S_ECN) {
-		qp->s_flags &= ~RVT_S_ECN;
-		/* we recently received a FECN, so return a BECN */
-		becn = 1;
-	}
 	hfi1_make_ruc_bth(qp, ohdr, bth0, bth1, bth2);
 
 	if (!ppd->lid)
@@ -818,6 +833,20 @@ static inline void hfi1_make_ruc_header_
 			  pkey, becn, 0, l4, priv->s_sc);
 }
 
+/**
+ * hfi1_make_ruc_header_9B - build a 9B header
+ * @qp: the queue pair
+ * @ohdr: a pointer to the destination header memory
+ * @bth0: bth0 passed in from the RC/UC builder
+ * @bth2: bth2 passed in from the RC/UC builder
+ * @middle: non zero implies indicates ahg "could" be used
+ * @ps: the current packet state
+ *
+ * This routine may disarm ahg under these situations:
+ * - packet needs a GRH
+ * - BECN needed
+ * - migration state not IB_MIG_MIGRATED
+ */
 static inline void hfi1_make_ruc_header_9B(struct rvt_qp *qp,
 					   struct ib_other_headers *ohdr,
 					   u32 bth0, u32 bth2, int middle,
@@ -853,6 +882,12 @@ static inline void hfi1_make_ruc_header_
 	else
 		middle = 0;
 
+	if (qp->s_flags & RVT_S_ECN) {
+		qp->s_flags &= ~RVT_S_ECN;
+		/* we recently received a FECN, so return a BECN */
+		bth1 |= (IB_BECN_MASK << IB_BECN_SHIFT);
+		middle = 0;
+	}
 	if (middle)
 		build_ahg(qp, bth2);
 	else
@@ -860,11 +895,6 @@ static inline void hfi1_make_ruc_header_
 
 	bth0 |= pkey;
 	bth0 |= extra_bytes << 20;
-	if (qp->s_flags & RVT_S_ECN) {
-		qp->s_flags &= ~RVT_S_ECN;
-		/* we recently received a FECN, so return a BECN */
-		bth1 |= (IB_BECN_MASK << IB_BECN_SHIFT);
-	}
 	hfi1_make_ruc_bth(qp, ohdr, bth0, bth1, bth2);
 
 	if (!ppd->lid)
