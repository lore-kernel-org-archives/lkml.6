Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpLI1qKnbMh0CX5P76OIqkwyiZxfW7EKyeuYhMmT9o9hnqpheYKuXd7zCGAsNKSoIHPDQim
ARC-Seal: i=1; a=rsa-sha256; t=1525767367; cv=none;
        d=google.com; s=arc-20160816;
        b=WTZhCjGolyL4wEdVcwbUQc0/E2OWi/w/ZrD2+o9Wuy+RYw9cpLHh17TlF1C99EFIuT
         RyyDUPZVxecNTvGsHtXLepZjC4zcBU0WbidkgKpBiWkxj6zu5GRQ9QNKN7UkbUdEVOuf
         s8j15jeXa6VJ/cMR0V90H1m8QittDcGkV7msAltixrwGEkQoX30bLnmC/bkaO6AHmXnq
         1mJv2Qa2dJ2hcnjJvSgzo1SF/2sOobZJPgsgvpa2W54sJikwhhDsNp3YWT0jzcSiTWK0
         H/1by04gpaxJpXbMyJ8+KNHSUHxgBv4sk/r9TF5z6ijNCncUwf54/bp0uEHzQHt4/Ut7
         3zlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=kW9gmiqHLsXWB6ykN8VG3QcJM87+JLCbjm7H0n0UrTQ=;
        b=S6L0ZkDv0hH0s4jPy5oczrQerkTQuQBGH6iPnuCXFN8LdD/VachhxbZG7I1+Hb8N5L
         BCc/w0lIHRGvrekZxx80K65KWbmwomI8ZJXUKU3Yl2BHwB2TNhQsdYtcTCCJZPWZ7x9h
         IyAItOIft3fVYcxJUuC2TfO+XDwjVmSZY29ME07mLTq76OGd+kcG9uwd+JmWg2O2J0bD
         /rtmZm1wzAGyyI/8fTKiJp68WVUAlrWYgVANkhDO6XTezh2sgVtdIrw4vpUypecPmV/Q
         m9JHabAq24luHUzaWPC6Dq5DzvNM0yr/3EKmNFfAASvvM7aGD/lG5sCzq+TGALcEcntX
         8LVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=T/ZI/GXS;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=T/ZI/GXS;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Steve Wise <swise@opengridcomputing.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 29/43] iw_cxgb4: Atomically flush per QP HW CQEs
Date: Tue,  8 May 2018 10:10:48 +0200
Message-Id: <20180508074008.530377687@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882822484700177?=
X-GMAIL-MSGID: =?utf-8?q?1599883042330820137?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bharat Potnuri <bharat@chelsio.com>

commit 2df19e19ae90d94fd8724083f161f368a2797537 upstream.

When a CQ is shared by multiple QPs, c4iw_flush_hw_cq() needs to acquire
corresponding QP lock before moving the CQEs into its corresponding SW
queue and accessing the SQ contents for completing a WR.
Ignore CQEs if corresponding QP is already flushed.

Cc: stable@vger.kernel.org
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/cxgb4/cq.c       |   11 ++++++++++-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |    2 +-
 drivers/infiniband/hw/cxgb4/qp.c       |    4 ++--
 3 files changed, 13 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -330,7 +330,7 @@ static void advance_oldest_read(struct t
  * Deal with out-of-order and/or completions that complete
  * prior unsignalled WRs.
  */
-void c4iw_flush_hw_cq(struct c4iw_cq *chp)
+void c4iw_flush_hw_cq(struct c4iw_cq *chp, struct c4iw_qp *flush_qhp)
 {
 	struct t4_cqe *hw_cqe, *swcqe, read_cqe;
 	struct c4iw_qp *qhp;
@@ -354,6 +354,13 @@ void c4iw_flush_hw_cq(struct c4iw_cq *ch
 		if (qhp == NULL)
 			goto next_cqe;
 
+		if (flush_qhp != qhp) {
+			spin_lock(&qhp->lock);
+
+			if (qhp->wq.flushed == 1)
+				goto next_cqe;
+		}
+
 		if (CQE_OPCODE(hw_cqe) == FW_RI_TERMINATE)
 			goto next_cqe;
 
@@ -405,6 +412,8 @@ void c4iw_flush_hw_cq(struct c4iw_cq *ch
 next_cqe:
 		t4_hwcq_consume(&chp->cq);
 		ret = t4_next_hw_cqe(&chp->cq, &hw_cqe);
+		if (qhp && flush_qhp != qhp)
+			spin_unlock(&qhp->lock);
 	}
 }
 
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -993,7 +993,7 @@ void c4iw_pblpool_free(struct c4iw_rdev
 u32 c4iw_ocqp_pool_alloc(struct c4iw_rdev *rdev, int size);
 void c4iw_ocqp_pool_free(struct c4iw_rdev *rdev, u32 addr, int size);
 int c4iw_ofld_send(struct c4iw_rdev *rdev, struct sk_buff *skb);
-void c4iw_flush_hw_cq(struct c4iw_cq *chp);
+void c4iw_flush_hw_cq(struct c4iw_cq *chp, struct c4iw_qp *flush_qhp);
 void c4iw_count_rcqes(struct t4_cq *cq, struct t4_wq *wq, int *count);
 int c4iw_ep_disconnect(struct c4iw_ep *ep, int abrupt, gfp_t gfp);
 int c4iw_flush_rq(struct t4_wq *wq, struct t4_cq *cq, int count);
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1349,12 +1349,12 @@ static void __flush_qp(struct c4iw_qp *q
 	qhp->wq.flushed = 1;
 	t4_set_wq_in_error(&qhp->wq);
 
-	c4iw_flush_hw_cq(rchp);
+	c4iw_flush_hw_cq(rchp, qhp);
 	c4iw_count_rcqes(&rchp->cq, &qhp->wq, &count);
 	rq_flushed = c4iw_flush_rq(&qhp->wq, &rchp->cq, count);
 
 	if (schp != rchp)
-		c4iw_flush_hw_cq(schp);
+		c4iw_flush_hw_cq(schp, qhp);
 	sq_flushed = c4iw_flush_sq(qhp);
 
 	spin_unlock(&qhp->lock);
