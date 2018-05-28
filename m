Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968701AbeE1KRY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:17:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968655AbeE1KRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:17:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chad Dupuis <chad.dupuis@cavium.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 073/268] scsi: bnx2fc: Fix check in SCSI completion handler for timed out request
Date: Mon, 28 May 2018 12:00:47 +0200
Message-Id: <20180528100210.092578879@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chad Dupuis <chad.dupuis@cavium.com>

[ Upstream commit ecf7ff49945f5741fa1da112f994939f942031d3 ]

When a request times out we set the io_req flag BNX2FC_FLAG_IO_COMPL so
that if a subsequent completion comes in on that task ID we will ignore
it.  The issue is that in the check for this flag there is a missing
return so we will continue to process a request which may have already
been returned to the ownership of the SCSI layer.  This can cause
unpredictable results.

Solution is to add in the missing return.

[mkp: typo plus title shortening]

Signed-off-by: Chad Dupuis <chad.dupuis@cavium.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/bnx2fc/bnx2fc_io.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -1858,6 +1858,7 @@ void bnx2fc_process_scsi_cmd_compl(struc
 		/* we will not receive ABTS response for this IO */
 		BNX2FC_IO_DBG(io_req, "Timer context finished processing "
 			   "this scsi cmd\n");
+		return;
 	}
 
 	/* Cancel the timeout_work, as we received IO completion */
