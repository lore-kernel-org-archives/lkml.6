Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413851-2-10485315228124614930
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES rodaca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413850; b=Zoih+nYNKaD66oN28qxcXxEtNGmFpvmo25SJBVfFX8+7NTx
    lT/XG7j7zwQicTOK/6MawnhXia6VSR3LUcH8MV17CtGNtC5GWn1A2PsPEnuk/RM4
    4koUgbtIEHkA6BOivqmTpo53ndxgJh6eSAZe2DH2i8EfsJuUkmVkD6u0oW4X3cnd
    rBRgv4J+KKZA/gisF2iEDvkodHCl6/u0t8tqVuHRNZg+fhe316lR3dMhmklSShRT
    vm2RtiXAKhyXbjodcbpqekmKoFOjPb5sn0Js1i51o4VtB0quTf/OzIRyi4prb/rt
    mxlt2b6gOm9NAb/UpuLvnmw91gyKQvCAQpUqA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413850; bh=57xzYLc27KJLdtmrH1dr69vV5V
    qSvWLkSlADJDWykYs=; b=EUfDbNCplIfTZaoaB/904n/hzrOvGVm12HFWRHjtlo
    GgatLNqFQvJrMkDggxx/RPIzC2dQiDmDB16N/uEB9GPyjd7fIFHyGRqdWKWaDXym
    q4VGtaugTMOjuKkOd1PvHdLVddC9SaJuJF4/wjkltNPDFs9s0MFh171MWiU8YupY
    jTG+KdvcGRu7iSz9p2luA4usu4unv3COohogv8ztdIwMC6CHUX7B7qqEsBDuX5Vg
    hG7IEl6Pi8696A2STq4+xY6l6BhfTPyTN6nE8wVvJXuOx0ZU7o7vvBrm22BJNm7x
    KpR6Rra6XDhUuMmNlztkIp3BwXwbtnVSlq1/Ie/DcLJQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934831AbeBWSxS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935345AbeBWSxO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:14 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chien Tin Tung <chien.tin.tung@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 089/159] i40iw: Allocate a sdbuf per CQP WQE
Date: Fri, 23 Feb 2018 19:26:37 +0100
Message-Id: <20180223170754.289693711@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chien Tin Tung <chien.tin.tung@intel.com>


[ Upstream commit 100d6de2ced538c539d923dc14a1b5cbae234503 ]

Currently there is only one sdbuf per Control QP (CQP) for
programming Segment Descriptor (SD). If multiple SD work
requests are posted simultaneously, the sdbuf is reused
by all WQEs and new WQEs can corrupt previous WQEs sdbuf
leading to incorrect SD programming.

Fix this by allocating one sdbuf per CQP SQ WQE. When an
SD command is posted, it will use the corresponding sdbuf
for the WQE.

Fixes: 86dbcd0f12e9 ("i40iw: add file to handle cqp calls")
Signed-off-by: Chien Tin Tung <chien.tin.tung@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c |   43 +++++++++++++++++++++----------
 drivers/infiniband/hw/i40iw/i40iw_d.h    |    4 ++
 2 files changed, 33 insertions(+), 14 deletions(-)

--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -506,7 +506,7 @@ static enum i40iw_status_code i40iw_sc_c
 
 	ret_code = i40iw_allocate_dma_mem(cqp->dev->hw,
 					  &cqp->sdbuf,
-					  128,
+					  I40IW_UPDATE_SD_BUF_SIZE * cqp->sq_size,
 					  I40IW_SD_BUF_ALIGNMENT);
 
 	if (ret_code)
@@ -589,14 +589,15 @@ void i40iw_sc_cqp_post_sq(struct i40iw_s
 }
 
 /**
- * i40iw_sc_cqp_get_next_send_wqe - get next wqe on cqp sq
- * @cqp: struct for cqp hw
- * @wqe_idx: we index of cqp ring
+ * i40iw_sc_cqp_get_next_send_wqe_idx - get next WQE on CQP SQ and pass back the index
+ * @cqp: pointer to CQP structure
+ * @scratch: private data for CQP WQE
+ * @wqe_idx: WQE index for next WQE on CQP SQ
  */
-u64 *i40iw_sc_cqp_get_next_send_wqe(struct i40iw_sc_cqp *cqp, u64 scratch)
+static u64 *i40iw_sc_cqp_get_next_send_wqe_idx(struct i40iw_sc_cqp *cqp,
+					       u64 scratch, u32 *wqe_idx)
 {
 	u64 *wqe = NULL;
-	u32	wqe_idx;
 	enum i40iw_status_code ret_code;
 
 	if (I40IW_RING_FULL_ERR(cqp->sq_ring)) {
@@ -609,21 +610,33 @@ u64 *i40iw_sc_cqp_get_next_send_wqe(stru
 			    cqp->sq_ring.size);
 		return NULL;
 	}
-	I40IW_ATOMIC_RING_MOVE_HEAD(cqp->sq_ring, wqe_idx, ret_code);
+	I40IW_ATOMIC_RING_MOVE_HEAD(cqp->sq_ring, *wqe_idx, ret_code);
 	cqp->dev->cqp_cmd_stats[OP_REQUESTED_COMMANDS]++;
 	if (ret_code)
 		return NULL;
-	if (!wqe_idx)
+	if (!*wqe_idx)
 		cqp->polarity = !cqp->polarity;
 
-	wqe = cqp->sq_base[wqe_idx].elem;
-	cqp->scratch_array[wqe_idx] = scratch;
+	wqe = cqp->sq_base[*wqe_idx].elem;
+	cqp->scratch_array[*wqe_idx] = scratch;
 	I40IW_CQP_INIT_WQE(wqe);
 
 	return wqe;
 }
 
 /**
+ * i40iw_sc_cqp_get_next_send_wqe - get next wqe on cqp sq
+ * @cqp: struct for cqp hw
+ * @scratch: private data for CQP WQE
+ */
+u64 *i40iw_sc_cqp_get_next_send_wqe(struct i40iw_sc_cqp *cqp, u64 scratch)
+{
+	u32 wqe_idx;
+
+	return i40iw_sc_cqp_get_next_send_wqe_idx(cqp, scratch, &wqe_idx);
+}
+
+/**
  * i40iw_sc_cqp_destroy - destroy cqp during close
  * @cqp: struct for cqp hw
  */
@@ -3534,8 +3547,10 @@ static enum i40iw_status_code cqp_sds_wq
 	u64 *wqe;
 	int mem_entries, wqe_entries;
 	struct i40iw_dma_mem *sdbuf = &cqp->sdbuf;
+	u64 offset;
+	u32 wqe_idx;
 
-	wqe = i40iw_sc_cqp_get_next_send_wqe(cqp, scratch);
+	wqe = i40iw_sc_cqp_get_next_send_wqe_idx(cqp, scratch, &wqe_idx);
 	if (!wqe)
 		return I40IW_ERR_RING_FULL;
 
@@ -3548,8 +3563,10 @@ static enum i40iw_status_code cqp_sds_wq
 		 LS_64(mem_entries, I40IW_CQPSQ_UPESD_ENTRY_COUNT);
 
 	if (mem_entries) {
-		memcpy(sdbuf->va, &info->entry[3], (mem_entries << 4));
-		data = sdbuf->pa;
+		offset = wqe_idx * I40IW_UPDATE_SD_BUF_SIZE;
+		memcpy((char *)sdbuf->va + offset, &info->entry[3],
+		       mem_entries << 4);
+		data = (u64)sdbuf->pa + offset;
 	} else {
 		data = 0;
 	}
--- a/drivers/infiniband/hw/i40iw/i40iw_d.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_d.h
@@ -1516,7 +1516,7 @@ enum i40iw_alignment {
 	I40IW_AEQ_ALIGNMENT =		0x100,
 	I40IW_CEQ_ALIGNMENT =		0x100,
 	I40IW_CQ0_ALIGNMENT =		0x100,
-	I40IW_SD_BUF_ALIGNMENT =	0x100
+	I40IW_SD_BUF_ALIGNMENT =	0x80
 };
 
 #define I40IW_WQE_SIZE_64	64
@@ -1524,6 +1524,8 @@ enum i40iw_alignment {
 #define I40IW_QP_WQE_MIN_SIZE	32
 #define I40IW_QP_WQE_MAX_SIZE	128
 
+#define I40IW_UPDATE_SD_BUF_SIZE 128
+
 #define I40IW_CQE_QTYPE_RQ 0
 #define I40IW_CQE_QTYPE_SQ 1
 
