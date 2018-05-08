Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoWLlEsuuuaZXi+Wz/EA4KzrxwdfqBmMkiudgTAiqZIw/Bq92ncAx8YIzSbvlpStyanbv0k
ARC-Seal: i=1; a=rsa-sha256; t=1525767148; cv=none;
        d=google.com; s=arc-20160816;
        b=IZ0BS8xpveeHli2ImEJ+R9Hl+xncWJ8O811oqt6cUSA73MdPjumz4f4uM7+37oY4pU
         J0bNKmBFmHOf/plgjqtEGLcNRNTRJunF5lH5l8WqwqspsupRtwwX4VJZdrIrXu8l3IKG
         x+RfvRn5A/JzyS/evHpk+hMLbuw+kW2EdocjQHZw9DoAAmC5wKgImftrh1STLDG3Jxmh
         FpfBuU5EphH/v261JY01hJbP4EEtI69uJhNleFkguUaxzczA8PSTwohQ4OjMEDq9FbnJ
         piF5+vJw/SeXhAPnRmxzZVQYPkXsyAyz/tZ1gb0ZwuIRIek5y06fJUQrKnMN/sKuBCau
         I1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=H4NbZ1RSGZ425d3+8FOpix4upRAc3I34ZW2HUCMUCuY=;
        b=E3KL8sHPeEtO3A1RgGpD/KQA+hd7m6vhn3z5Gv3KOfo1GHbMvcTG99t0mAJ4tljdwL
         60+69iRq5e35Nr8cXaP2mPu5FTlnRgNwPg0CKu0KA4DyGp4qiLWI/s0v+zz866HpPfQs
         B5zyB22yyivc6zDqw8NOPftsXdPAi3gU/n6ardcHlhZYZucXxSsQ5MvhEAUuZyctMnGw
         34kf1N+IujcavSspVtM1WKqZaZz6oH6CmAdxJQRSsyChDroBiRX0yhbmvSqF1S8QsVN5
         YKc/UcKMu5D/BeM1IaQgTwzaC4eQJrJXAXJMDvEJ9XKsThsWUB+LoHiHn29jKjTueoGu
         EjhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WwPpuFe4;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WwPpuFe4;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Don Hiatt <don.hiatt@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.16 26/52] IB/hfi1: Fix handling of FECN marked multicast packet
Date: Tue,  8 May 2018 10:10:24 +0200
Message-Id: <20180508073931.616687680@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882813049072132?=
X-GMAIL-MSGID: =?utf-8?q?1599882813049072132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

commit f59fb9e05109b836230813e45f71c9ecc2d5dbe6 upstream.

The code for handling a marked UD packet unconditionally returns the
dlid in the header of the FECN marked packet.  This is not correct
for multicast packets where the DLID is in the multicast range.

The subsequent attempt to send the CNP with the multicast lid will
cause the chip to halt the ack send context because the source
lid doesn't match the chip programming.   The send context will
be halted and flush any other pending packets in the pio ring causing
the CNP to not be sent.

A part of investigating the fix, it was determined that the 16B work
broke the FECN routine badly with inconsistent use of 16 bit and 32 bits
types for lids and pkeys.  Since the port's source lid was correctly 32
bits the type mixmatches need to be dealt with at the same time as
fixing the CNP header issue.

Fix these issues by:
- Using the ports lid for as the SLID for responding to FECN marked UD
  packets
- Insure pkey is always 16 bit in this and subordinate routines
- Insure lids are 32 bits in this and subordinate routines

Cc: <stable@vger.kernel.org> # 4.14.x
Fixes: 88733e3b8450 ("IB/hfi1: Add 16B UD support")
Reviewed-by: Don Hiatt <don.hiatt@intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/driver.c |   19 +++++++++++++++----
 drivers/infiniband/hw/hfi1/hfi.h    |    8 ++++----
 drivers/infiniband/hw/hfi1/ud.c     |    4 ++--
 3 files changed, 21 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -432,31 +432,43 @@ void hfi1_process_ecn_slowpath(struct rv
 			       bool do_cnp)
 {
 	struct hfi1_ibport *ibp = to_iport(qp->ibqp.device, qp->port_num);
+	struct hfi1_pportdata *ppd = ppd_from_ibp(ibp);
 	struct ib_other_headers *ohdr = pkt->ohdr;
 	struct ib_grh *grh = pkt->grh;
 	u32 rqpn = 0, bth1;
-	u16 pkey, rlid, dlid = ib_get_dlid(pkt->hdr);
+	u16 pkey;
+	u32 rlid, slid, dlid = 0;
 	u8 hdr_type, sc, svc_type;
 	bool is_mcast = false;
 
+	/* can be called from prescan */
 	if (pkt->etype == RHF_RCV_TYPE_BYPASS) {
 		is_mcast = hfi1_is_16B_mcast(dlid);
 		pkey = hfi1_16B_get_pkey(pkt->hdr);
 		sc = hfi1_16B_get_sc(pkt->hdr);
+		dlid = hfi1_16B_get_dlid(pkt->hdr);
+		slid = hfi1_16B_get_slid(pkt->hdr);
 		hdr_type = HFI1_PKT_TYPE_16B;
 	} else {
 		is_mcast = (dlid > be16_to_cpu(IB_MULTICAST_LID_BASE)) &&
 			   (dlid != be16_to_cpu(IB_LID_PERMISSIVE));
 		pkey = ib_bth_get_pkey(ohdr);
 		sc = hfi1_9B_get_sc5(pkt->hdr, pkt->rhf);
+		dlid = ib_get_dlid(pkt->hdr);
+		slid = ib_get_slid(pkt->hdr);
 		hdr_type = HFI1_PKT_TYPE_9B;
 	}
 
 	switch (qp->ibqp.qp_type) {
+	case IB_QPT_UD:
+		dlid = ppd->lid;
+		rlid = slid;
+		rqpn = ib_get_sqpn(pkt->ohdr);
+		svc_type = IB_CC_SVCTYPE_UD;
+		break;
 	case IB_QPT_SMI:
 	case IB_QPT_GSI:
-	case IB_QPT_UD:
-		rlid = ib_get_slid(pkt->hdr);
+		rlid = slid;
 		rqpn = ib_get_sqpn(pkt->ohdr);
 		svc_type = IB_CC_SVCTYPE_UD;
 		break;
@@ -481,7 +493,6 @@ void hfi1_process_ecn_slowpath(struct rv
 					      dlid, rlid, sc, grh);
 
 	if (!is_mcast && (bth1 & IB_BECN_SMASK)) {
-		struct hfi1_pportdata *ppd = ppd_from_ibp(ibp);
 		u32 lqpn = bth1 & RVT_QPN_MASK;
 		u8 sl = ibp->sc_to_sl[sc];
 
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1538,13 +1538,13 @@ void set_link_ipg(struct hfi1_pportdata
 void process_becn(struct hfi1_pportdata *ppd, u8 sl, u32 rlid, u32 lqpn,
 		  u32 rqpn, u8 svc_type);
 void return_cnp(struct hfi1_ibport *ibp, struct rvt_qp *qp, u32 remote_qpn,
-		u32 pkey, u32 slid, u32 dlid, u8 sc5,
+		u16 pkey, u32 slid, u32 dlid, u8 sc5,
 		const struct ib_grh *old_grh);
 void return_cnp_16B(struct hfi1_ibport *ibp, struct rvt_qp *qp,
-		    u32 remote_qpn, u32 pkey, u32 slid, u32 dlid,
+		    u32 remote_qpn, u16 pkey, u32 slid, u32 dlid,
 		    u8 sc5, const struct ib_grh *old_grh);
 typedef void (*hfi1_handle_cnp)(struct hfi1_ibport *ibp, struct rvt_qp *qp,
-				u32 remote_qpn, u32 pkey, u32 slid, u32 dlid,
+				u32 remote_qpn, u16 pkey, u32 slid, u32 dlid,
 				u8 sc5, const struct ib_grh *old_grh);
 
 #define PKEY_CHECK_INVALID -1
@@ -2438,7 +2438,7 @@ static inline void hfi1_make_16b_hdr(str
 		((slid >> OPA_16B_SLID_SHIFT) << OPA_16B_SLID_HIGH_SHIFT);
 	lrh2 = (lrh2 & ~OPA_16B_DLID_MASK) |
 		((dlid >> OPA_16B_DLID_SHIFT) << OPA_16B_DLID_HIGH_SHIFT);
-	lrh2 = (lrh2 & ~OPA_16B_PKEY_MASK) | (pkey << OPA_16B_PKEY_SHIFT);
+	lrh2 = (lrh2 & ~OPA_16B_PKEY_MASK) | ((u32)pkey << OPA_16B_PKEY_SHIFT);
 	lrh2 = (lrh2 & ~OPA_16B_L4_MASK) | l4;
 
 	hdr->lrh[0] = lrh0;
--- a/drivers/infiniband/hw/hfi1/ud.c
+++ b/drivers/infiniband/hw/hfi1/ud.c
@@ -628,7 +628,7 @@ int hfi1_lookup_pkey_idx(struct hfi1_ibp
 }
 
 void return_cnp_16B(struct hfi1_ibport *ibp, struct rvt_qp *qp,
-		    u32 remote_qpn, u32 pkey, u32 slid, u32 dlid,
+		    u32 remote_qpn, u16 pkey, u32 slid, u32 dlid,
 		    u8 sc5, const struct ib_grh *old_grh)
 {
 	u64 pbc, pbc_flags = 0;
@@ -687,7 +687,7 @@ void return_cnp_16B(struct hfi1_ibport *
 }
 
 void return_cnp(struct hfi1_ibport *ibp, struct rvt_qp *qp, u32 remote_qpn,
-		u32 pkey, u32 slid, u32 dlid, u8 sc5,
+		u16 pkey, u32 slid, u32 dlid, u8 sc5,
 		const struct ib_grh *old_grh)
 {
 	u64 pbc, pbc_flags = 0;
