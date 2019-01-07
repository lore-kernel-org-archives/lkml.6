Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E22BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA1320651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865341;
	bh=Mz+RnP/LNzC2uBbiJrF1l63r+EFUM2wj1ePC8fONfRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uyVv2CvpNJ4W/63DwxNhUmGDMESqi9Q6JRvFDh1FHo1raQMMGkKGqcD4eXEzixdc0
	 SlKINcnvRrLE8Fz8hcmJzSF06fes6cqekvPxmi5euW+4in1FVky5FAsyrqfYtWyFef
	 TPapqWMItvgNripM8rBvB9pkBIGaYuP/Y2CzG2cA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfAGMtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:49:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbfAGMs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC4020651;
        Mon,  7 Jan 2019 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865337;
        bh=Mz+RnP/LNzC2uBbiJrF1l63r+EFUM2wj1ePC8fONfRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a9GLGhlFFKDPo9UJlWOevGmkfOmWU1sul7xSE3prDKAFIsatIxLq4g3zdkxPFnVI7
         cQopekmI0vFYOJz0BhBBfq44kwRCwMyBzbb6+0mcWMAIEdyERb/RLyyT7Mai9z8H/p
         ysNyd/P0HwoTHRHy+tvJ8u/t6J0q7E1Hd+wzsSjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.19 059/170] IB/hfi1: Incorrect sizing of sge for PIO will OOPs
Date:   Mon,  7 Jan 2019 13:31:26 +0100
Message-Id: <20190107104500.035981734@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit dbc2970caef74e8ff41923d302aa6fb5a4812d0e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/verbs.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1141,6 +1141,8 @@ int hfi1_verbs_send_pio(struct rvt_qp *q
 
 				if (slen > len)
 					slen = len;
+				if (slen > ss->sge.sge_length)
+					slen = ss->sge.sge_length;
 				rvt_update_sge(ss, slen, false);
 				seg_pio_copy_mid(pbuf, addr, slen);
 				len -= slen;


