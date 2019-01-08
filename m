Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A756AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79543206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977210;
	bh=n2Q9X+KnpsyaIgG65JlRgw+7QxeI0SOwQuzJC2O3280=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nv0szUS2ws+7TDQ9uUeKAjw7ca1ErRwtvWH0r6V6ueUhRP5ty0O6AuNjW88Q82E7a
	 rQ9eF7tKmUZiG3d0Z8Bv2vb/4ltIts4j9TjQvyFZ5pTnwTHm0NMC0zeV5Vgawu9dwE
	 S1BtlK1ZIHDTsuwhW2RjlKJdodfC4Ilmq0Q+1238=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfAHTx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730943AbfAHTbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:31:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 605342070B;
        Tue,  8 Jan 2019 19:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975860;
        bh=n2Q9X+KnpsyaIgG65JlRgw+7QxeI0SOwQuzJC2O3280=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDMs23Q2MTtlsfN5k/BQLb5Go24r7cBVKRIhPO7zYBfpgIU0FPv4NTezlPKm3WtiJ
         pdHgDNM/+26MRwTJkXEl42iIOzIFUBap0fWiFskPfS/DLYEv6xU+horPR0zm8SNdrj
         w1HrJ2r+VibVEQRWIIXwdEQjzf8J4c9RkKKZwvkA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 42/97] IB/hfi1: Incorrect sizing of sge for PIO will OOPs
Date:   Tue,  8 Jan 2019 14:28:51 -0500
Message-Id: <20190108192949.122407-42-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>

[ Upstream commit dbc2970caef74e8ff41923d302aa6fb5a4812d0e ]

An incorrect sge sizing in the HFI PIO path will cause an OOPs similar to
this:

BUG: unable to handle kernel NULL pointer dereference at (null)
IP: [] hfi1_verbs_send_pio+0x3d8/0x530 [hfi1]
PGD 0
Oops: 0000 1 SMP
 Call Trace:
 ? hfi1_verbs_send_dma+0xad0/0xad0 [hfi1]
 hfi1_verbs_send+0xdf/0x250 [hfi1]
 ? make_rc_ack+0xa80/0xa80 [hfi1]
 hfi1_do_send+0x192/0x430 [hfi1]
 hfi1_do_send_from_rvt+0x10/0x20 [hfi1]
 rvt_post_send+0x369/0x820 [rdmavt]
 ib_uverbs_post_send+0x317/0x570 [ib_uverbs]
 ib_uverbs_write+0x26f/0x420 [ib_uverbs]
 ? security_file_permission+0x21/0xa0
 vfs_write+0xbd/0x1e0
 ? mntput+0x24/0x40
 SyS_write+0x7f/0xe0
 system_call_fastpath+0x16/0x1b

Fix by adding the missing sizing check to correctly determine the sge
length.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 3dfb4cf2f8c9..48692adbe811 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1141,6 +1141,8 @@ int hfi1_verbs_send_pio(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 
 				if (slen > len)
 					slen = len;
+				if (slen > ss->sge.sge_length)
+					slen = ss->sge.sge_length;
 				rvt_update_sge(ss, slen, false);
 				seg_pio_copy_mid(pbuf, addr, slen);
 				len -= slen;
-- 
2.19.1

