Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E06DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEA721873
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864473;
	bh=a1kPk8+4G4mMKkTrSpwpHyvHI8Vz5X+3mzmIR+CVpwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lCu/gG0/4aWxK2ZNmM7lv0XZw389owjl3T/vXoH/N5L2hYLTVB/qKEKglAV9wYJ5/
	 Hn9AkwIElyWFDYdfS/P04qln+yqKMATkF4QC9f/+Hkefw3olCXtv3LLYfCeF2auItr
	 plvwrZ2oUseY1zbAdX7dn1+nSvh9EOkz7onPXKp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfAGMec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:34:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfAGMeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:34:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19C6E217D4;
        Mon,  7 Jan 2019 12:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864464;
        bh=a1kPk8+4G4mMKkTrSpwpHyvHI8Vz5X+3mzmIR+CVpwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5kUKM1tZppWESM4v/x7oYpAhwgph6sCjT9D8WrhmhDYaBrsDtTP4uPmTdA6qLulb
         e7VoEUCJF9RI5h3oZd0buYO4V0MzEQOJM3eAbLqaCZ2e1JGPBOUNVxn2amQ5n41X64
         wTurLWWCV7Qc0O0HbXkZA8gpDOe9Xi/wBs19FO2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.20 020/145] IB/hfi1: Incorrect sizing of sge for PIO will OOPs
Date:   Mon,  7 Jan 2019 13:30:57 +0100
Message-Id: <20190107104439.886060440@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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
@@ -919,6 +919,8 @@ int hfi1_verbs_send_pio(struct rvt_qp *q
 
 				if (slen > len)
 					slen = len;
+				if (slen > ss->sge.sge_length)
+					slen = ss->sge.sge_length;
 				rvt_update_sge(ss, slen, false);
 				seg_pio_copy_mid(pbuf, addr, slen);
 				len -= slen;


