Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F97FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57728206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217805;
	bh=2FKYDrv2RvWzwH1z43V3xN215TqJ5H87Tw6aOTxO3x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RSDDPkTOTDqVhTRIza5jvQ8954DlQ/Mkr+yuAnbaDtoYA033Erbu+nHYWJT6YyZnN
	 AzY28DpkxzVa8Mi0vshWrI+zvbzVeIe2KQsaJMME0LgwtIUElG88YzNqAWKpI+2z5U
	 IlV2igfkRSTvvJAKGOZAkjF3VRytpPO4Pnh8VCRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404361AbfAKOnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:43:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391233AbfAKOnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:43:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2515E206B6;
        Fri, 11 Jan 2019 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217799;
        bh=2FKYDrv2RvWzwH1z43V3xN215TqJ5H87Tw6aOTxO3x0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bTzHiVhgQ42P8hyDHizrLgWv3gnynchf2cp2RISD61QE10B2fspKUEmFkrZ5BNJma
         T2GsP5chUQMDQ2X3tZ/IyjuWSIlGU3GpuxBY1SdF5DkmuQDRjHA12J7rImYcOGDJ1J
         xzeMdAdKG9AGYMQiKApSMLfBbhy0IVBUysqbXZBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Walker Benjamin <benjamin.walker@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Zhu Yanjun <yanjun.zhu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.20 46/65] rxe: fix error completion wr_id and qp_num
Date:   Fri, 11 Jan 2019 15:15:32 +0100
Message-Id: <20190111131102.638135073@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>

commit e48d8ed9c6193502d849b35767fd18e20bbd7ba2 upstream.

Error completions must still contain a valid wr_id and
qp_num such that the consumer can rely on. Correctly
fill these fields in receive error completions.

Reported-by: Walker Benjamin <benjamin.walker@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
Tested-by: Zhu Yanjun <yanjun.zhu@oracle.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/rxe/rxe_resp.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -844,11 +844,16 @@ static enum resp_states do_complete(stru
 
 	memset(&cqe, 0, sizeof(cqe));
 
-	wc->wr_id		= wqe->wr_id;
-	wc->status		= qp->resp.status;
-	wc->qp			= &qp->ibqp;
+	if (qp->rcq->is_user) {
+		uwc->status             = qp->resp.status;
+		uwc->qp_num             = qp->ibqp.qp_num;
+		uwc->wr_id              = wqe->wr_id;
+	} else {
+		wc->status              = qp->resp.status;
+		wc->qp                  = &qp->ibqp;
+		wc->wr_id               = wqe->wr_id;
+	}
 
-	/* fields after status are not required for errors */
 	if (wc->status == IB_WC_SUCCESS) {
 		wc->opcode = (pkt->mask & RXE_IMMDT_MASK &&
 				pkt->mask & RXE_WRITE_MASK) ?


