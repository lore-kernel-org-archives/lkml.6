Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD9FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640E220643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197324;
	bh=aIGqLqSjr38y+LNi35vhzZWnAuxfrttykwv8vrF8Qsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i8y8OrlCbtDPp62T8AzeFziomS35e2MCfYDe8Rtl78GXRwIk01HFV75XaWqhxHScA
	 irMT+NSSVhHpqYUgISq9WnuozdUPJVzfRCuJG+dVUccv9NM7yG9IlJ9HclTwlNsnYS
	 TZ7nZtKj7Q/dWBD9dJgTMKA1xt1YaTlBQmpz+qYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733130AbfBOCWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:22:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390238AbfBOCO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:14:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9849821934;
        Fri, 15 Feb 2019 02:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196897;
        bh=aIGqLqSjr38y+LNi35vhzZWnAuxfrttykwv8vrF8Qsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0olOoY2GX1C2imDvMBBuLywg8G5WIhw0SRWetWO8Zn8Sen6nOd/ui3QHtqBZJqc1U
         ixcXV8YZ0CDHW1lvs8nXmnbk80SQdDWsAdaY1E09LPcAeb/v6Ak5zcg1xMtK45p7cq
         C3fUGjx6ZgrycWjW+FI/mxUnBG5dFvjzH3WR7q3A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Varun Prakash <varun@chelsio.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 17/27] scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()
Date:   Thu, 14 Feb 2019 21:14:14 -0500
Message-Id: <20190215021424.178979-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021424.178979-1-sashal@kernel.org>
References: <20190215021424.178979-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit fe35a40e675473eb65f2f5462b82770f324b5689 ]

Assign fc_vport to ln->fc_vport before calling csio_fcoe_alloc_vnp() to
avoid a NULL pointer dereference in csio_vport_set_state().

ln->fc_vport is dereferenced in csio_vport_set_state().

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/csiostor/csio_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_attr.c b/drivers/scsi/csiostor/csio_attr.c
index 2d1c4ebd40f9..6587f20cff1a 100644
--- a/drivers/scsi/csiostor/csio_attr.c
+++ b/drivers/scsi/csiostor/csio_attr.c
@@ -582,12 +582,12 @@ csio_vport_create(struct fc_vport *fc_vport, bool disable)
 	}
 
 	fc_vport_set_state(fc_vport, FC_VPORT_INITIALIZING);
+	ln->fc_vport = fc_vport;
 
 	if (csio_fcoe_alloc_vnp(hw, ln))
 		goto error;
 
 	*(struct csio_lnode **)fc_vport->dd_data = ln;
-	ln->fc_vport = fc_vport;
 	if (!fc_vport->node_name)
 		fc_vport->node_name = wwn_to_u64(csio_ln_wwnn(ln));
 	if (!fc_vport->port_name)
-- 
2.19.1

