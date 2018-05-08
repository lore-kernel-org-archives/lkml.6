Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoZOIu3/1NSKXa4Wu2IFioLxHtdkEeXxYrIuKd86TBLTJ5CHyQAJ4SLwdczT0LcjfPcwBhH
ARC-Seal: i=1; a=rsa-sha256; t=1525767151; cv=none;
        d=google.com; s=arc-20160816;
        b=GcYD6+av4iAg9+G0VoC0WeJg2AFtzuUNbB1qqr6cjeoxMLYEixmXIfUevjNqUIXhEb
         AfxdsuJHYqWyAAJoU/EEMrlO4ZHBZYAb+3ehSvERUITEt09l9bR0jDvCIcwwtWmHl2ZY
         nzVk7wlDX1qffuKzXl4vwENHiIkc09YO/oOH5yNZ/hM8lG8JcsvfIgYK5ZJx2+HelTBj
         7V2ruy8ZVPcOE8BhdTn0SuHGnIbGjwtRY/du5yirjl5etgyModxU9EURnYyLBd/MGAoQ
         +Q0JBQMmP6AG47SzrFnrH8ssspoWO7+gCfWoleyvVE6zqdtczh2GlZ8fofxjzr1gGfDw
         PvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=U0bY2hAqlqkbLoEYwn9Soy10K6KKnpYNnEoGmwxIOVI=;
        b=xOJj379NmDDxiMvisVLKq+JEBJAMm5Wdcu9PR+ucM+tOTHIY7ioHE0IPPykqdMDAta
         cdSS/U6Zw9FN2c2AnjtAe/zJoJ0DJdImSDqhHYWb5WGo1l2S6tirT6Trb83FueFpuS9S
         9i8nddyoNxAsjG8DdSmYXWL2NDnx1dC9kdjZJgO/DDJ7RHeXPUCidcRT5sKUD4tXXd7C
         kRYaIdx+W/5g4sQ+N6Cq99ueLw5cNp4ohYySROXgnxV8JjSLGYvmjBJyvs5HGR18+aRF
         gvMI+g6wQ+uZgMo1OXETpwpuyzbxC2xs6SlmXEuHHaGU9Gu7V3SBAHk4O2HEgAWnRAiC
         46Vg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rW9YPm3h;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rW9YPm3h;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.16 27/52] IB/hfi1: Fix loss of BECN with AHG
Date: Tue,  8 May 2018 10:10:25 +0200
Message-Id: <20180508073931.780135827@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882816352442145?=
X-GMAIL-MSGID: =?utf-8?q?1599882816352442145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -733,6 +733,20 @@ static inline void hfi1_make_ruc_bth(str
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
@@ -777,6 +791,12 @@ static inline void hfi1_make_ruc_header_
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
@@ -784,11 +804,6 @@ static inline void hfi1_make_ruc_header_
 
 	bth0 |= pkey;
 	bth0 |= extra_bytes << 20;
-	if (qp->s_flags & RVT_S_ECN) {
-		qp->s_flags &= ~RVT_S_ECN;
-		/* we recently received a FECN, so return a BECN */
-		becn = true;
-	}
 	hfi1_make_ruc_bth(qp, ohdr, bth0, bth1, bth2);
 
 	if (!ppd->lid)
@@ -806,6 +821,20 @@ static inline void hfi1_make_ruc_header_
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
@@ -839,6 +868,12 @@ static inline void hfi1_make_ruc_header_
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
@@ -846,11 +881,6 @@ static inline void hfi1_make_ruc_header_
 
 	bth0 |= pkey;
 	bth0 |= extra_bytes << 20;
-	if (qp->s_flags & RVT_S_ECN) {
-		qp->s_flags &= ~RVT_S_ECN;
-		/* we recently received a FECN, so return a BECN */
-		bth1 |= (IB_BECN_MASK << IB_BECN_SHIFT);
-	}
 	hfi1_make_ruc_bth(qp, ohdr, bth0, bth1, bth2);
 	hfi1_make_ib_hdr(&ps->s_txreq->phdr.hdr.ibh,
 			 lrh0,
