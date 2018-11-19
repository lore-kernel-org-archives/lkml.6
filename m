Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF272C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9671B21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpOVspuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9671B21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbeKTDG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:06:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732866AbeKTDG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:06:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 970C22145D;
        Mon, 19 Nov 2018 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645768;
        bh=QPOFC5yx/z/J5UinNORu04UPy8PIBG5XNyqrNrqAPE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpOVspuw+S9UX4znBXvLU3JSm1I9iIh71eiCOTeWprQWld5r/cMrMd6oYvesv0ngY
         AgQktFrG+omODsH5EF4IGJiUh9M1X2RPbF8pYVVLuxjhl9wcfRT95UYVbRLScfewaF
         XauiDfYJ42IRI/krMI1jpM0MvbCpwXsx7YCMoLJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.18 044/171] scsi: qla2xxx: Fix driver hang when FC-NVMe LUNs are configured
Date:   Mon, 19 Nov 2018 17:27:20 +0100
Message-Id: <20181119162626.947590535@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

From: Himanshu Madhani <himanshu.madhani@cavium.com>

commit 39553065f77c297239308470ee313841f4e07db4 upstream.

This patch fixes multiple call for qla_nvme_unregister_remote_port() as part
of qlt_schedule_session_for_deletion(), Do not call it again during
qla_nvme_delete()

Fixes: e473b3074104 ("scsi: qla2xxx: Add FC-NVMe abort processing")
Cc: <stable@vger.kernel.org>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_nvme.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -657,9 +657,6 @@ void qla_nvme_delete(struct scsi_qla_hos
 		    __func__, fcport);
 
 		nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port, 0);
-		init_completion(&fcport->nvme_del_done);
-		nvme_fc_unregister_remoteport(fcport->nvme_remote_port);
-		wait_for_completion(&fcport->nvme_del_done);
 	}
 
 	if (vha->nvme_local_port) {


