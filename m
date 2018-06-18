Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FD2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7A3208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7A3208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965232AbeFRJvg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:51:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965035AbeFRIVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:21:15 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ECFC1C7A;
        Mon, 18 Jun 2018 08:21:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianchao Wang <jianchao.w.wang@oracle.com>,
        Zhu Yanjun <yanjun.zhu@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 131/279] IB/rxe: add RXE_START_MASK for rxe_opcode IB_OPCODE_RC_SEND_ONLY_INV
Date:   Mon, 18 Jun 2018 10:11:56 +0200
Message-Id: <20180618080614.251184505@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianchao Wang <jianchao.w.wang@oracle.com>

[ Upstream commit 2da36d44a9d54a2c6e1f8da1f7ccc26b0bc6cfec ]

w/o RXE_START_MASK, the last_psn of IB_OPCODE_RC_SEND_ONLY_INV
will not be updated in update_wqe_psn, and the corresponding
wqe will not be acked in rxe_completer due to its last_psn is
zero. Finally, the other wqe will also not be able to be acked,
because the wqe of IB_OPCODE_RC_SEND_ONLY_INV with last_psn 0
is still there. This causes large amount of io timeout when
nvmeof is over rxe.

Add RXE_START_MASK for IB_OPCODE_RC_SEND_ONLY_INV to fix this.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/rxe/rxe_opcode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -390,7 +390,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NU
 		.name	= "IB_OPCODE_RC_SEND_ONLY_INV",
 		.mask	= RXE_IETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK
 				| RXE_COMP_MASK | RXE_RWR_MASK | RXE_SEND_MASK
-				| RXE_END_MASK,
+				| RXE_END_MASK  | RXE_START_MASK,
 		.length = RXE_BTH_BYTES + RXE_IETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,


