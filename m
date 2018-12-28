Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD503C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3F72148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545997998;
	bh=MBhSwKKg5lfZpzbUPh5KYKXA/kZR9RRw5pueXoRO2YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=odavA3rF09Q8Nb0SFWW//ldXbxrrlYRSE1HRdqKrQeX980BgT+iO3DKHEbrI3dsI2
	 GymPYdfsqO7DNQtRnK7bDXdEJgxZyGi/A/+Mwueh3A1MztgBkf2J3tdaLmFvPboaoc
	 rfEFh+QeI/zfX0zLi2wg+3OqMq4J8S88OMQLMwXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbeL1LxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:53:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbeL1LxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:53:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E5282087F;
        Fri, 28 Dec 2018 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545997994;
        bh=MBhSwKKg5lfZpzbUPh5KYKXA/kZR9RRw5pueXoRO2YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N39k25M7noQkatSRTg4z0fx891U4UIUYRHs1RteaOVb45q4z7MrODMKNUruRzRIcx
         aWcRfaUDeablzG25wqKgtZWuUMeLf8Fzew7lIOhfZn3H59BlkHBsftea57qeKVSdeB
         7oEiarlgV//hQzUlXrlBu+UAJRUub59o6J3MQtpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 12/46] scsi: t10-pi: Return correct ref tag when queue has no integrity profile
Date:   Fri, 28 Dec 2018 12:52:06 +0100
Message-Id: <20181228113125.503803504@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

From: Martin K. Petersen <martin.petersen@oracle.com>

commit 60a89a3ce0cce515dc663bc1b45ac89202ad6c79 upstream.

Commit ddd0bc756983 ("block: move ref_tag calculation func to the block
layer") moved ref tag calculation from SCSI to a library function. However,
this change broke returning the correct ref tag for devices operating in
DIF mode since these do not have an associated block integrity profile.
This in turn caused read/write failures on PI-formatted disks attached to
an mpt3sas controller.

Fixes: ddd0bc756983 ("block: move ref_tag calculation func to the block layer")
Cc: stable@vger.kernel.org # 4.19+
Reported-by: John Garry <john.garry@huawei.com>
Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/t10-pi.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -39,12 +39,13 @@ struct t10_pi_tuple {
 
 static inline u32 t10_pi_ref_tag(struct request *rq)
 {
+	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-	return blk_rq_pos(rq) >>
-		(rq->q->integrity.interval_exp - 9) & 0xffffffff;
-#else
-	return -1U;
+	if (rq->q->integrity.interval_exp)
+		shift = rq->q->integrity.interval_exp;
 #endif
+	return blk_rq_pos(rq) >> (shift - SECTOR_SHIFT) & 0xffffffff;
 }
 
 extern const struct blk_integrity_profile t10_pi_type1_crc;


