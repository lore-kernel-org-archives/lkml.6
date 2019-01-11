Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1424DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC282184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217634;
	bh=ilLru7CQ0RU1aO+bM/Kjt/6SLLsoHddtSaCzzRiVpus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pdvBXK/RIQkatUR8U6d9nkfVldJWVDTdZB7Ci85ld6zadvei4xgZ5mJ9c7D520hrg
	 TI1VBcCYRj3umojLwDOP/euAchZurLhbUvM7hEmbemwzPQcOffKeyJhu1QdI4p36BR
	 2836K5U59ooTFxW4xLsTmBWQ97gsqNo35gC1Px4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391248AbfAKOke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:40:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390859AbfAKOkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:40:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B1821848;
        Fri, 11 Jan 2019 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217630;
        bh=ilLru7CQ0RU1aO+bM/Kjt/6SLLsoHddtSaCzzRiVpus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQ6sxwS87XaMCxdhgXubeYF3m/fzVYc5nTmVdXA4DgwXzZk6oxL6yh91qLOXpWve0
         EX/U3frJgIvtuHnZ790cv7Mz1eblybGKWjQiR6BXvnqEswhiDAPB3WPjqp2KabGW1W
         t8lKfBQ3S47nlfiksQhE3KADhD0/qfbLj9Mz2/+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Walker Benjamin <benjamin.walker@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Zhu Yanjun <yanjun.zhu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.19 132/148] rxe: fix error completion wr_id and qp_num
Date:   Fri, 11 Jan 2019 15:15:10 +0100
Message-Id: <20190111131119.545132025@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


