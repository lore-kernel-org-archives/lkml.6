Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96A4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9754222AB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897305;
	bh=iSvtoMp48jq+jGDGcGytS+EJXW3cdK59IFW/rKEzkpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XWKHz7gfhAmi6QFVfNb9jv7LKip5b1vws0OjRA0tjzRqq+wJC3LPmPuyu2fq95lV/
	 T3D1rA27SiluVXyqaatOEKFM1mcmU8l4/jUJvKJOBfcuR54+14D+/8blKX8PHj0Z8V
	 2046tIrGytcgBmTRBmhaixNLxznd8q6dMmyUEf28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbfBKPBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389769AbfBKPBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:01:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3C56222AF;
        Mon, 11 Feb 2019 15:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897301;
        bh=iSvtoMp48jq+jGDGcGytS+EJXW3cdK59IFW/rKEzkpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1oSVR4T64hmW/vyM+zrZWROKVjfTkIWjp2fnpfK5S1ZtJp8QTAfJUcdlASmTPiR4
         P7v0TAH8A3mtdO4QA2OnnrbUcTjAtOo4osHJsrw6j6R+OHskRxFNpVsjg4LOgmhElH
         G9juHjtlFoKfWorH4G3UWybhk+QWELiO6nQMNHYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Feng Li <lifeng1519@gmail.com>,
        Ajish Koshy <ajish.koshy@microsemi.com>,
        Murthy Bhat <Murthy.Bhat@microsemi.com>,
        Dave Carroll <david.carroll@microsemi.com>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 115/205] scsi: smartpqi: increase fw status register read timeout
Date:   Mon, 11 Feb 2019 15:18:33 +0100
Message-Id: <20190211141836.004098627@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 65111785acccb836ec75263b03b0e33f21e74f47 ]

Problem:
 - during the driver initialization, driver will poll fw
   for KERNEL_UP in a 30 seconds timeout.

 - if the firmware is not ready after 30 seconds,
   driver will not be loaded.

Fix:
 - change timeout from 30 seconds to 3 minutes.

Reported-by: Feng Li <lifeng1519@gmail.com>
Reviewed-by: Ajish Koshy <ajish.koshy@microsemi.com>
Reviewed-by: Murthy Bhat <Murthy.Bhat@microsemi.com>
Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_sis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_sis.c b/drivers/scsi/smartpqi/smartpqi_sis.c
index 5141bd4c9f06..ca7dfb3a520f 100644
--- a/drivers/scsi/smartpqi/smartpqi_sis.c
+++ b/drivers/scsi/smartpqi/smartpqi_sis.c
@@ -59,7 +59,7 @@
 
 #define SIS_CTRL_KERNEL_UP			0x80
 #define SIS_CTRL_KERNEL_PANIC			0x100
-#define SIS_CTRL_READY_TIMEOUT_SECS		30
+#define SIS_CTRL_READY_TIMEOUT_SECS		180
 #define SIS_CTRL_READY_RESUME_TIMEOUT_SECS	90
 #define SIS_CTRL_READY_POLL_INTERVAL_MSECS	10
 
-- 
2.19.1



