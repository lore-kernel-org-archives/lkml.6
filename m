Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E63C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D63B204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x8kkqCuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D63B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbeJICAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeJICAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:13 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10F752064A;
        Mon,  8 Oct 2018 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024427;
        bh=d5Lmo3Hg+M0orTrO9Go45NElihyJlGg7UMO3xRIK5KA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x8kkqCuYclWKxxFBZvGblTEUl3ve2qV2ADcl7gH+t2eKfGdG51SgTikkr5KAVmrTl
         lq5aArz49oIL4P4PmA2sL5ij8kTUJZnn3N3BRYlEGrd9K1i7gcRFcTKFNDrCUWMeod
         sRBVFhrUvdWgBy0CBXSU8bTSJ4rcyKVdjbWvmnIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 011/168] scsi: aacraid: fix a signedness bug
Date:   Mon,  8 Oct 2018 20:29:51 +0200
Message-Id: <20181008175620.472438074@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b9eb3b14f1dbf16bf27b6c1ffe6b8c00ec945c9b ]

The problem is that ->reset_state is a u8 but it can be set to -1 or -2 in
aac_tmf_callback() and the error handling in aac_eh_target_reset() relies
on it to be signed.

[mkp: fixed typo]

Fixes: 0d643ff3c353 ("scsi: aacraid: use aac_tmf_callback for reset fib")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/aacraid/aacraid.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -1346,7 +1346,7 @@ struct fib {
 struct aac_hba_map_info {
 	__le32	rmw_nexus;		/* nexus for native HBA devices */
 	u8		devtype;	/* device type */
-	u8		reset_state;	/* 0 - no reset, 1..x - */
+	s8		reset_state;	/* 0 - no reset, 1..x - */
 					/* after xth TM LUN reset */
 	u16		qd_limit;
 	u32		scan_counter;


