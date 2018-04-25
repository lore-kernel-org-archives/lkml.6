Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/JzoJ/HLascvj03IS3N6pqEA/rihYFLfEBTcR2SkS/Y1vXfev96Rr/2ZePz7SDA4yVyE41
ARC-Seal: i=1; a=rsa-sha256; t=1524652796; cv=none;
        d=google.com; s=arc-20160816;
        b=w4E8sqJsKkxA7rEeD9Zb/he6y2WnK2pTRS3q9MbzzzVCPY933DFB2UwbldAyA6NbXI
         0WntY5nNAHUxzKJoUE4ZkrZhYQAfAlu7tlXhsJiyaVmb4+Qeb2o+/7aeIAnYXOeKFIkn
         UYwidIF0eH87fxiN/MVBwTSHdrRqFLrYKBFsmAqP/iFfKwz83jwoDsiMI28RdntSciMC
         22lF8phyiW9IXjTMZb6ksPyK2KBjkZzh8wNRvrvAWsb5qhFIJ2r7rY7+r0WNiSPgSpf1
         9FI/f5moqisjE28hdBHAP+xq7a5HkqzUWNgN7l01zWLJ8y1cyVTtQYVnkR1PGHz59zYB
         FVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6CGANYDVVNShh7Bm9VVObGWiT7qYF2N+QLHWGEZG4Po=;
        b=vVdUGSXuwiYglUz0XBQSkr+yT+ObjLYqbBrF74OEbCSPfoPH0yuJrSZj7/saRrDCym
         V/a9Etoj4+hCAr1jot3hOgmx33GHdqdN3idWDa7stBZrqYoEm+3h0gWG2I3KELpHuTmL
         JctGquVEiPN1Glnd14tgdUxvl76vR066nm1UGLl8AZysmwj9zMmwMF4Xva3wxIjOzrcu
         wXf9/onwyL2AgTnYKfcdo5qGg0aN9M1DZbEZP9etOAgtsLVxEv7ktc+enjvTIimROn7g
         HVVlDUXBeQGXITAfWStb82nTqvj4kZihWHrWW2PlkdyJMojAJy7duG5xU/cevnh3DHZQ
         hQJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 035/183] i40iw: Free IEQ resources
Date: Wed, 25 Apr 2018 12:34:15 +0200
Message-Id: <20180425103243.991423685@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714330371988024?=
X-GMAIL-MSGID: =?utf-8?q?1598714330371988024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mustafa Ismail <mustafa.ismail@intel.com>


[ Upstream commit f20d429511affab6a2a9129f46042f43e6ffe396 ]

The iWARP Exception Queue (IEQ) resources are not freed when a QP is
destroyed. Fix this by freeing IEQ resources when freeing QP resources.

Fixes: d37498417947 ("i40iw: add files for iwarp interface")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw_puda.c  |    3 +--
 drivers/infiniband/hw/i40iw/i40iw_puda.h  |    1 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/i40iw/i40iw_puda.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.c
@@ -48,7 +48,6 @@ static void i40iw_ieq_tx_compl(struct i4
 static void i40iw_ilq_putback_rcvbuf(struct i40iw_sc_qp *qp, u32 wqe_idx);
 static enum i40iw_status_code i40iw_puda_replenish_rq(struct i40iw_puda_rsrc
 						      *rsrc, bool initial);
-static void i40iw_ieq_cleanup_qp(struct i40iw_puda_rsrc *ieq, struct i40iw_sc_qp *qp);
 /**
  * i40iw_puda_get_listbuf - get buffer from puda list
  * @list: list to use for buffers (ILQ or IEQ)
@@ -1480,7 +1479,7 @@ static void i40iw_ieq_tx_compl(struct i4
  * @ieq: ieq resource
  * @qp: all pending fpdu buffers
  */
-static void i40iw_ieq_cleanup_qp(struct i40iw_puda_rsrc *ieq, struct i40iw_sc_qp *qp)
+void i40iw_ieq_cleanup_qp(struct i40iw_puda_rsrc *ieq, struct i40iw_sc_qp *qp)
 {
 	struct i40iw_puda_buf *buf;
 	struct i40iw_pfpdu *pfpdu = &qp->pfpdu;
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.h
@@ -186,4 +186,5 @@ enum i40iw_status_code i40iw_cqp_qp_crea
 enum i40iw_status_code i40iw_cqp_cq_create_cmd(struct i40iw_sc_dev *dev, struct i40iw_sc_cq *cq);
 void i40iw_cqp_qp_destroy_cmd(struct i40iw_sc_dev *dev, struct i40iw_sc_qp *qp);
 void i40iw_cqp_cq_destroy_cmd(struct i40iw_sc_dev *dev, struct i40iw_sc_cq *cq);
+void i40iw_ieq_cleanup_qp(struct i40iw_puda_rsrc *ieq, struct i40iw_sc_qp *qp);
 #endif
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -428,6 +428,7 @@ void i40iw_free_qp_resources(struct i40i
 {
 	struct i40iw_pbl *iwpbl = &iwqp->iwpbl;
 
+	i40iw_ieq_cleanup_qp(iwdev->vsi.ieq, &iwqp->sc_qp);
 	i40iw_dealloc_push_page(iwdev, &iwqp->sc_qp);
 	if (qp_num)
 		i40iw_free_resource(iwdev, iwdev->allocated_qps, qp_num);
